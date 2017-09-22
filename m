Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8CDC202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbdIVQ3p (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:29:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34231 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdIVQ3o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:29:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so1767726wma.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=tW/D0/az6jGnn95rkL33M9Noz4jakemx/saENYqfTAk=;
        b=sgFNeFp2+lE2XBhJslJzomEuUXz+b+XYs5gZVxEPinLDazkYtQaph5sIVj1SPb9LXJ
         RfPAIqNGKjo2P+LY1yKAnXmRkYbT4ADXNjUUdmles4LdD05XjbanegDiuj8laqaqdYhW
         +15llJP/ywQ7tZqvFbkNGPqN7+npGKAWK7eCk2UYnz6z28FD8yT533xldKs3YMyachTX
         3cjWvZks07PWc9YHNBynA0CxARDyXUgwz6nvRLojodbymHqseMvcSDG8+2WR7VSCMv5w
         zV/ubK/CgNDqiAp141vzRF/jbCTeHV0if1gZNCNsh/+Jh3m5YlEhF3+F6IJmXDhLPO9S
         PVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=tW/D0/az6jGnn95rkL33M9Noz4jakemx/saENYqfTAk=;
        b=Is6y/I0il9gTJunffaXI9fd4SbJDAkbFeGZzq+R5LLm+9c+G3oPORXJt7Ap9XSWgEH
         ofuIp8GtNQ97qKBW8csSM5AsnzLjmFRyhTPJpx3xvSyQ5OfhIbO/ZlPiC5SmWvOfAMYD
         1uWmi//ROy+G53xnW66vEOKqhyUweR2KThwUSmidGgHrenKVdgVO+WxCs6vHbN1Nf/Pq
         ABrzmiVhNLANGI3nHLPEJChCK4hlZOVLdYrPp6LJZvg0U5gvzFskUQsEfBIz5zZCGvXY
         QbnEjJDMlQe7CwHA6FbLF3mLLFPYmWXY7Gd+HPFUWqfHjpwC3+URgkLTHraHHfytE0HR
         K33A==
X-Gm-Message-State: AHPjjUhHCvmm6NcYuyTy3bS3e9+D1sYxO87omiGLcPNxrN/tHiZJLL6k
        TSlncwgUsAWIFjqq/bUIbzc=
X-Google-Smtp-Source: AOwi7QDx1qevSjrBkgqd3CVTxAJXKk4LJ4cXGVTBbdJOWeoJYtqdq3jAorjuI+Q+4sbzWoS1oOC0Iw==
X-Received: by 10.80.241.92 with SMTP id z28mr5349849edl.294.1506097782907;
        Fri, 22 Sep 2017 09:29:42 -0700 (PDT)
Received: from localhost.localdomain (x4db0492a.dyn.telefonica.de. [77.176.73.42])
        by smtp.gmail.com with ESMTPSA id b3sm153202edb.19.2017.09.22.09.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 09:29:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] ALLOC_GROW: avoid -Wsign-compare warnings
Date:   Fri, 22 Sep 2017 18:25:12 +0200
Message-Id: <20170922162512.7398-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.1.796.ga2e68c72f
In-Reply-To: <c97784ce-d85d-2b7a-4eb7-d4043dc1a0b7@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


At first I was somewhat puzzled by the "ALLOC_GROW:" prefix in the
subject line, because this patch doesn't touch ALLOC_GROW() at all.
However, since ALLOC_GROW() is a macro, of course, and since this
patch changes the data type of variables "passed" to ALLOC_GROW(),
that's sort of fine...

But then I was even more puzzled to see that this patch also changes
the data type of several variables that are never passed to
ALLOC_GROW(), but only compared to other variables that are indeed
passed to ALLOC_GROW(), i.e. most of (all?) the changes in line-log.c.
Perhaps it would be worth mentioning that all those changes are
fallout of the type change in 'struct range_set' in line-log.h. (and
all those changes silence only two warnings!)


> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  builtin/pack-objects.c |  4 ++--
>  config.c               |  2 +-
>  diff.c                 |  2 +-
>  line-log.c             | 18 +++++++++---------
>  line-log.h             |  2 +-
>  revision.c             |  2 +-
>  tree-walk.c            |  3 +--
>  7 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a57b4f058..a6ee653bf 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2563,8 +2563,8 @@ struct in_pack_object {
>  };
>  
>  struct in_pack {
> -	int alloc;
> -	int nr;
> +	unsigned int alloc;
> +	unsigned int  nr;
>  	struct in_pack_object *array;
>  };
>  
> diff --git a/config.c b/config.c
> index cd5a69e63..aeab02c06 100644
> --- a/config.c
> +++ b/config.c
> @@ -2200,7 +2200,7 @@ static struct {
>  	size_t *offset;
>  	unsigned int offset_alloc;
>  	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
> -	int seen;
> +	unsigned int seen;
>  } store;

On first sight this looked like an independent change, but on closer
inspection it turns out that the variables 'seen' and 'offset_alloc'
are used to manage the allocation of the '*offset' array.

I wish we would have named these fields more consistently with '_nr'
and '_alloc' suffixes, or, if there is a compelling reason to diverge,
then at least put the two fields on subsequent lines (or even on the
same line), with a comment explaining the connection between the two
fields and the array.

