Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB22BE643
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501724; cv=none; b=C9LhiSe8gQx63FPbgKQQeUrBPVXrPLI7qB+knEEbP9c03M6vAwiWR3sGcRlYywh34FEnj6iaABobgpdYc31JT4ypkPbr2p88FPa3JdS9yFoLIJ1d/WCYJH0Tr480/r5IsbJEKMBTKhW3ZbDow1wv3DxorEoG1vc9RPsyc/dEEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501724; c=relaxed/simple;
	bh=VCSzLZj5DDC71aK6vtyPLv7dgBGAKpTRYnlB0NV4MX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QkBEfYXzQtNPLFkMFFh34dwN9dXsKOSAh/7xCQ4DeO4hlo5zjjm2Gizk756fPGfX/FV9Vc5TY25jfRRMXyLxBi667kVDKeyk2AeYNnunHLcgI8HqQOl9iW7IfUcM8DdKUI1r8AziRSIPpKLvLJpFn4H4S6vUIBYvqi8m49AS39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qyf6vHZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFq3C9CK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qyf6vHZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFq3C9CK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EA1181D00177;
	Wed,  6 Aug 2025 13:35:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 06 Aug 2025 13:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754501719; x=1754588119; bh=lASxRMYQWG
	VOEAyOZLik3R5yJgZXjumIX7yhPq2wspU=; b=Qyf6vHZI/FlNGrJfHVw15yoGdN
	u6WjCtalOnnNQv2NMmMD7GmVl8D18TZ04Lld0qHP9de7qW0ulBrftzoRVGuUnwEM
	93Y0O3CtudGZsp70qu3lPIT9eLJTtM3k84hFSPBV0QfWar5A/ZzD4jPleO6WWONJ
	TVcUGeE0nAG5WKsnZYZKX9276QgY19/Px8yxNL3ba0IzkxLNoQtervm+dNS7Vajy
	3Zm9zvaqgrCpTUAtjnlB/drqdxsK48j32Pbrfj6ahoNXknH+OW0Rx4NdSVhUVrnw
	8iXwkr8hsgxDtKcDkYx5cDhu7wyV2gkEqal1Bf6JXSLwJm8PRs0obRDa6F0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754501719; x=1754588119; bh=lASxRMYQWGVOEAyOZLik3R5yJgZXjumIX7y
	hPq2wspU=; b=AFq3C9CKmLyh8pyifkhdApA+xagQxndkNT7Pt2yL/z2TnAUrFSo
	1i5Bki7ct0Whh+gstp+25XDIK55kmLsTaUimGxulaAaNn+zoL3uf571vgVEuti8J
	Wi37SkMpec82bjJErpSucA3b7kv4AMIIKcbPCDEFmg6tsXe1mPcrbogsegWA33B+
	dFgsj/2a+dTng+a/Jn0XVISdLF/1S51VVtPBtxcfrC6N18Ld+gTON4UiFzvzz0zh
	dI0P225AddU/K/5C8DpfEquv8Rdm/toZblCbLYw7jsvXxTp1sw6mfHDRE6/SzHAf
	6nEaehbhjvNJVyrvvAqEYpxgKg4sV74Y5uQ==
X-ME-Sender: <xms:V5KTaAnOhba_qm3JIZ-I5ncnZnTAvPaxgiHQLr80e61lexJ-Qs5FFQ>
    <xme:V5KTaIQqJPXlHLbD4GJCzjJzUgd6r_OvkNqwfEmE6qUhCcttdbBf1uIGgAlhn9VLN
    JLBPx1TeUp4UZCsew>
X-ME-Received: <xmr:V5KTaPEhNmz02VTQIF4UDHliXFga7J9ZMAef6jy6Txv6ZLuHP6dKlZBrvwDptKe4j0K_f31mzMp-lQwBDe2MEhy_GlcGFOnViR3O1zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhisegrrhhnvghsrdhsphgrtggvpdhrtghpthht
    ohepmhhitghhrghlsehishgtrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V5KTaNHILGQQdgOM_SARObUGGHycNow2HkBsK7PMjP8w4g7qgIpzRw>
    <xmx:V5KTaNRlWdGKaSQoVVZJB2QCETEZeCt0ayvnTact4GFeCXCIxS8wIw>
    <xmx:V5KTaOJJBToZqepwCwXVsFEPuv-Nqasq1fD_fuKjpaIeAA7stCIJ-Q>
    <xmx:V5KTaIaFx4saKOethEHpoJdc-3gn2A_1mQ8qwHzsdjqufKal-pTL9A>
    <xmx:V5KTaMB3V8M2AQSr7xhq7n7cbppBu7rAHaQgShvg_-xbhN0ZNWoG7z-P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 13:35:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH v3] diff: ensure consistent diff behavior with ignore
 options
In-Reply-To: <20250806123306.25532-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Wed, 6 Aug 2025 20:33:06 +0800")
References: <20250803145155.57894-1-yldhome2d2@gmail.com>
	<20250806123306.25532-1-yldhome2d2@gmail.com>
