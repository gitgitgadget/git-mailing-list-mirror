Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821501F609
	for <e@80x24.org>; Fri, 24 May 2019 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfEXKdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 06:33:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42584 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 06:33:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so729810qkc.9
        for <git@vger.kernel.org>; Fri, 24 May 2019 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jCZMGaRAnhm3gcTqMuVDClZDspwRQLllplNktLZeIXI=;
        b=nXprpBZX/9yEkAurI5aoYTARwhLD2C+yvFIgVaZ7rQ19OKQ12ji6/2GNklRzKg2hlO
         n+bok45B5zH/6iv1B8jZEfsgoAwUEzYtAwq6eoXZkvSPv2e6WMVB86QXoKSZpCI3HebY
         Y0fZwyIEUxEOFXcPzsiooHRbaMjRE5wTNRi89/n55Ta0OXhuaNY+AKrUkF1ssFnKq/uJ
         juFIVFXdVB8rQoq/HWOtaXwahLdaEK+wR6CLNvOi/Ue15SO4vYN3KYsyamqtgDGCsNbN
         96J3c0EWdthApZHwcY/uRMCmhVBhrqM014rbxGkf8dH5NkXdvrx2zColn08hbU7HHj51
         fM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCZMGaRAnhm3gcTqMuVDClZDspwRQLllplNktLZeIXI=;
        b=W5/4C66JuLqBMDimwxKPoMmLpKO5t4zNk/nvbRHe2jlWCraUUjshK+KHFprUPTgUtZ
         FwC2jt6/Rtz4X+sMqh13qj/AgS5BvarH4AXX+z+64gAFl3MyIXyNQOljflcAHmNcooBn
         IoVEGf7TP13lCzp/cB9pVhd5kge4OhilCFJW0k1NikCmRAHnZa7Ir2oWuo+QBSa23Fv3
         eakLY78hZ7HV/fSdfuPkZQsI1bpLeKZRFViXcwshdzX4Y0j89wP0QXyp+/ABqWBNsMn3
         jArsNPApQyWRMab1TTQVoUsoizxsKd16BYnxfw+K3dayrWz4Mkp3N+1UCp98dUgoVR0f
         6wiQ==
X-Gm-Message-State: APjAAAVuxIh84s+B/96Nntxma5Vx5hN+oPEaiafO60Zdz06iHHKzoQVG
        1WeR01eGk+gD0nMFdg6biAh7BCaZRoo=
X-Google-Smtp-Source: APXvYqyTc0uZ0VOPZb/aFUsa/FZMxyt/FypTJ2JEirZpuYn6Yz1WunQVGKebVZqsajVcPTgfzWPs6Q==
X-Received: by 2002:a0c:93dd:: with SMTP id g29mr29856369qvg.169.1558693981937;
        Fri, 24 May 2019 03:33:01 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u125sm1011073qkd.5.2019.05.24.03.33.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:33:01 -0700 (PDT)
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
References: <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <20190523113031.GA17448@sigill.intra.peff.net>
 <1e0d216b-5e68-faff-883c-778a04f55bde@gmail.com>
 <20190524072426.GG25694@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cbd7540b-0d36-e378-c5e7-871a70e47e18@gmail.com>
