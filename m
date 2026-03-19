Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB782D8399
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954897; cv=none; b=XXyQ4q/5Cz8ZYcay9wCx2531XVjsq8tNUNVBvC6QW/Er7m9DrbS6iaLTNI1pMWBsu1iQJFPo4whbKeW40lSBW65lfHpOjQXbd0uEZdl2ZpsRK3eLiQ2f7yZEcAowzHNnmclyG6kh1ySJh34azWmz0MkJUwwlKEdEkQ37SbZwpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954897; c=relaxed/simple;
	bh=GDDKgyvv5qve+NtW/+bxoW+1zMHHfLIB8Hc6P+3CT5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOhsu50IA8s1biOdrwUfHRtGN2f/Gb60Tegts19PXjic30w7Od8S/G67zGA10PI2uRtwLY0ZPDlU+oqUKYPSzizbGY6M0GlYz8lcOFlcB9YilNLMhautHF0JCJUFPRLKwsN58T7H+OwNzwYvF5KlSuA3hsJGNKLyNh5l8ugVsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NqfJavIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmmFCiL2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NqfJavIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmmFCiL2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D949E7A0047;
	Thu, 19 Mar 2026 17:14:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 17:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773954894;
	 x=1774041294; bh=+cQRR3JUcSYTL5gyGt/ub7NBkhbE3VI7kTddsdsueIE=; b=
	NqfJavIRvtk85sxue97NhVBtz2MmV0IkI/cfIZEbYKE2J6Ztr1EzOCSuTDAg29z6
	2I68tD806/eGkITF6HMDMRawiDqQ6jZkBGFXZj2lEC/PZOSpXknCBJeDdIHj2PyZ
	BrHodPf9Lsky8YF/gnsmQ7MiZ3ww/E1vuJ8qB8UW0w1mYkRmi8WfMg4rc18SI10j
	Uvg9Ik1SQX4stTohJPZ2JgTKjAKqrTVIfZe7ahBGpp6SUzZQF8cV6MTo3EDQgqHP
	0YdZgdDLwKQ1sC/ktr0zGngD6lgWsbMHyv3Q8r3bISrjFvDkk9e65g11CqMOXg6z
	3YmKwpFcMO+/q/coKJqwiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773954894; x=
	1774041294; bh=+cQRR3JUcSYTL5gyGt/ub7NBkhbE3VI7kTddsdsueIE=; b=E
	mmFCiL2AhiGxZJiPYE/9V3D1cl9+jABJZHnXBH1+5zQzvwIzrY1BE8pbohsyu39E
	H/NTf9Sv2SkHehYSvjFn0r5Ovhf05+DiCSj3AKciM4DYVSnmDCNvRaj+RFvh5t0W
	wN86W1yVBPYFIjfRbBkGiWkR3qw3Pn+pk5nyCxs0O6KpB8K7YIqVUea9zFD7PQw0
	heHmmNGVRJlU3Qxw8JZGMAE55BidmOCdPixRxAbdzcaUZ84DQqv3Yub6+foRjM+H
	nijG7pCWbEqnlurMhUoVV+lnPoJkqcmPnK5iSzJp1D4ppi/WKrHHw66sT2L4Kos6
	xmClCWW0JVBmZDLZz1N1A==
X-ME-Sender: <xms:Tme8aRM2VbntZ7lMUUKO-k4XlYDz7tEF-rXRbW-OsFZzcYXo__8uxA>
    <xme:Tme8abYPM31ELaGSIlt5OBzvp5QUOEtx3OJjaixRjoC4ySizVg8xEuFdJKBmbfml3
    T0XZxnXc1N3_ovUYV1jVnzC9Pl7u0kZugEznAi7mEAiIaTJ0Uz43Q>
