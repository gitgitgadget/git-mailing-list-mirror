Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936D1EB5DB
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856465; cv=none; b=Fmtu+6ZjL507Rw56bp6yUZAeradzM2MU1RLHkSpH7b2qxciy1iesbHe/Ib9z5VrM86+RWJLkLgELkF7WAtYzsW4l6h2yoegDFiCUmGMhocIaTmTZP5rKaVOx50kupEEMkFcK+TBxSPCaXrbTZYukj3dbWmmUdBSdxWkOVNtTdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856465; c=relaxed/simple;
	bh=g/oRpgQSHEQ4xT4kT/dVuzDzMEIUwZrGtwj6Oyt5qvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP8p+jpzK3ugYQN4e5gTKF+LvUMvDj70B/mZkRMmXxw90ze1RiexpUd9NkDgySgmh/oGLfA/ioCXpLNILeilJHdSC7sdI69Fnm6IlX94lAhw/yH+f5+wveHC4T6T8DddznZa7+RFR9ly/FUr2QXnn5GJuz821NmcEDGxPNmUIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgpEptmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3DG43nX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgpEptmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3DG43nX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B06437A237D;
	Wed, 30 Jul 2025 02:21:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Jul 2025 02:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753856460; x=1753942860; bh=u5MjwDHNkq
	Lt9ESl+aMxCoQKQMhcdEHpNnjQ4yE5pGI=; b=fgpEptmAG8HNNuA+JvTFwg7rdm
	Rcoi7CE2C0u5sTSI8WPkKDnDXNTFlgkCvG43OEsEeC6CQzQNJGCvTCAOSOyl+c3t
	t6/SbWCc4N4hGLvv06MndP6nwH5nZnFgd9TU8yDMvoe97sTJGJ1cDdl0W+qJ5B4g
	/Vbnab6+/ZRsMmSKAKirkFB0PY/mAHRLDn620/011uDTNPjleGOA5135jDHuPGc5
	WE9P2dYXNMoPsyVv8B+1uKq5Ab1qUJpxTYS4PaLn8Po5V5OfFmeZKrfIgLnm5TOF
	pTIN96jiCrroMEhWKXjOkupoaG91exAMJ/aFngrpblc8+EWCYCgOYDcRKwdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753856460; x=1753942860; bh=u5MjwDHNkqLt9ESl+aMxCoQKQMhcdEHpNnj
	Q4yE5pGI=; b=a3DG43nXVLOCZcue5HLef36uh7giRXb6kqMAUq5z5Pq62/elYDt
	g6Tz+ohm26dbDjBfaUT+hyU6DgG3lNBHKrN5wKe6tjZdGITw5ICOt3neoaVEfSpW
	6pPH6yxh7YZzJVwIwKF5YF4UoVnrfLPiGSoIRwe4sZR/zCAZDcMNTAu3rJsK7jot
	VNiEqcknHa06hJ+dajEnepVfYw8fbXUgzyLph0PKOGEHo1kmvbCHBPPO28EUMb+E
	40JHvpWP9Tc4KMtFuah2BgG47bxJUwXtcN+Ctleilx/0IqVURTBAdNwUggOTZiQc
	UusKqJP0o+j9B9ONEUzKfV2qXp04LdwnbOQ==
X-ME-Sender: <xms:zLmJaHXCBKGnTCkgXEmDHF3vkgTxLpS-U9tJFtqgVvsCjpaFgYizbg>
    <xme:zLmJaKL3gf0P3-HXKDNzKmIQTW27QPUfpyaiKvFT7Ox4AT8m1grmIlM0Lgd_qoRQH
    xrV7PqSuvDySvsZTw>
X-ME-Received: <xmr:zLmJaP8JSlNOT_vQ3XojsJJjC566Md_unm1SgEw2gJTET6BVSQy1kdidnetFytIbsmLDm-1g8r6ajV1QyJ1W-gykfI13mfga5PLy2VWy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:zLmJaFKR1gGlOzVT19V2qvzj-pS619MF9aVyCzwKFDOzoT1lN1VKNA>
    <xmx:zLmJaMnZGfEqv_YF0W9rLA76Q3OWMClticm4lht46Q5ZRzDSArC-Cw>
    <xmx:zLmJaBNk43z3R8y-5GX1-jOcpVCcIQ2xjMsMIB4VtekcyPq7rWgvtA>
    <xmx:zLmJaK2Ua08YUVUdo9JyZxC11Q0cQldJ0-u7pUTXwAE_5EWkyXgBnA>
    <xmx:zLmJaEG5CF0Rf3Z1TLIPp3mjvNx7jKtRo-2g3bUbJSz9QpOTItV86d2j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 02:20:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97adba1d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Jul 2025 06:20:58 +0000 (UTC)
