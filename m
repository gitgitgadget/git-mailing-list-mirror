Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007D01F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBBEBL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:01:11 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35514 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBEBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:01:09 -0500
Received: by mail-wr0-f194.google.com with SMTP id w50so21263664wrc.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIoVh0OmyywZLwWCndK6hisDrmWh6giUT1jr3OQzc8c=;
        b=bU2DkoLkCk9pw0L2AobyPWHhgSMuncGBfPo3+8aO+sdkyT6IaZOE3zLjIlFRw2kjaU
         aKJJNwxeCEZASkzsVeFUkFv/qMDPJGgSXSSuFN+aWK0UaIy3eCZOiSfMHyKOssH8eXLk
         NJ5NTmEaUJSVMYwGJK8wacP4Tn36A1hD3uZUMUePiIuu+rq9qv4fZX2yCm2Rj/2bd1xs
         HmFPaGcQ4f43BpxBy6czcxj+nqiA75ISuIFt2CL8Sv9Bb24rZd7qOltRsBasFfxB3whd
         5zlLURSOTJIJV6HVymWDcSZdF/fd29VroFkmleH6zpmYTBxJ2f3sWhlmReYPOCSdVEwW
         9OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIoVh0OmyywZLwWCndK6hisDrmWh6giUT1jr3OQzc8c=;
        b=GL6fjBKSaHHQTSZLnSIyhmFYUn2xX36Qi3/ka1LtXqqMto5xDsKVT77vqDkMSNSe58
         ht7c1DtiL5jncPADxUwbRAUjNdzfBdQURvVblxGKpjOuj09TeqXQgjzcveFULFK+xPzt
         jEfV8oUMhlbGYdUhhowyKLUZLoTK/nk7INd2zUbAzwzLFhWYKrJmeLZJepYoek5lOGpD
         4ycB35BUrNX0RFbU+1VygkKPyb1JH2Y1z4Mk6klS4nhjkCRLOWa54g5j/z07roY0/Ysr
         PpOHSzbcXyt8J69CRyTDMTppuaT3iTr87Av+nuoYQ6qaZda46H3IVlvegL8JvRA4544K
         TyJA==
X-Gm-Message-State: AKwxytcAxmCT6Bm8REW8vqMDzGqTHeMZTNzYXFmryGAeupr0UeEqJrgA
        79rEFkYKe+9hxEaZeCDIDkQ=
X-Google-Smtp-Source: AH8x225CGTq3591puJ/UFNsaiBQcyjjwIhdNHfNL57/mtCNP08JHQ9wUa5jsiN0aKhtDbmGAJHvhhQ==
X-Received: by 10.223.178.9 with SMTP id u9mr29968308wra.149.1517544068154;
        Thu, 01 Feb 2018 20:01:08 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id q131sm919990wmg.18.2018.02.01.20.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:01:07 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 08/14] commit-graph: implement git-commit-graph --clear
Date:   Fri,  2 Feb 2018 05:01:00 +0100
Message-Id: <20180202040100.13793-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-9-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-9-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach Git to delete the current 'graph_head' file and the commit graph
> it references.

And will it leave other, non-important graph files behind?  Looking at
the code it indeed does.  What is the use case for keeping the
non-important graph files?

> This is a good safety valve if somehow the file is
> corrupted and needs to be recalculated. Since the commit graph is a
> summary of contents already in the ODB, it can be regenerated.

Wouldn't a simple 'git commit-graph --write --update-head' regenerate
it on it's own, without cleaning first?  It appears, after running a
few tests, that a corrupt graph file can be recreated without
cleaning, which is great.  However, if graph-head is corrupt, then the
command errors out with 'failed to read graph-head'.  I don't
understand the rationale behind this, it would be overwritten anyway,
and its content is not necessary for recreating the graph.  And
indeed, after commenting out that get_graph_head_hash() call in
cmd_commit_graph() it doesn't want to read my corrupted graph-head
file, and recreates both the graph and graph-head files just fine.

I think the requirement for explicitly cleaning a corrupt graph-head
before re-writing it is just unnecessary complication.

On second thought, what's the point of '--write' without
'--update-head', when consumers (thinking 'log --topo-order...) will
need the graph-head anyway?  I think '--write' should create a
graph-head without requiring an additional option.

Hmph, another second thought: the word 'head' has a rather specific
meaning in Git, although it's usually capitalized.  Using this word in
options and filenames may lead to confusion, especially the option
'--update-head'.


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 16 ++++++++++++++--
>  builtin/commit-graph.c             | 32 +++++++++++++++++++++++++++++++-
>  t/t5318-commit-graph.sh            |  7 ++++++-
>  3 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 99ced16ddc..33d6567f11 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git commit-graph' --write <options> [--pack-dir <pack_dir>]
>  'git commit-graph' --read <options> [--pack-dir <pack_dir>]
> +'git commit-graph' --clear [--pack-dir <pack_dir>]
>  
>  OPTIONS
>  -------
> @@ -18,16 +19,21 @@ OPTIONS
>  	Use given directory for the location of packfiles, graph-head,
>  	and graph files.
>  
> +--clear::
> +	Delete the graph-head file and the graph file it references.
> +	(Cannot be combined with --read or --write.)
> +
>  --read::
>  	Read a graph file given by the graph-head file and output basic
> -	details about the graph file. (Cannot be combined with --write.)
> +	details about the graph file. (Cannot be combined with --clear
> +	or --write.)
>  
>  --graph-id::
>  	When used with --read, consider the graph file graph-<oid>.graph.
>  
>  --write::
>  	Write a new graph file to the pack directory. (Cannot be combined
> -	with --read.)
> +	with --clear or --read.)

