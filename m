Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A7C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E691E2087D
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt2jLGLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393652AbgJPCSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 22:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393649AbgJPCSu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 22:18:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5633C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 19:18:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 32so1118906otm.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lFbni1+GIzneh0idT/dO0dGnKib8Wkddb6GdTsi4drI=;
        b=nt2jLGLgLcuPBuOonCcqV0MZNBEzw/Dj75Sj1fz4PZHlZUKdIcaYLZ8RpM9rnMDGi4
         URuHuuAcCvw+wVCFo2f5EStqRgO8VSo58YtxTdqFDj8wPi4fdqYAPch3BeUKsIerDiHc
         FNlxSNpbLunCmUneh4Ck3rjdjhr4IGLhWs1Q+oWlsOSHgpg3t0JtmoaHAQBtIM4wsG67
         pBaVTdHKey+6s2IX9W8EjeBgGLODeE//B0ei0gfLUhUvCljPSg1HFJtndfZ3o6/ZJfx3
         ePtedZdJ2HN8u9HHMtBdwqNrVcue3jMFpK6qYLJTfyPTTWVDxK4IvmT1yF1GLAUVTpx2
         lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lFbni1+GIzneh0idT/dO0dGnKib8Wkddb6GdTsi4drI=;
        b=Zde174MbQBgfrv2XaIuQhmec9enHyErt4/cjOrW2Zny7LtG5H0GFrHQFoqInK1Wz6r
         hnLc7xKvKI6KFTboD6bptVoyA6gBftdcw96nDc8mhMbeOA6RD3ER+f3NGEFMYFlAm3SX
         hzsZk7Z69IaPXpd77YBAHZ+oTRNgSPRLL2HSNoRsbFvYRGZN+Elfb8rPU8Ah2FTpJ1pq
         Bk7XMbUslXdYOjFQVbK7xtuq64XFRcyag6UJJv0YhwM9to6ngGHLlO958YPigX7uPRCR
         fC85ihn6In97rqxjtcnoRMZ1xGwBOCT4Rp/P3U4RX6tbjbYmP2/VpFMC7iWpt4bNScSX
         E0mg==
X-Gm-Message-State: AOAM531TcTej71UuHrKT8PGBwQu+7NxrlD/LkgB2inhEnFQheJrJtf8m
        3v7G1A7qlDXOKuJjiKLh84Q=
X-Google-Smtp-Source: ABdhPJxAN+AcTSIol6M5vQtzuRIBDZIk8BEvmA9LIsWXQTzCI5GCq4uu6yOhOT9hLtUebrAKmFUnYA==
X-Received: by 2002:a9d:6f96:: with SMTP id h22mr952865otq.344.1602814729900;
        Thu, 15 Oct 2020 19:18:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5421:4c38:9a16:23a4? ([2600:1700:e72:80a0:5421:4c38:9a16:23a4])
        by smtp.gmail.com with UTF8SMTPSA id d11sm464265otf.44.2020.10.15.19.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 19:18:49 -0700 (PDT)
Subject: Re: [PATCH v4 04/10] commit-graph: persist existence of changed-paths
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
 <f1e3a8516ebd58b283166a5374843f5cb3332d08.1593610050.git.gitgitgadget@gmail.com>
 <20201015132147.GB24954@szeder.dev> <20201015214111.GA2176154@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <103404f0-a164-2550-4730-6b8773d3ca1f@gmail.com>
Date:   Thu, 15 Oct 2020 22:18:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201015214111.GA2176154@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2020 5:41 PM, Taylor Blau wrote:
> So, we need to be more aggressively checking the Bloom filter settings
> in any layer we want to reuse a Bloom filter out of before reusing it
> verbatim in the current layer. The patch below the scissors line is
> sufficient to do that, and it causes the third test to start passing.

I think there are three things we should keep in mind:

1. Incompatible Bloom filter settings between layers should be seen
   as _inconsistent data_ as Git should not be writing incremental
   commit-graph files with inconsistent Bloom filter settings. Thus,
   when reading the commit-graph chain we should prevent incompatible
   filters from being used. One way to do this is to notice different
   settings and completely disable Bloom filters. The other way would
   be to take the settings from the first layer with filters and then
   clear the chunk_bloom_indexes and chunk_bloom_data fields for the
   layers that don't agree. This fits with an expectation that lower
   layers are larger, so more filters can be used in that situation.

2. We should be sure that Git will not agree to write incompatible
   settings between layers of a commit-graph chain. Even more, it
   should definitely not re-use filters when merging layers with
   incompatible filter values. The strategy above to ignore Bloom
   filters in incompatible upper layers is enough of a guard against
   the "merge layers" situation.

3. Allowing users (or future Git developers) to adjust the default
   Bloom filter settings is one that is good to do for future-proofing,
   but not one that I expect to be widely used (any gains here are
   minuscule compared to the results already achieved with the defaults).
   On top of that, including incompatible settings across layers is even
   less likely to be a real use case. We should not be straining to make
   the code even worse for this imaginary scenario.

With that said...
 
> ...But, teaching the revision machinery how to handle a walk through
> commits in multiple commit-graph layers with incompatible Bloom filter
> settings is trickier. Right now we compute all of the Bloom keys up
> front using the Bloom filter settings in the top layer. I think we'd
> probably want to change this to lazily compute those keys by:
It would probably be easiest to compute an array of bloom_key structs
(per path) where the index corresponds to the depth of the commit-graph
layer. You can then access the correct key after you have identified
which layer the commit is from.

> At least, that's the best way that I can think to do it. It does get
> kind of slow, though; we'd have to scan every commit graph layer at each
> commit in the worst case to find the actual 'struct commit_graph *' in
> order to get its Bloom filter settings. So, I think that's sort of
> show-stoppingly slow, and that we should probably think more deeply
> about it before taking up that direction.
> 
> Maybe Stolee has some better thoughts about how we can quickly go from a
> commit to either (a) the commit-graph struct that that commit is stored
> in, or (b) the Bloom filter settings belonging to that struct.

We already have code that finds a commit in a commit-graph layer
based on its integer position by iterating until num_commits_in_base
is below our position. The lexicographic position within that layer
is found by subtracting num_commits_in_base.

For us, we would simply need:

int get_commit_graph_layer(struct commit_graph *g, uint32_t pos)
{
	uint32_t layer_index = 0;

	while (g && pos < g->num_commits_in_base) {
		g = g->base_graph;
		layer_index++;
	}

	return layer_index;
}

You could then use the response from get_commit_graph_layer()
to load the correct Bloom key.

Again, I strongly suggest _not_ working hard to support this
case. We should only put in proper safeguards to prevent data
like this being written and protect a Git process that might
stumble across data in this shape.

Thanks,
-Stolee
