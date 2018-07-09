Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4530F1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeGIVlg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:41:36 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40055 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVlf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:41:35 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so7091446ywg.7
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOb5MLqU4BDayEN51of3EcypsPds9IKmsnyJ7u9JA4c=;
        b=oiV5IACG3Gzr8pcMr3EY+qxEjttk14zMVdCOwJPsDfFh6A5BXoV2SSQ7t5Al2esOj3
         f1gY8S/PZVOMQuAxCiHHSvXqwdkZScyyzKbr+19wD6P8z9WtZwSULlPZtS7IPJlmL/m6
         nAO/20ZkxsORsN9XocMkJkzNiYTcZxCPKn4+35iRYxJFK3uY+7YEEDc16Wx8jtav+GRa
         ITkEE46rK0MOlCBOVnuA6Vo6ymcjWW/wSMWv6Pff36bw/nq0v2n1bmucJe36MlZyIMEi
         ZmA/AlrOCCz9cp77aV0QG9yirlKvla9iBXQgrXsXpSE1jLtUBvCUR5UbhhaBCgaUnCKQ
         54Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOb5MLqU4BDayEN51of3EcypsPds9IKmsnyJ7u9JA4c=;
        b=LLWJ98vcoP2XgNiIyF5a4z6Z2HgR78wPZnymDDfNreGkqcLpK8vHXM7qWahStARhRC
         vARR86uJAONf5e/9EuL+Ize8wXtJhUT+hhWJyHMMnmsebrTWkG7XbBtm4Dv550P3BOqg
         Vz9gpmtsWNIvKqjakGKxdQSKlf6Gc2fgc/54aK/X22U66LKIItAT2rL/CFv4ElF0+U9X
         /JOC2K7mZr6khB4SRbVSMYnK9S4PyYFc07ZoGncsIE4xtSNEohpNHEeHZYoFPZBWq3T/
         bnPlxn6V3ifBj5R5eSwqhlbuP3VpudqeLoKoX8CCu1JUttKFNxXhrCnVjt0JIX1W7q22
         mcPw==
X-Gm-Message-State: APt69E152xSK6ebXzZ4S3q871xAClyqIIvMOLTJc8JPJHDjWH3+uUYfp
        P2VqszmqS2PJlwLvZCipwaiFQyvQEBoH3nE3h4PKFw==
X-Google-Smtp-Source: AAOMgpeOnkZB6BhE7HeQv+ssp8h9nonHaziEn4X8HtxoDTjZUPpaCCzUJGAsktSoLC7HUTJ5uXuh6GoBAYzFlKObZjQ=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr10728694ywd.500.1531172494768;
 Mon, 09 Jul 2018 14:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531168854.git.jonathantanmy@google.com> <9769e2a7471c2b32185896e833cc74824ac5437e.1531168854.git.jonathantanmy@google.com>
In-Reply-To: <9769e2a7471c2b32185896e833cc74824ac5437e.1531168854.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 14:41:23 -0700
Message-ID: <CAGZ79kaE_42A2B=VjRcNdJzueeVZmrsj6iNgk=6u9bi6pA4hQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] commit-graph: refactor preparing commit graph
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,
On Mon, Jul 9, 2018 at 1:44 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Two functions in the code (1) check if the repository is configured for
> commit graphs, (2) call prepare_commit_graph(), and (3) check if the
> graph exists. Move (1) and (3) into prepare_commit_graph(), reducing
> duplication of code.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>



>  static int prepare_commit_graph_run_once = 0;
> -static void prepare_commit_graph(void)
> +
> +/*
> + * Return 1 if commit_graph is non-NULL, and 0 otherwise.
> + *
> + * On the first invocation, this function attemps to load the commit
> + * graph if the_repository is configured to have one.

and as we talk about in-memory commit graph (and not some
stale file that may still be around on the fs), we can assertly return
0 when core_commit_graph is false.

Makes sense!

> @@ -337,22 +348,17 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
>
>  int parse_commit_in_graph(struct commit *item)
>  {
> -       if (!core_commit_graph)
> +       if (!prepare_commit_graph())
>                 return 0;
> -
> -       prepare_commit_graph();
> -       if (commit_graph)
> -               return parse_commit_in_graph_one(commit_graph, item);
> -       return 0;
> +       return parse_commit_in_graph_one(commit_graph, item);

Makes sense.

>  }
>
>  void load_commit_graph_info(struct commit *item)
>  {
>         uint32_t pos;
> -       if (!core_commit_graph)
> +       if (!prepare_commit_graph())
>                 return;
> -       prepare_commit_graph();
> -       if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> +       if (find_commit_in_graph(item, commit_graph, &pos))
>                 fill_commit_graph_info(item, commit_graph, pos);

here too,

This is
Reviewed-by: Stefan Beller <sbeller@google.com>
