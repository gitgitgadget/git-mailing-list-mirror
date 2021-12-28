Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1EEC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhL1K5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 05:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhL1K5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 05:57:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA0C06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:57:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i22so37547553wrb.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smC92yYp+R20LvUDUnTQIglLpv/aACW7+s3jEoe8mRc=;
        b=AzBLpS3qq1/V9jrN3DNSI2gmbWaN7krWiz+XK+ulwNCtCbKMM4PtyHuRZvTd7DtO+P
         WPK+W+J4STShf2AcotupDgdo12btc8lXOGCnDWcLk/oL0RA0eB7oBiM6O9aTFMAcHFd3
         xPKsStK4jrHG1q/jR7D2m9XZ+UI9yiE7dhEg5G2VkzlPyt146HJ4rnzQ/h+3uePq+LJy
         q9r1upr/I/QjjFCgwCIQ2Lnbh+OYwDO7AeahhQ6siR3DnB2UCsD0zYcKtuelw0+UR8yz
         n6yy09XmAAUqBDOb36+5WoY278UE2Uq2UMF9LwxcBdCcdapZamJNwvPnb6s6AdPGcvbj
         fD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smC92yYp+R20LvUDUnTQIglLpv/aACW7+s3jEoe8mRc=;
        b=qXCMN8oMMuaiHySdHRV4Zo5yygAZh+ao4m3dy5s+iAH9/VSJmPaiaVQIYzHl83ti5K
         wm4F6tvz7dqHXPHmZqVMdi1sakwT1AlhrwlO9XqytLwjlTrzX1gTN04tpzUlj3n1QZKD
         oDHQF+ScbmTtfLGki1bIzfz1ta8M0DrU/hbdfTOasxHM3A4hZPvGwPFYY4R69JlanGx9
         80C6trXLPcTLn9tXt+H6EU36fd145sChiE8cB1vjyzT1KcZ6+dUJW0M7/1oz3tgMbj4M
         ymHNqYPcHOAHPOJ+zkAZWHQj7jq0JcBBuduMFEETlvCSYkkzyMuvP6Fx0RN3n710hHKc
         StRA==
X-Gm-Message-State: AOAM5301W2G9XKJpxEhL2xDHAJHyJGdq+xTRiU0mLngAuzmTgmSqek1C
        mRKK6a0OlR2vLVokJdOgACQ=
X-Google-Smtp-Source: ABdhPJyy4MTvCtJfd+SIDAOuIiuplapxxPHOdzlTa0PdeaAPOrk+1aO9fmq4b0yMlB+lQPw3xcbxdQ==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr16028357wrw.116.1640689055637;
        Tue, 28 Dec 2021 02:57:35 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id e13sm21360471wmq.10.2021.12.28.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:57:35 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:57:33 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 7/8] diff: add ability to insert additional headers
 for paths
