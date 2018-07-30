Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D6A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeG3VBX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:01:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43334 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeG3VBX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:01:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so14062970wrv.10
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3V7svOT3JLbwV6x7OsX0JI4SihXmTeGsjYxJbnkSnsg=;
        b=bV4wwjj7kv39UMyu8jEcJo6Ris6XENLBQ+5IZ/fPx3aWQ4mZoT7tbziwbaKM5rwTGN
         yGDgHSfvZJap6L/DXYjatb9FD0TcQSq+xVXCkMKnVrMeM/YJkCMQZH5TOQNf02OEyEMW
         qKIhhbOGadGUpq+JtRAas5yvzcOPDtNBB9vnlU80rVjA6JRH8F+IsFS6h0a1Z6jjtL4B
         dlyJ4JWagAQSuZR8IfVjUvAnc4DjisInZKXMVDYddYj1qiX/bKKcnrS6M7nxHFIS4yiq
         gMRdGIKMC1AFifhK82Ys9hBUjeDPby625EZ50jfKHCFao1SY13SnFbuFY/4hz11eeuBd
         etzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3V7svOT3JLbwV6x7OsX0JI4SihXmTeGsjYxJbnkSnsg=;
        b=G8rn2Y/crTfFZEdenOd8WYEGe1j1DWzS/BlI58F0IivctwOP1pEUg4vp7v+Suy8r3u
         Y0aC4H4ip1Fy/7jkPrj2Gi2ESunSbFokpZH5XUu0tAiDnGTRVBX/xmrzRUw4oNYXyNaH
         LodYtElkG2ojYJ1mY0Km5WhKvchkdoSLuKZ/ZDoMszeLrRWrWupim0Dk8aiunkTwhCcR
         z8C1Y9D/fl9WtywZzFERo6CqDU81UcdvKofS95atZWgbmYD1+YGevd4kDrHJB71pqnCC
         TKP5CIkhUzkI6WuvXsqO+Hg1tRdglcf+93VSrtL0XLYr87vf7B/0CsJA2K3gP+Iu7ywl
         yO+g==
X-Gm-Message-State: AOUpUlGHlKdQKZjRo9uZ+OsREky7i+1lr1DYfy39WUptcFT4mPfqlDoz
        Qs6KS7WKT0AARCQ1dT8h5mE=
X-Google-Smtp-Source: AAOMgpds1cj9HEGr9NFS3UfwAOwTQ1sGyyF9ldNcS7/iJTlfc/ynEiLKF25ejjStavxyfOWzm5Cqyg==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr102630wro.263.1532978695130;
        Mon, 30 Jul 2018 12:24:55 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abur106.neoplus.adsl.tpnet.pl. [83.8.189.106])
        by smtp.gmail.com with ESMTPSA id z3-v6sm16553369wru.27.2018.07.30.12.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:24:53 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 8/8] commit-graph: close_commit_graph before shallow walk
References: <pull.11.git.gitgitgadget@gmail.com>
        <f4ab234ed20ac813f41cb4be418528d3e59303fd.1531926932.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Jul 2018 21:24:53 +0200
In-Reply-To: <f4ab234ed20ac813f41cb4be418528d3e59303fd.1531926932.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:45 -0700 (PDT)")
Message-ID: <86tvog5xx6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Make close_commit_graph() work for arbitrary repositories.

The first line (above) does not match the rest of the commit message.

> Call close_commit_graph() when about to start a rev-list walk that
> includes shallow commits. This is necessary in code paths that "fake"
> shallow commits for the sake of fetch. Specifically, test 351 in
> t5500-fetch-pack.sh runs
>
> 	git fetch --shallow-exclude one origin
>
> with a file-based transfer. When the "remote" has a commit-graph, we do
> not prevent the commit-graph from being loaded, but then the commits are
> intended to be dynamically transferred into shallow commits during
> get_shallow_commits_by_rev_list(). By closing the commit-graph before
> this call, we prevent this interaction.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 8 ++++----
>  commit-graph.h | 1 +
>  upload-pack.c  | 2 ++
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 233958e10..237d4e7d1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -256,10 +256,10 @@ static int prepare_commit_graph(struct repository *r)
>  	return !!r->objects->commit_graph;
>  }
>  
> -static void close_commit_graph(void)
> +void close_commit_graph(struct repository *r)
>  {
> -	free_commit_graph(the_repository->objects->commit_graph);
> -	the_repository->objects->commit_graph = NULL;
> +	free_commit_graph(r->objects->commit_graph);
> +	r->objects->commit_graph = NULL;
>  }
>  
>  static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
> @@ -871,7 +871,7 @@ void write_commit_graph(const char *obj_dir,
>  	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
>  	write_graph_chunk_large_edges(f, commits.list, commits.nr);
>  
> -	close_commit_graph();
> +	close_commit_graph(the_repository);
>  	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
>  	commit_lock_file(&lk);
>  
> diff --git a/commit-graph.h b/commit-graph.h
> index 76e098934..13d736cdd 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -59,6 +59,7 @@ void write_commit_graph(const char *obj_dir,
>  
>  int verify_commit_graph(struct repository *r, struct commit_graph *g);
>  
> +void close_commit_graph(struct repository *);
>  void free_commit_graph(struct commit_graph *);
>  
>  #endif
> diff --git a/upload-pack.c b/upload-pack.c
> index 4ca052d0b..52ad6c8e5 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -24,6 +24,7 @@
>  #include "quote.h"
>  #include "upload-pack.h"
>  #include "serve.h"
> +#include "commit-graph.h"
>  
>  /* Remember to update object flag allocation in object.h */
>  #define THEY_HAVE	(1u << 11)
> @@ -739,6 +740,7 @@ static void deepen_by_rev_list(int ac, const char **av,
>  {
>  	struct commit_list *result;
>  
> +	close_commit_graph(the_repository);
>  	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
>  	send_shallow(result);
>  	free_commit_list(result);
