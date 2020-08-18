Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A12C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8E020738
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYetXsyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHRWXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgHRWXf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:23:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF22C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 15:23:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so23939752ejb.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mvSXTJDpBzgGI+vxgOF8V2kQ1M5KsZ7z6oEyF10d5X4=;
        b=jYetXsyTRVVm0Uvctule7I3WowYMV3WpM7MxFeeLypBxNBzZbnqQF3fjE2+LwEYT+A
         MtdlPiGYMvoA1ibGG4Vz827df+doTZ5nuzjlAp33cnsowK9J9DlwJOfMGL/aGxD1VoZ1
         rn6Fyk7sDLvwzfKFhJCnjj/XIJDE4ldOZFlpQchvrjPVOyzGTO+rdrddDkZQEJuA6+ts
         tONmkI/a93eUGafgZ7tDTU7WqKrjmNehFnvTcjHuonA5I+PRILMqfD+9ZW2zA7F15yX+
         I5+WpJdKg/RCcUqdX6pG+Apd7cRJn228FEgwk3RK/AzLReO0qDFcVmui40dtvUfA6Om2
         gqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvSXTJDpBzgGI+vxgOF8V2kQ1M5KsZ7z6oEyF10d5X4=;
        b=VAyrGQ+n2dgKRVah/bvXAZ4xNgqug2B0VNS1HdZCSjGt2Ws2B8AbWoo52JJ2SS4wro
         YQPHp7ZNabG8UPQSK5NRZbZ7EYW9HuSENbaD8yHQoINVSA+kVuhO04glVAUx2p+wHi9H
         v3bha1zxOcSZLrlT7iQT3hkaN5bKvCJC2cF1/u/hsWyZMRM0H+UQ9L9tM7TVnE1H+HFn
         O19PNtYuFeeYgNu6DaIJQO0puCLot9sHbBrA7tAk84YZN2E0umWEKO/n7YNT2N+0O2OL
         p/Ptx+sr5TW3T3rG8koZPsZPFk2A5K1DnOmCOKckuU9zLOlGsC+gQf43WTKFYitt8YFz
         ++Sw==
X-Gm-Message-State: AOAM5300y24lth7DaeeE2gFUQxrQgyZS7sHWqxH3JqOQXITkcePm/6Yc
        SsYdMJhFkLz1LwT1WOSLNOSFKRnd/Rs=
X-Google-Smtp-Source: ABdhPJylBKMAMwl1xE/ta5jW7pEkBh1K4LcePCQ6IyivPZtaO7wmKzOGsz58T9Xt0tRtGRPbU1C9zA==
X-Received: by 2002:a17:907:100f:: with SMTP id ox15mr21859551ejb.323.1597789413158;
        Tue, 18 Aug 2020 15:23:33 -0700 (PDT)
Received: from szeder.dev (62-165-238-100.pool.digikabel.hu. [62.165.238.100])
        by smtp.gmail.com with ESMTPSA id d9sm15983118edt.20.2020.08.18.15.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:23:32 -0700 (PDT)
Date:   Wed, 19 Aug 2020 00:23:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200818222329.GC29528@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:
> Introduce a command-line flag and configuration variable to fill in the
> 'max_new_filters' variable introduced by the previous patch.

'max_new_filters' is introduced in this patch.

> The command-line option '--max-new-filters' takes precedence over
> 'commitGraph.maxNewFilters', which is the default value.

What "filters"?  While misnamed, the '--changed-paths' options did a
good job at hiding the implementation detail that we use Bloom filters
to speed up pathspec-limited revision walks; as far as I remember this
was a conscious design decision.  Including "filter" in the name of
the option and corresponding config variable goes against this
decision.  Furthermore, by not being specific we might end up in abad
situation when adding some other filters to the commit-graph format.
Unfortunately, I can't offhand propose a better option name, all my
ideas were horrible.

