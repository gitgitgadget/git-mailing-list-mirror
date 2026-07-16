Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E543F092
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237728; cv=none; b=a6Bs2xFU9zlbyN/Ptr0d8oOkJJK6DsDJER15RHsqPCk0zSWsO5CQBUjum7Fm+svVHHqUbau5oEEOANdhbFuMOm61YaAUWazSKD6qW/5/ed6nRvb9/etuo0FfXJSfuEJH1STNCwH6F4MwzY2h9iec1cJFWRjqv7KmGEPpkpuM6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237728; c=relaxed/simple;
	bh=jAjwMvhWVro87coMjdYjJjml7xW+nFCGj1qQThb/sRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nx/F5mQ2TlFEe6BmB0gVW0+0SrPRUC6rXSWtVKRNH/AiU4dHSYMkjA/XV9+DkE7Oo2A2ZvK6RSCPAUoiQz2C7qEStAEaXDiPrFhYcPrzfOGg5yluRlW4YbfUBM3PhMsOVBDFlyVLuF/7qgmxgdsorLwX0qTmhAdQqP1+4VdFX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N9c2uy7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jiuwGsQy; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N9c2uy7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jiuwGsQy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C053EC011C;
	Thu, 16 Jul 2026 17:35:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 17:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784237726; x=1784324126; bh=ErqwiAxqGl
	GR+YF9DUw1hd/zorZmiVtWFT7laFbebTE=; b=N9c2uy7Qw2HwbMdbiiVOjGyIm+
	82yrGKRLTAdTFovQb2sYrnL2UU5YQFmD7nyiBGC3wgwPmkKNdamvDl+m6EU886fn
	5Z0+qWcsQu8TpqZm8WftlsMBN1F336DnfY5zJDZODqWrn+om4cTHnykoEe3UzFDZ
	V0WelUEEdxc7LDlGHamhLZBCdzGDB14lOdxL/cndgXSPVMng3mWm37VC9QgJrvLS
	9bVrBlJLgMM963cR/K0nPkIMxZbDtaTelwEil/NlvQS84arPTvwgS12VDYcJmgtm
	knDW1KWQlrQ2lXY3gz5RngpVSBe9Sn4ELP7nm/U2J4dDKq/YqScAkbBAJ49Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784237726; x=1784324126; bh=ErqwiAxqGlGR+YF9DUw1hd/zorZmiVtWFT7
	laFbebTE=; b=jiuwGsQy2BT0GJ+yMaqCLn9JkHsfzYJdKaSnBsKFA0eRLu88WXv
	JNQSaOoOy1c4UBCGBH30yVfkyfDikpOXQie8JsJROmLO16VgHdeP3AasGtqC1UMZ
	P7D8MlxEYPmycBY1jzr1ltIzpwm3JXZEdiXqsXnZtleWW33eZPS2vMMU3z0IG/ez
	SFbW4Qmf3EJXVLaXz3SiUYKW0q2zy8kX4gXfQgnSMp8jo/h+LxnI4hoVTs3W4sSu
	vOwpE/rxa/nIcaxgRzoKHNcmQBIJa2gxMSd3mrFfJ7CK73prOMHnsoIb/9kFnl9F
	UQ9ktQ8JH4nMaei1vfuYcWqcRGFDbhLhr7A==
X-ME-Sender: <xms:nU5ZanSzHMWMar5ews2Kz7dJk12fnjrBWpex_VKT7WEfPNtiKIQmEA>
    <xme:nU5ZalWHLjX6BRbUvKbx_lSh-UALq863Z24FgEinEA86YNq1alX1efWjneSpsUt_H
    w7fjcjTbqnYH1kwaogzOjc0HtMlAZA_30uzIf0wypOq-czpmWQVcg>
X-ME-Received: <xmr:nU5ZahQ2aF5DTW2N1GWBxhq1TGMTwzvU7STtE_-9o4p0CppUBwAaYu3K5W-usIz-KGQrUT3pNBvjSXeNOf0dyaSMCVH1aQa71ZoyZBY>
X-ME-Proxy-Cause: dmFkZTEU4nnSNHJy1a+QYAUgNOeLZSfCslycrmoIILNICGXvn0S6TQighRzbUYqXEjTCiU
    0QdS7SMTK31wFhmrcr7doGeKzYbyqzWx/t0BoF3ZFzNdH2htNItPwtJ4XbqucMTse7rew0
    EEf4E3QJLaNcUsoNUsXfbiQoL2tkH6s+2g5pzw31q9sRmLqqnNAKnXYv7TDz8qw8GGs/dj
    thCdm27RfwQ5ubnNPIPZqpnu3Ern+bttfQbeF+YJU0Lvlht8NSVR69vxySRcOsaTgfTwUM
    qDXGeTmYOnbbDX5UFmgvVfSR1D45Ab3UGrstJX1mzdm4oXPqqICQD9mYagawzl/3/HjaEl
    fZSGjvfl8CuZ8i2CDYLVxocPrrTJA3/Nc4UhfhnTXMGRl/5IRfbmi8Ls3nOElFVhUsvdHO
    kV8iWKH8LE5UBnouldyO8KqoVQA880LqK3I2LMYXGifAt4bjSMXrFyDjDLzXmH7qh+6ORB
    y4AxP+xYE4kqfgEiFQirwCOw6MxuSjcr7MXNT2vlKeki+6lyW0pSdNdSNr7qLvkgwdOIrU
    2XYmkcnjOzTa4yFKa2pFgp03wTIS21BekJft0yR0rNfTkwKGPubNvJn00s7YlMOX8A4aeA
    E/+mBE+JMgPj3dm60FvESnlg0TIaLTNNjjQVUCyrAOeGDStc+hG29Z4zQuJw
