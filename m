Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88719C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 22:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A06206D5
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 22:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRjq2V2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFGWVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgFGWVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 18:21:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE6AC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 15:21:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so15406753wrv.4
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q0EFM1Wk0V/OXEJE9su+/ORBuhaKZ1StysD2NZBkqzM=;
        b=dRjq2V2Pzul1fllywevwAnL6ttnmyy2mYmoi0JL7VrQxqNRAXpmESJD/9jizkgFOwn
         uN+cBFBkx6yZbmAdNRoPcPesVqi6Du7yg9SbRbE3oWahf+CMXEZozjL+vJaGhBY64paA
         1n5cKJ2LebQyrToCimMA+Sbrzww2E6jTSUBjteFG0Vouip+OpgYpZ/+TKhJDHlhePPsF
         hTA+NhdcOcn81dt5fIU4eD3A/ap1tkSffgL0XF86hemwlSlvZetM7+r/5NXHqBR8J8Ov
         9gSd0YDbLcPy/PjjYkKKpQ1tqVoL3JrwFCnj75FLCH+kj0nGh/eH2r92dXKu3/jmP+wF
         tC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q0EFM1Wk0V/OXEJE9su+/ORBuhaKZ1StysD2NZBkqzM=;
        b=tHQ1Ao09+AXmmPHnPuU4oPbI7mCa+ZY4UPXVj79pNiMm2XXdnnRsokZzXSF0EaFZx6
         Zih8Xau6qNNQ6KLJWPVKd3RRfHxfKW1keHQBRFgFzARiFYa4VPK86wR3snKGD+7Cn9i5
         IuU45fnDlJW/hWRbb4H5l3ZUZh9jMHjAOKWHK2N9dP5tf5fjumIYoh4ZfNEX+YG9Kcke
         BSOYVrDxMdZd/Dc+ZdPRiKDdFrECtDQG6OPw4E5yKkBHYNHvdyLFqPHm7AWe1n0AtyrL
         En99iiFnWZxgzrIwQ4m9WOFvXh9bQa139XDrZNbSjRsixF8DgMgyWa6qkfJCkItbJnT5
         1NKw==
X-Gm-Message-State: AOAM5303TBHMwz1Lp/DJ8sMK+cL1OomKTSHjmX3E102T+pPKeME6PS/x
        lSaeeVVfdbPfQSrw00EGE9M=
X-Google-Smtp-Source: ABdhPJxznmfodXtKhOo34G/NpHvn1bhOfk+eIWyGDolsH3Clzj9CYRhHUA2UUhSY9j9Mc3kXd88k2w==
X-Received: by 2002:a5d:408e:: with SMTP id o14mr19875439wrp.84.1591568469876;
        Sun, 07 Jun 2020 15:21:09 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id k64sm21509373wmf.34.2020.06.07.15.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 15:21:09 -0700 (PDT)
Date:   Mon, 8 Jun 2020 00:21:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 11/15] commit-graph: add --changed-paths option to
 write subcommand
Message-ID: <20200607222106.GB2898@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <c8b86c383abdbbd31ba307eb7e79942ddde1b711.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8b86c383abdbbd31ba307eb7e79942ddde1b711.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:51PM +0000, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> Add --changed-paths option to git commit-graph write. This option will
> allow users to compute information about the paths that have changed
> between a commit and its first parent, and write it into the commit graph
> file. If the option is passed to the write subcommand we set the
> COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
> commit-graph logic.
> 
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 5 +++++
>  builtin/commit-graph.c             | 9 +++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 28d1fee5053..f4b13c005b8 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -57,6 +57,11 @@ or `--stdin-packs`.)
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
>  +
> +With the `--changed-paths` option, compute and write information about the
> +paths changed between a commit and it's first parent. This operation can
> +take a while on large repositories. It provides significant performance gains
> +for getting history of a directory or a file with `git log -- <path>`.

So 'git commit-graph write' only computes and writes changed path
Bloom filters if this option is specified.  Though not mentioned in
the documentation or in the commit message, the negated
'--no-changed-paths' is supported as well, and it removes Bloom
filters from the commit-graph file.  All this is quite reasonable.

However, the most important question is what happens when the
commit-graph file already contains Bloom filters and neither of these
options are specified on the command line.  This isn't mentioned in
the docs or in the commit message, either, but as it is implemented in
this patch (i.e. COMMIT_GRAPH_WRITE_BLOOM_FILTERS is not passed from
the builtin to the commit-graph logic) all those existing Bloom
filters are removed from the commit-graph.  Considering how expensive
it was to compute those Bloom filters this might not be the most
desirable behaviour.

This is important, because 'git commit-graph write' is not the only
command that writes the commit-graph file.  'git gc' does that by
default, too, and will wipe out any modified path Bloom filters while
doing so.  Worse, the user doesn't even have to invoke 'git gc'
manually, because a lot of git commands invoke 'git gc --auto'.

  $ git commit-graph write --reachable --changed-paths
  $ ~/src/git/t/helper/test-tool read-graph |grep ^chunks
  chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
  $ git gc --quiet 
  $ ~/src/git/t/helper/test-tool read-graph |grep ^chunks
  chunks: oid_fanout oid_lookup commit_metadata

Consequently, if users want to use modified path Bloom filters, then
they should avoid gc, both manual and auto, or they'll have to
re-generate the Bloom filters every once in a while.  That is
definitely not the desired behaviour.


Now compare this e.g. to the behaviour of 'git update-index
--split-index' and '--untracked-cache': both of these options turn on
features that improve performance and write extra stuff to the index,
and after they did so all subsequent git commands updating the index
will keep writing that extra stuff, including 'git update-index'
itself even without those options, until it's finally invoked with the
corresponding '--no-...' option.  I particularly like how
'--[no-]untracked-cache' and 'core.untrackedCache' work together and
warn when the given command line option goes against the configured
value, and I think the command line options and configuration
variables controlling modified path Bloom filters should behave
similarly.

>  With the `--split` option, write the commit-graph as a chain of multiple
>  commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
>  not already in the commit-graph are added in a new "tip" file. This file
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index d1ab6625f63..cacb5d04a80 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -9,7 +9,7 @@
>  
>  static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
>  	NULL
>  };
>  
> @@ -19,7 +19,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
>  };
>  
>  static const char * const builtin_commit_graph_write_usage[] = {
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
>  	NULL
>  };
>  
> @@ -32,6 +32,7 @@ static struct opts_commit_graph {
>  	int split;
>  	int shallow;
>  	int progress;
> +	int enable_changed_paths;
>  } opts;
>  
>  static struct object_directory *find_odb(struct repository *r,
> @@ -135,6 +136,8 @@ static int graph_write(int argc, const char **argv)
>  			N_("start walk at commits listed by stdin")),
>  		OPT_BOOL(0, "append", &opts.append,
>  			N_("include all commits already in the commit-graph file")),
> +		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
> +			N_("enable computation for changed paths")),
>  		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>  		OPT_BOOL(0, "split", &opts.split,
>  			N_("allow writing an incremental commit-graph file")),
> @@ -168,6 +171,8 @@ static int graph_write(int argc, const char **argv)
>  		flags |= COMMIT_GRAPH_WRITE_SPLIT;
>  	if (opts.progress)
>  		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
> +	if (opts.enable_changed_paths)
> +		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>  
>  	read_replace_refs = 0;
>  	odb = find_odb(the_repository, opts.obj_dir);
> -- 
> gitgitgadget
> 
