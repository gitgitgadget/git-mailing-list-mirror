Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D80D215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeD3QeM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:34:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32776 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbeD3QeL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:34:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12so12020889wmc.0
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N4GKTdNCawEU0vi8ZyZBl0fOiCHE25ZZWj5rl0tLdhI=;
        b=U1jXHzlD6zsan6SL7WipH1kVg259JuoSrRzk7PFk74yeD6F6+sDlQBKeuqWatg4ohC
         nbWcDEKJvR2Tyzdfr5xICdBPEp2ufm1acEbgDPXZy8L4vJ4mzLMYCp2ElrGlOLQvt3C8
         0ISL2TIdu7quHUxSbTGfvSo33IPwhmJ7kJbENTOndw9acWx/KD9ejI4+/ThKHWH1nAVv
         WklpyTzDDYrXZjyJnygl8dtu/HQYLUZdi2LSciiY6vRJlNo7rlx0oDRPyatNFeTH2xGq
         sJpvFvZoO0K0FVBM/kw3AGEH4SvyTrxvpi7FVrQYm6q3F2ex8rVkoWonVgJ8ywBPdg49
         mJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=N4GKTdNCawEU0vi8ZyZBl0fOiCHE25ZZWj5rl0tLdhI=;
        b=smSru87Hc6pd1dbtzQFHJKupSoiGQQ4BAN9IZqGObotExiZmFiQhPkA6QM50ib2Lyf
         vgA6S647Zk8apf2tMkrEes/WtNgZhCeNClPssX9loMbfmRLSJIDpmyLLZvZX4FYh0l2F
         aH3g9LYJ8IPmPTJW3vDDHw8tzEaCqO3ink8mgacenA+YSZlJiVmayqhqQiXiIuT0ih68
         nzvkjsdOF9q4NGajuVdPfwoO1xj55evOLtl1HxOZtgnY2/gBZYEhDEWv1WIVN5Y5b11w
         GYV4T2CBjCSZVVhq9y1PA99m3+6qmahW9+x68jRnhpPDgbbWWh/aLX2YQkjqyh+Dbm4Q
         PU2w==
X-Gm-Message-State: ALQs6tBd2Y6/KyIGI0AGsj/N1XcbSGjl/DT8Wlp9ZW2ZXhZVRyq5MpeP
        cEP36db8nEpA0vWtHDcVMQA=
X-Google-Smtp-Source: AB8JxZqNOeIUJfSyYrlkCvVUXlrTGo4Qwcs2EWbDTKyX3/hA7E5vAHCnAsrTIJ3f0MV6a3ewUZ/mCw==
X-Received: by 10.28.94.210 with SMTP id s201mr8777094wmb.140.1525106050274;
        Mon, 30 Apr 2018 09:34:10 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abqa10.neoplus.adsl.tpnet.pl. [83.8.68.10])
        by smtp.gmail.com with ESMTPSA id b185sm7593452wmb.25.2018.04.30.09.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 09:34:08 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 06/10] ref-filter: use generation number for --contains
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-7-dstolee@microsoft.com>
Date:   Mon, 30 Apr 2018 18:34:05 +0200
In-Reply-To: <20180425143735.240183-7-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:58 +0000")
Message-ID: <86po2ghcw2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> A commit A can reach a commit B only if the generation number of A
> is strictly larger than the generation number of B. This condition
> allows significantly short-circuiting commit-graph walks.
>
> Use generation number for '--contains' type queries.
>
> On a copy of the Linux repository where HEAD is containd in v4.13

Minor typo: containd -> contained.

> but no earlier tag, the command 'git tag --contains HEAD' had the
> following peformance improvement:
>
> Before: 0.81s
> After:  0.04s
> Rel %:  -95%

Very nice.  I guess that any performance changes for when commit-graph
feature is not available are negligible / not measurable.

Rel % = (before - after)/before * 100%, isn't it?.

Good.

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ref-filter.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index aff24d93be..fb35067fc9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -16,6 +16,7 @@
>  #include "trailer.h"
>  #include "wt-status.h"
>  #include "commit-slab.h"
> +#include "commit-graph.h"
>  
>  static struct ref_msg {
>  	const char *gone;
> @@ -1587,7 +1588,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>   */
>  static enum contains_result contains_test(struct commit *candidate,
>  					  const struct commit_list *want,
> -					  struct contains_cache *cache)
> +					  struct contains_cache *cache,
> +					  uint32_t cutoff)
>  {
>  	enum contains_result *cached = contains_cache_at(cache, candidate);
>  
> @@ -1603,6 +1605,10 @@ static enum contains_result contains_test(struct commit *candidate,
>  
>  	/* Otherwise, we don't know; prepare to recurse */
>  	parse_commit_or_die(candidate);
> +
> +	if (candidate->generation < cutoff)
> +		return CONTAINS_NO;
> +

We use here weaker negative-cut criteria, which has the advantage of
simply automatic handling of special values: _INFINITY, _MAX, _ZERO.

Stronger version:

  if A != B and A ---> B, then gen(A) > gen(B)

  if gen(A) <= gen(B) and A != B, then A -/-> B

Weaker version:

  if gen(A) < gen(B), then A -/-> B

If commit-graph feature is not available, then all generation numbers
would be _INFINITY, and cutoff would also be _INFINITY - which means
this operation is practically no-op.  One memory access (probably from
cache) and one comparison is very cheap.

All right.

>  	return CONTAINS_UNKNOWN;
>  }
>  
> @@ -1618,8 +1624,18 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  					      struct contains_cache *cache)
>  {
>  	struct contains_stack contains_stack = { 0, 0, NULL };
> -	enum contains_result result = contains_test(candidate, want, cache);
> +	enum contains_result result;
> +	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
> +	const struct commit_list *p;
> +
> +	for (p = want; p; p = p->next) {
> +		struct commit *c = p->item;
> +		load_commit_graph_info(c);
> +		if (c->generation < cutoff)
> +			cutoff = c->generation;
> +	}

For each in wants, load generation numbers if needed and find lowest
one.  Anything lower cannot reach any of wants.  All right.

If commit-graph feature is not available, this is practically no-op.  It
is fast, as it only accesses memory - it does not access disk, nor do it
needs to do any decompression, un-deltafication or parsing.

All right.

>  
> +	result = contains_test(candidate, want, cache, cutoff);
>  	if (result != CONTAINS_UNKNOWN)
>  		return result;
>  
> @@ -1637,7 +1653,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  		 * If we just popped the stack, parents->item has been marked,
>  		 * therefore contains_test will return a meaningful yes/no.
>  		 */
> -		else switch (contains_test(parents->item, want, cache)) {
> +		else switch (contains_test(parents->item, want, cache, cutoff)) {
>  		case CONTAINS_YES:
>  			*contains_cache_at(cache, commit) = CONTAINS_YES;
>  			contains_stack.nr--;
> @@ -1651,7 +1667,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  		}
>  	}
>  	free(contains_stack.contains_stack);
> -	return contains_test(candidate, want, cache);
> +	return contains_test(candidate, want, cache, cutoff);

Those two just update callsite to new signatore.  All right.

>  }
>  
>  static int commit_contains(struct ref_filter *filter, struct commit *commit,
