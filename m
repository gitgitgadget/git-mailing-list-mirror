Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52CC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B322083B
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 12:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t55mrCqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgJHMuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgJHMuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 08:50:25 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBEC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 05:50:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id q21so5333231ota.8
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xaqgiSsyc4EBzacIsowlbX56nWoHGSXxPshNIcV13qg=;
        b=t55mrCqSKf9n0IqlqbjHfp3N/rkopq0Y9AXc65HFcktAXJeThktgJW+jWuz9MzFGQH
         8eBtMOFRVU10b/DHCq1flZEN4j+h88xobi59tajOU6YVCKHZ6zMGHBK3odh23MkN+D0U
         PJkhfFm/OeEsDyxs1QzC9LXevdcoaW3q8NIs7RZnlTRMMSAEPIkNJZkexkG+AQ04tObs
         XubahFvaoa31FEAFPJZlpoRLWfs08Az8BCGsDt9uLQ7OMQQrlMHuR/uDPyyh7W9eBP+Z
         yX8s5BAgqrk7n2sAPrElchGn8DkUl4gwWlmw6hmrDUc6/LGDFz2DKfF3jm2EDUievLui
         JKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xaqgiSsyc4EBzacIsowlbX56nWoHGSXxPshNIcV13qg=;
        b=q+TF1GCCDBz1TGWVOee0gaMzx9+j48hL4B9HxmUMy+ICq9mRre1Lw2o0T5zOb/qXQ0
         6fu89Iwm0aIAi2yNbQQSyq3MvZsxApBItdpVppAWk8zEk7i4fu6W6sCk4mgkHo/IEfvw
         JgzItK2lhac/YMeeJbGbXnSoiQx1Y7MQg5L1Vz4oLp2Fg9WmLcZSMX65aCgh9VUujZtY
         sYiT+wOtlgHEoe8OdxtSdENTyjgKo7k6H54vVLIFHqvNX2DIVptubY4fRxdeK4A+wyjK
         wwQMF1Ev0xGEth2OqKbexfi3OYLsX89izPGliRJNhmUyK5bPTB+C5fn4oxCfsLYCmH0X
         diXg==
X-Gm-Message-State: AOAM5332ClbGizhiNLyuLs0y0nSiA2Y4Fhpc5TjJnmoE41iT5J+Rwn2T
        s8UgiANqBDhkyUUT9/jSTd0=
X-Google-Smtp-Source: ABdhPJxjQ2q/ieG33xFEF3TeAVRnhcu9tl7TaJdJ9u909VCT4df9Bqz6kUEbTnNU/E7hw2NoYXLqDg==
X-Received: by 2002:a05:6830:1df8:: with SMTP id b24mr4832144otj.256.1602161424085;
        Thu, 08 Oct 2020 05:50:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:56e:1bd4:bf96:36ec? ([2600:1700:e72:80a0:56e:1bd4:bf96:36ec])
        by smtp.gmail.com with UTF8SMTPSA id x198sm4511052oix.33.2020.10.08.05.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 05:50:23 -0700 (PDT)
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
To:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
Date:   Thu, 8 Oct 2020 08:50:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201008120658.GA2689590@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2020 8:06 AM, Jeff King wrote:
> On Thu, Oct 08, 2020 at 11:52:03AM +0200, Thomas Braun wrote:
> 
>>> Is it possible to share the contents of your .git directory? If not, can
>>> you look in .git/objects/info/ and see if there are multiple
>>> commit-graph files (and if so, possibly share those; they don't contain
>>> any identifying info).
>>
>> Yes sure, I can share that [1]. Thanks for looking into that.

Thank you for the report! And thanks for sharing your data.

> To solve your immediate problem, you can just remove the whole
> .git/objects/info/commit-graphs directory. It doesn't have any data that
> can't be regenerated from the actual objects.

Yes, this is the best way forward for issues like this. Sorry
for the inconvenience!
 
> The rest of this email is my look at what the actual bug is.
...
> So I _think_ everything being done by that patch is correct, and we
> didn't see the problem before simply because we were erroneously not
> rolling up the graph files. And once we do, we can see that indeed we
> have the same commit in two files.

I think the die() that is reporting this answer is doing so because
this state is one that _shouldn't_ happen. The intention is that
there is always only one "graph position" for a commit object, and
any case where we have multiple is an unknown and unsupported situation.

However, how wrong would that be (as long as the two "rows" have the
same data)? It depends on how we find the commit:

1. If we are trying to look up a commit from a ref, then the binary
   search into the commit-graph(s) will find one of the rows first,
   then set "graph_pos" in the commit_graph_data_slab for that commit.

2. If we are looking up a commit via a graph position from a child
   commit in the commit-graph, then we will immediately navigate to
   that specific row to find the OID. If we previously parsed that
   commit, then we will not try to parse it a second time based on
   the populated "struct commit" we get from lookup_commit().
   Otherwise, we'll read the row to fill the parents and other data
   at that commit.

So, it seems that the existing commit-graph reading strategy can
handle this "duplicate commit" case (at least, across layers).

 If I instrument the commit-graph code
> like this (I couldn't find a command to dump incremental graph file
> data; is there one?):

Not really. Could be useful for cases like this, though.

> I'm not sure how that happened, and whether it's a bug that we got into
> this state at all.

It is likely a bug that we got into this state. We should still be
able to handle it gracefully.

> But regardless, it seems unfriendly that we can't
> get out of it while merging the graphs. Doing this obviously makes the
> problem go away:
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index cb042bdba8..ae1f94ccc4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2023,8 +2023,11 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  
>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>  			  &ctx->commits.list[i]->object.oid)) {
> -			die(_("unexpected duplicate commit id %s"),
> -			    oid_to_hex(&ctx->commits.list[i]->object.oid));
> +			/*
> +			 * quietly ignore duplicates; these could come from
> +			 * incremental graph files mentioning the same commit.
> +			 */
> +			continue;
>  		} else {
>  			unsigned int num_parents;
>  
> 
> but it's not clear to me if that's papering over another bug, or
> gracefully handling a situation that we ought to be.

I think this is a good thing to do, at minimum. As I discussed above,
the "input data" of the incremental commit-graph chain with duplicate
commits across layers isn't actually _invalid_. It's unexpected based
on what Git "should" be doing.

This kind of change is something we could possibly handle within the
RC window, since it only unblocks people who are already in a bad state.

It would also be good to see if we can discover how this happened in
the first place, but that might be a more lengthy investigation and
patch.

Thanks,
-Stolee
