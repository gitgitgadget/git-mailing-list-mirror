Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0F2C0F90
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116707; cv=none; b=TQRtFukcDUHntGttSUBXC+HZ/pj2yBr6SEEGRnk9lLCCyIzo9N5Itvx/1xhiHRsm5yaOHHJjtnKqSRAUToRE1eBawO+u6Z0KzjTXtgtVcehviJjq79O4/paQOwDKDKHu8WJGPMZUkXBdyF9SXL+qMKS2TYtgvAut+xTzdxtinI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116707; c=relaxed/simple;
	bh=PxwNzmU+w/fu6w8lgkdRuHf1dWp21H/rpQTw1prbYnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zp3dD5qPJ0S6k+tyjNFKn0aqp43lXMwbInFJvwdIu0REwmcuaATdbrogW33kjCViN8tV8aPeCIQpDxjWepwBMOji7C9VA54K1QYZagNx6zG6lHqyXCk3tQd1WUjdXcUfu8kzj23nQDBp02eanBUg0VT7OC0iLfeJYL7EoE7wVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WwaUBH5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nfMPveMO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WwaUBH5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nfMPveMO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 42F1F1D00127;
	Wed, 13 Aug 2025 16:25:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 13 Aug 2025 16:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755116704; x=1755203104; bh=7u9zPIfyB9
	bE8BnQhoeKuLOrS7Ei+RA9yGyPW4VM/oY=; b=WwaUBH5V0w8sEuNk9U8yAaNFYT
	RjJWbHgsYxNdHblWDJEmvNTdo9LWzEq0F+1Ywjj7MK3SD9P8C+CfxwftoOG08MgX
	Cyq7SGlfvXxxBjNA64TcOEBZ79I9y00tK4okMEEFI2fchKPdy3GqCVwT1UUr3tYw
	o5JhlW9gETyO/utzvLVePqyeaYehf6mKXB3XuBZouH0VIOle5XQrzo3XN+o1PVEM
	fBBNWxwsJoYQ3IWdduuErQ/zlydBNqA3fGnO1gH7s0NTW2+YmNFUCIKfhbe2S7lw
	dt4Vp8pQ+Nc/gRM8atkq21q/StQaVNXRkL0yeoeY/O8lOHM3VZul5NSNqvDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755116704; x=1755203104; bh=7u9zPIfyB9bE8BnQhoeKuLOrS7Ei+RA9yGy
	PW4VM/oY=; b=nfMPveMODV9Qv7QYOwHKW99yndX738F3mutSIBjw+Na3sV2IrWW
	2535f0o4xZ6xBQ0aVrISFFj3zHPPZ7nF9lz9oQe1fURW8qu8wXR+EspfIw9p5aj+
	5rTrPE/oi+YoSG4EjNNreDHVIv1h57YF7RULromGI2ZsqVDLIUMzJ0zhCdNhtR9t
	v3pODVaJLaqR2dtBv/AEq3WMjxuHC2tccvUq3YLBKeTE3GBsY8vACaJZwpN6AJ1d
	Oi4brDiX07oPRZ6yC1tAo0lRvWi9h3dKxhpA/E69Q7pgudP0BKCcUkvSxD7OKbGH
	zWm83dejABeom6X6y1tP+CMzmANmsE9dqiQ==
X-ME-Sender: <xms:n_ScaFT270VDDZTsmVJ0Va433Sw-CbdcDVzsObMrrGQBsyJRBPrfZw>
    <xme:n_ScaJVn1bkGnxSeW27duYJqKHxTiLBJeBLGJb1-WN9cJwkm35SzUs1iYuBR4csbT
    pfwZI2Hhwt6imd_BQ>
X-ME-Received: <xmr:n_ScaHYGaWercX6mwIfOpyOS6M5bNCSnw5_RnRsN7J4cLcftDyikSfDBMNtA2wcz7E_fb2eMtiGJEDI1uIGAxMGMymZHy3elehmbXVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithdqphgrtghkrghgvg
    hrshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:n_ScaP35jllgIka0OaVg1E6D6sDG9EQLmvnKVvWBKQYkHq6V-XNvpA>
    <xmx:n_ScaJgMTMB9hivJt3x-8JRZlXn9Cwla1bH61uvPeCctpvdo7mVuHw>
    <xmx:n_ScaDYAvSeSAioGce7M1jbGSvkshRCmbMgJmOnx6u3rBGvRbJmdvA>
    <xmx:n_ScaJSBntqdo9VbYxtf8qemt85qsZ0aLjtu3bbPC7wyKlLUSZSM4w>
    <xmx:oPScaC6lHY39J5IPHsXM3TX4gEMFWFXscH0DKMa0hzQyawN5rtX91FSt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 16:25:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.51.0-rc2
In-Reply-To: <1McYCl-1u9unZ2L9R-00c2nr@mail.gmx.net> (Johannes Schindelin's
	message of "Wed, 13 Aug 2025 21:45:55 +0200 (CEST)")
References: <1McYCl-1u9unZ2L9R-00c2nr@mail.gmx.net>
Date: Wed, 13 Aug 2025 13:25:02 -0700
Message-ID: <xmqqo6sjas0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.51.0-rc2 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.51.0-rc2.windows.1
>
> Changes since Git for Windows v2.50.1 (July 8th 2025)
>
> New Features
>
>   * Comes with Git v2.51.0-rc2.
>   * The Portable Git installers (which are self-extracting 7-Zip
>     archives) are now based off of 7-Zip 25.01
>   * Comes with cURL v8.15.0.
>   * Comes with the MSYS2 runtime (Git for Windows flavor) based on
>     Cygwin v3.6.4.
>   * Comes with MinTTY v3.7.9.

Thanks, as always.

>
> Git-2.51.0-rc2-64-bit.exe | f62cd3143a03e496b64468f9833434be19df4b2428fc5d058774d3ee394579f1
> Git-2.51.0-rc2-arm64.exe | 846e317ec5bea38e9164d627bd6f4e6881acb7bd136660e1c1ce9be7a54d8406
> PortableGit-2.51.0-rc2-64-bit.7z.exe | 01a8ab8481362c230f18cef8966a612f760d4ea40d539e9d8cb419e517a8ac20
> PortableGit-2.51.0-rc2-arm64.7z.exe | 4d44e057f7d6596d6671f413f694d5ab04cb02392b05d0a9cf929e4acf0155e3
> MinGit-2.51.0-rc2-64-bit.zip | b73e8059a6c2380f84ff1483dbffcdbcf1d97bec28de24a1c3d0d503a872a619
> MinGit-2.51.0-rc2-arm64.zip | ac5690ffeab59eb177d2091d68eef17e4f063f4b3f904749cdfa632a455f93f8
> MinGit-2.51.0-rc2-32-bit.zip | ca5585924690f62cbfddf317111eb1d02a9fca03f9a13fc15573b20c2bb9b754
> MinGit-2.51.0-rc2-busybox-64-bit.zip | 720914cae321f172d6546134624aa29b974bed00c8edfaa952b58f5c0193ffe4
> MinGit-2.51.0-rc2-busybox-32-bit.zip | 0ca7c6985243899b441474cd5a7cfb7cf994a0e57160e776a9170db7b4444da2
> Git-2.51.0-rc2-64-bit.tar.bz2 | 5804070e7e8fed5e624bbb74e5ea6f286367a698384681152dbb31eefabf9a3b
> Git-2.51.0-rc2-arm64.tar.bz2 | 5218e4574410a80a6f0fcbfb905522909eaf91729ce26138b1985578e0823a33
>
> Ciao,
> Johannes
