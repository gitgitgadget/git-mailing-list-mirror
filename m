Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54677239E7F
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447736; cv=none; b=sse8as597JXvHAg7Mzkr7zKmFHecQqaFpsLWujN1RI8uZe93KW5x7URrxGz8JCr4PN/Vm9w/huEj/TlcCmE4rzf06yXlP9MWIP3JPQ1YQMO/uxIYi0+PXzNRJUrjuRZSwRiS7VigKNPCV/Lzt9+n3eddwDcUwtH+x7Td4z/jOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447736; c=relaxed/simple;
	bh=4vTFyDaPA403nZPwimynycxuZhcy2yrJ4OYGJJ2AG0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lis2cCujFUuybSSYEwkqdAl9mrgL6rq2v1qXV/V0+hXWlzHjQgtkR/1blNlyDJ1KppKiSTNUvTLPZPOrGxCCI6jwYSo1x8OIK+ZimS5hWbx1Mdfj3deNMEJERFjqnZ01diB6wR304wHFLVVGyye2eKZHLYZldas2IpYnAvOQfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dRDL4e8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EAYZ4gDM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dRDL4e8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EAYZ4gDM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AF1201D000D1;
	Fri, 13 Mar 2026 20:22:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 20:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773447734; x=1773534134; bh=/g6Fi3PqUC
	G47NxUiIYQlMytRe65apqVx/RNoy2erk4=; b=dRDL4e8eYHAmhSF40URrKByp9b
	8pNvRt2OKJo3O5NdPcbKtRz24U9IbE2vUKrWrSFZKCfpMOb3YpE3xT98T/AWyiB3
	8DEgtVY7Nr5jJznbgnKNQipgFGpvBX1HVzySswxtSahg6GJOLwnpvB7N5OyiubC4
	XZdOZ8ubZWlI0OODaKqsEaeLaHK0/4zSLxkx9bo6PZU3GnbTHJEWNtaWdAm8J1qC
	XRr1q2BfMEzo9m9Ogpb7MKSm96yp4IU75XnyBMnN+xtsQJDeXJvYXgYB0jgj++TX
	DfKFSiV2sjes/Fcx9jILlb1UOyovK6N5zTYO6WqiT9Zn2QDxViWCUNq4BrKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773447734; x=1773534134; bh=/g6Fi3PqUCG47NxUiIYQlMytRe65apqVx/R
	Noy2erk4=; b=EAYZ4gDMiSQEugZS4O9kt0hXFywGQLCtxK7+U/Ep2GGTMOwCCFV
	jKW5ApJShBfzD2fhMZKMFu1vbWLTTW+80FUUY2hl47PlohmS4/jXAOdIGNMmgQWO
	3BPQ/IondZ9JQ+pgXuRdbzFcAW4V1N0qXY43hDwG14bRzKfWo7EjeYM/ugSb1R96
	qkLEVlYEq6SRO6IQOaxcUHg9wNek63dyPspsFhIvSkicPLINgwy8epX/vtIoax7c
	cDLh5/xVrplXotjjiJdcRvpKOwhugr3UROdPDqL5aDHEgbBVZQuAxU6cDDAMU/5c
	q1Azu634fhxzlQrwjwiV/C41mHqF1pzNW8Q==
X-ME-Sender: <xms:Nqq0aamODYb5X4JD11mci8ytqvp5e774ZFInUKAfoCdQ8ZLelJiqzw>
    <xme:Nqq0acahp8EgmmHMMsvLB6FiXty_n_Kss_aTkuf7kugqurHtGCHWZ-65J26G0TMsa
    7n_gS-IsVRyK5x9jYObOliIqMJic9i6sLPwHm05v0CYZ3fRVlThPtc>
X-ME-Received: <xmr:Nqq0aVPTX78N3fXhmNGcHS1zfQbyAt4AxgXoOge1WxqZCHICAopUUd4bneJqZYgsWlyNhkd8ZKYLaLgVGBaZJslwAycxsGr3tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleduuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:Nqq0aRbCbgtROddVRc0ndQ4FjUYqht7LPgqkKRU6YldKbbL8XYbFiA>
    <xmx:Nqq0aT21Zq_-T-sSA5ADIe0IE8nS4qT7ctBxRZEMN3Qx4ODgbBumQg>
    <xmx:Nqq0aXcMt3dvlMA-OOaTf4SDKigTGBR914mHSTK2HuSZCJG-nZZ8hQ>
    <xmx:Nqq0aUEfBDlxjXp59aMCjxQmhWNy-1NGOMwCy9D5qqihMd0vzLzA6Q>
    <xmx:Nqq0aZ8H_rOL5LW3jlOcqJOIecUdiAH8tNU87tbo0_JG0B6g98Dwb2QB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 20:22:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/2] name-rev: learn --format=<pretty>
In-Reply-To: <name-rev_--format.4af@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 13 Mar 2026
	17:03:38 +0100")
References: <CV_name-rev_--format.4ad@msgid.xyz>
	<name-rev_--format.4af@msgid.xyz>
