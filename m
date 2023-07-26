Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD2C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGZRst (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGZRsq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 13:48:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C365E77
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:48:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d13e11bb9ecso33981276.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690393724; x=1690998524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmf9auoBB3wVK6OL7dIfR6Y3b/1hoV29Iny6R8rJ28s=;
        b=Zin0024NW5+4uzEnGzqXiW8ss2EvUy4v6oqRRv9U4XI1BAeRUYv81G5xybijUvQTca
         32gXF+M6rTlFjLpKBGDDRf4GAk3au1wgHDqx0vpmtyg92ENLTy1ebrZaM11CzVk2VCI7
         tGxePkSQhqyVzKbAE5LsDE6RKR3okRjWwMoQVlyODK6CiOr9GsAtPp5RYAwBR30Wi4KJ
         zWs8+GoyK0R6mRQLHzRlwfC2RwKPCD5ylKBn2yBdge6r95/PEAnhXwCEIM0Xw+dczbgw
         i5N5RumUz5ZoqqmOVJM873f+KE5NzJdUB/FAQT1paOw8RQ3JSo2z1zXX+b4gzmNQQGfQ
         dYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690393724; x=1690998524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmf9auoBB3wVK6OL7dIfR6Y3b/1hoV29Iny6R8rJ28s=;
        b=U+uBgIeTMS7aBgz6r6X85Wmx45e1wpkEXmt50Sohd5r7fre3HMWJU+sXfwv9dLzoa0
         f7UHbSTA+ZW8M8Y3gUzmyWLjeSBANDGmBj8pmSYfStyBNbyDPIG3qYBIDOI13QvtjXUy
         l/6E1sHbxyCeeNVkKciwCgM06ZGVA5/EQGtTnyw5Cvoa55JV/gWI0e6lxgUMZfrFlAV/
         gZS6I97YNSmBiv67B07DCtXQjpRozMj5qLoUHPUAeoifvG9zt5d3o1pzJc0leCTXb0z9
         ZukXYLVS+B+ksr5LIg4Z3d+hHnsTnk67mFG8DMSPn08HnrXG/u5YQyGcXnRADNUrlTel
         WfZQ==
X-Gm-Message-State: ABy/qLa9isd774V4VPZYLaTHSOXI/Q09NCaez/vUIt6aJXxT818xYkWN
        2BbMHSLb5uKeFNMejjNvjig8GKH5IhO+3Q==
X-Google-Smtp-Source: APBJJlF0o6yQx3VfJzcHmutDozbgFKp6PZyfXwg14Sb8mwC+Apqya4Aii0iSBWOCfzN0wwZdBzGGnm/k3xrxBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1803:b0:d0b:c67:de3b with SMTP
 id cf3-20020a056902180300b00d0b0c67de3bmr16416ybb.13.1690393724450; Wed, 26
 Jul 2023 10:48:44 -0700 (PDT)
Date:   Wed, 26 Jul 2023 10:48:42 -0700
In-Reply-To: <a3526864-dd3a-f95c-72e6-44995a9a460f@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
 <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com>
 <fdb605bf-938d-6135-b341-6cf20600abaf@gmail.com> <kl6lo7k0ym57.fsf@chooglen-macbookpro.roam.corp.google.com>
 <a3526864-dd3a-f95c-72e6-44995a9a460f@gmail.com>
Message-ID: <kl6lfs5azhqd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Unfortunately, it's been a while since I reviewed this patch, so forgive
>> me if I'm rusty. So you're saying that this test is about checking
>> invariants that we want to preserve between Git versions.
>
> Not really. One of the reasons why testing the implementation rather 
> than the user observable behavior is a bad idea is that when the 
> implementation is changed the test is likely to start failing or keep 
> passing without checking anything useful. I was trying to say that in 
> this case we're unlikely to change this aspect of the implementation 
> because it would be tricky to do so without inconveniencing users who 
> upgrade git while rebase is stopped for a conflict resolution and so it 
> is unlikely that this test will be affected by future changes to the 
> implementation.

Ah, I see the difference. I think that's it's fair to assume that the
names of the files will be fairly stable, though this series has made it
clear to me that what each file does and when it is written is quite
under-documented, and I wouldn't be surprised to see some of that change
if we start to try to explain the inner workings to ourselves.

> Yes this patch adds a test to t5407-post-rewrite-hook.sh to do that but 
> it only checks a failing "pick" command. The reason I think it is useful 
> to add these test_path_is_missing checks is that they are checking 
> failing "squash" and "merge" commands as well. Maybe I should just bite 
> the bullet see how tricky it is to extend the post-rewrite-hook test to 
> cover those cases as well.

Yes, that would probably be a good idea. Maybe if we combined them into
a test helper that checks all of "pick", "squash" and "merge", which
also has the added benefit of being able to hide implementation details
in case we decide to change them.
