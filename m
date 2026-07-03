Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872237F741
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078046; cv=none; b=ahDq4JEwABjUCHhpwAXEkDzmODdkxuTBDq7rogbThbb8vD7bQKdm5CRkTx5uZNVwPaCSE7Coexv3cun5Y9Rz5IHPnxTqxnpf7SbBj9BGlyxbW/1ycY7eskGZen3pnfN2jpucyCQeYrqvTFxZoQqQQSKqHEW9KCwqsxozny6SUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078046; c=relaxed/simple;
	bh=fczmlqtZfq0vprAPUG95kYdtXs/J4w2VAcRNtvMWn5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOs34ttI2xAL+9LgunmDQ+uDE46jFbZPITnwfcq4n0PsLbBkSAtvXNpRZscXLEJ3Rt2N2/h0tGqsKx3M1GnOFdLBygKkn/jXAIK7F2gDZVOUrsFPZytnGGXxYeOIYthxb9uvjkYsr4kgBFK1/rA5bIhVsbjvmh2Aj3FccdlwEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F44VM6wX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWZ3+5JV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F44VM6wX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWZ3+5JV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DD2B7A012E;
	Fri,  3 Jul 2026 07:27:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jul 2026 07:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783078041; x=1783164441; bh=AgqafCS1Gl
	izvk6UlTjdtbmkZ5M6f5HP8kIpahQsVPI=; b=F44VM6wXFogZMIa144PPernWlu
	flvW/9yzQW6b0Bt5s8gJrOuO1DfsF3R25Sby6jWfTKoYiEzZdE5zkU2baf2l7VUW
	YbhvlVytnBCDP734M69K0SmYAo57UnT7UHGGdKCtHo0yGuJkGHPW+DX2QX2ddXgh
	NAZsZq4EHg5UNJ43XQs42O3CiGwPPQaN4QQJkGBMwsz0P2GXJ7HqcmyrDqDv0cp3
	IxWQXwynhcPnmqpgZRgskuXzPZwE5taYExAJzM8021/waQQwSc4/7iAH/0N12zU1
	rDLcEc9VdsSBpqpRrkRYyeWwlV9/8E3a4sE6ed4eyo9Zm9bWi3fAVKnZhQjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783078041; x=1783164441; bh=AgqafCS1Glizvk6UlTjdtbmkZ5M6f5HP8kI
	pahQsVPI=; b=YWZ3+5JV0W9InE2vbL+m7zHgLhx6KoszhnKe5sdWMR4Etxcl5OV
	ca51tDgzFXzv8J/HK/3V9kEJBnfKFbyOd2eKAp2XRkZWxDKB7EY7KfNacw85EoxE
	ytdazUPz02gyFoOIBZviep7ztwmgCb6Q4UjIF7vo2xr/NUBCo2q3TcPaZBFrpZDg
	TDQdqNbtzZRgk9QYseghwvtTT4yc/JSWCrx1+lxYu7r2saCqtk0v0uroO+qPbMOq
	i43lbo8pJVKLulaOk9Xq30mgCnFUlKOUiEdJNAytmOA9eOZQ5I9zOpUHeUwvW/0q
	0LKs1RXlhqnXYhwo1jSvJr8MZW4nPP4eJzw==
X-ME-Sender: <xms:mJxHasO1Fh6PVK6jAvTy22Ue2sW0tGLPuBETfsu82RhTiw2pHWs2Gw>
    <xme:mJxHaqaNjpLWfxsn5vRrt3UsJ-7kgaDV0atDgzIzUvuFXyLf8tYRFoKOG8PppcFQ2
    le0kl1lq6U9Wh22HS6LB9_zMepIiy5sW2i3zD-HZFVZMTO1yGy7QQ>
