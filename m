Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCA2A1CF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804799; cv=none; b=JXupt/kdGERrwA/rLWseG0iElmIkukZMNFyzQX+N4fiYtQ3FihSM1RPt4h5pjAl+Pra+8DOWgf39QGWY5042CzkSlCdzOS6PgnXFo+TAT8d20d1D6djMLjY/0RttDGjLYNdFCIurl5cUw3G3zan8pY2MzkMMfG/EBTc/AmHSO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804799; c=relaxed/simple;
	bh=VFI9/VHwr2qpajWtI2saYLhTrRarKBaaMq0kdvLxCZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACH+uDTesi2u7hiQvesXj19YRyjKcs0SYZqBB3QKGVEuRrPwTsppRGZ6YvE9q6SE9s+9oYcwezzfnZNKespnEgcX4TknFvziNvwfpS0Snk09IPbFHaOO/Q5NCzoGm4eQJEi38WnagzuZGHtIWjCHgXowRCCIBx8edvQVbn8WbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K8Pf+4WI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q9+FD4Nc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K8Pf+4WI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9+FD4Nc"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6E5C41151B49;
	Fri, 16 Aug 2024 06:39:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 06:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723804796; x=1723891196; bh=lWeL80NRwr
	qk/3nBlCx1xgj0kEF/YTldtHLBYEU58nA=; b=K8Pf+4WISky1Ge+U/ONZnptu24
	3Bf/B00S1WPiDNz5p7OYROXZYqRikkwdB9wyjSyJ96TD9z/ySm1H++fV9oBb+swJ
	GCsjDueiODm+8YeOgMYl9JQ7G2toJ3qd5t9AYRiYjZuFkVPFUOp6LxM5yOAWTrSh
	2iVQTXwZhfkI9AIBXlQMlxVM39cykzhjY2tKE8IdYrRUPIYjkVHNUJQ516GK07QC
	EWlAqD54m9+IHtJw5Lw7lxaRc7pWFDsCu9JWWAPyv3wAi/wMiwRM0X+95zM3D/3l
	vBI5ibOGyS5yThrJPmCt3oLUp6l46/4QFMCOJnqDiRu/1Jpdt7emnyOlMKog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723804796; x=1723891196; bh=lWeL80NRwrqk/3nBlCx1xgj0kEF/
	YTldtHLBYEU58nA=; b=q9+FD4Nc1wlfT1PHc3LpWVPKcJY3ZExNrCiIg2cXgO2W
	1ew2+x4Zn21BePp6pX5XHLhQ0BkEs2yXDKPPNC3KoZIa3qKpzr4vNzxTKP5U4rq1
	uwzXMevQpQUYrlHdJg4fuNxpYe92TL7sxeb5mINiSlHCTb+f5U5Je+xGuUWrBx+q
	7h5cqpwijU2fTVCg1aDr+Efjw0hLTyW/XJtRfhis19xo4GpcO6MvKejsZfY7s7kZ
	PFQnZNsgBYI7Lz/JYSpLiXxh+ZNThLfaHCaD9vrIAHlDD+g8r47dOiAUdUxgr87T
	/qSHiHdv2Z/Tzj0Gd1DKjzCP8jmNvIGJXWB73GXUnA==
X-ME-Sender: <xms:fCy_Zur6pmRMAbFCpdJJIX5TA7u7dvVqPnBVOVSAvmD-VBSnTiJnUg>
    <xme:fCy_ZsotNWQbnDnqX6HPtP3zA9DdR9PjiOHd0Es5A2F390A7b_aWmVnO_uEwcWvxL
    woR1pgyA4R54A75UQ>
X-ME-Received: <xmr:fCy_ZjNTYMuebm08gBQ6ztDHv2gjz5YVk2G6vgmZiw-xslzbMUblOGT2tDyQeXt03s6TGBPxwG-MS4dQdxzbDn-wSuPj3wCi4FhvI5OhbKUmWj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhiohhtrhhsihhuphgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fCy_Zt6qqlTfYH_AhdL0yv6kM7YaT-54iNSVRTnOfJrQxbPTAkt-1A>
    <xmx:fCy_Zt74Gacb8KW-27uV6mjtf4R8Xf27ZHq5qCOOCwBGNql-KVhZqw>
    <xmx:fCy_ZtgGNe0BX9WPANXDK1R4P4EuyJmK7VE4zGSou2_XfHff18wOOw>
    <xmx:fCy_Zn6Ld7WC2q4lA2pQoP9U-4t8CP_mTh0grFE6vRe6J0PVPPwtrw>
    <xmx:fCy_ZtEDzELd3iSLSaneiYFJFXcy7Fht-kftlBK-6skWZJj_onCQmz-5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:39:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9905ac3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:39:30 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:39:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Piotr Siupa <piotrsiupa@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: "git-stash --keep-index" crashes when there are no tracked files
Message-ID: <Zr8sd01HNGwd8zJC@tanuki>
References: <CAPM0=yCJ0snEznK0C+zkmGofWHE3OPWoMXSVGH6=TdM7=rZ84g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM0=yCJ0snEznK0C+zkmGofWHE3OPWoMXSVGH6=TdM7=rZ84g@mail.gmail.com>

On Tue, Aug 13, 2024 at 07:36:15PM +0200, Piotr Siupa wrote:
> Hello,
> 
> I've found a bug.
> It's something that's unlikely to happen in a normal workflow but it
> breaks a script I'm trying to write.
> 
> Here is the complete report from "git bugreport":
> 
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> git init
> git commit --allow-empty --message='initial commit'
> touch foo
> git stash push --include-untracked --keep-index
> 
> What did you expect to happen? (Expected behavior)
> A stash entry storing the untracked file "foo" should be created. The
> working directory and index should become empty.
> 
> What happened instead? (Actual behavior)
> The command did what was expected but after that it crashed with the
> following error message:
> error: pathspec ':/' did not match any file(s) known to git

I would clarify that this is not "crashing", but that's basically
splitting hairs. In any case, thanks for this clear bug report with a
nice and simple reproducer. I agree that this is something that should
be fixed indeed.

Will send a patch shortly.

Patrick
