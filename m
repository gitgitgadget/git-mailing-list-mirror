Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D5314A8E
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161445; cv=none; b=VCblvDPn0HWPXNTPxgPGbzbkOagKu5i6D+TuhfFdSZmT8N96czSiH2NNjKv1OBL4lc0Q/JXToZ9u9Hx5GrIIhjY3i5B4NuD4RcwIZ+rtP0vsP71FicUDCGpLnrAdrtn8HkYyORFQHL62xgcIp6Z3JINL7UiU8wVpU29cmuOkCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161445; c=relaxed/simple;
	bh=W50zrqht99aOsChYSmnarzsx1khNyIv7/lMqNwTL7VE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iCLfnz2OhBgIhv1KaN1jB0gxzGeV40yEO4BgBgrjAmS9OdLwiIbkAzBx7CB/xmTuoDm7qgmYXa9CdwqZ402N1PmfC+PysSrFFdkD+zVtF1Wa7EZ87R3Yrp6daiFvuey6AZMBXeJOFTYAcjXOOWN57ONwTTzVF0aeWgkKAhaU0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=I68zGmcQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rq8dBhgj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="I68zGmcQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rq8dBhgj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D02BE7A007E;
	Thu, 11 Jun 2026 03:04:02 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 03:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781161442;
	 x=1781247842; bh=W50zrqht99aOsChYSmnarzsx1khNyIv7/lMqNwTL7VE=; b=
	I68zGmcQGKFD7ANB//Zf/y2DuiYSwuJ5ds8AjkWhxnQNGZ9wb1pce+/qnMlQyhh9
	Jg8Kla5fSOphLu/Eh7LD7hKcRr1DsLCJVK7+oeQWhhONM0U1fTtopxrZ+ZkYkMEy
	z3wUhLfKrv0I5YdoMdExiZYbT+oPnjXmkkyjW+911+vBRj/MZK/5p9k2omMXIAe1
	+UNsuoOYzsfr6ZRI73C/4AKfiJCsWN9dBTk2DHWU8K5LjFytTneZTiHeJDO1nLXn
	ICP0o6W0aYW0j3jHkwDb8t4aro5Ijp1VaCJd4mnUmjX30ob4UitkIVd8U5Qs5P1p
	HWTORVbB/vUB0paFkYk7JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781161442; x=
	1781247842; bh=W50zrqht99aOsChYSmnarzsx1khNyIv7/lMqNwTL7VE=; b=R
	q8dBhgj16D7EoYc4w4iKZdaw+bwUvNsU71reJP6dG/lDxPHNEuNFRz6ybaCX5oyl
	nVla90pXomsknMohNEvzzrDYLQylI0EpCrDrHqtBaeIIaSdF4/4QPkc9LorlUeGa
	hS2RMdzE42vFUdPHwx/RJQhZfJkpvBH2Va9SJfQRLI34boBV/jjjhstseFED5xq1
	UuUzZqR8NcF68/9qj4hXIUAcAaSS/9VwireJTecqcpotCjdmBlRDsuZK3Mfk0f2i
	cuXJfvCe51krwp6Xuah8qncbmzWg0zvA0VC6KQPyREzw8vshDKp5udh+LgobC5j9
	Bs4oUe6NTl8Pnfiv05o7Q==
X-ME-Sender: <xms:4l0qahg2ediRu58oE4GLnw6AfKUGOK68lDixdfmA1Udc4RLUhGWQOyU>
    <xme:4l0qag1s5Jv4BHruNKYALkIhRJL_wDE7Xt0mE7_7iIdpY-wJ-UEPwnweWbuoQRdFd
    _6jTaMYBO1VazxfZgEYc4al0pT8s3zFdaBHwN7nbwtZJF3u6mNbIXc>
X-ME-Proxy-Cause: dmFkZTGMFYn2ODYVaAeOGzh0tG+UAKtimaEMIm44rGrS8iAel0hAYsm3VDioY1TZcE77e5
    e3EDEJ4q0J2zjadLy+YlS5GTfp83Zygce0kdQwMZ+B7lUh0EmioHWk9VP38/f/ea8cUEZ0
    uzsG/4VSU/Co6YWnGslvQa4DzkMAiVugW1X01DQbYDjggvN8m7qaGnHrdYQvPD7acSkaEF
    VyhTDfSI5qVR+yoxFsUkaFqQ5vmO9kIulx8hercbHqrT6JKmWeYSy6NlvHK5dZBDD1M/et
    p99lqEfC4TGqxTgJj45TY/f5TCDkz44d53j3vN6EzMoLyBYkyUjDAZ0gZnEIEJu8YyYQDw
    6H5z9IF2zlk8uVxfDbIHSXdfBcpHFQ6YNpa0ae3zzE4AuSLr84se/Vjow0z/+DGsbN/2bd
    NB7okRMp4donCQRdN1e2zhncS/073PLnI2YrHp+LyiOD4HMnI1OJwUec4K7vaVBbOrYqQW
    +BVr2guOznBYV8UHP7ucEmXbbV4WkwW5AZWGzymXBsEjfn9Fp4O7HGjVM1pkQXHy6vc50i
    WYU2l2NEoGBCwQLLWG4i/ZWWetgWBQ9uGa5kCe+4m7107UuszeyQb+2cJ9stQVFwZnCsdW
    WZPH0CLBt2YFlf+PMki2EjbHuotCoohdI9YQijaIX4z+6x+dD/uJIu2v01JA
X-ME-Proxy: <xmx:4l0qakNTXWfri6H-2lbYihtqwSdxTqWeE9s6yb1S67hmTdZ5nKZxqA>
    <xmx:4l0qao7uKN9jwk7mVyiHDyT-W48Ujm1DZaAbuAkM6jSyS9pKdkVO8w>
    <xmx:4l0qai2kb8OetWv1m5AX-NMBFRBkiGSjSieR4SSKXvQ-0riw2g055Q>
    <xmx:4l0qapZAHYG1KygqfbC8mBDMdBMfm6kDX5fdTqZK6DRYrZafZ1mGUw>
    <xmx:4l0qapT4XXHvX1473nGiC3-oHbSZKm2tqo_bQ8-ljW4X2sWYzYE4igw3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8BE8D30201A7; Thu, 11 Jun 2026 03:04:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jun 2026 09:03:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <01433a29-133a-4705-98e1-c8f29d66e581@app.fastmail.com>
In-Reply-To: <20260611065616.GE2191159@coredump.intra.peff.net>
References: <ae4a32e7-bacb-4c88-b2a0-5aeaff60b904@app.fastmail.com>
 <20260609004340.GF358144@coredump.intra.peff.net>
 <d8f7f827-27da-41fc-af8d-72d383b24fff@app.fastmail.com>
 <20260611065616.GE2191159@coredump.intra.peff.net>
Subject: Re: trailers: --only-trailers normalizes URLs to trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 08:56, Jeff King wrote:
>>[snip]
>>=20
>> And again I don=E2=80=99t think that is likely to ever happen (with a=
 knock
>> on wood).
>
> I didn't spend much effort on the patch I showed beyond running it onc=
e.
> It would probably need tests and a doc update. I wasn't planning to run
> with it, but if you feel like doing so, please feel free to use it as
> you like.

Yeah, I want to add some tests on top
and make a sumbission (but sent a
message to first confirm that you weren't
cooking anything more ;) ). Thanks.

--=20
Sent from mobile
