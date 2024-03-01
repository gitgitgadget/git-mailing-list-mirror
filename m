Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BDC107A6
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320633; cv=none; b=I4kvECBil8DUkdUda/hkSQiGGILQtSKLxZca/BgxY92NYpffd8bgCpDgxArVKO1WmPlZvWctzvE/TanTIfVcCxO6LHEqNfScvPVmEZnH2+k/d8bq4nfjNFcKdEeFinySfX8+5sW7wZSsvSsQ7khWg7gxlRnIOT0RSBNUAs8n6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320633; c=relaxed/simple;
	bh=kmZmA+Wgpa+Yu+5Fr8ENZMGDtc1Njm9h4n83bXaewyk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ISbulzZsL4K49BmiQAWVxVpyZW2z3a0b6pKNz5LgZWrVwt1/0G5r4ab7mc3TYQYxzRUo3fJFq2T9mVEotIXFbdDIMhyaEgvyHV57su1S6r3oFLnHDUGkPNYbJ+QcYye8NBRbU3sZvO0gBrQbJLD1uYmMJdkcXK8vrfHMh3Kvg+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPCiMxD5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPCiMxD5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28a6cef709so405270666b.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709320630; x=1709925430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BG7lTP7wXbpVp8S6PUDV+fnvIRNgFSqCunEfCOt2tjg=;
        b=IPCiMxD5HiaaQmq1tLdBPW3EZCJk9DPQVopVkcC5UD83C31Ie8DHy1kU8wCKO+pMB+
         Q+c8YTb90v+nWW3R5Tq7WadRrAX+BiGMqS3Xu3UQwrlo/9vFU2h3DgtGayEr12/JZi+m
         h2AIPF3jSSbheWOjea/bc7VKQJmtgToKqy06gYFJda6THmbJ5pL09zxEZKj81RaE41Q/
         CEd3v8S/c3iTpFRMC10E2l08UagW417mLC9ThcxDTKYoectdL0pYeGyXRC945FEVnIZo
         BBBh6cUy0nzwMT/ygoDEYZb5t98BQEXmnC9XYpnRgvmv/JAmTemUkdJfzQ4zIa0Yxyw7
         UQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320630; x=1709925430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BG7lTP7wXbpVp8S6PUDV+fnvIRNgFSqCunEfCOt2tjg=;
        b=cK14v7eIc/DL3bYQ5D58rcX9nJp+goADYetPTYROYSko20mZVApj49R3hnFKtVgWJh
         dMkiaAN2zQMIBceQwRRjZdXrz/1yrQPjcuOVctmy8v4giSddLxAXftVdZEDxMmHnBt/J
         3Z5+Q/Qx165fLHas2c9lSQWoWd2y9RdByDc8UcAolfIe7UhteTegNXL+Dq6ld/exDw7S
         gBZnHiDPIgywC51dYXEz1k9d7UcDHObCbJkrL4JcLifMglXbr/H0tNzhattW1kM16co5
         MIZJ+7YeVPNz/+GdJh33TaH2Fg3d9rMGBLyYnPtlXxvDN3R0REu7RIwUMUyOdXM2bLor
         Ls7A==
X-Gm-Message-State: AOJu0Yz9JGv5KnDAd9OFG1SBuBs2xqdwQDaWPQG3MNVRppY0NW+vG23H
	U2XennLxFPU6b1V/ToD9ntFwLzu2BdyIcpfwpdVLvgm9xRqj0GIw332E56Si4wBUv5XrT+n5Na0
	YbwHSxzb3gaOfb5jUOoxVo6o09pEUHqlnw7U=
X-Google-Smtp-Source: AGHT+IE++bgmPJWeKlK9LtMLSXSnE8V/Lx4CgHHtcyIuVdgzxVvormVF0mc4tme0jKxo8cNP8CwTW5vZgxM4up1xcTQ=
X-Received: by 2002:a17:906:2dd9:b0:a44:b4e:307d with SMTP id
 h25-20020a1709062dd900b00a440b4e307dmr2068552eji.59.1709320629813; Fri, 01
 Mar 2024 11:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 1 Mar 2024 20:16:58 +0100
Message-ID: <CAP8UFD2mVOAbP9Rv_+6OXVM_aWi=LMuMX3k+2CJqmTc1arNYog@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 108
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	lwn@lwn.net, Bruno Brito <bruno@git-tower.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
	Jeff King <peff@peff.net>, Dragan Simic <dsimic@manjaro.org>, 
	Brooke Kuhlmann <brooke@alchemists.io>, Jack Lot <jack@themoderncoder.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 108th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/02/29/edition-108/

Thanks a lot to Brooke Kuhlmann, Jack Lot, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec=
 and Bruno
Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/697