Date: Fri, 13 Mar 2026 17:22:13 -0700
Message-ID: <xmqq8qbvz2dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev.adoc
> index d4f1c4d5945..8f050cd4763 100644
> --- a/Documentation/git-name-rev.adoc
> +++ b/Documentation/git-name-rev.adoc
> @@ -9,7 +9,7 @@ git-name-rev - Find symbolic names for given revs
>  SYNOPSIS
>  --------
>  [verse]
> -'git name-rev' [--tags] [--refs=<pattern>]
> +'git name-rev' [--tags] [--refs=<pattern>] [--format=<pretty>]
>  	       ( --all | --annotate-stdin | <commit-ish>... )

We acquired a new option.  Do we need a matching change to
the contents of name_rev_usage[] array?

> +--format=<pretty>::
> +--no-format::
> +	Format revisions instead of outputting symbolic names. The
> +	default is `--no-format`.
> ++
> +Implies `--name-only`.

If it is implication, would 

    git name-rev --format=reference --no-name-only

do what is naturally expected?

> @@ -462,6 +472,25 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
>  	if (o->type != OBJ_COMMIT)
>  		return get_exact_ref_match(o);
>  	c = (const struct commit *) o;
> +
> +	if (format_ctx) {
> +		strbuf_reset(buf);
> +
> +		if (format_ctx->want.notes) {
> +			struct strbuf notebuf = STRBUF_INIT;
> +
> +			format_display_notes(&c->object.oid, &notebuf,
> +					     get_log_output_encoding(),
> +					     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
> +			format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
> +		}
> +
> +		pretty_print_commit(&format_ctx->ctx, c, buf);
> +		free(format_ctx->ctx.notes_message);

Is free() the expected thing to do here, or FREE_AND_NULL()?  Unlike
callers like log-tree.c:show_log() where a context is prepared, used
once, and then discarded, format_pp is initialized in cmd_name_rev()
once and then repeatedly used by show_name() potentially multiple
times, so there may be a risk of getting confused by this leftover
non-NULL pointer that points at an already free'd piece of memory.

Or there may not be---I did not check, but you as the author must
have already checked, hence this question.

> +		return buf->buf;
> +	}
> +
>  	n = get_commit_rev_name(c);
>  	if (!n)
>  		return NULL;
> @@ -479,6 +508,7 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
>  
>  static void show_name(const struct object *obj,
>  		      const char *caller_name,
> +		      struct pretty_format *format_ctx,
>  		      int always, int allow_undefined, int name_only)
>  {
>  	const char *name;
> @@ -487,7 +517,7 @@ static void show_name(const struct object *obj,
>  
>  	if (!name_only)
>  		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
> -	name = get_rev_name(obj, &buf);
> +	name = get_rev_name(obj, format_ctx, &buf);
>  	if (name)
>  		printf("%s\n", name);
>  	else if (allow_undefined)
> @@ -507,7 +537,9 @@ static char const * const name_rev_usage[] = {
>  	NULL
>  };
>  
> -static void name_rev_line(char *p, struct name_ref_data *data)
> +static void name_rev_line(char *p,
> +			  struct name_ref_data *data,
> +			  struct pretty_format *format_ctx)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	int counter = 0;
> @@ -532,7 +564,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>  				struct object *o =
>  					lookup_object(the_repository, &oid);
>  				if (o)
> -					name = get_rev_name(o, &buf);
> +					name = get_rev_name(o, format_ctx, &buf);
>  			}
>  			*(p+1) = c;
>  
> @@ -567,6 +599,10 @@ int cmd_name_rev(int argc,
>  #endif
>  	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
>  	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
> +	const char *format = NULL;
> +	struct rev_info format_rev = REV_INFO_INIT;
> +	struct pretty_format *format_ctx = NULL;
> +	struct pretty_format format_pp = {0};

Hmph, would we want to use the full init_revisions() instead of
static REV_INFO_INIT that initialises a lot more members of the
struct properly, most importantly the "repo" member that points at
the repostiory to be used?

> +	if (format) {
> +		struct pretty_print_context ctx = {0};
> +		struct userformat_want want = {0};
> +
> +		get_commit_format(format, &format_rev);
> +		ctx.rev = &format_rev;
> +		ctx.fmt = format_rev.commit_format;
> +		ctx.abbrev = format_rev.abbrev;
> +		ctx.date_mode_explicit = format_rev.date_mode_explicit;
> +		ctx.date_mode = format_rev.date_mode;
> +		ctx.color = GIT_COLOR_AUTO;
> +		format_pp.ctx = ctx;

Why does this code initialize and assign to a on-stack ctx first and
then assign it to format_pp.ctx, instead of working on format_pp.ctx
directly?

> +		userformat_find_requirements(format, &want);
> +		if (want.notes)
> +			load_display_notes(NULL);
> +
> +		format_pp.want = want;
> +		format_ctx = &format_pp;
> +
> +		data.name_only = true;
> +	}
> +
