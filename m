Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EBD387347
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780725; cv=none; b=DhtUwFaa9CKtPPgp8S8zWWggDvMafDBZtARFhgimedoJchkhWvT+Dxbdsdrwgpg0GHZLJzuDFrUuBUQBBW3TiETwzF0dqRxDz26+wvMlDiCSWg0D0r8erWsAIAQqfSW4AYIJIeE8GJxAXNSTPkGe/d786zVGbSx9GtWsnkq6yCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780725; c=relaxed/simple;
	bh=eYG56pI1iAlQte+HI5ScNiG7A6wEc3Wy/meQi09+amE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgGvwRNgIS5bActAjKSTwzZBElW/Z1Mp1b+TQph+PCkJJOmL/0cUu9g70mJa7aAvUZb4Ww0eD0xqrxB5MbtMP2YNwaymTbMnrZMnrJpRhZal60rUO1jf/+Eue3d+nN6Qx1FZOorBDI767/KVUTbC/NXAOC5G3DVQlK8gqKnC4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AiDd/71J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=21nGHjdm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AiDd/71J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="21nGHjdm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A4BA7A01CB;
	Tue, 17 Mar 2026 16:52:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 16:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773780722; x=1773867122; bh=IyB6yCALoB
	p2aMfL8wF3i4l2CJbS2//FS9ALZ9ZvfFY=; b=AiDd/71J+pvmkh+ENp5XmlQBfp
	hxrV+bm8RT1rit94voXLYzbUoWHmdoa719C1xVg+MV3/4OeZdWqC5uXmI/8avBHM
	Zq+tpWLwEKjrnaxmwyPvY/b6iyeHYbJo9jtIV9133k95yaijH/5rd6WTCDE4S8JJ
	H7HoGSrWgvTPl6UkbBbMEOFh6DYLVc/QXtCEdT563u7KdwtWTYSladN1qXhXIdXY
	ccjv0rZp4fwpXqRkZa6MlLyEAiGgPQHyMlHrbzxiPC9CLDKALd30nShsNLlJUcNs
	+RgdxdnQbT1Nwaa3SvISZ4JGBr/Th3hpVDMxNAGHBhTn5eNQogpaSPCJENiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773780722; x=1773867122; bh=IyB6yCALoBp2aMfL8wF3i4l2CJbS2//FS9A
	LZ9ZvfFY=; b=21nGHjdmLYZ+cFlJ8ZySQWCCjXuD1TkhEY5eJZbhZTceMPe96TW
	a1ud3itApM/GOulaF/RvfkpP/0aV5DLcdA50suWOWzAQ6lyLgIDevSGzpQF/GLdA
	Da2WT47m9WZxzXmWNTYsuBCHGzE7BJeRmNgqg2COz5cTWtDzpkUN3LCbtzOYBW+R
	iT6hHovanRaowlmpnXa8XykQQDRWzDyt+UwMzuL20xIZG4EMC6CrSb/tYpydQQja
	8g/bpDF/OhR0Cf84YEcDLRzWPEcPfUJRG4/WP/Ez3g+dxIjxknHOat3iZeOASXrs
	Y/E+a9th9NE1SgQS6/7eag3Sj3iDp27QnuQ==
X-ME-Sender: <xms:8r65aY3tzc90cayF_ENyUF58qOaWJXa3VKR6iNYczazfDAkwxqeazw>
    <xme:8r65aaGTRSVa7nVHB5WrYumYV8Z5-TjQhyziVhBZ6qKX-ki7BZKn1E9yGPuo8zcc8
    uyYDahX8MsYJSja7vwtQOkDKLfcYKkbvcEGyrSoylIbbNy11dcIfQ>
X-ME-Received: <xmr:8r65aV6PmIUIjEmiZhWygI-SPWqy4UfOBr_DgqXk8l_Q0IjWY9LHn1uT5lgiMQknN5qu3ez5PPVJJrj-hf1Z9Lbc7b4Pcib3yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:8r65aQuNi3rKv20mAGDIDiH-5AJGpyJCfJ3hinDXnWBbPDSDGX4tCw>
    <xmx:8r65aW4liMudv4KUagSL8yWnFRkUlzlNElP9Kcoaa-1uUoVLwXpWmQ>
    <xmx:8r65abURly7k677CtV7N6DAwlusxNDMU0MRbeutTkhFlFOOP3zYTGA>
    <xmx:8r65aY87AmFnSR4V5obD0WhSPu9_DESu5lrUkmFoiLD-uRf9Gn4-AA>
    <xmx:8r65aRZXp3giiH1IdQrWy3iyKxmPtXZKeP_Ha-WIRG27KJJBQorXdi9q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 16:52:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 2/4] line-log: route -L output through the standard
 diff pipeline
In-Reply-To: <4e2bc55082e79654ebf0d30fc00479a5eb29f750.1773714095.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Tue, 17 Mar 2026
	02:21:33 +0000")
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
	<4e2bc55082e79654ebf0d30fc00479a5eb29f750.1773714095.git.gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 13:52:01 -0700