X-ME-Received: <xmr:Tme8ado8IbPE3GzZ3XqtvQxKKG01lxiw8C3vayGdI2gehu43h9AUMMiPAl2XpauuUOFAi4NYiXY0ttBcn9kHto29xOCT26Pucw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdektdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepuedttdeigeeugedvfeehhffggf
    ejteekgfffteeuffdvleetffeikeeuffeiffdvnecuffhomhgrihhnpegrrhhgshdrnhhr
    pdgrrhhgshdrvhhinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Tme8aXZIlS9v8ADTbIb22hE4LkN3Bn8ij6SvBtHbkqLBh3ojcjf1Ew>
    <xmx:Tme8adRZ0-yo0MxV6xwZa62FaVbZVPfGzmMp3ZX9DO6YkSqudmkXHg>
    <xmx:Tme8aW44s2pP4wKSxg3UKsF_zzSGRnd81IozEJQjMr1L440nyK0t3w>
    <xmx:Tme8aazkPEqm16zc7-hnm6m2hXBj2i-d9W_dy7BOZ6X_jJwWpn0QBw>
    <xmx:Tme8abDqGjKzKlFDgWHZfPF_GIwrXfJqRIfgFGDc72qqFM3GWxdGjl8y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 17:14:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] use strvec_pushv() to add another strvec
In-Reply-To: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 19 Mar 2026 21:49:05 +0100")
References: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
Date: Thu, 19 Mar 2026 14:14:52 -0700
Message-ID: <xmqqwlz7iks3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Simplify the code by letting strvec_pushv() add the items of a second
> strvec instead of pushing them one by one.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  fetch-pack.c | 8 ++------
>  git.c        | 3 +--
>  submodule.c  | 4 +---
>  3 files changed, 4 insertions(+), 11 deletions(-)

Nice.  Is this something we can make a coccinelle rule for?

Something like

@@
struct strvec SRC;
struct strvec DST;
size_t I;
@@
-	for (size_t I = 0; I < SRC.nr; I++)
-		strvec_push(&DST, SRC.v[I]);
+	strvec_pushv(&DST, SRC.v);

perhaps?

Will queue.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6ecd468ef7..a32224ed02 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1024,12 +1024,8 @@ static int get_pack(struct fetch_pack_args *args,
>  				     fsck_msg_types.buf);
>  	}
>  
> -	if (index_pack_args) {
> -		int i;
> -
> -		for (i = 0; i < cmd.args.nr; i++)
> -			strvec_push(index_pack_args, cmd.args.v[i]);
> -	}
> +	if (index_pack_args)
> +		strvec_pushv(index_pack_args, cmd.args.v);
>  
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  
> diff --git a/git.c b/git.c
> index 2b212e6675..5a40eab8a2 100644
> --- a/git.c
> +++ b/git.c
> @@ -877,8 +877,7 @@ static int run_argv(struct strvec *args)
>  			commit_pager_choice();
>  
>  			strvec_push(&cmd.args, "git");
> -			for (size_t i = 0; i < args->nr; i++)
> -				strvec_push(&cmd.args, args->v[i]);
> +			strvec_pushv(&cmd.args, args->v);
>  
>  			trace_argv_printf(cmd.args.v, "trace: exec:");
>  
> diff --git a/submodule.c b/submodule.c
> index cd879a5cfe..4c8c674aa4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1815,7 +1815,6 @@ int fetch_submodules(struct repository *r,
>  		     int default_option,
>  		     int quiet, int max_parallel_jobs)
>  {
> -	int i;
>  	struct submodule_parallel_fetch spf = SPF_INIT;
>  	const struct run_process_parallel_opts opts = {
>  		.tr2_category = "submodule",
> @@ -1842,8 +1841,7 @@ int fetch_submodules(struct repository *r,
>  		die(_("index file corrupt"));
>  
>  	strvec_push(&spf.args, "fetch");
> -	for (i = 0; i < options->nr; i++)
> -		strvec_push(&spf.args, options->v[i]);
> +	strvec_pushv(&spf.args, options->v);
>  	strvec_push(&spf.args, "--recurse-submodules-default");
>  	/* default value, "--submodule-prefix" and its value are added later */
