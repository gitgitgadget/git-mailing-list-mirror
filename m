Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C0C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 03:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbhLaDHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 22:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbhLaDHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 22:07:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC25C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:07:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r17so53774374wrc.3
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UssaDv2htdFwr6yTW9LV2D6RC9Rjezo32v0H7K6NP+M=;
        b=JGGY7CiCBOF5ON0Z1z0FnNHHCu9Ud3mBwHvPVX6JaPrvhPe98w1NOoWaqyXHvjLPEh
         /OFTa1JWmtmA6auaahLqx+QMDef607jLhYmlG83RQWeaBR8yD6jq4AmEjsxNkeLVHyQW
         bmCpPe1TK2r2eXQ0rFfWVpxd3l4JCLm9WE4g2t7y5ZXwpYzWmzUTQ8S8WTB1E87fSMgg
         0Af3M8neFVtXpV+13R5uoP6efiNDIOLDEneYENvsLlk5cGD60O1nH13dHpCz6VMZWNrw
         gstU5uvYbyHQwi/GjAeH9fJyBCPOxDgP+BbLIYqG5KsyJvVFveBfoc2+jgFkEg6MouK3
         s2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UssaDv2htdFwr6yTW9LV2D6RC9Rjezo32v0H7K6NP+M=;
        b=6FDAPPYGX63/mH/fiOzQPQ+CNxTIoEglCr0E6L/rpN2mYt94rrrowF3M9SvsHZkad5
         B/eaDaEaEoYFORwFETsGmeEYchv/bzUQiENmTrCrs6T7unV/1YZlndQE7LIaDxuk7hvY
         oxb6w99SxOc9SC3tkKnmvyFPv7oTjJuXnRawhYX89yrYLqf0lRQ3KCGv8y60+REKooiX
         qxva34IfBGTwXhp+R57b3i3bqfMbZwNYmAr7jG/N6E1Kc++obH2PQvE4BSLYkIFDuaIQ
         vD494EzLquEOMcJQxOT6gDnkwzH76bsXjutPrPlCew4wKyQ0XenDH1atQKTqhlAKeEA3
         wz7Q==
X-Gm-Message-State: AOAM532dNwzVDxofga8VQu/Dy3z77ojV+E2i098bFPGKU195bvTsF1i4
        8USB72VW748qpAOV29+aLkU=
X-Google-Smtp-Source: ABdhPJz4yM/GFhshb0iIyuqXK2dRGpX8c3jUtSffzVCwf5kSFaG5djmtu9Iu1FnH1VNt+tTocmuwCg==
X-Received: by 2002:adf:facb:: with SMTP id a11mr26693835wrs.18.1640920069095;
        Thu, 30 Dec 2021 19:07:49 -0800 (PST)
Received: from gmail.com (62-47-8-46.adsl.highway.telekom.at. [62.47.8.46])
        by smtp.gmail.com with ESMTPSA id o10sm29270998wrc.55.2021.12.30.19.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 19:07:48 -0800 (PST)
Date:   Fri, 31 Dec 2021 04:07:46 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 7/8] diff: add ability to insert additional headers
 for paths
Message-ID: <20211231030746.t42ehzftcdlu3pif@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <e94706513038adc85e818e8736ad713b2e6b6be4.1640419160.git.gitgitgadget@gmail.com>
 <20211228105733.lomkg23htd2kjtii@gmail.com>
 <CABPp-BH5XUsmTo=BD7osUgi4o=eFWgaQkN1qYDky6uqb9SykHA@mail.gmail.com>
 <20211229001647.6pv5damtyt3dsiyr@gmail.com>
 <CABPp-BHoiNiYoVzknJEGQpe5a6nnQXj_bwwrtWbmKLBiUCOj_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHoiNiYoVzknJEGQpe5a6nnQXj_bwwrtWbmKLBiUCOj_Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 30, 2021 at 02:04:30PM -0800, Elijah Newren wrote:
> >                                 enqueue(file_pair_for(extra_headers[j]))
> 
> The queue is an array of sorted items, so enqueue here would be
> insertion into an already sorted list.  Inserting N items into a list
> of M items is quadratic (O(N*M)) -- unless you meant to just append to
> the end and add a third sort at the end?

yeah I would have probably used a third sort

> 
> >                         j++
> 
> At the end of the for loop, there may be remaining additional headers
> that sort after all those found in the queue, so you'll need an
> additional loop to handle those.

my bad, I should have tried it

> It's actually considerably more code as you can see from the diffstat,
> and feels like we're reaching into some ugly internals with tmp_queue
> (the SWAP and the special-case freeing) in order to get the desired
> performance improvements.  And it was already O(NlogN) overall (due to
> the sort), which doesn't change with this new algorithm.  It's really,
> really hard for me to imagine a case where we have large numbers of
> additional headers.  Even if someone else can imagine that we for some
> reason have a huge number of conflicts in order to generate a huge
> number of additional headers...how could the performance of sorting
> O(N) filenames and merging these lists possibly matter in comparison
> to the O(N) three-way file merges that would likely have been
> performed from those conflicts?

Yeah, I agree with that conclusion, it's surely not worth the added complexity.
Seeing the code definitely helps, thanks.

> 
> So, I'm going to throw this code away and keep the original.
> 
> It was an interesting idea and exercise; thanks for keeping me on my toes.