Message-ID: <xmqqecliji1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> `git log -L` has always bypassed the standard diff pipeline.
> `dump_diff_hacky()` in line-log.c hand-rolls its own diff headers and
> hunk output, which means most diff formatting options are silently
> ignored.  A NEEDSWORK comment has acknowledged this since the feature
> was introduced:
>
>     /*
>      * NEEDSWORK: manually building a diff here is not the Right
>      * Thing(tm).  log -L should be built into the diff pipeline.
>      */
>
> Remove `dump_diff_hacky()` and its helpers and route -L output through
> `builtin_diff()` / `fn_out_consume()`, the same path used by `git diff`
> and `git log -p`.  The mechanism is a pair of callback wrappers that sit
> between `xdi_diff_outf()` and `fn_out_consume()`, filtering xdiff's
> output to only the tracked line ranges.  To ensure xdiff emits all lines
> within each range as context, the context length is inflated to span the
> largest range.
>
> Wire up the `-L` implies `--patch` default in revision setup rather
> than forcing it at output time, so `line_log_print()` is just
> `diffcore_std()` + `diff_flush()` with no format save/restore.
> Rename detection is a no-op since pairs are already resolved during
> the history walk in `queue_diffs()`, but running `diffcore_std()`
> means `-S`/`-G` (pickaxe), `--orderfile`, and `--diff-filter` now
> work with `-L`, and `diff_resolve_rename_copy()` sets pair statuses
> correctly without manual assignment.
>
> Switch `diff_filepair_dup()` from `xmalloc` to `xcalloc` so that new
> fields (including `line_ranges`) are zero-initialized by default.
>
> As a result, diff formatting options that were previously silently
> ignored (e.g. --word-diff, --no-prefix, -w, --color-moved) now work
> with -L, and output gains `index` lines, `new file mode` headers, and
> funcname context in `@@` headers.  This is a user-visible output change:
> tools that parse -L output may need to handle the additional header
> lines.
>
> The context-length inflation means xdiff may process more output than
> needed for very wide line ranges, but benchmarks on files up to 7800
> lines show no measurable regression.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  diff.c                                        | 279 +++++++++++++++++-
>  diffcore.h                                    |  16 +
>  line-log.c                                    | 174 ++---------
>  line-log.h                                    |  14 +-
>  revision.c                                    |   2 +
>  t/t4211-line-log.sh                           |  12 +-
>  t/t4211/sha1/expect.beginning-of-file         |   4 +
>  t/t4211/sha1/expect.end-of-file               |  11 +-
>  t/t4211/sha1/expect.move-support-f            |   5 +
>  t/t4211/sha1/expect.multiple                  |  10 +-
>  t/t4211/sha1/expect.multiple-overlapping      |   7 +
>  t/t4211/sha1/expect.multiple-superset         |   7 +
>  t/t4211/sha1/expect.no-assertion-error        |  12 +-
>  t/t4211/sha1/expect.parallel-change-f-to-main |   7 +
>  t/t4211/sha1/expect.simple-f                  |   4 +
>  t/t4211/sha1/expect.simple-f-to-main          |   5 +
>  t/t4211/sha1/expect.simple-main               |  11 +-
>  t/t4211/sha1/expect.simple-main-to-end        |  11 +-
>  t/t4211/sha1/expect.two-ranges                |  10 +-
>  t/t4211/sha1/expect.vanishes-early            |  10 +-
>  t/t4211/sha256/expect.beginning-of-file       |   4 +
>  t/t4211/sha256/expect.end-of-file             |  11 +-
>  t/t4211/sha256/expect.move-support-f          |   5 +
>  t/t4211/sha256/expect.multiple                |  10 +-
>  t/t4211/sha256/expect.multiple-overlapping    |   7 +
>  t/t4211/sha256/expect.multiple-superset       |   7 +
>  t/t4211/sha256/expect.no-assertion-error      |  12 +-
>  .../sha256/expect.parallel-change-f-to-main   |   7 +
>  t/t4211/sha256/expect.simple-f                |   4 +
>  t/t4211/sha256/expect.simple-f-to-main        |   5 +
>  t/t4211/sha256/expect.simple-main             |  11 +-
>  t/t4211/sha256/expect.simple-main-to-end      |  11 +-
>  t/t4211/sha256/expect.two-ranges              |  10 +-
>  t/t4211/sha256/expect.vanishes-early          |  10 +-
>  34 files changed, 512 insertions(+), 213 deletions(-)

Huge diff to the test material mostly comes from the addition of the
diff headers like the index line, etc., which makes this patch scary
but is very welcome addition.

> @@ -106,6 +117,11 @@ int diff_filespec_is_binary(struct repository *, struct diff_filespec *);
>  struct diff_filepair {
>  	struct diff_filespec *one;
>  	struct diff_filespec *two;
> +	/*
> +	 * Tracked line ranges for -L filtering; borrowed from
> +	 * line_log_data and must not be freed.
> +	 */
> +	const struct range_set *line_ranges;

OK.

> diff --git a/line-log.c b/line-log.c
> index 9d12ece181..858a899cd2 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -885,160 +885,6 @@ static void queue_diffs(struct line_log_data *range,
>  	move_diff_queue(queue, &diff_queued_diff);
>  }
>  int line_log_print(struct rev_info *rev, struct commit *commit)
>  {
> -
>  	show_log(rev);
>  	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
>  		struct line_log_data *range = lookup_line_range(rev, commit);
> -		dump_diff_hacky(rev, range);
> +		struct line_log_data *r;
> +		const char *prefix = diff_line_prefix(&rev->diffopt);
> +
> +		fprintf(rev->diffopt.file, "%s\n", prefix);
> +
> +		for (r = range; r; r = r->next) {
> +			if (r->pair) {
> +				struct diff_filepair *p =
> +					diff_filepair_dup(r->pair);
> +				p->line_ranges = &r->ranges;
> +				diff_q(&diff_queued_diff, p);
> +			}
> +		}
> +
> +		diffcore_std(&rev->diffopt);
> +		diff_flush(&rev->diffopt);

Very welcome change.
