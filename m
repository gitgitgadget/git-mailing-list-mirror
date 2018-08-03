Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A6E1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 09:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeHCLfJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 07:35:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41675 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeHCLfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 07:35:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so1921794edr.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3l7x2+EYX7yHTVGfjoM5BK3vmGMd7Z2iujrQnDz9tyA=;
        b=CA+S9yuXfql7FvioozC7nwjPYdOoyV0pSo0sB3Igu9j0mMGvz2HRY2HMJkqeRc3+ug
         uDqKJLYdsMpy9DSggdLT/vhle9DrL7QZNtlR4i9UrPSNgezuAQkMGZn24Yea8ZOU28zK
         y57AS8qYA5HeboP20m6c9S39yqmfmjjVNd5NqLcTTFUVuhD1rELX+qSGq/a0oNtRFna2
         ZniV8EtxlchXK8aiVBlgukKbh3TYh9qPoVsOxCw37W9Dgev+3tL/6Z9n6LOdmdSDQlL2
         9EuanYsXyARUVP3vxWfLIoZdypsZ4SBVi2lHI7fynHwcXn/4eNh0BAbpdqKp5ds9HICW
         mwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3l7x2+EYX7yHTVGfjoM5BK3vmGMd7Z2iujrQnDz9tyA=;
        b=enQ8WNNVt1rSVC+YmFUfd5TuH5sQEfBgWFElKppoWN7qA9s4qn6zhrsPNfpjA0VWXL
         4MC0/qM2B0UPkAxq/bocLn/ZQh7kjOLY3vIpZHmeT3jztXQXaW5fLrzgCEq0EeVeN2oa
         baRtZmBhk9yUjkBnPotuuhotkxo0mftdROkJk5DLGWUQZeUj0UQ4ShaK/d3Te0H5sXKi
         wUa5bGrE1udy5ze64F8FVikpa4eYRCC09Mav6/CJsVd/rDjihNV/cTUizi5sZ3eRyaFq
         RTDNu68YAa2dzV0DVGAKow+dUSfyzTohzxoCw+BIBocjOBBooxHVrn8NpetsDOeZ3yyU
         PJ+g==
X-Gm-Message-State: AOUpUlF/Xz/O56jnateVcxh0MHGC/8sWEJkNklaIGI6gJujVcG6XcCK/
        cyZTGWTV633Rv7IAuIstSzs=
X-Google-Smtp-Source: AAOMgpdZQVjbBz+sJ8XTVFn+gFuBSW7jenZabsyb3Yfj4HwRKVZ2VNgStEp+Zu+n5SfsfAMZrzUAeg==
X-Received: by 2002:a50:97fc:: with SMTP id f57-v6mr6589276edb.21.1533289178253;
        Fri, 03 Aug 2018 02:39:38 -0700 (PDT)
Received: from localhost.localdomain (x590c6fd8.dyn.telefonica.de. [89.12.111.216])
        by smtp.gmail.com with ESMTPSA id a8-v6sm3184346eda.27.2018.08.03.02.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 02:39:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        sbeller@google.com, jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 21/22] gc: automatically write commit-graph files
Date:   Fri,  3 Aug 2018 11:39:09 +0200
Message-Id: <20180803093909.2853-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180627132447.142473-22-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com> <20180627132447.142473-1-dstolee@microsoft.com> <20180627132447.142473-22-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Derrick,

> The commit-graph file is a very helpful feature for speeding up git
> operations. In order to make it more useful, make it possible to
> write the commit-graph file during standard garbage collection
> operations.
> 
> Add a 'gc.commitGraph' config setting that triggers writing a
> commit-graph file after any non-trivial 'git gc' command. Defaults to
> false while the commit-graph feature matures. We specifically do not
> want to have this on by default until the commit-graph feature is fully
> integrated with history-modifying features like shallow clones.
> 
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt |  9 ++++++---
>  Documentation/git-gc.txt |  4 ++++
>  builtin/gc.c             |  6 ++++++
>  t/t5318-commit-graph.sh  | 14 ++++++++++++++
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828c..978deecfee 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -904,9 +904,12 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>  
> -core.commitGraph::
> -	Enable git commit graph feature. Allows reading from the
> -	commit-graph file.
> +gc.commitGraph::
> +	If true, then gc will rewrite the commit-graph file when
> +	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
> +	'--auto' the commit-graph will be updated if housekeeping is
> +	required. Default is false. See linkgit:git-commit-graph[1]
> +	for details.