X-ME-Received: <xmr:mJxHagp8ezdOBr4BKz6U-HV-id5QncLn9BYT1Th4BgHEQb9IcBfa39e52PEBOU64Dj6KV-3nIuDKe2bYRBDpDTJajcAoutPQ6_M69dAogQ>
X-ME-Proxy-Cause: dmFkZTGeAY3XLQ+eJytQBDv4r96S0vh0CaBkfGJD4vwzxE1pmIM2XDaq/VlOc3U8w8oTLN
    3zwjSJf/qrPTLB/FFLWyzEj377Axywm7Rd+oDxcbSexgTHsD+HsLTY9glWNg5xUPoXjlku
    yX8qowJw4FGOVPu57OjOjTDq0el8O9AHWDLKtDknck9XssHTSQPtGSgllZ2DpV3CvmmMS9
    QqzdXSVZXoIoRjfcWsgMcGTHKtXcYHpaxDeHr+l5c8aH5ZcjimVbzY5Zg1QN5zOZlpsJoC
    SxIZ6sdUtDON3CYx2DaICYZnBESHPGpVgm2NIqnallUJyY1Vx5uB3tVsT33Px5LUZiIlJs
    ffN/dDuh9ZgwkBhD2JTDGvjLriuoytqq3romwM1m3dpTPbnNV8+QIJtinZGqxXLt904BzS
    TiFJ8i/fv0NBtimwdcfW5bT1G5ZrGAmZePemFNCabRqgOWnzo1+PtAJzOOIVU31/KJ5HhK
    aarKBXdw2cy/Zuf4UvdGXbsnGDYMfyR0xVgbvdf9QrpnAzzZkrTdbIlLWI3pQWn8pZV7ny
    Rj7zwXbcp8VNeykjmMksmqY9uIPCWBsRugF33845cSwVSaJWcxOlhv51dDk/nlAAeAOO7U
    6QI9BS4QdVr56atSwWccon27O/QeNbC7QnfQ0rRYf6Ylc6G8VStDdNu8CPKA
X-ME-Proxy: <xmx:mJxHauZPB3-vafQTT6OfcyaGPAK8YJWtOemNRkSEdUwUn36GY3faSQ>
    <xmx:mJxHaoQkTy7LAEAEbfSeDHNrLmi81qHx-edPWtgIj-forq-McgoNow>
    <xmx:mJxHal6lwv4t4LKwqFZ1XvPgunQ48rtSS5on7NHf1ZLCracGp_5HIg>
    <xmx:mJxHatzm7b3aAzJYI1qiGF23kJR2jXvSOTT5Rpi92JNE_HDklTLGBA>
    <xmx:mZxHarJHI_tUQJLNl8w5BsrNZz2GurfvzE-TLi2cbApcMn7NdKNj0tLL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:27:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6e9401a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 11:27:18 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:27:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/9] csum-file: drop discard_hashfile()
Message-ID: <akeck67vIBHe8o9C@pks.im>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702075744.GA2029434@coredump.intra.peff.net>
 <xmqqik6xl0fb.fsf@gitster.g>
 <20260702210601.GA2051171@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702210601.GA2051171@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 05:06:01PM -0400, Jeff King wrote:
> On Thu, Jul 02, 2026 at 11:19:04AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > So now we have two functions, discard_hashfile() and free_hashfile(),
> > > and we only need one. Which one do we want to keep?
> > >
> > > The only difference between them is that the discard variant also closes
> > > the descriptors held in the struct. Let's look at the three callers:
> > > ...
> > > Note that I said "descriptors" plural above. Those callers all care
> > > about the "fd" member of the struct. But discard_hashfile() also closes
> > > check_fd. That is only used if the struct is initialized with
> > > hashfd_check(), and neither of its two callers call either discard or
> > > free (they always "finalize" instead). So closing it is irrelevant for
> > > the current callers.
> > >
> > > I think we're better off sticking with the simpler free_hashfile()
> > > interface, and the handful of callers can decide how to handle the
> > > descriptors themselves.
> > 
> > Sonds good.
> > 
> > Our resident naming czar (already Cc'ed) may have preference about
> > the names and word order, though ;-)
> 
> Heh, yes, it should be hashfile_free() but that would require changing
> the whole interface. We could do that on top, which might also be a good
> time to do s/free/discard/ without worrying about a subtle behavior
> change.

Heh :P

I think this being called a "free" function makes perfect sense, because
ultimately that's all we do here. So the semantics align with other free
functions.

We could of course fix the ordering while at it, but I don't want to
tack that onto this series. It already makes the codebase a better
place, so I'm happy enough.

Patrick
