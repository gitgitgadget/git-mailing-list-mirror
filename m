Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6014B092
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738357534; cv=none; b=MBBQEJAUhNYWX4UfdeZxr/3b6V4V4CSayorDPdfkRQ8Ze1Ew96Xv0LmNccCnUr2z3PECimK0JohIrqY0LGqaSjI6x1aweC+XN2nH099UNl9hPxIqoYojLI3mu0QsH6zaph5ydNtkW8Sj5cjDaD5I6DoLi45O95tl7W+lsB6Tjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738357534; c=relaxed/simple;
	bh=X5jTHiHIe5tNbwkl5jyY9ydT+iWW1fvcahbrEqg4kxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSU/vDsa5Z4IamgBtbKI96wfgF4LCxkeZlUtJk8+DZ6Tg00FyToLkSf9u+7uOjQNnxLCeqast2w8zwvYHD8tlVGFpO6ZvGZ+GAJtqJzTbNZaV7r35G9oxhAMT2TcdTDC+hwiULdrL5uTqOKMU3sFtwKKAaw3KTpij+Jd22bgoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VudZwb/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQzMMpTV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VudZwb/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQzMMpTV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 47870114010B;
	Fri, 31 Jan 2025 16:05:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jan 2025 16:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738357531; x=1738443931; bh=x+58Ptr0mg
	25pr19q9DpoZpcLAujteG4A9HQyC0/m5Q=; b=VudZwb/FFHhweGtrcNRTL2pjyj
	O5B8XIAoj7WBhk0duAIRFgkQeaIymuFLZZClRoZZHJsSnTxolFGkuXlQoasdnQrx
	KbDb4q5Yltnt73KJjkLgFEpwVp7sa1HF3m9RwGTQVBWN6i/DYPrTGeyea3k8OXGs
	F8Fz1Z+pyWymOwDjTGPmB9JblYulmdHnvAsB09bMfrAryOmlum96RbfH4tvkPxaK
	gEWF+2zRlvO1RG2zFXT8MSaZCxwTrfzkZofeIlRSD++xKGVOIckQbiljDLUVxccX
	KaUVLTGNibB9W9pghdHGqR/mPmwRLQ00IcYw5F8p1dWqk5QWtmZSOXhcWzvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738357531; x=1738443931; bh=x+58Ptr0mg25pr19q9DpoZpcLAujteG4A9H
	QyC0/m5Q=; b=WQzMMpTV5wbgENaPglcPn09zgeTpLFkmSweZWCBqh5bNjGY36UB
	M9yVlCEif7e/OVAvfNMBZ3lNTZP0tftBemEVg1pWuj/bFWkyAaV1Zg4t0tXPq/qz
	S6fqfltySVIlSgyou0fR/XGBPiZSwm6GQsXwxsNNT4u6llPlOks6jCrCT6eB8nQr
	axK+td+GlXGKgnQUMYbzGRoIOmFDcBCtyr8I+cDaIvq627ovsCEeL0cgFT3tWRYS
	OLItHfwdB0Nu4pShjTUitAmNYGB2IB6UPvRVr9hQlSgXdxYzsZjYgMr0HQQKqObu
	rU/689bnRCmDYHVjwzcT7qWDY0sSKG7c+DQ==
X-ME-Sender: <xms:GjudZ9Jvouyy2AIDpKwKEgPP0re9X3HMJdOrxMbEQ60qK4TMnYWOCg>
    <xme:GjudZ5JkLivewChxqEMk0FPf2RZvTCiZ7NC5PXHAFoKNrXvF19X7Bhu70LMoL_XGQ
    EQximX-n87Jojvl2A>
X-ME-Received: <xmr:GjudZ1tWFFuFbAQOcLY2KKJGNllYYYfo6skj00FCgCxWPkjm2H1l5yuPoN62XlOPtbHIr0C91_TVvseLxIdiocDio3qKeP0MSj13>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggvpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GjudZ-byBdhTsFYX_7ATqyZNeQIBvjis3vnUmfWbD9aPt4PvqOIUSg>
    <xmx:GjudZ0bUDu_3bYk9SwNF_TjHCqJ_M1Qvluv7ZSg-Amu5NYip4SBMYw>
    <xmx:GjudZyDidQEgVZfk9DvK7HZEK1z4xECkA9HKxbMK7LD6rXfKifS_vA>
    <xmx:GjudZyaZdzAJgMY_TLJ-4ahvJKPWr-No1tI2D2O-mjnveZZAGh6d1Q>
    <xmx:GzudZ043IphUVudrDhoZbP92a4n-nnn5ChoZcvUHM4vOsYScZ9WbM_J3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 16:05:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 6/6] builtin/clone: teach git-clone(1) the
 --revision= option
In-Reply-To: <20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com> (Toon
	Claes's message of "Fri, 31 Jan 2025 16:30:34 +0100")
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
	<20250131-toon-clone-refs-v4-6-2a4ff851498f@iotcl.com>
Date: Fri, 31 Jan 2025 13:05:28 -0800
Message-ID: <xmqq1pwi7kyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>  		OPT_STRING('b', "branch", &option_branch, N_("branch"),
>  			   N_("checkout <branch> instead of the remote's HEAD")),
> +		OPT_STRING(0, "revision", &option_rev, N_("rev"),
> +			   N_("clone single revision <rev> and check out")),

OK, this thing comes as a string; we'll parse it down to a commit
later, hopefully?

> -	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
> -			branch_top.buf);
> +	if (!option_rev)
> +		refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
> +				branch_top.buf);

> +	die_for_incompatible_opt2(!!option_rev, "--revision",
> +				  !!option_branch, "--branch");
> +	die_for_incompatible_opt2(!!option_rev, "--revision",
> +				  option_mirror, "--mirror");

So here is where we mark the new thing incompatible with these two,
and when either of them is given with "--revision", we would bail
out.  OK.

> +	// TODO --no-single-branch

Style.

> @@ -1381,7 +1396,15 @@ int cmd_clone(int argc,
>  	if (transport->smart_options && !deepen && !filter_options.choice)
>  		transport->smart_options->check_self_contained_and_connected = 1;
>  
> -	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +	if (option_rev) {
> +		option_tags = 0;
> +		option_branch = 0;
> +		option_single_branch = 0;
> +		opts.wants_head = 0;
> +		opts.detach = 1;

option_branch is of type "char *" so sparse rightfully complains
that you are assigning an integer 0 to it, which follows stronger
rules than plain vanilla C standard to help us avoid mistakes.

But stepping back a bit, hasn't we already been ruled out earlier
that when option_rev is set, we cannot possibly be affected by the
"--branch" option that was given at the same time?  I do not now
about other assignments we see in this block, but are there others
that are unnecessary?  For example, you do not clear option_mirror
in this block.  Is option_branch so special that it needs clearing,
and if so why?

Thanks.
