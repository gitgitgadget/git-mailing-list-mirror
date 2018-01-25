Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3AD1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 21:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeAYVn2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 16:43:28 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35364 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeAYVn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 16:43:27 -0500
Received: by mail-pf0-f194.google.com with SMTP id t12so6767657pfg.2
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EeYjzo6F3RRrkRa1jwPwkmNrM7k9ZJObhccsuWl3Mk4=;
        b=rk4zLhTtbCuEp6/bCVi49/MUlpmAAm1h3fkXcoKaGzSLA38/nbW7KUUTVz+WgnOxm3
         +b2PvTVjO+Tg+8ertWNwQj87MBsGlqu1jujHfkMIsi5tzFhbhUKls0C7ETkzlSj3jBni
         BKane4sNX1yZGjj97pauZXL521SEhfdCD+uClUqlIH6vQCYwIRtRfK89ELlMDfwIvAQe
         azEDC9GVsTwSP0b5jcwaEgb5gl104wk2aVoKC4Y/VIOU/2pBvYZCOeqsxro30ILbZXM8
         2ifnuqSlmtOrORtsuOYNwucf9MP5IlFyGr2SqlF93EFB6Y/ImXKjtkrpw5H7Lamj/qoX
         qi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EeYjzo6F3RRrkRa1jwPwkmNrM7k9ZJObhccsuWl3Mk4=;
        b=kJUdh99cQm+5VrrzF10EYcXtM9Y1wul6coKkB1uMBfxLOKD+WQtky2koGLo1Lp0JjI
         sjLxuaUVzZIJ4+2beEQvhIKfT5csS/h9YF/tzQi++Y6RMnmNJ7BtxUCLarQFJPrHd62R
         D4cjqecdISwI9+IWok5r17p/F9JzqwMTWfRBjuPKi1wz4kONUngqXaQHxaHSgXE3QdRw
         2CqaDVpNj/lLD46sy6hC1F8zS7kWW1dhIdhppI4Qf8J6D6DY72d6uPaGeyCWEbAg9bd5
         kGpvNOWurQ1dZleo/zq/cKYpW2PvdpqJ2DTTniqe8QYQDpXLhU5uIMyLyKUQCjBGl/NX
         DU2w==
X-Gm-Message-State: AKwxyteKoTsRtJN+ubQ2t3Ti9SJrLAatWC1k59AXKROZ+OnnmriEQIlo
        jX1dF8n+Xq81JYfkQxIgoP0=
X-Google-Smtp-Source: AH8x227q0b38qQ4pitA5dxUwMrEXRmlYOIB5m0tcWGGG0bvV9yWcjsdAPFGKcNJSfU/lDjsOFq6Ctg==
X-Received: by 2002:a17:902:6c41:: with SMTP id h1-v6mr12416162pln.25.1516916606483;
        Thu, 25 Jan 2018 13:43:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id i187sm971975pfc.99.2018.01.25.13.43.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 13:43:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 02/14] packed-graph: add core.graph setting
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-3-dstolee@microsoft.com>
Date:   Thu, 25 Jan 2018 13:43:24 -0800
In-Reply-To: <20180125140231.65604-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 25 Jan 2018 09:02:19 -0500")
Message-ID: <xmqqvafp8vib.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The packed graph feature is controlled by the new core.graph config
> setting. This defaults to 0, so the feature is opt-in.
>
> The intention of core.graph is that a user can always stop checking
> for or parsing packed graph files if core.graph=0.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt | 3 +++
>  cache.h                  | 1 +
>  config.c                 | 5 +++++
>  environment.c            | 1 +
>  4 files changed, 10 insertions(+)

Before you get too married to the name "graph", is it reasonable to
assume that the commit ancestry graph is the primary "graph" that
should come to users' minds when a simple word "graph" is used in
the context of discussing Git?  I suspect not.

Let's not just call this "core.graph" and "packed-graph", and in
addition give some adjective before "graph".




> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e25b2c92b..e7b98fa14f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -898,6 +898,9 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>  
> +core.graph::
> +	Enable git commit graph feature. Allows writing and reading from .graph files.
> +
>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
> diff --git a/cache.h b/cache.h
> index d8b975a571..655a81ac90 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -825,6 +825,7 @@ extern char *git_replace_ref_base;
>  extern int fsync_object_files;
>  extern int core_preload_index;
>  extern int core_apply_sparse_checkout;
> +extern int core_graph;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
> diff --git a/config.c b/config.c
> index e617c2018d..fee90912d8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1223,6 +1223,11 @@ static int git_default_core_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.graph")) {
> +		core_graph = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.sparsecheckout")) {
>  		core_apply_sparse_checkout = git_config_bool(var, value);
>  		return 0;
> diff --git a/environment.c b/environment.c
> index 63ac38a46f..0c56a3d869 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -61,6 +61,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>  char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_apply_sparse_checkout;
> +int core_graph;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