Date:   Fri, 24 May 2019 06:33:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190524072426.GG25694@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2019 3:24 AM, Jeff King wrote:
> On Thu, May 23, 2019 at 08:53:56AM -0400, Derrick Stolee wrote:
> 
>>> I spent a while thinking and experimenting with this tonight. The result
>>> is the patch below. Ævar, do you still have a copy of the repo that
>>> misbehaved? I'd be curious to see how it fares.
>>
>> This patch caught my attention, and I think I understand some of the issues
>> at hand. I'm not well-versed specifically in Git's bitmap implementation.
>> The fundamental ideas are there, but my perspective is biased by my own
>> independent bitmap implementation for Azure Repos. What worked there may not
>> work at all here.
> 
> Thanks for looking at this. There are a lot of short-comings in the
> current bitmap implementation, so if there's a better way to do things,
> I'm not opposed to moving to a new format. :)
> 
>>> Finding the right trees to explore is a little tricky with bitmaps.  In
>>> a normal traversal, we consider the "edges" to be worth exploring.
>>> I.e., the places where an UNINTERESTING commit is the parent of an
>>> interesting one.
>>
>> This is the "commit frontier" which I bring up again below.
> 
> Right. I actually had trouble coming up with a succinct way of
> describing this, and stole the definition from your recent blog post. ;)
> 
>>> But with bitmaps, we don't have that information in the same way,
>>> because we're trying to avoid walking the commits in the first place. So
>>> e.g., in a history like this:
>>>
>>>   A--B--C
>>>       \
>>>        D
>>>
>>> Let's imagine we're computing "C..D", and that D has a bitmap on disk
>>> but C does not.
>>
>> (As I read your discussion below, I'm confused. For "C..D", C is a have
>> and D is a want. We should explore all the haves _first_, then walk the
>> wants, right?)
> 
> I think I may have confused things by starting my description with a
> hypothetical combined want/have walk. To take a step back: the problem
> we were discussing is that we spend a lot of time reading trees to fill
> in the "have" bitmap, even though most of those objects are unlikely to
> be in the "want" in the first place (only the frontier trees are really
> useful).

Thank you for resolving my confusion.

[snip]

> As I said earlier in the thread, I suspect our commit selection is not
> great. It's mostly some heuristics we threw together in 2013, and I
> don't think it was tested very thoroughly. So fixing that may be a
> simpler approach.

It's a hard problem! There are no _sure_ answers here, and what works in
some cases will probably not work in other cases.
 
> What I was wondering here was whether we could get an easy fix based on
> the same frontier ideas that the non-bitmap walk uses.

[snip]
 
> But doing that commit walk to find the frontier negates part of the
> purpose of using the bitmaps, which is avoiding even walking commits.
> Going back to a variant of our example:
> 
>   A -- B -- C_1 -- .. -- C_1000
>         \
> 	 D_1 -- .. -- D_1000
> 
> If we have a bitmap at C_1000 and D_1000, we don't have to walk any
> commits at all. But finding the frontier requires walking 2000 commits.

In my opinion, walking commits is easy (easier with the commit-graph)
and walking trees is hard. We probably _should_ do more commit walking if
it helps avoid walking some trees.
 
> Is there a way to find it with just bitmaps? You can certainly find the
> intersection, but you don't have any idea which of the many shared
> commits is the merge base. Of course in this example you don't actually
> care about the frontier (you have the full answer immediately). But how
> do you decide which way to optimize: try to avoid walking commits to
> get a quick answer from bitmaps, or prefer to walk some commits to find
> the frontier and avoid opening too many trees?

With a new perspective on the problem, I think perhaps trying to solve this
problem with bitmaps is incorrect. If you want to use bitmaps for C..D and
you don't have any bitmaps in the range D..C, then maybe we should just use
the old-fashioned method of walking trees? In your examples above, the
new method would walk trees for the commits in {B, C_i, D_j} while the
bitmap method would walk trees for the commits in {B, C_i, A_k}. I would
expect the list of {A_k} commits to be the largest in most cases.

The approach here would be to do the commit frontier walk, and check for
commits with bitmaps along the way. If we don't find an UNINTERESTING
bitmap, then use the non-bitmap way instead. Perhaps worth a shot.

I'll bring up this code snippet again:

        /*
         * if we have a HAVES list, but none of those haves is contained
         * in the packfile that has a bitmap, we don't have anything to
         * optimize here
         */
        if (haves && !in_bitmapped_pack(bitmap_git, haves))
                goto cleanup;

In addition to this, we can fill the "haves" set with the commits
in D..C (with boundary) and then check if any of those commits have a
precomputed bitmap. If not, goto cleanup.

Thanks,
-Stolee
