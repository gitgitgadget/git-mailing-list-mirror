Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6741F42D
	for <e@80x24.org>; Thu, 24 May 2018 22:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935889AbeEXWrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 18:47:18 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33682 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935803AbeEXWrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 18:47:17 -0400
Received: by mail-yb0-f193.google.com with SMTP id x36-v6so1202025ybi.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 15:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wNDOQOpDn7vTELQgO6P2spbYffkQfvhn/5eMPVPwK28=;
        b=kiZG4Vs1oqPE70779cnhndHiy7gymHivmyzMDoLOnrkO/x8SnqugxlmpVJfxQwxREx
         wPoT+0Nx542cGdO4m5c0s13zsjyzwlQSJzXASQ5oj7ZlVfZvNZeyvfMAJeTCc1WSWilZ
         fPtZXkU9GAZuiQVMiZsciM+a8SmDjtp6wuz6FygNyanGP9HSvA8LGwSsGNSgwlo7npYG
         8wdk5DavUN1uDhIEpefAa+wQ5EIpHXWtx795An2x6ctJ3bUBcJwG5p9Zzw6qzahRFI3a
         MXXiPUswXLf/DhK/ZFocbfeeEX2PC2j828LLeC88AZhrVgHUAOPrqcUeOe8HsBnhmJCy
         JJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wNDOQOpDn7vTELQgO6P2spbYffkQfvhn/5eMPVPwK28=;
        b=gEBIq+JxF7eC17LJKBnlL/aQz52FuF0pqeg721oN1s/16hdA/j4UXLvbTnLO+HZ3i2
         uQPiMiMbPeZ38A6DnCr44AMO2siIuA1Sjr7jHKbT6NrfXccOza4J2vVgYECYkdpb9k3i
         bG8Zjl1unxsyKPtJ3Q193Sgh14YI4OYg73W3AAEj2nXwzzHUd3bi6QhnyQPDgFc8SRKX
         DTVyo0vzSuejdUMzCNFS0eoCoZyzhCf4LCbC8j8rHlGjsbZWafXfRYR9pp9dPejzsAld
         PoKj5jkw8AIjh6Ly8EIy5IprFGPqpE+2Go/OQByQqIlbUYkdVm9ZF2h14eZs1WwDHVhT
         zD8A==
X-Gm-Message-State: ALKqPwegIhye6V8iEePMvsumaz8/XobKrM4FJ5xWvPls25RBs/X2FnE3
        j6SK7hmLNRD/rg/q2M4YnbQSqsOojD+bpzGq75jPFABn
X-Google-Smtp-Source: AB8JxZqGzd1NJwb5B7q85FpHlIxFR0JQTmInb4n9dvt2BmPEIcdNO7iuPtlqmVc+xL3AVKTe7v8G8NN8CkuTubYbdMk=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr5515634ybx.352.1527202036986;
 Thu, 24 May 2018 15:47:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 24 May 2018 15:47:16 -0700 (PDT)
In-Reply-To: <20180524162504.158394-2-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com> <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-2-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 May 2018 15:47:16 -0700
Message-ID: <CAGZ79kYaC3VsH2kGMvsv0Xn-ghu5t7ENe+yebQCS5nvW5ms1_g@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] commit-graph: UNLEAK before die()
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 9:25 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit-graph.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 37420ae0fd..f0875b8bf3 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -51,8 +51,11 @@ static int graph_read(int argc, const char **argv)
>         graph_name = get_commit_graph_filename(opts.obj_dir);
>         graph = load_commit_graph_one(graph_name);
>
> -       if (!graph)
> +       if (!graph) {
> +               UNLEAK(graph_name);
>                 die("graph file %s does not exist", graph_name);

Unrelated to this patch: Is the command that ends up die()ing here
a plumbing or porcelain, or: Do we want to translate the message here?

In a lot of commands that show paths we single quote them '%s',
(speaking from experience with a lot of submodule path code)