Date: Wed, 30 Jul 2025 08:20:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 3/3] diff: teach tree-diff a max-depth parameter
Message-ID: <aIm5x4kah8608Ba5@pks.im>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
 <20250729-toon-max-depth-v1-3-c177e39c40fb@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-toon-max-depth-v1-3-c177e39c40fb@iotcl.com>

On Tue, Jul 29, 2025 at 08:57:44PM +0200, Toon Claes wrote:
> From: Jeff King <peff@peff.net>
> 
> When you are doing a tree-diff, there are basically two options: do not
> recurse into subtrees at all, or recurse indefinitely. While most
> callers would want to always recurse and see full pathnames, some may
> want the efficiency of looking only at a particular level of the tree.
> This is currently easy to do for the top-level (just turn off
> recursion), but you cannot say "show me what changed in subdir/, but do
> not recurse".
> 
> This patch adds a max-depth parameter which is measured from the closest
> pathspec match, so that you can do:
> 
>   git log --raw --max-depth=1 -- a/b/c
> 
> and see the raw output for a/b/c/, but not those of a/b/c/d/
> (instead of the raw output you would see for a/b/c/d).

Hm, okay. So what happens if I pass both "a/b" and "a/b/c"? Would I see
the contents of both trees?

> diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
> index f3a35d8141..46e6ed2d67 100644
> --- a/Documentation/diff-options.adoc
> +++ b/Documentation/diff-options.adoc
> @@ -893,5 +893,33 @@ endif::git-format-patch[]
>  	reverted with `--ita-visible-in-index`. Both options are
>  	experimental and could be removed in future.
>  
> +--max-depth=<n>::
> +
> +	Limit diff recursion to `<n>` levels (implies `-r`). The depth
> +	is measured from the closest pathspec. Given a tree containing
> +	`foo/bar/baz`, the following list shows the matches generated by
> +	each set of options:
> ++
> +--
> + - `--max-depth=0 -- foo`: `foo`
> +
> + - `--max-depth=1 -- foo`: `foo/bar`
> +
> + - `--max-depth=1 -- foo/bar`: `foo/bar/baz`
> +
> + - `--max-depth=1 -- foo foo/bar`: `foo/bar/baz`

This partially answers my question, as we talk about the scenario where
we have "foo/bar/baz", but no "foo/qux". If we had the latter, would
that also be displayed here because it's 1 level deep from the closest
matching pathspec ("foo")?

> + - `--max-depth=2 -- foo`: `foo/bar/baz`
> +--
> ++
> +If no pathspec is given, the depth is measured as if all
> +top-level entries were specified. Note that this is different
> +than measuring from the root, in that `--max-depth=0` would
> +still return `foo`. This allows you to still limit depth while
> +asking for a subset of the top-level entries.
> ++
> +Note that this option is only supported for diffs between tree objects,
> +not against the index or working tree.

Let's also note that wildcard pathspecs aren't supported.

>  For more detailed explanation on these common options, see also
>  linkgit:gitdiffcore[7].
> diff --git a/diff-lib.c b/diff-lib.c
> index 244468dd1a..fa7c24c267 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -115,6 +115,9 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  	uint64_t start = getnanotime();
>  	struct index_state *istate = revs->diffopt.repo->index;
>  
> +	if (revs->diffopt.max_depth_valid)
> +		die("max-depth is not supported for worktree diffs");

This and the following error messages should be made translatable.

