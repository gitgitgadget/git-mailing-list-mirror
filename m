Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4C19E965
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417186; cv=none; b=FOMCCKw3/cm9nDBvjAwfWh8aKGSDlfa+kWPVqFhpNDi7Uhzz5ZxgqL3Zf+9AgrQ9IV9bhCHlFmlBqOwn1/OOLjXzCuONK2tkl4cGwqNxqvEWCCSIZi4u6dNkqkWbHW2rS2jAv8CARZmYlbSDiGlWH1bONj5Fngw+XAcVJGkSsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417186; c=relaxed/simple;
	bh=Cpl1BRjzV3SvnPHChOFkT47bVtShiS7egdHoJVYR15c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiegMQA17SCkM/KSpr/fvt6UXnrsKUlyupZHGOhgJY4jC+2Syq/dfJsMl3UnSecSURrOa59rI0v/TVWXVrqAT/iBnO2bEjk97xa47pvAvosyBigEVzZCxU0GM78MJqp428Mvtz5sSTDypab39hlxOSB6SC9kMr+cWXBams6TOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DRP/1zm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+15DLfZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DRP/1zm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+15DLfZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D735C2540105;
	Thu,  9 Jan 2025 05:06:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jan 2025 05:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736417183; x=1736503583; bh=HVQwbf5B/6
	d0DsHHXwD/IEMdkGSMTD15tjgMsq4WMM4=; b=DRP/1zm/qniiyTYJHfZ2YiDruD
	l+RFfaN4aZyoViHidJOdkG+S0zTRJ//J9njf+t2jmkCVkoO9RavHdVJZoqUe0/xL
	UZ5Ou2e+qNS0zzPaHxkW+7eBlYyGfKkdszeax6s60ieYeTDgZ4CUdOJoCvXEPXkS
	XX2zPViSb2iULixkdchZ9RoOvwZNCCSy1tkP2m7i6ADXTZ4X6qi3dbhZpmXY2cm3
	0Fmiw58w9MdjRi3e0f3x7J+YQSPy4xAsb+1IdqhTLD7gzQl5He3vzx58oq6oaJsp
	V9+ysmceu320tjDCPci5TLo99UC9XuMqKhdgquBmgQG3IlYJ4VYO3CsG3gyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736417183; x=1736503583; bh=HVQwbf5B/6d0DsHHXwD/IEMdkGSMTD15tjg
	Msq4WMM4=; b=v+15DLfZIECADkFA1WTm3rKFUDwWakkFcpjHYi/wI5eIeDZd7fy
	Pa7vbuz45Jlntn8igdJ00NfCHLNYycDI7IzB0xVNMngI3UtkLQeflcM+iYqcnYS2
	FrMWENH0qkyDqotSmPYYudeZx/f+AFNYVhwYkNMQxRRWp3Gn1NHBrng5jY0x8MUr
	L5KHejWtcw84NSA6aC2LLjNZZz8beru9nH0zorKxUen0kVYwKCQyff1/QiEipiEl
	WXdYtHqIy4uU42d8mUOsTOKPUnfs/NX/HG9QgXyRNg3q6VRpLB3Cy1PYeRxaeGPx
	suVfRWax0PXt5ZMuhV/O71adPgAvrmv4pRA==
X-ME-Sender: <xms:n59_Z23-A8ZWJGp4r7xs5DPAgJxYmprcd2cLYEp6WxJflQeQGV9OSQ>
    <xme:n59_Z5Feu0DkHWYOfqogdnrNKeDkkh4y8X6ggy5jR0pfU_ALUZ1FevhjQsByhnRxs
    Xr8i80M-DZuLSWdbA>
X-ME-Received: <xmr:n59_Z-7hycmIQlZSfqUXhwAp51HrK68liC8oPCHmkvqW3N_I4GMZcT-PrXwCQCF3-cxbYSkZoIV-u-F5s-xweBZ3fdHA9-U8DOY6JkjW4FK6sgrt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:n59_Z31yPDxqW11Wl5qoiZ15yUgYlVL6MVhTBBziL76K4JLZH-Zumw>
    <xmx:n59_Z5HRGCKKgmhVVYcLw1k9TCGtUw31dx97IUoWXI9x5bkTZlhf9A>
    <xmx:n59_Zw8dbEFAo2xXNlqPxCQjzXcnWnELTopQ5y9wjy4_au51YvzsSw>
    <xmx:n59_Z-lqlTsLUEm3fT52-oXbPoaiB3RuyU-8GdTebfeezWSAivaOJQ>
    <xmx:n59_ZyPrhgEtN7eLsj72EFRXfKpkntTnq4FLxMjcjdsKBAZ7QrYUUrXr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 05:06:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43d1f3db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 10:06:20 +0000 (UTC)
Date: Thu, 9 Jan 2025 11:06:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Christian Couder' <christian.couder@gmail.com>,
	git@vger.kernel.org, "'D. Ben Knoble'" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z3-fnHV3nOMa1EPZ@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
 <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
 <xmqq34hw0whh.fsf@gitster.g>
 <Z30hnx43mEwjWqzA@pks.im>
 <xmqq8qrmvap5.fsf@gitster.g>
 <xmqq4j2avaam.fsf@gitster.g>
 <006701db6124$f16f9420$d44ebc60$@nexbridge.com>
 <Z34c3rj0E6hP_kHN@pks.im>
 <xmqqwmf5mdvb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmf5mdvb.fsf@gitster.g>

On Wed, Jan 08, 2025 at 09:09:28AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Jan 07, 2025 at 11:55:16AM -0500, rsbecker@nexbridge.com wrote:
> >
> >> I like this but wonder whether there might be some way to inhibit the
> >> warnings one a user gets it and decides they will act but do not want
> >> to see the warnings any longer? I have had requests like this on other
> >> products. Just a thought.
> >
> > I guess the best idea I have here is to use an environment variable,
> > e.g. "GIT_ALLOW_DEPRECATED_REMOTES=true", along with a hint for how to
> > enable it.
> 
> Hmph.
> 
> I may be missing something, but wouldn't the whole point of the
> warning be noisy and pesky as long as the user _uses_ that
> configuration?  It is not like "you can set this knob and delay the
> removal past Git 3.0".  If the user migrates away from the mechanism
> that is being removed, we would stop bugging the user about the
> stale setting, so I do not see why we want to add anything extra
> (other than possibly telling them how to migrate away from
> $GIT_DIR/{branches,remotes}/ using "git remote" in the warning
> message itself).

Sure, that would be the intent. But it may take the user a bit of time
to do the migration, and meanwhile they may want to silence the warning.
It's not like we'll release Git 3.0 tomorrow, it will probably take us a
while to get there, which gives people a bit of time to migrate.

I'm also happy to just leave it out though, I don't mind too much.

Patrick