Sorry, I've lost track of this patch series, unfortunately, but after
it hit master yesterday a merge conflict with one of my (unrelated)
WIP patches drew my attention to this hunk above, which got me
confused:

 - Why remove the description of 'core.commitGraph'?  'git grep -i
   core.commitGraph' shows that it's still used supported.

 - Why insert the description of 'gc.commitGraph' here instead of next
   to the other 'gc.*' config variables, breaking lexicographical
   order of confvars?

 - This hunk, the other documentation hunk right below, and indeed the
   commit message all speak about 'gc.commitGraph', but the new code
   and test added in this patch use 'gc.writeCommitGraph' (following
   my suggestion from a couple of weeks ago, I think?).

What's going on?

>  
>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 24b2dd44fe..f5bc98ccb3 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -136,6 +136,10 @@ The optional configuration variable `gc.packRefs` determines if
>  it within all non-bare repos or it can be set to a boolean value.
>  This defaults to true.
>  
> +The optional configuration variable `gc.commitGraph` determines if
> +'git gc' should run 'git commit-graph write'. This can be set to a
> +boolean value. This defaults to false.
> +
>  The optional configuration variable `gc.aggressiveWindow` controls how
>  much time is spent optimizing the delta compression of the objects in
>  the repository when the --aggressive option is specified.  The larger
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ccfb1ceaeb..b7dd206f41 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -20,6 +20,7 @@
>  #include "sigchain.h"
>  #include "argv-array.h"
>  #include "commit.h"
> +#include "commit-graph.h"
>  #include "packfile.h"
>  #include "object-store.h"
>  #include "pack.h"
> @@ -40,6 +41,7 @@ static int aggressive_depth = 50;
>  static int aggressive_window = 250;
>  static int gc_auto_threshold = 6700;
>  static int gc_auto_pack_limit = 50;
> +static int gc_write_commit_graph = 0;
>  static int detach_auto = 1;
>  static timestamp_t gc_log_expire_time;
>  static const char *gc_log_expire = "1.day.ago";
> @@ -129,6 +131,7 @@ static void gc_config(void)
>  	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
>  	git_config_get_int("gc.auto", &gc_auto_threshold);
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
> +	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_get_expiry("gc.pruneexpire", &prune_expire);
>  	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
> @@ -641,6 +644,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (pack_garbage.nr > 0)
>  		clean_pack_garbage();
>  
> +	if (gc_write_commit_graph)
> +		write_commit_graph_reachable(get_object_directory(), 0);
> +
>  	if (auto_gc && too_many_loose_objects())
>  		warning(_("There are too many unreachable loose objects; "
>  			"run 'git prune' to remove them."));
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2208c266b5..5947de3d24 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -245,6 +245,20 @@ test_expect_success 'perform fast-forward merge in full repo' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success 'check that gc computes commit-graph' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit --allow-empty -m "blank" &&
> +	git commit-graph write --reachable &&
> +	cp $objdir/info/commit-graph commit-graph-before-gc &&
> +	git reset --hard HEAD~1 &&
> +	git config gc.writeCommitGraph true &&
> +	git gc &&
> +	cp $objdir/info/commit-graph commit-graph-after-gc &&
> +	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
> +	git commit-graph write --reachable &&
> +	test_cmp commit-graph-after-gc $objdir/info/commit-graph
> +'
> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
> -- 
> 2.18.0.24.g1b579a2ee9
> 
> 