X-ME-Proxy: <xmx:nU5Zat3_2TUD6itIjOO0hYKZAl34euXrzAcL20arR4ezOEvLU3dh_w>
    <xmx:nU5ZahdXjKulqz7iMNxqgxXDLnfNkWIc8j1qphXU4DEaG46Tza5DxA>
    <xmx:nU5ZalM2NjXKEl_Q4M7W2FsOX6wlhhzPmWCKsRGvl0tpJoqkJkMXaQ>
    <xmx:nU5ZalUcKP_qADDg1fVIZbL6BREd3Vso_8FpQQ52yLe3SPZt8QDEsA>
    <xmx:nk5Zar-D4ruq70TBjE_v2tab7CoC0g8PrEWeChS-XVuVNJR9zYiXKLWK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 17:35:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/7] fast-import: use struct option for usage string
In-Reply-To: <20260716165517.433849-8-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 16 Jul 2026 18:55:17 +0200")
References: <20260716165517.433849-1-christian.couder@gmail.com>
	<20260716165517.433849-8-christian.couder@gmail.com>
Date: Thu, 16 Jul 2026 14:35:24 -0700
Message-ID: <xmqq4ihyehyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +	unsigned long pack_size_limit, big_file_threshold, depth, active_branches;
> +	char *edges, *signed_commits, *signed_tags, *date_format, *import_marks;
> +	char *import_marks_if_exists, *export_marks, *submodules_from, *submodules_to;
> +	int opt_quiet, opt_show_stats, opt_relative_marks, opt_force, opt_done;
> +	int opt_allow_unsafe;
> +	int cat_blob;
>  
> -	fast_import_state_init(&state, argc, argv, prefix);
> +	/*
> +	 * NEEDSWORK: For now this is used only to render
> +	 * `-h`/`--help-all` usage messages. The actual parsing is
> +	 * done by parse_one_option()/parse_one_feature().
> +	 */

OK, I am a bit torn on this.  On one hand:

 (1) I do agree that it would be nice to eventually have
     fast_import_state_init() (or some other helper that groks
     argc/argv) use this options array to parse the command line
     arguments.

 (2) I am sympathetic to the position that doing so is a bit
     outside the scope of this series, whose focus is strictly on
     "git fast-import -h" and nothing else.

 (3) I suspect that when fast_import_state_init() does start using
     the options array to initialize the state, the parsed results
     will not be stored in the variables this caller currently holds,
     but will instead live inside the fast_import_state structure.

So in that sense, the huge list of unused function-local variables
above are merely throw-away placeholders.  When the real code is
written, they will disappear, and the references to them in the
fast_import_options[] array will have to be updated to point to
members of the structure (or global variables).

Still, seeing all of those variables left uninitialized leaves a
slightly sour taste.  And because of (3), it would be a clear waste
of time to go through the motions of initializing these throw-away
locals.

Perhaps we would end up in a better position if we bent (2) a bit.
After all, my hesitation likely stems from the feeling that this
series stops short at a slightly awkward spot, having already
completed 90% of the journey.

For example, instead of inventing a local, throw-away
"pack_size_limit" variable, wouldn't it make more sense to refer to
the existing global "max_packsize" variable from the options[]
array below?

> +	struct option fast_import_options[] = {
> +		OPT_GROUP(N_("Common")),
> +		OPT_STRING_F(0, "date-format", &date_format, N_("fmt"),
> +			   N_("format of the commit/tag dates"), PARSE_OPT_NONEG),
> +		OPT_BOOL_F(0, "stats", &opt_show_stats,
> +			   N_("display some basic statistics (objects, packfiles and memory)"),
> +			   PARSE_OPT_NONEG),
> +		OPT_BOOL_F(0, "quiet", &opt_quiet,
> +			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
> +		OPT_BOOL_F(0, "force", &opt_force,
> +			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
> +		OPT_BOOL_F(0, "done", &opt_done,
> +			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
> +		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
> +			     N_("maximum size of each output pack file")),
> +		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,

Thanks.
