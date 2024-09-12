Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F619F429
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135510; cv=none; b=TTbclHKZRJVrRU/FxlayKzVuPpHeFNptlTjiGaeLN+t3Tj35RZHtUSquMCziETCIZczVAHlJZujVcetl+SnafQZFLrs10gJNn4RtDk3WsujGs5s3BaA3T05JGfa/eNL+K3zU1mLQng3ztpB11YB54FDUknLYmTrCfLwDfAbr85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135510; c=relaxed/simple;
	bh=0jT6iC7/kP83Pp+BltLsL0tPniWUMnvhqISHDv5iM0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXqC2hgdnLPjJqbr1S5GWsZ0ChzKd4wNZisdPMg+oql597bnwiUl/fsiAqePWB/pl2Od7VjztJHgRIbLwlsilbyoAmDjDm8Cfwz9d/5BQqZ8RP5uTXf93nQ8DYeby+/4x7BX8M9Qw/zi1JQmIBTZ7gVy2md6H40NTV9qag2x7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KwOuqOpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXfoVNZx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KwOuqOpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXfoVNZx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A08611140247;
	Thu, 12 Sep 2024 06:05:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Sep 2024 06:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726135507; x=1726221907; bh=XViXVyQAFA
	CAVJe7mGyoQusMDneJVNsDkexb9JM/LqM=; b=KwOuqOprm6+NOFnwjECkYcTWSv
	6worb91bBdOSJQmwQwnL6RAGb/eF8uigV+EgJhtM8nVu4V+/U/ZR71aVO3d64Pbj
	x7YfgCRx2W+NlwghrWU5Av9BgtFwcnfxi0hj+/N6kDRQ9WsDnLVwsr4VXayfZbmX
	hOWVyx2HNB+Se/NNQbDThSn2Nr3rY+mw0OatRf/qVhrp+YdCkVwnq3efTvEg/7SR
	3c084VPWiLfwKzPkvVWAiTUuE9oIGpP7rvtg2H1WLeMZl6v3FWpXr+VJdmHIZJoD
	F+rhEOgH7OtatluMCEnIT9ZKKSjjq/W+b9SE7Ow4yek7D8JYFz3HSeREbnkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726135507; x=1726221907; bh=XViXVyQAFACAVJe7mGyoQusMDneJ
	VNsDkexb9JM/LqM=; b=bXfoVNZxC4f+OpEBl782Zj9576vyCmcERkCDaTH/FwL5
	j8Xdr8SChIaNoeelVbHxVtxmn1GLi/6fxnsEhziR3lnhadv6BkkSubBV9qOTWtKW
	1itwOXQHikQSHaLA/JJyLVnoSKDez0OSvAPZ9QJKNdiEcTNjOlfeEf4eOOSLBabJ
	SXXd56ZWAZddiDAAwkVqiQ8NJiV/15sV0i6pygFiWAHN2gyUR3VEtoGfNxz2GrP9
	Glt0hBSj1bEE5KlI8V7CEq9+X7QXvQMjgO3HrAFdkXHrGULDUeq1jrbZOMfmkUUo
	kCHvBn/r8GZHNH6TMkEnailbi12TnBgyUG0YZq0emA==
X-ME-Sender: <xms:07ziZgoZMowcdKUzgnypjyX90nHwAcZvYkMkGGT6KVxnTgrNVm721A>
    <xme:07ziZmrBAb0sdIBiJmYQqCywWhegG-_0MYd9_wbLKHPbvt54TAWmC3KdPcM9QU8h-
    krxXG95eNZ-ksetGw>
X-ME-Received: <xmr:07ziZlPunD42F5K9hqH-B35pSHzA9OYdln0Zg1Nhw5xpLhbzvd-59OMrtQ50ik-au3ThgJ93RxhWf5cdn1TNtA8_MvRVFqxrM1surksMhske>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhhtggrrhhltdekudeg
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:07ziZn53V5pTAeLzXBqGU6p92EdH9Yk_In_6OK5gSES34fAMxFoSsw>
    <xmx:07ziZv7YBPUgbNp5QWGbCe9NY9UBgcz-i44IJ9Uo6k347ub3i3RC2g>
    <xmx:07ziZng0E32Y0vQEN1ecmN7PkwndEWOlw1bqDAAo16OrIKD3_sHw8g>
    <xmx:07ziZp64jmNu3vMNKPxdaCMtY3djUlPapHvkB3FwUz-cW3KC6dIFPQ>
    <xmx:07ziZlSw-0jxj_TOBYau2K5yZZPTtoUVc6SPS0lkPlR4-WYwa34kSCpD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:05:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07dd86b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:04:57 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:05:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 4/4] remote: check branch names
Message-ID: <ZuK80YvPSo8WUpp2@pks.im>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
 <xmqqfrq686n5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrq686n5.fsf@gitster.g>

On Wed, Sep 11, 2024 at 10:03:26AM -0700, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +static int check_branch_names(const char **branches)
> > +{
> > +	int ret = 0;
> > +
> > +	for (const char **b = branches; *b; b++) {
> > +		if (check_refname_format(*b, REFNAME_ALLOW_ONELEVEL |
> > +						REFNAME_REFSPEC_PATTERN))
> > +			ret = error(_("invalid branch name '%s'"), *b);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> This implementation is inconsistent with what "git branch new HEAD"
> uses to check the validity of "new", which is in this call chain:
> 
>     builtin/branch.c:cmd_branch()
>     -> branch.c:create_branch()
>        -> branch.c:validate_new_branchname()
>           -> branch.c:validate_branchname()
>              -> object-name.c:strbuf_check_branch_ref()
> 
> At least, we should prepend "refs/heads/" to *b, so that we can
> reject "refs/heads/HEAD".  The authoritative logic in the above
> however may further evolve, and we need to make sure that these two
> checks from drifting away from each other over time.  We probably
> should refactor the leaf function in the above call chain so that
> both places can use it (the main difference is that you allow '*' in
> yours when calling check_refname_format()).
> 
>     Side note: we *should* lose "strbuf_" from its name, as it is
>                not about string manipulation but the "strbuf'-ness
>                of the function is merely that as the side effect of
>                checking it computes a full refname and it happens to
>                use strbuf as a mechanism to return it.
> 
> Something like the patch attached at the end.

Agreed. It's also kind of curious that the function lives in
"object-name.c" and not in "refs.c".

Patrick