> diff --git a/diff.c b/diff.c
> index dca87e164f..c03a59ac3b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5622,6 +5625,18 @@ static int diff_opt_rotate_to(const struct option *opt, const char *arg, int uns
>  	return 0;
>  }
>  
> +static int diff_opt_max_depth(const struct option *opt,
> +			      const char *arg, int unset)
> +{
> +	struct diff_options *options = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	options->flags.recursive = 1;
> +	options->max_depth = strtol(arg, NULL, 10);

We're missing error handling in case the argument is not an integer. We
should probably use `git_parse_unsigned()` instead.

> @@ -5894,6 +5909,10 @@ struct option *add_diff_options(const struct option *opts,
>  		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
>  			       N_("select files by diff type"),
>  			       PARSE_OPT_NONEG, diff_opt_diff_filter),
> +		OPT_CALLBACK_F(0, "max-depth", options, N_("<depth>"),
> +			       N_("maximum tree depth to recurse"),
> +			       PARSE_OPT_NONEG, diff_opt_max_depth),
> +
>  		{
>  			.type = OPTION_CALLBACK,
>  			.long_name = "output",

Okay. We don't use `OPT_UNSIGNED()` because we also want to impliy the
`recursive` flag. Wouldn't it be simpler though to use `OPT_UNSIGNED()`
and then set the flag in `diff_setup_done()` like we already do for a
couple of other options?

> diff --git a/diff.h b/diff.h
> index 62e5768a9a..e3767df237 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -404,6 +404,15 @@ struct diff_options {
>  	struct strmap *additional_path_headers;
>  
>  	int no_free;
> +
> +	/*
> +	 * The extra "valid" flag is a slight hack. The value "0" is perfectly
> +	 * valid for max-depth. We would normally use -1 to indicate "not set",
> +	 * but there are many code paths which assume that assume that just

Double "assume that".

> +	 * zero-ing out a diff_options is enough to initialize it.
> +	 */
> +	int max_depth;
> +	int max_depth_valid;

So in that case, shouldn't we convert `max_depth` to be unsigned and
`max_depth_valid` to be a boolean?

> diff --git a/tree-diff.c b/tree-diff.c
> index e00fc2f450..acd302500f 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -48,6 +49,73 @@
>  		free((x)); \
>  } while(0)
>  
> +/* Returns true if and only if "dir" is a leading directory of "path" */
> +static int is_dir_prefix(const char *path, const char *dir, int dirlen)
> +{
> +	return !strncmp(path, dir, dirlen) &&
> +		(!path[dirlen] || path[dirlen] == '/');
> +}
> +
> +static int check_recursion_depth(struct strbuf *name,

Let's mark the `name` parameter as `const` both here and in
`should_recurse()` so that it becomes clear that it shouldn't be
modified.

> +				 const struct pathspec *ps,
> +				 int max_depth)
> +{
> +	int i;
> +
> +	if (!ps->nr)
> +		return within_depth(name->buf, name->len, 1, max_depth);
> +
> +	/*
> +	 * We look through the pathspecs in reverse-sorted order, because we
> +	 * want to find the longest match first (e.g., "a/b" is better for
> +	 * checking depth than "a/b/c").
> +	 */
> +	for (i = ps->nr - 1; i >= 0; i--) {

`nr` is of type `int` indeed, so the loop index is correct even though
it feels wrong. But that's nothing we have to fix as part of this patch
series. We could inline the declaration though and make it loop-local.

> +		const struct pathspec_item *item = ps->items+i;
> +
> +		/*
> +		 * If the name to match is longer than the pathspec, then we
> +		 * are only interested if the pathspec matches and we are
> +		 * within the allowed depth.
> +		 */
> +		if (name->len >= item->len) {
> +			if (!is_dir_prefix(name->buf, item->match, item->len))
> +				continue;
> +			return within_depth(name->buf + item->len,
> +					    name->len - item->len,
> +					    1, max_depth);
> +		}
> +
> +		/*
> +		 * Otherwise, our name is shorter than the pathspec. We need to
> +		 * check if it is a prefix of the pathspec; if so, we must
> +		 * always recurse in order to process further (the resulting
> +		 * paths we find might or might not match our pathspec, but we
> +		 * cannot know until we recurse).
> +		 */
> +		if (is_dir_prefix(item->match, name->buf, name->len))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static int should_recurse(struct strbuf *name, struct diff_options *opt)
> +{
> +	if (!opt->flags.recursive)
> +		return 0;
> +	if (!opt->max_depth_valid)
> +		return 1;
> +
> +	/*
> +	 * We catch this during diff_setup_done, but let's double-check
> +	 * against any internal munging.
> +	 */
> +	if (opt->pathspec.has_wildcard)
> +		die("BUG: wildcard pathspecs are incompatible with max-depth");

Let's use `BUG()` instead. This patch series must be old, the function
has been introduced 8 years ago in d8193743e0 (usage.c: add BUG()
function, 2017-05-12).

Patrick