>  static int matches(const char *key, const char *value)
> diff --git a/diff.c b/diff.c
> index ea7e5978b..be94ad4f4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1541,7 +1541,7 @@ static void emit_rewrite_diff(const char *name_a,
>  
>  struct diff_words_buffer {
>  	mmfile_t text;
> -	long alloc;
> +	unsigned long alloc;

This one is interesting.  'alloc' and 'mmfile_t's 'text.size' manage
the allocation of 'text.ptr', and both are signed longs...  so where
does the warning come from?  Well, just a couple of lines later we
have this:

  static void diff_words_append(char *line, unsigned long len,
                  struct diff_words_buffer *buffer)
  {
          ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);

Note the addition of the signed long 'buffer->text.size' and the
unsigned long 'len', which, according to "6.3.1.8 Usual arithmetic
conversions", converts the signed long to unsigned.  ALLOC_GROW() then
compares the resulting unsigned long sum to the signed long
'buffer->alloc', hence the warning.

So, while the change in this hunk is technically correct and indeed
eliminates the warning, it is subtle and the resulting code with a
signed long 'text.size' in 'mmfile_t' and unsigned long 'alloc' might
raise the eyebrows of future readers.  I think this would be worth
mentioning in the commit message or in a comment.

Ultimately 'text.size' should be turned into unsigned, too, maybe even
size_t, but that change would be much more difficult to make and
review, because mmfile_t is used over hundred times in our codebase,
and 'size' is not a grep-friendly field name to look for.

>  	struct diff_words_orig {
>  		const char *begin, *end;
>  	} *orig;

The very next line of 'struct diff_words_buffer's definition is:

    int orig_nr, orig_alloc;

These two fields are used to manage the allocation of the struct's
'*orig' array.  While these are not involved in any warnings, having
an 'unsigned long alloc' and a signed 'orig_alloc' so close to each
other in the same struct might raise some eyebrows, too.

> diff --git a/line-log.c b/line-log.c
> index ab0709f9a..545ad0f28 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -90,7 +90,7 @@ static int range_cmp(const void *_r, const void *_s)
>   */
>  static void range_set_check_invariants(struct range_set *rs)
>  {
> -	int i;
> +	unsigned int i;
>  
>  	if (!rs)
>  		return;
> @@ -110,8 +110,8 @@ static void range_set_check_invariants(struct range_set *rs)
>   */
>  void sort_and_merge_range_set(struct range_set *rs)
>  {
> -	int i;
> -	int o = 0; /* output cursor */
> +	unsigned int i;
> +	unsigned int o = 0; /* output cursor */
>  
>  	QSORT(rs->ranges, rs->nr, range_cmp);
>  
> @@ -144,7 +144,7 @@ void sort_and_merge_range_set(struct range_set *rs)
>  static void range_set_union(struct range_set *out,
>  			     struct range_set *a, struct range_set *b)
>  {
> -	int i = 0, j = 0;
> +	unsigned int i = 0, j = 0;
>  	struct range *ra = a->ranges;
>  	struct range *rb = b->ranges;
>  	/* cannot make an alias of out->ranges: it may change during grow */
> @@ -186,7 +186,7 @@ static void range_set_union(struct range_set *out,
>  static void range_set_difference(struct range_set *out,
>  				  struct range_set *a, struct range_set *b)
>  {
> -	int i, j =  0;
> +	unsigned int i, j =  0;
>  	for (i = 0; i < a->nr; i++) {
>  		long start = a->ranges[i].start;
>  		long end = a->ranges[i].end;
> @@ -397,7 +397,7 @@ static void diff_ranges_filter_touched(struct diff_ranges *out,
>  				       struct diff_ranges *diff,
>  				       struct range_set *rs)
>  {
> -	int i, j = 0;
> +	unsigned int i, j = 0;
>  
>  	assert(out->target.nr == 0);
>  
> @@ -426,7 +426,7 @@ static void range_set_shift_diff(struct range_set *out,
>  				 struct range_set *rs,
>  				 struct diff_ranges *diff)
>  {
> -	int i, j = 0;
> +	unsigned int i, j = 0;
>  	long offset = 0;
>  	struct range *src = rs->ranges;
>  	struct range *target = diff->target.ranges;
> @@ -873,7 +873,7 @@ static char *output_prefix(struct diff_options *opt)
>  
>  static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
>  {
> -	int i, j = 0;
> +	unsigned int i, j = 0;
>  	long p_lines, t_lines;
>  	unsigned long *p_ends = NULL, *t_ends = NULL;
>  	struct diff_filepair *pair = range->pair;
> @@ -906,7 +906,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
>  		long t_start = range->ranges.ranges[i].start;
>  		long t_end = range->ranges.ranges[i].end;
>  		long t_cur = t_start;
> -		int j_last;
> +		unsigned int j_last;
>  
>  		while (j < diff->target.nr && diff->target.ranges[j].end < t_start)
>  			j++;
> diff --git a/line-log.h b/line-log.h
> index 7a5c24e2d..e2a5ee7c6 100644
> --- a/line-log.h
> +++ b/line-log.h
> @@ -14,7 +14,7 @@ struct range {
>  
>  /* A set of ranges.  The ranges must always be disjoint and sorted. */
>  struct range_set {
> -	int alloc, nr;
> +	unsigned int alloc, nr;
>  	struct range *ranges;
>  };
>  
> diff --git a/revision.c b/revision.c
> index f9a90d71d..c8c9cb32c 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1105,7 +1105,7 @@ static void add_rev_cmdline(struct rev_info *revs,
>  			    unsigned flags)
>  {
>  	struct rev_cmdline_info *info = &revs->cmdline;
> -	int nr = info->nr;
> +	unsigned int nr = info->nr;
>  
>  	ALLOC_GROW(info->rev, nr + 1, info->alloc);
>  	info->rev[nr].item = item;
> diff --git a/tree-walk.c b/tree-walk.c
> index c99309069..684f0e337 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -582,12 +582,11 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
>  	int retval = MISSING_OBJECT;
>  	struct dir_state *parents = NULL;
>  	size_t parents_alloc = 0;
> -	ssize_t parents_nr = 0;
> +	size_t i, parents_nr = 0;
>  	unsigned char current_tree_sha1[20];
>  	struct strbuf namebuf = STRBUF_INIT;
>  	struct tree_desc t;
>  	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
> -	int i;
>  
>  	init_tree_desc(&t, NULL, 0UL);
>  	strbuf_addstr(&namebuf, name);
> -- 
> 2.14.0

