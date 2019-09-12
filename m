Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A871F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfILTaa (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:30:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38677 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfILTaa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:30:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so4169091qta.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NgKN/+9ROV8xFBJphqfVwNY4wrBZp7buMD/5rAsDjGA=;
        b=UKKs/oWMPTyPdmePqr+z/1nCHgSQYH/YBDtD5ZF7Clvgpt0aviBLAaqh6XMNuqEO3B
         muAhTEocjkZMtspPz9c3/T5c7zhEI3tKSEY8bKk4BiNKnUQO+wvEYyalezAy9N5Pu0eE
         kgPAwO8L/G6CRCrcX6HFrqKESWSQj9fPNEfZmMVCN4YJV0++C2mI2r3xUMKid6L6MgnD
         dGUtge2O3uZgaDDeoZSawZo6v1XEzYgeyMI5tOZmHK1zAIyKRHnuBc+4coQGdI/60B0t
         l7Ws5GDangsAt1Q4ulGKC6ypOi0EN6tyO0Cmg11jhbJbP400AcUtLSw1Cb+9ygB7FodM
         Y1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NgKN/+9ROV8xFBJphqfVwNY4wrBZp7buMD/5rAsDjGA=;
        b=pLd+ChiOJyo8BPvt34yN0je++FTd5JPQau6usi7iQi8BXFCwdl0Ol13J1lmvBqTbvx
         NyvTjaetplVVDf09Rz+w9q+lNe9tti8yOgZJ517Qhe9QuFHoAi+BaMjCgYzfWfmLWdfQ
         j02/ItoI+VRYsyIK4PHNvGkxH2/2cLQzTGx4/bXlN4J8vf/jTH2vqIA8FGKAb/HGanbp
         WlsHmfa5AYiNcLPjtboIFeqeGyvWeLsRP7dSDMxqRo7oEc9xHrOdzIbBsDNIEmYYc/cw
         hrhLHOIZsyFqO7nSsV0W2xXJMlCk+zJITp4+qK8BnoO4cgh3tcQkgJWJERyYgcgOIdMx
         qIwg==
X-Gm-Message-State: APjAAAWpy4fX9Ano8gB+HbUNrzsWoIjZW29JGB5YkFnWLuZviTATY0xZ
        Uby46M3H1E2BJIWQ2piPWGtBccb9B/Q=
X-Google-Smtp-Source: APXvYqw+URYw5bIwfbYQlp9FWSK6QkP5uSXb0ZGCwhufHdFf1f3wNkUajC45cyKtmVj4Jvp3bjZJtA==
X-Received: by 2002:a0c:8a6d:: with SMTP id 42mr28669126qvu.138.1568316628553;
        Thu, 12 Sep 2019 12:30:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:3977:64ab:d1ea:251b? ([2001:4898:a800:1010:c20d:64ab:d1ea:251b])
        by smtp.gmail.com with ESMTPSA id k46sm10005553qtc.96.2019.09.12.12.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 12:30:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] commit-graph: bump DIE_ON_LOAD check to actual
 load-time
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190912144122.GA27815@sigill.intra.peff.net>
 <20190912144434.GA25101@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef10d60c-aab1-4336-a330-9ea4d102bbc5@gmail.com>
Date:   Thu, 12 Sep 2019 15:30:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190912144434.GA25101@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2019 10:44 AM, Jeff King wrote:
> Commit 43d3561805 (commit-graph write: don't die if the existing graph
> is corrupt, 2019-03-25) added an environment variable we use only in the
> test suite, $GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD. But it put the check for
> this variable at the very top of prepare_commit_graph(), which is called
> every time we want to use the commit graph. Most importantly, it comes
> _before_ we check the fast-path "did we already try to load?", meaning
> we end up calling getenv() for every single use of the commit graph,
> rather than just when we load.
> 
> getenv() is allowed to have unexpected side effects, but that shouldn't
> be a problem here; we're lazy-loading the graph so it's clear that at
> least _one_ invocation of this function is going to call it.
> 
> But it is inefficient. getenv() typically has to do a linear search
> through the environment space.
> 
> We could memoize the call, but it's simpler still to just bump the check
> down to the actual loading step. That's fine for our sole user in t5318,
> and produces this minor real-world speedup:
> 
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      1.460 s ±  0.017 s    [User: 1.174 s, System: 0.285 s]
>     Range (min … max):    1.440 s …  1.491 s    10 runs
> 
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      1.391 s ±  0.005 s    [User: 1.118 s, System: 0.273 s]
>     Range (min … max):    1.385 s …  1.399 s    10 runs

This looks like an important improvement on its own.

> Of course that actual speedup depends on how big your environment is. We
> can game it like this:
> 
>   for i in $(seq 10000); do
>     export dummy$i=$i
>   done
> 
> in which case I get:
> 
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      6.257 s ±  0.061 s    [User: 6.005 s, System: 0.250 s]
>     Range (min … max):    6.174 s …  6.337 s    10 runs
> 
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>   Time (mean ± σ):      1.403 s ±  0.005 s    [User: 1.146 s, System: 0.256 s]
>   Range (min … max):    1.396 s …  1.412 s    10 runs
> 
> So this is really more about avoiding the pathological case than
> providing a big real-world speedup.

This change is stunning. I'm _sure_ someone is hurting with this.
 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 9b02d2c426..baeaf0d1bf 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -468,14 +468,14 @@ static int prepare_commit_graph(struct repository *r)
>  {
>  	struct object_directory *odb;
>  
> -	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
> -		die("dying as requested by the '%s' variable on commit-graph load!",
> -		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
> -
>  	if (r->objects->commit_graph_attempted)
>  		return !!r->objects->commit_graph;
>  	r->objects->commit_graph_attempted = 1;
>  
> +	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
> +		die("dying as requested by the '%s' variable on commit-graph load!",
> +		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
> +
>  	prepare_repo_settings(r);
>  
>  	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&

LGTM, thanks!

-Stolee