> '--no-max-new-filters' can also be provided, which sets the value back
> to '-1', indicating that an unlimited number of new Bloom filters may be
> generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> '0', hence a custom callback was used instead).
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/config/commitgraph.txt |  4 +++
>  Documentation/git-commit-graph.txt   |  4 +++
>  bloom.c                              | 15 +++++++++++
>  builtin/commit-graph.c               | 39 +++++++++++++++++++++++++---
>  commit-graph.c                       | 27 ++++++++++++++++---
>  commit-graph.h                       |  1 +
>  t/t4216-log-bloom.sh                 | 19 ++++++++++++++
>  7 files changed, 102 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
> index cff0797b54..4582c39fc4 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -1,3 +1,7 @@
> +commitGraph.maxNewFilters::
> +	Specifies the default value for the `--max-new-filters` option of `git
> +	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
> +
>  commitGraph.readChangedPaths::
>  	If true, then git will use the changed-path Bloom filters in the
>  	commit-graph file (if it exists, and they are present). Defaults to
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 17405c73a9..9c887d5d79 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -67,6 +67,10 @@ this option is given, future commit-graph writes will automatically assume
>  that this option was intended. Use `--no-changed-paths` to stop storing this
>  data.
>  +
> +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> +enforced. Overrides the `commitGraph.maxNewFilters` configuration.

I think this description should also detail what happens with those
commits for which no modified path Bloom filters are calculated, and
which commands will calculate them (even implicitly).

> ++
>  With the `--split[=<strategy>]` option, write the commit-graph as a
>  chain of multiple commit-graph files stored in
>  `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> diff --git a/bloom.c b/bloom.c
> index ed54e96e57..8d07209c6b 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -51,6 +51,21 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
>  	else
>  		start_index = 0;
>  
> +	if ((start_index == end_index) &&
> +	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
> +		/*
> +		 * If the filter is zero-length, either (1) the filter has no
> +		 * changes, (2) the filter has too many changes, or (3) it
> +		 * wasn't computed (eg., due to '--max-new-filters').
> +		 *
> +		 * If either (1) or (2) is the case, the 'large' bit will be set
> +		 * for this Bloom filter. If it is unset, then it wasn't
> +		 * computed. In that case, return nothing, since we don't have
> +		 * that filter in the graph.
> +		 */
> +		return 0;
> +	}
> +
>  	filter->len = end_index - start_index;
>  	filter->data = (unsigned char *)(g->chunk_bloom_data +
>  					sizeof(unsigned char) * start_index +
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 38f5f57d15..3500a6e1f1 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -13,7 +13,8 @@ static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
>  	N_("git commit-graph write [--object-dir <objdir>] [--append] "
>  	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> -	   "[--changed-paths] [--[no-]progress] <split options>"),
> +	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
> +	   "<split options>"),
>  	NULL
>  };
>  
> @@ -25,7 +26,8 @@ static const char * const builtin_commit_graph_verify_usage[] = {
>  static const char * const builtin_commit_graph_write_usage[] = {
>  	N_("git commit-graph write [--object-dir <objdir>] [--append] "
>  	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
> -	   "[--changed-paths] [--[no-]progress] <split options>"),
> +	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
> +	   "<split options>"),
>  	NULL
>  };
>  
> @@ -162,6 +164,23 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
>  	return 0;
>  }
>  
> +static int write_option_max_new_filters(const struct option *opt,
> +					const char *arg,
> +					int unset)
> +{
> +	int *to = opt->value;
> +	if (unset)
> +		*to = -1;
> +	else {
> +		const char *s;
> +		*to = strtol(arg, (char **)&s, 10);
> +		if (*s)
> +			return error(_("%s expects a numerical value"),
> +				     optname(opt, opt->flags));
> +	}
> +	return 0;
> +}
> +
>  static int graph_write(int argc, const char **argv)
>  {
>  	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
> @@ -197,6 +216,9 @@ static int graph_write(int argc, const char **argv)
>  			N_("maximum ratio between two levels of a split commit-graph")),
>  		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
>  			N_("only expire files older than a given date-time")),
> +		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
> +			NULL, N_("maximum number of changed-path Bloom filters to compute"),
> +			0, write_option_max_new_filters),
>  		OPT_END(),
>  	};
>  
> @@ -205,6 +227,7 @@ static int graph_write(int argc, const char **argv)
>  	write_opts.size_multiple = 2;
>  	write_opts.max_commits = 0;
>  	write_opts.expire_time = 0;
> +	write_opts.max_new_filters = -1;
>  
>  	trace2_cmd_mode("write");
>  
> @@ -270,6 +293,16 @@ static int graph_write(int argc, const char **argv)
>  	return result;
>  }
>  
> +static int git_commit_graph_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "commitgraph.maxnewfilters")) {
> +		write_opts.max_new_filters = git_config_int(var, value);
> +		return 0;
> +	}
> +
> +	return git_default_config(var, value, cb);
> +}
> +
>  int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_commit_graph_options[] = {
> @@ -283,7 +316,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_commit_graph_usage,
>  				   builtin_commit_graph_options);
>  
> -	git_config(git_default_config, NULL);
> +	git_config(git_commit_graph_config, &opts);
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_commit_graph_options,
>  			     builtin_commit_graph_usage,
> diff --git a/commit-graph.c b/commit-graph.c
> index 6886f319a5..4aae5471e3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -954,7 +954,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
>  }
>  
>  static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> -					   const struct commit *c)
> +					   const struct commit *c,
> +					   uint32_t max_changed_paths)
>  {
>  	uint32_t graph_pos = commit_graph_position(c);
>  	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> @@ -965,6 +966,17 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
>  
>  	if (!(g && g->bloom_large))
>  		return 0;
> +	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
> +		/*
> +		 * Force all commits which are subject to a different
> +		 * 'max_changed_paths' limit to be recomputed from scratch.
> +		 *
> +		 * Note that this could likely be improved, but is ignored since
> +		 * all real-world graphs set the maximum number of changed paths
> +		 * at 512.

I don't understand what the second part of this comment is trying to
say; and real-world graphs might very well contain Bloom filters with
more than 512 modified paths, because the applying that limit was
buggy.

> +		 */
> +		return 0;
> +	}
>  	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
>  }
>  
> @@ -1470,6 +1482,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  	int i;
>  	struct progress *progress = NULL;
>  	int *sorted_commits;
> +	int max_new_filters;
>  
>  	init_bloom_filters();
>  	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
> @@ -1486,10 +1499,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
>  		&ctx->commits);
>  
> +	max_new_filters = ctx->opts->max_new_filters >= 0 ?
> +		ctx->opts->max_new_filters : ctx->commits.nr;
> +
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		int pos = sorted_commits[i];
>  		struct commit *c = ctx->commits.list[pos];
> -		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
> +		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph,
> +						    c,
> +						    ctx->bloom_settings->max_changed_paths)) {
>  			bitmap_set(ctx->bloom_large, pos);
>  			ctx->count_bloom_filter_known_large++;
>  		} else {
> @@ -1497,7 +1515,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  			struct bloom_filter *filter = get_or_compute_bloom_filter(
>  				ctx->r,
>  				c,
> -				1,
> +				ctx->count_bloom_filter_computed < max_new_filters,
>  				ctx->bloom_settings,
>  				&computed);
>  			if (computed) {
> @@ -1507,7 +1525,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  					ctx->count_bloom_filter_found_large++;
>  				}
>  			}
> -			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
> +			if (filter)
> +				ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
>  		}
>  		display_progress(progress, i + 1);
>  	}
> diff --git a/commit-graph.h b/commit-graph.h
> index af08c4505d..75ef83708b 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -114,6 +114,7 @@ struct commit_graph_opts {
>  	int max_commits;
>  	timestamp_t expire_time;
>  	enum commit_graph_split_flags flags;
> +	int max_new_filters;
>  };
>  
>  /*
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 6859d85369..3aab8ffbe3 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -286,4 +286,23 @@ test_expect_success 'Bloom generation does not recompute too-large filters' '
>  	)
>  '
>  
> +test_expect_success 'Bloom generation is limited by --max-new-filters' '
> +	(
> +		cd limits &&
> +		test_commit c2 filter &&
> +		test_commit c3 filter &&
> +		test_commit c4 no-filter &&
> +		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=2" \
> +			2 0 2
> +	)
> +'
> +
> +test_expect_success 'Bloom generation backfills previously-skipped filters' '
> +	(
> +		cd limits &&
> +		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=1" \
> +			2 0 1
> +	)
> +'
> +
>  test_done
> -- 
> 2.28.0.rc1.13.ge78abce653
