Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100D1A2C2B
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139866; cv=none; b=ZGrWBUHINYbgHd0qo/geMPjGTlfeosZBH1bdd2XH4/ow5PMhac4iu5/2RUvXAZs9MwvD0CeAs64UwuwKx0Le6Yi16KVE4WGszzKLiDceWPM4B2ajWEbih12vztdtgYEwg/Hm958NQUJ4XSIBP94WyupRE7P+qmqWuIYU7+0+lIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139866; c=relaxed/simple;
	bh=kxMFp0CU5eoZPOHR3q3cFfS1MkcWkvRFa7fkfqlk47s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF2tq3Gb62OzNsPeA5X0YyhfjPmPQc2AG/8Oordg58dUSW+swvraAYM00KgI4ut2FG1fHFE1fxPnsh64kibd5AiZfWMyBPsPpl6OqOz5vUcQgfUkKPsTlKu0h4grc50lsxYqjtGZnpv3GKw2Wh0huWZerKb4YxD0nSqR4JKC6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NbQiILWD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dotUs3/3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NbQiILWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dotUs3/3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A034D138062B;
	Thu, 12 Sep 2024 07:17:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Sep 2024 07:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726139863; x=1726226263; bh=2kE4tyGkPk
	9cGfBbsWk45dlhvxCDX2cA3M4OCUNcrwE=; b=NbQiILWDIExWER4JTepGYwNpp7
	wXSHSwbAx0p1Dwpk3knYwchfGE7fnHXITdiIKdsWJ5ytaWGqxgkQY4gPkiB3pZq1
	kO0DRHebVXKOctVshHmdRc8nlnXi/MY0nw2drGKxbTiKF5Nao1Vuh9DIqjySLPwx
	zRwOiAAh/bIc/DOlGSgHTdY1mHgWFZcpqJtgiQj7yhGGf/vWDRyCDOcp94YhzY7U
	1NM0Habjh4iAY+yH3YAU8yvA7+aKJl7/UyX/37qDGxW9H5F7+8dkEJJHHTL11qDh
	cQ32rMNy/J2HB96XTp5BzCbnen6DP4fbX+p+ChoK9r9+eXOOYaWqAp0HC9bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726139863; x=1726226263; bh=2kE4tyGkPk9cGfBbsWk45dlhvxCD
	X2cA3M4OCUNcrwE=; b=dotUs3/38gXmP4uo2ibmamWxPTf9Bjuf671SseKhaheQ
	w99lBMWBrvufjESCkfFbySFaoM/a6C1GPrwXnjc9v33b/VhFq8k5qf9c0++193he
	bkPBiBKBUmdtpXKqlUB66RO0oLo+OPD7Z3IhiWRbH7FZIiONZx80nOEl4sgCwm2z
	8ced2E4Cv+kfYrx4gzd6O5QYN65U824r0RSe0ozbsTJlgtz+Fwml22LR3EV+qVqP
	HZxKnMCLQgViBuJEbpMd3125064+88A3gULZ4mByZ+BBQHTMvTfiHB7Iymqn0eRH
	A8sDG2igS6AUOSbz+A6a8/Z/7zhxQukZGOWD6plXtw==
X-ME-Sender: <xms:183iZg64l3Sbt6eJIDdYyIkPwec-UCcu1-UemV649KRRP7MfxUUQ0Q>
    <xme:183iZh4O1AzgxctB7egHYB_cUI_OxscRR4clHZloBThrnq_4fcBKyhPK_dZij14nH
    vVp4QdtfVvnJL9zpQ>
X-ME-Received: <xmr:183iZvdOAfoBjj51mo9xV29gYzcn5A-5rF1awOBVFubp9qMrTnc6jRblUns787QQFOCnFzd-uF6eUhENa8w6bHWImPh2f3WxoxrgDDSDQjDH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:183iZlL1F-KlOFMIYcW0Ya0FDbwyJWnF8Xlj8qbVeAaO9eAU_OjeLA>
    <xmx:183iZkLkdkqeaKO43-_Los5hey-TjP_tJ6fWRMDdH-nOqUnaHDZozw>
    <xmx:183iZmwYca9KWMhupKTCGzdHaC0185-qeBDuuseVdQrKd8zSFRaXig>
    <xmx:183iZoL_Re3H5LaSX5rn1Wg7vocNAoCbKnw4LbBDtA3AEJ-OBXlEcQ>
    <xmx:183iZugFcFGszi-lhrGifENeZg_PyL7VSyCadjXdUj4P_25llVb_7kJD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:17:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e113116f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:17:33 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:17:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] environment: guard reliance on `the_repository`
Message-ID: <ZuLN1Eq0SqncdteD@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <CAOLa=ZQ20ndA6cG8_9OHO-Ci5AHu5i2K6O+2hJ8oa6+nhxaPZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ20ndA6cG8_9OHO-Ci5AHu5i2K6O+2hJ8oa6+nhxaPZA@mail.gmail.com>

On Thu, Sep 12, 2024 at 04:14:53AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this is the second version of my patch series which guards functions and
> > variables in the environment subsystem that rely on `the_repository`
> > with the `USE_THE_REPOSITORY_VARIABLE` define.
> >
> > Changes compared to v1:
> >
> >   - Clean up now-unnecessary and add newly-necessary includes.
> >
> >   - Stop reordering includes in "setup.c".
> >
> >   - Fix missing `USE_THE_REPOSITORY_VARIABLE` defines in Win32 code.
> >
> > Thanks!
> >
> 
> I haven't read v1, but this version reads nicely. I left two comments,
> and I think the first one applies to the first few patches.
> 
> Thanks

Thanks for your review!

Patrick
