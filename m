Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EFF2215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755073AbeD3RF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 13:05:29 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37539 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755056AbeD3RF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 13:05:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id l1so15423945wmb.2
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zOY4C8pvNlgIoUFBSbLKFnmyfDNzgvi99pXA3Klz2Ig=;
        b=Lk1ZJ4kN9ZaVefzzOBBx2s++YDWja6lrzHDZuXtaz9sRbe6AKH0czat6bYYANiSJyY
         fjkDbcNUHYz27IL21SN1ajV7KjqwkCwyxWribS2kA4oM1pMM3zCqGzw4wVtYTyc3WTVD
         SZ5F8aQ5CZASHehsQMG5Px6mwVbW8ohk2adE0A8kudZ7iQVDhcPd23Hu92PH6d9hPmIX
         Y3fGnTqQuRcchpnODAXeSN6NPMcH6bHNsffaPMPDIP27DXHR3AXFgO0Iqpiw+wIx+jUj
         1p7B2jMOJCuQS37Ao6U4LGhirWZ5MZ6C/WPaFDeTZpHTyVPerEIKW4y+Af7tsV1SxW5+
         xi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=zOY4C8pvNlgIoUFBSbLKFnmyfDNzgvi99pXA3Klz2Ig=;
        b=BEt5IqIDrgZKAueTLDuJocWqLimQRlKISaaLxF5Nl8mLEKyQ8KHCS9ekUSR2UpreAn
         Lwb9SbD/fBLatMII2fFAAGwmkiUxCUYTW8T5poCYIAsLEh/ALITlS7Erv2bCZZB2KXlr
         6cPlnYT0LMoyeKYONZm9tMINoJHv6DT9NTJqqEj5BqrINZsAN8Z7RtrpwMRk7yDxr+f1
         KloVPXOYhlPlT1tzNkMAe7Y0L+iEZoG+O+bgqXvNa/EJHWSrhxictvvcS7yz66IP+Iu0
         GIuZrOgiv10NV+/XP8Nv7o2LzI0v8OFRITYOYSBPEnF8RodVqGqucNxbNPHhBkli+lPQ
         03PQ==
X-Gm-Message-State: ALQs6tBi9wSWlw0uPfU6IVJnMAIbCw9PDx3X0sOpie7dLYw4Vv2oXfhu
        uDL5JYujiNXdwBZXE3dKwLc=
X-Google-Smtp-Source: AB8JxZoM+yFGIeIi3uZS75qKeDEX0HvKdcXKs73zE4iQvCaZx1D8KE7Gx7uYOtsw1Adk60xgOQuVjg==
X-Received: by 10.28.172.194 with SMTP id v185mr7732374wme.67.1525107927002;
        Mon, 30 Apr 2018 10:05:27 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abqa10.neoplus.adsl.tpnet.pl. [83.8.68.10])
        by smtp.gmail.com with ESMTPSA id w31-v6sm13047779wrb.93.2018.04.30.10.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 10:05:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 07/10] commit: use generation numbers for in_merge_bases()
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-8-dstolee@microsoft.com>
Date:   Mon, 30 Apr 2018 19:05:22 +0200
In-Reply-To: <20180425143735.240183-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:59 +0000")
Message-ID: <86in88hbfx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The containment algorithm for 'git branch --contains' is different
> from that for 'git tag --contains' in that it uses is_descendant_of()
> instead of contains_tag_algo(). The expensive portion of the branch
> algorithm is computing merge bases.
>
> When a commit-graph file exists with generation numbers computed,
> we can avoid this merge-base calculation when the target commit has
> a larger generation number than the initial commits.

Right.

>
> Performance tests were run on a copy of the Linux repository where
> HEAD is contained in v4.13 but no earlier tag. Also, all tags were
> copied to branches and 'git branch --contains' was tested:

I guess that it is equivalent of 'git tag --contains' setup from
previous commit, just for 'git branch --contains', isn't it?

>
> Before: 60.0s
> After:   0.4s
> Rel %: -99.3%

Very nice.

Sidenote: an alternative to using "Rel %" of -99.3% (which is calculated
as (before-after)/before) would be to use "Speedup" of 150 x (calculated
as before/after).  One one hand it might be more readable, on the other
hand it might be a bit misleading.

Yet another alternative would be to use a chart like the following:

           time  Before   After
  Before  60.0s      --  -99.3%
  After    0.4s   +149%      --

Anyway, consistency in presentation in patch series is good.  So I am
for keeping your notation thorough the series.

>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 39a3749abd..7bb007f56a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1056,12 +1056,19 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *

Let's give it a bit more context:

   /*
    * Is "commit" an ancestor of one of the "references"?
    */
   int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
>  {
>  	struct commit_list *bases;
>  	int ret = 0, i;
> +	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
>  
>  	if (parse_commit(commit))
>  		return ret;
> -	for (i = 0; i < nr_reference; i++)
> +	for (i = 0; i < nr_reference; i++) {
>  		if (parse_commit(reference[i]))
>  			return ret;

We use parse_commit(), so there is no need for calling
load_commit_graph_info(), like in previous patch.

All right.

> +		if (min_generation > reference[i]->generation)

At first glance, I thought it was wrong; but it is the same as the
following, it is just a matter of taste (which feels more natural):

  +		if (reference[i]->generation < min_generation)

> +			min_generation = reference[i]->generation;
> +	}
> +
> +	if (commit->generation > min_generation)
> +		return ret;

All right, using weak version of generation numbers based negative-cut
nicely handles automatically all corner-cases, including the case where
commit-graaph feature is turned off.

If commit-graph feature is not available, it costs only few memory
access and few comparisons than before, and performance is dominated by
something else anyway.  Negligible and possibly unnoticeable change, I
guess.  Good.

>  
>  	bases = paint_down_to_common(commit, nr_reference, reference);
>  	if (commit->object.flags & PARENT2)
