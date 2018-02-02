Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D091F404
	for <e@80x24.org>; Fri,  2 Feb 2018 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeBBPE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 10:04:57 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36011 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBBPEx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 10:04:53 -0500
Received: by mail-wm0-f54.google.com with SMTP id f3so13039818wmc.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jvgeMXr3dOT0XNOPmKfFNuDXQSGRWpPHnhDkk1++b8=;
        b=czXZ4YmJLGeXrBC+HfvdgYvNMm4GN4+E3jOrAr93VfxmGQRk7xoUcFbzS9kRvoW6WT
         TDNaTqMdZyWQCjNofwS0nXLVQtXito+85u/wWVCdaQ1y8mbSvLKVM9FxPC/yCDOLAxlz
         Uw+FMaP1dP0I9zjgAOwo2GQvuwBj9qFkd0UeFpzoTYW/Qn98sLfMMhRI4RRSMmfKAAU6
         UFHQJbytFBM+/V2mHRBsL8mTjorbVoTsJP2RlySFXRtm+k7QxWs6eoZNGZppCJUdt8xW
         hvZSXYVV3h8GP8aNb6bigIKDmLPpeXWkKHYA78jz95xDyX2Vd1qkd+f8Ud2ZdF4sxtNL
         uN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jvgeMXr3dOT0XNOPmKfFNuDXQSGRWpPHnhDkk1++b8=;
        b=jMje2Kj5ImwWobvMr1tKBmgx1xbR2ucziIyyQGsbqs6Jwj4HuOLur6CdkmgnOTNJBO
         MzHt9/Rh6j+HnvEn397YCvtFDnqCQGXqF1Nt9Dml9wry8IV3SgMVVPCrnv5Ojs/nvqIs
         Nb5bZyK67aNKlOyU++FudM06BI69IA2pXXlJjOEpRA3xR6c85HASSLIsdNarSGgUHVBe
         2BehzV0GNBE4Iml1Xi4bGgZTWxJ4BVglus9qQwngPIQB/izDWUhu3jhqmTGURwiu7Ll/
         ckiF8pMOZg9L9xNVuaKTyzhlK5TOSMN28jIag51LruS/BIuBv/29plkkqJSHVLXovRBs
         zY5w==
X-Gm-Message-State: AKwxyteKbexRPSo99wXh6OWNJ5Ms5f1969W2D+fwVUWZUZRYN/qi8DQi
        zqoGUr3qhPxuKKqrbewZhzk=
X-Google-Smtp-Source: AH8x224kFbrW42nqUeFuA0FJNANbc27GM2bleVUsPCCt3hQx4ORUNcGQWceHITcEePsDfupLnT1uFg==
X-Received: by 10.28.46.22 with SMTP id u22mr28460628wmu.47.1517583892350;
        Fri, 02 Feb 2018 07:04:52 -0800 (PST)
Received: from localhost.localdomain (x4db2a0d5.dyn.telefonica.de. [77.178.160.213])
        by smtp.gmail.com with ESMTPSA id m6sm2909029wmb.6.2018.02.02.07.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Feb 2018 07:04:51 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 09/14] commit-graph: teach git-commit-graph --delete-expired
Date:   Fri,  2 Feb 2018 16:04:41 +0100
Message-Id: <20180202150441.27206-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-10-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-10-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach git-commit-graph to delete the graph previously referenced by 'graph_head'
> when writing a new graph file and updating 'graph_head'. This prevents
> data creep by storing a list of useless graphs. Be careful to not delete
> the graph if the file did not change.

We have to be careful with deleting the previously referenced graph
file right away after generating the new one.  Consider two processes
running concurrently, one writing new graph files with
--delete-expire', and the other reading the commit graph, e.g. a
future graph-aware 'git gc' and 'git log --topo-order':

  1. 'log' reads the hash of the graph file from graph-head.
  2. 'gc' writes the new graph and graph head files and deletes the
     old graph file.
  3. 'log' tries to open the the graph file with the hash it just
     read, but that file is already gone.

