Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842C2F50B2
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477599; cv=none; b=pZJzEyusAdriJ+0BNp85FoDH/XkpICVvxPRLDwS0zns8dUO2g09UPdxu3bEGvzGTN2gXmIiT/8qdpsl4aE+rxxxqiwoHZCH3+hJMjCURb+6SO5ce4VWR1ee8RXFjKDjWTh2WFSiW4VTH6l6w9NQxPfMBSc1PjB1Cg+0nf/UFfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477599; c=relaxed/simple;
	bh=SVgYIr6QRyoJUjgJSZOCxevHekqPqxDpqK1G/H/0lJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VkLbCMKkMmV2WiOJM4Iw3Lc5j8al7q82LtmFCpuPdcb/xWJTYXYG+OAq8eLVlfqo+lhecx1FmAJrjLahkj5sF6TAJgOm/KxCjjpLeNgHEtrXB8VZSNB0THMe5Z0p439eqnjbMVj1Xqpa3rKt7C8+ue6CJj+MYKP656XF4j0xvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTRwTKqL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTRwTKqL"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8318777a12.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477596; x=1752082396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rO5HrSxbzmffQVYb5MSxNLE/QBwXduWzWXChaGVxvTg=;
        b=XTRwTKqLsOz6hupWcdPTb5jVVEoV67lR4uxMToURZ9dCk7ar0dfO0awF016m7ucLOf
         HX0myjMzl25dJdMaAUt4WAOgJP3q7DvoDoqwlMs2HNpS2qEN2md4+aEd7sYsFJC1p0uQ
         7UAxWRERk0lNjoqGIro75KUnfHMwYsrIR1sflzssCEp/jm5R7G/eDthqaGkh0cC6/rCm
         54fue425irkCNOY7+0ZWSXO8jXaX5uGe2Qo0DRfoDY47y5gfFR69KVeMPHDDyF1+aEpM
         SO4TfRcN7HeJPiPsPHKBsXLZBWi3x2JuE4bLIPRJo2jNuO/UzrKCM5kiEAH8istVq0TM
         0pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477596; x=1752082396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO5HrSxbzmffQVYb5MSxNLE/QBwXduWzWXChaGVxvTg=;
        b=mY0fT3B4hwWoSqTLkuV9wA+KlJ+WRd76vxc1mYCraedRkBiLkY5CgsXKB3xmwhi3ZO
         eSnMvYvRFInzHerdLcWYN0ghQ5fs4FLJm3egYNYmnCbVQur0sOJNokL85hrsm85/zKeU
         iMRufFfOC9xu5pPvVtoBp3A1fCerenNmV1d2PqhxQT8muxT/5uwjickQr558+Gu+aDsG
         w4XgfZa8EHFlZTXBUYpqLEYz7+hFKDCa81BmjkS2fyKuaQNZNhOiV7U/L9A4/VNBapTO
         bC2gSBUaZZeV+utIjudDTt7B6gfLRiS4VWQ68b37qMv0gBv6LV9V7K2W7yAOJIkKi6yy
         Eo0w==
X-Gm-Message-State: AOJu0YyZxb7hFu+c/hpE/SdVdjVtQaT5Gijcyx+wvuwfJAar3xFPN9XB
	IILV7HFGNmLr+didsXJVVoeEZ8NLqZ9eBli80YGcR6KWQPGmpLZP5IJEDR/C5Oxqezg/tjAhN3L
	+S5G4lYEhvc7LRM11BcaGjnrvj19uOyEB99xn
X-Gm-Gg: ASbGncsCpT/D9MDMJ820eKHk2nVtNuMyxugiLZvTX/GGlBo7PbecCsUQsnngG98p/9K
	i1eu1bTB9Z+v+FYFftRcuBYabfG+trXvtJipNk2Goi5nRe3BKH5ocDGQxY1QYcp8Nip50E/rUty
	0cAHDd2slShi4Hg4mtOgL53zcAe+us/0cUnxzAM9E/Yt4mnQ==
X-Google-Smtp-Source: AGHT+IEkyue2FhqloWeLrYzMmaCo6XeKRU05GZNsjUeNlxL2KB8/1jzbrl4agmxn0dupENC7dhIa3052ud/JUetMSWY=
X-Received: by 2002:a17:907:ec06:b0:ae0:a813:1bc0 with SMTP id
 a640c23a62f3a-ae3c2cea8cbmr357879466b.53.1751477595627; Wed, 02 Jul 2025
 10:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 2 Jul 2025 19:33:03 +0200
X-Gm-Features: Ac12FXy73bTuuMwHiJMfrjNXelOAXMFJb153h1JDBZD0r8kbHqY39_O-jSI_fJw
Message-ID: <CAP8UFD2m468L8BFcZHcYO6oLkObgHTaXftAz4ONHVGmhLpso=Q@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 124
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, 
	Stuart MacDonald <SMacDonald@kaimaging.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Bruno Brito <bruno@git-tower.com>, 
	Lee Reilly <leereilly@github.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 124th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/06/30/edition-124/

Thanks a lot to Luca Milanesio, Bruno Brito, Lee Reilly and =C5=A0t=C4=9Bp=
=C3=A1n
N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/786
