Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614C376F1
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088871; cv=none; b=VBLihGCpBOJMEfmx7GmB8hl6tb+duXB3xapVRTlrmJukTREMb/Gx7bEB9UZMOl8mZ4Kpb4DTLixP9xDyJL+EN+ABUBR2hm4sEgpXAf3diTEGDAKH4x2KWqwcYcu/17P9rDmFA1u/ErpTor5sAA2kq0r6uN1pqqP1pJQK/Zg/gsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088871; c=relaxed/simple;
	bh=CyzpPX4va7+22EKXq9AFi/XiWNZtfWtYpZnKLaLPjaU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FGusjsrVn71yEV65xg046VDpJ++oKEpyiaAFZN5wdrwAe23IImgTTyA++NFyhfxfg9vQrmGY6xyNlZd9eLu/cig4bPw2Tam74W86RT4KeFf3DxMlNCV1utG+OZISXjbF7c9BnsRD27G+wlSEdrz5oTrbM6bkkWyKGWcdQZKhszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExlEt3ju; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExlEt3ju"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0bf77af4dso2521144a12.3
        for <git@vger.kernel.org>; Sun, 01 Dec 2024 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733088867; x=1733693667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWF0OKyg6Xy19/FPXeXgxVdYtXuOX6gxrrpI/PNkw/0=;
        b=ExlEt3ju+1si+bPWifOY9neUyH6d8PsJrDhIeGwJnPKLfNpc5QXXhIikaqKWbyAue2
         kSQxFpu0881fcWrFZ9Kd4HAopxIm5zVlBFyMkHB1YfWbm5IZaRkDQHXljGffzeH3OyiF
         12p5okIkSWingUpJqPXxDiJygUCew1/anURey8iad9FHxEfDZ0MaSi9W6pJ0yTYI/uS2
         3kjgGAaPkgLgB+IGaeqDPCkSnYRGmkYGDP9qVxmU5ULAkkwNqtgRBjghl7KznMmCS8xo
         bEgr+6OptimKPy526ziYiTd0IC3QkUkBJ5aIMsHXBy8RFl5B35lI/5q1uCsT51B0PGTP
         6OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088867; x=1733693667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWF0OKyg6Xy19/FPXeXgxVdYtXuOX6gxrrpI/PNkw/0=;
        b=ORMiJj85SYupVpDH8PmLvBMpAXi1XQEjTjFfMoTfnFBR7oEWk3mmF4l+/KTQ+lfh04
         1HWWGME56naLzlZO0fkz0VFb5O2Z13ZYVizXimo7nfVFByTCzkg9uRnp2NnNUvFO5/Ak
         cak4b37gV+VUFxji7vxrmc8VoGD9+pR7a4Oa2qUDy67XWMTXaTg1XDXLcurxQtCOfuFG
         F45AX+bTLB1LDqDV8Ei8LAl8Caz9rx+93R39b5zF3HV0nW3eh/+YW6PTY1HzfxytQlCD
         jgOR9kMWn1CG6eTXH1eSfa+WZXgjezg5iPajwp1mqoQ2BwXysqEQ/Le2lzB1ETHIABiG
         GyVQ==
X-Gm-Message-State: AOJu0YyhA29ieSno/r3V0I8GO4S8efpfxrNQPlClTufimUNU8wYaody1
	Bc0Z9XSjj1N9DUTRVSGFNsIQx/4N0kv9NRJ//92sKa8HPKJ22GZW9negjpycq248PTunRa32P6T
	ET6/AwTlQfdjGWtUISqc5NFMsA+KHb2vz
X-Gm-Gg: ASbGnct5wTsruXQWI/LVFUEJqTC7B7tdd7p/KJB+VA821tw8+zVcDJ6/Nl3WJO5BHCo
	YsyLTHOMLE6uFTDUh2cgKg4TSYiqZDSXz3Q==
X-Google-Smtp-Source: AGHT+IHhSHJi/UyifH9gOrBBbmjfPq/LYYSxZuSStDGvfja8+TJHH2+4NB8W4dIKI6xsPCGR7uTr4Q/HwVRsBJRvkJg=
X-Received: by 2002:a17:906:30ce:b0:aa5:1551:99f2 with SMTP id
 a640c23a62f3a-aa581072b9amr1862564666b.49.1733088867301; Sun, 01 Dec 2024
 13:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 1 Dec 2024 22:34:15 +0100
Message-ID: <CAP8UFD31OWebD5PXnCDVU-Sya8pY07bA2nsoskF50NUPhTcWZA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 117
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Bruno Brito <bruno@git-tower.com>, fox <fox.gbr@townlong-yak.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, Toon Claes <toon@iotcl.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 117th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/11/30/edition-117/

Thanks a lot to Ghanshyam Thakkar, Johannes Schindelin,
=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Bruno Brito and Toon Claes who helped
this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/741