At this point 'log' could simply error out, but that would be rather
unfriendly.  Or it could try harder and could just ignore the missing
graph file and walk revisions the old school way.  It would be slower,
depending on the history size maybe much slower, but it would work.
Good.

However, in addition to the reader trying harder, I think we should
also consider making the writer more careful, too, and only delete a
stale graph file after a certain grace period is elapsed; similar to
how 'git gc' only deletes old loose objects.  And then perhaps it
should delete all graph files that are older than that grace period;
as it is, neither '--clear' nor '--delete-expired' seem to care about
graph files that aren't or weren't referenced by the graph-head.


> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 4970dec133..766f09e6fc 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c

> @@ -121,6 +122,17 @@ static int graph_write(void)
>  	if (graph_hash)
>  		printf("%s\n", oid_to_hex(graph_hash));
>  
> +
> +	if (opts.delete_expired && opts.update_head && opts.has_existing &&
> +	    oidcmp(graph_hash, &opts.old_graph_hash)) {
> +		char *old_path = get_commit_graph_filename_hash(opts.pack_dir,
> +								&opts.old_graph_hash);
> +		if (remove_path(old_path))
> +			die("failed to remove path %s", old_path);
> +
> +		free(old_path);
> +	}
> +
>  	free(graph_hash);
>  	return 0;
>  }
> @@ -139,6 +151,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			N_("write commit graph file")),
>  		OPT_BOOL('u', "update-head", &opts.update_head,
>  			N_("update graph-head to written graph file")),
> +		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
> +			N_("delete expired head graph file")),
>  		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
>  			N_("hash"),
>  			N_("A hash for a specific graph file in the pack-dir."),

Like '--update-head', '--delete-expired' is silently ignored when it's
not used with '--write'.


> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 6e3b62b754..b56a6d4217 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh

> +test_expect_success 'write graph with merges' \
> +    'graph3=$(git commit-graph --write --update-head --delete-expired) &&
> +     test_path_is_file ${packdir}/graph-${graph3}.graph &&
> +     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
> +     test_path_is_file ${packdir}/graph-${graph1}.graph &&
> +     test_path_is_file ${packdir}/graph-head &&
> +     echo ${graph3} >expect &&
> +     cmp -n 40 expect ${packdir}/graph-head &&

printf and test_cmp.

> +     git commit-graph --read --graph-hash=${graph3} >output &&
> +     _graph_read_expect "23" "${packdir}" &&
> +     cmp expect output'
> +
> +test_expect_success 'write graph with nothing new' \
> +    'graph4=$(git commit-graph --write --update-head --delete-expired) &&
> +     test_path_is_file ${packdir}/graph-${graph4}.graph &&
> +     test_path_is_file ${packdir}/graph-${graph1}.graph &&
> +     test_path_is_file ${packdir}/graph-head &&
> +     echo ${graph4} >expect &&
> +     cmp -n 40 expect ${packdir}/graph-head &&

Likewise.

> +     git commit-graph --read --graph-hash=${graph4} >output &&
> +     _graph_read_expect "23" "${packdir}" &&
> +     cmp expect output'
> +
>  test_expect_success 'clear graph' \
>      'git commit-graph --clear &&
>       test_path_is_missing ${packdir}/graph-${graph2}.graph &&
> +     test_path_is_file ${packdir}/graph-${graph1}.graph &&
>       test_path_is_missing ${packdir}/graph-head'
>  
>  test_expect_success 'setup bare repo' \
> @@ -121,7 +185,7 @@ test_expect_success 'write graph in bare repo' \
>       echo ${graphbare} >expect &&
>       cmp -n 40 expect ${baredir}/graph-head &&
>       git commit-graph --read --graph-hash=${graphbare} >output &&
> -     _graph_read_expect "18" "${baredir}" &&
> +     _graph_read_expect "23" "${baredir}" &&
>       cmp expect output'
>  
>  test_done
> -- 
> 2.16.0.15.g9c3cf44.dirty