Date: Wed, 06 Aug 2025 10:35:17 -0700
Message-ID: <xmqqikj0uze2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> In git-diff, options like `-w` and `-I<regex>` require comparing
> file contents to determine whether two files are the same, even when
> their SHA values differ. For options like `--raw`, `--name-status`,
> and `--name-only`, git-diff deliberately compares only the SHA values
> to determine whether two files are the same, for performance reasons.
> As a result, a file shown in `git diff --name-status` may not appear
> in `git diff --patch`.
>
> To quickly determine whether two files are identical, Add helper
> function diff_flush_patch_quiet() in diff.c. Add `.diff_optimize`
> field in `struct diff_options`. When `.diff_optimize` is set to
> `DIFF_OPT_DRY_RUN`, builtin_diff() will return immediately upon
> detecting any change. Call diff_flush_patch_quiet() to determine
> if we should flush `--raw`, `--name-only` or `--name-status` output.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> ---
>  diff.c                     | 67 +++++++++++++++++++++++++++++---------
>  diff.h                     |  5 +++
>  t/t4013-diff-various.sh    | 14 ++++++++
>  t/t4015-diff-whitespace.sh |  2 +-
>  xdiff-interface.h          |  6 ++--
>  5 files changed, 74 insertions(+), 20 deletions(-)

The code looks much easier to reason about than the previous rounds.

A few comments about the design.

 - Are there other possible values that might fit in this "optimize"
   member, and what kind of behaviour would they trigger, that we
   can envision?  I do not think of any and that is why the "enum
   diff_optimize" member in the diff_options structure smells more
   like a "bool dry_run".

   By the way, giving a member "diff_" prefix when the enclosing
   struct is clearly about "diff" by having a name "diff_options" is
   often a waste of readers' time.

 - It is unclear why the dry-run need to imply 0-line context.

 - diff_flush_patch_quietly() would be a better name for
   diff_flush_patch_quiet().

On to the details.

> diff --git a/diff.c b/diff.c
> index dca87e164f..5254ef9373 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2444,6 +2444,15 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
>  	return 0;
>  }
>  
> +static int quick_consume(void *priv, char *line, unsigned long len)
> +{
> +	struct emit_callback *ecbdata = priv;
> +	struct diff_options *o = ecbdata->opt;
> +
> +	o->found_changes = 1;
> +	return 1;
> +}

OK, as a non-zero return value from consume callbacks is supposed
to signal an error and causes xdiff_outf() an early return, this
serves as a short-cut.  One downside is that we cannot truly notice
and signal an error to our callers, as we will see in a later hunk.

> @@ -3709,6 +3718,7 @@ static void builtin_diff(const char *name_a,
>  		xdemitconf_t xecfg;
>  		struct emit_callback ecbdata;
>  		const struct userdiff_funcname *pe;
> +		int dry_run = o->diff_optimize == DIFF_OPT_DRY_RUN;

And this screams that o->dry_run that is a Boolean may be
sufficient, but I could be missing obvious future enhancement
opportunities.

> @@ -3741,8 +3751,8 @@ static void builtin_diff(const char *name_a,
>  		xpp.ignore_regex_nr = o->ignore_regex_nr;
>  		xpp.anchors = o->anchors;
>  		xpp.anchors_nr = o->anchors_nr;
> -		xecfg.ctxlen = o->context;
> -		xecfg.interhunkctxlen = o->interhunkcontext;
> +		xecfg.ctxlen = dry_run ? 0 : o->context;
> +		xecfg.interhunkctxlen = dry_run ? 0 : o->interhunkcontext;

Unclear why.  I think you had a similar change with a comment ...

> @@ -3750,7 +3760,8 @@ static void builtin_diff(const char *name_a,
>  			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
>  
>  		diffopts = getenv("GIT_DIFF_OPTS");
> -		if (!diffopts)
> +		/* ignore ctxlen if we are in dry run mode */

... here, but this comment is totally useless.

> +		if (!diffopts || dry_run)
>  			;
>  		else if (skip_prefix(diffopts, "--unified=", &v))
>  			xecfg.ctxlen = strtoul(v, NULL, 10);

Anybody who can read the code can tell that dry_run disables the
xecfg.ctxlen handling we have below.  What the code does not tell,
hence the author of a patch must help the readers by writing *why*
ignoring patch context is safe, correct, necessary, and desirable
when the main non-dry-run invocation of the diff machinery, which
this dry-run mode is trying to help, may use some context lines.

It does not have to be done in in-code comment.  Especially because
the consequence of the design decision to "ignore context" appears
in two different places, the proposed log message would be a better
place to explain why it is a safe, correct, necessary and desirable
thing to do.

> -		if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
> -				  &ecbdata, &xpp, &xecfg))
> +		if (dry_run)
> +			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
> +				      &ecbdata, &xpp, &xecfg);
> +		else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
> +				       &ecbdata, &xpp, &xecfg))
>  			die("unable to generate diff for %s", one->path);

And this is the consequence of xdi_diff_outf() not having an
extensible way to report different "abnormal" conditions to its
caller.

In the normal case, all exceptional/abnormal conditions are error.
But in the dry-run case, "abnormal return is an error and we should
die" would not fit our purpose.  "Assume that non-zero 'success'
return is because our quick_consume() is signalling that it found
what it needs to find, and that is not an error" is what is going on
here.

I'll stop here for now.  Will continue later.

Thanks.