Message-ID: <20211228105733.lomkg23htd2kjtii@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <e94706513038adc85e818e8736ad713b2e6b6be4.1640419160.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94706513038adc85e818e8736ad713b2e6b6be4.1640419160.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 25, 2021 at 07:59:18AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When additional headers are provided, we need to
>   * add diff_filepairs to diff_queued_diff for each paths in the
>     additional headers map which, unless that path is part of
>     another diff_filepair already found in diff_queued_diff
>   * format the headers (colorization, line_prefix for --graph)
>   * make sure the various codepaths that attempt to return early
>     if there are "no changes" take into account the headers that
>     need to be shown.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diff.c     | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  diff.h     |   3 +-
>  log-tree.c |   2 +-
>  3 files changed, 115 insertions(+), 6 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 861282db1c3..aaa6a19f158 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -27,6 +27,7 @@
>  #include "help.h"
>  #include "promisor-remote.h"
>  #include "dir.h"
> +#include "strmap.h"
>  
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -3406,6 +3407,31 @@ struct userdiff_driver *get_textconv(struct repository *r,
>  	return userdiff_get_textconv(r, one->driver);
>  }
>  
> +static struct strbuf *additional_headers(struct diff_options *o,
> +					 const char *path)
> +{
> +	if (!o->additional_path_headers)
> +		return NULL;
> +	return strmap_get(o->additional_path_headers, path);
> +}
> +
> +static void add_formatted_headers(struct strbuf *msg,
> +				  struct strbuf *more_headers,
> +				  const char *line_prefix,
> +				  const char *meta,
> +				  const char *reset)
> +{
> +	char *next, *newline;
> +
> +	for (next = more_headers->buf; *next; next = newline) {
> +		newline = strchrnul(next, '\n');
> +		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
> +			    (int)(newline - next), next, reset);
> +		if (*newline)
> +			newline++;
> +	}
> +}
> +
>  static void builtin_diff(const char *name_a,
>  			 const char *name_b,
>  			 struct diff_filespec *one,
> @@ -3464,6 +3490,17 @@ static void builtin_diff(const char *name_a,
>  	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
>  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
>  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
> +	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
> +		/*
> +		 * We should only reach this point for pairs from
> +		 * create_filepairs_for_header_only_notifications().  For
> +		 * these, we should avoid the "/dev/null" special casing
> +		 * above, meaning we avoid showing such pairs as either
> +		 * "new file" or "deleted file" below.
> +		 */
> +		lbl[0] = a_one;
> +		lbl[1] = b_two;
> +	}

not so familiar with this logic, but I saw that without this change, the
rename/rename conflict test fails. Is this because we add a file pair under
the original name (that's been renamed on both sides). I wonder if we
can sketch such a case in the comment.

>  	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
>  	if (lbl[0][0] == '/') {
>  		/* /dev/null */
> @@ -4328,6 +4365,7 @@ static void fill_metainfo(struct strbuf *msg,
>  	const char *set = diff_get_color(use_color, DIFF_METAINFO);
>  	const char *reset = diff_get_color(use_color, DIFF_RESET);
>  	const char *line_prefix = diff_line_prefix(o);
> +	struct strbuf *more_headers = NULL;
>  
>  	*must_show_header = 1;
>  	strbuf_init(msg, PATH_MAX * 2 + 300);
> @@ -4364,6 +4402,11 @@ static void fill_metainfo(struct strbuf *msg,
>  	default:
>  		*must_show_header = 0;
>  	}
> +	if ((more_headers = additional_headers(o, name))) {
> +		add_formatted_headers(msg, more_headers,
> +				      line_prefix, set, reset);
> +		*must_show_header = 1;
> +	}
>  	if (one && two && !oideq(&one->oid, &two->oid)) {
>  		const unsigned hexsz = the_hash_algo->hexsz;
>  		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
> @@ -5852,12 +5895,22 @@ int diff_unmodified_pair(struct diff_filepair *p)
>  
>  static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
>  {
> -	if (diff_unmodified_pair(p))
> +	/*
> +	 * Check if we can return early without showing a diff.  Note that
> +	 * diff_filepair only stores {oid, path, mode, is_valid}
> +	 * information for each path, and thus diff_unmodified_pair() only
> +	 * considers those bits of info.  However, we do not want pairs
> +	 * created by create_filepairs_for_header_only_notifications() to
> +	 * be ignored, so return early if both p is unmodified AND
> +	 * p->one->path is not in additional headers.
> +	 */
> +	if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
>  		return;
>  
> +	/* Actually, we can also return early to avoid showing tree diffs */
>  	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
>  	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
> -		return; /* no tree diffs in patch format */
> +		return;
>  
>  	run_diff(p, o);
>  }
> @@ -5888,10 +5941,14 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
>  	run_checkdiff(p, o);
>  }
>  
> -int diff_queue_is_empty(void)
> +int diff_queue_is_empty(struct diff_options *o)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
>  	int i;
> +
> +	if (o->additional_path_headers &&
> +	    !strmap_empty(o->additional_path_headers))
> +		return 0;
>  	for (i = 0; i < q->nr; i++)
>  		if (!diff_unmodified_pair(q->queue[i]))
>  			return 0;
> @@ -6325,6 +6382,54 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
>  		warning(_(rename_limit_advice), varname, needed);
>  }
>  
> +static void create_filepairs_for_header_only_notifications(struct diff_options *o)
> +{
> +	struct strset present;
> +	struct diff_queue_struct *q = &diff_queued_diff;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +	int i;
> +
> +	strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
> +
> +	/*
> +	 * Find out which paths exist in diff_queued_diff, preferring
> +	 * one->path for any pair that has multiple paths.

Why do we prefer one->path?

> +	 */
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		char *path = p->one->path ? p->one->path : p->two->path;
> +
> +		if (strmap_contains(o->additional_path_headers, path))
> +			strset_add(&present, path);
> +	}
> +
> +	/*
> +	 * Loop over paths in additional_path_headers; for each NOT already
> +	 * in diff_queued_diff, create a synthetic filepair and insert that
> +	 * into diff_queued_diff.
> +	 */
> +	strmap_for_each_entry(o->additional_path_headers, &iter, e) {
> +		if (!strset_contains(&present, e->key)) {
> +			struct diff_filespec *one, *two;
> +			struct diff_filepair *p;
> +
> +			one = alloc_filespec(e->key);
> +			two = alloc_filespec(e->key);
> +			fill_filespec(one, null_oid(), 0, 0);
> +			fill_filespec(two, null_oid(), 0, 0);
> +			p = diff_queue(q, one, two);
> +			p->status = DIFF_STATUS_MODIFIED;
> +		}
> +	}

All these string hash-maps are not really typical for a C program. I'm sure
they are the best choice for an advanced merge algorithm but they are not
really necessary for computing/printing a diff. It feels like this is an
implementation detail from merge-ort that's leaking into other components.

What we want to do is

	for file_pair in additional_headers:
		if not already_queued(file_pair):
			queue(file_pair)

to do that, you use a temporary has-set ("present") that records everything
that's already queued (already_queued() is a lookup in that set).

Let's assume both the queue and additional_headers are sorted arrays.
Then we could efficiently merge them (like a merge-sort algorithm)
without ever allocating a temporary hash map.

I haven't checked if this is practical (better wait for feedback).
We'd probably need to convert the strmap additional_path_headers into an
array and sort it (I guess our hash map does not guarantee any ordering?)

> +
> +	/* Re-sort the filepairs */
> +	diffcore_fix_diff_index();
> +
> +	/* Cleanup */
> +	strset_clear(&present);

Not a strong opinion, but I'd probably drop this comment

> +}
> +
>  static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  {
>  	int i;
> @@ -6337,6 +6442,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  	if (o->color_moved)
>  		o->emitted_symbols = &esm;
>  
> +	if (o->additional_path_headers)
> +		create_filepairs_for_header_only_notifications(o);
> +
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		if (check_pair_status(p))
> @@ -6413,7 +6521,7 @@ void diff_flush(struct diff_options *options)
>  	 * Order: raw, stat, summary, patch
>  	 * or:    name/name-status/checkdiff (other bits clear)
>  	 */
> -	if (!q->nr)
> +	if (!q->nr && !options->additional_path_headers)
>  		goto free_queue;
>  
>  	if (output_format & (DIFF_FORMAT_RAW |
> diff --git a/diff.h b/diff.h
> index 8ba85c5e605..06a0a67afda 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -395,6 +395,7 @@ struct diff_options {
>  
>  	struct repository *repo;
>  	struct option *parseopts;
> +	struct strmap *additional_path_headers;
>  
>  	int no_free;
>  };
> @@ -593,7 +594,7 @@ void diffcore_fix_diff_index(void);
>  "                show all files diff when -S is used and hit is found.\n" \
>  "  -a  --text    treat all files as text.\n"
>  
> -int diff_queue_is_empty(void);
> +int diff_queue_is_empty(struct diff_options*);
>  void diff_flush(struct diff_options*);
>  void diff_free(struct diff_options*);
>  void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
> diff --git a/log-tree.c b/log-tree.c
> index d4655b63d75..33c28f537a6 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -850,7 +850,7 @@ int log_tree_diff_flush(struct rev_info *opt)
>  	opt->shown_dashes = 0;
>  	diffcore_std(&opt->diffopt);
>  
> -	if (diff_queue_is_empty()) {
> +	if (diff_queue_is_empty(&opt->diffopt)) {
>  		int saved_fmt = opt->diffopt.output_format;
>  		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
>  		diff_flush(&opt->diffopt);
> -- 
> gitgitgadget
> 