All these "cannot be combined with --this and --that" remarks make
subcommands more and more appealing.

>  
>  --update-head::
>  	When used with --write, update the graph-head file to point to
> @@ -61,6 +67,12 @@ $ git commit-graph --write --update-head
>  $ git commit-graph --read --graph-hash=<hash>
>  ------------------------------------------------
>  
> +* Delete <dir>/graph-head and the file it references.
> ++
> +------------------------------------------------
> +$ git commit-graph --clear --pack-dir=<dir>
> +------------------------------------------------
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index d73cbc907d..4970dec133 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -10,6 +10,7 @@
>  
>  static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph [--pack-dir <packdir>]"),
> +	N_("git commit-graph --clear [--pack-dir <packdir>]"),
>  	N_("git commit-graph --read [--graph-hash=<hash>]"),
>  	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head]"),
>  	NULL
> @@ -17,6 +18,7 @@ static char const * const builtin_commit_graph_usage[] = {
>  
>  static struct opts_commit_graph {
>  	const char *pack_dir;
> +	int clear;
>  	int read;
>  	const char *graph_hash;
>  	int write;
> @@ -25,6 +27,30 @@ static struct opts_commit_graph {
>  	struct object_id old_graph_hash;
>  } opts;
>  
> +static int graph_clear(void)
> +{
> +	struct strbuf head_path = STRBUF_INIT;
> +	char *old_path;
> +
> +	if (!opts.has_existing)
> +		return 0;
> +
> +	strbuf_addstr(&head_path, opts.pack_dir);
> +	strbuf_addstr(&head_path, "/");
> +	strbuf_addstr(&head_path, "graph-head");

strbuf_addstr(&head_path, "/graph-head")

Although, considering that this is the third place assembling this
path, maybe a helper function would be worth it.

> +	if (remove_path(head_path.buf))
> +		die("failed to remove path %s", head_path.buf);
> +	strbuf_release(&head_path);
> +
> +	old_path = get_commit_graph_filename_hash(opts.pack_dir,
> +						  &opts.old_graph_hash);
> +	if (remove_path(old_path))
> +		die("failed to remove path %s", old_path);
> +	free(old_path);
> +
> +	return 0;
> +}
> +
>  static int graph_read(void)
>  {
>  	struct object_id graph_hash;
> @@ -105,6 +131,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
>  			N_("dir"),
>  			N_("The pack directory to store the graph") },
> +		OPT_BOOL('c', "clear", &opts.clear,
> +			N_("clear graph file and graph-head")),
>  		OPT_BOOL('r', "read", &opts.read,
>  			N_("read graph file")),
>  		OPT_BOOL('w', "write", &opts.write,
> @@ -126,7 +154,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			     builtin_commit_graph_options,
>  			     builtin_commit_graph_usage, 0);
>  
> -	if (opts.write + opts.read > 1)
> +	if (opts.write + opts.read + opts.clear > 1)
>  		usage_with_options(builtin_commit_graph_usage,
>  				   builtin_commit_graph_options);
>  
> @@ -139,6 +167,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  
>  	opts.has_existing = !!get_graph_head_hash(opts.pack_dir, &opts.old_graph_hash);
>  
> +	if (opts.clear)
> +		return graph_clear();
>  	if (opts.read)
>  		return graph_read();
>  	if (opts.write)
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index d1a23bcdaf..6e3b62b754 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -101,6 +101,11 @@ test_expect_success 'write graph with merges' \
>       _graph_read_expect "18" "${packdir}" &&
>       cmp expect output'
>  
> +test_expect_success 'clear graph' \
> +    'git commit-graph --clear &&
> +     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
> +     test_path_is_missing ${packdir}/graph-head'
> +
>  test_expect_success 'setup bare repo' \
>      'cd .. &&
>       git clone --bare full bare &&
> @@ -110,7 +115,7 @@ test_expect_success 'setup bare repo' \
>       baredir="./objects/pack"'
>  
>  test_expect_success 'write graph in bare repo' \
> -    'graphbare=$(git commit-graph --write) &&
> +    'graphbare=$(git commit-graph --write --update-head) &&

This should have been done in the previous patch.

>       test_path_is_file ${baredir}/graph-${graphbare}.graph &&
>       test_path_is_file ${baredir}/graph-head &&
>       echo ${graphbare} >expect &&
> -- 
> 2.16.0.15.g9c3cf44.dirty

