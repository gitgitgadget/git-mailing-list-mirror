Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC10C3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 16:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLHQjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLHQiu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 11:38:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D211CAFCFB
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 08:38:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id k189so1922259oif.7
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/05QyAuX71pRVen3zqBcAhuut5Czcf11CZs4nrHelo=;
        b=Ae2vSjdDZfcEl0maNFxVK3xtK0zA1Ti/gc9+PvTtKXqZocJ68TGWDSXeCOBiwQWB5x
         dRil1Beh9pLkTEGoMroS5GN7sLw5+W+sy3cpEhA9T4jJwFNcKsyn92frNwIEh/fQXVMx
         s/65R6q3LEfk3hRKvA0hRNVgi9pkMQXNaYD/PccHIgzQZFvG3lfOIbSt8G1qGqUzdrmu
         yphSBtmEnm+0/Pi4AvHep2YTvvllBxAFkhElQTWWjgN5uzpbvm9hfbN/Z/vwil81lQsA
         uoRZhTYMepif+ip89wvm+r1VAUhRuEMoxEDv8oND3wzOP+7788hlopmSJ8YgxZLihXFL
         KM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/05QyAuX71pRVen3zqBcAhuut5Czcf11CZs4nrHelo=;
        b=rnzwkJ8Xy/SimCZnJSX+LXC04IgDPv9x/r/c+z3elA5iYWQpzoFFFjR3R9bN+otiAJ
         RqiulxApx7j83m51NnGEc0CCLNV+Zdisoi8PkaoQCO+Oq6SJw40lCseYSwpse4V3tb/n
         aCqpqh5BJDuG/FH6mZ78oCpJhV6Z+XP8v2348Avk7Rx0KtIwVYkILie9ax1+bpdhd40x
         I4sSNOqnpI9mZCWTbqRC7LQpG84DAbCO6ILYFPp84ZKYlK/WEYUAuhxSBjfgDmW+PHxf
         iC4B5qB4287xKJfbdRYrtKseVRsw8FRQskufIYm7U0LnvEGPehCpmAflaiLJW0fCr9CY
         fU1A==
X-Gm-Message-State: ANoB5pnt/DSLWu7o/GnqOylKgJt8ZSGWtiPu275WI8tn2Lt81r022Msw
        kPQKjxJLAv0cACpFRHxz8Udh
X-Google-Smtp-Source: AA0mqf5XGLpgsn9HzwPX7JLy1TSqyag42XFazx3BMDDi2r6C4HHnX4dtmFMPjIlPX3taZIS/VjXjnQ==
X-Received: by 2002:aca:5905:0:b0:355:1de8:de62 with SMTP id n5-20020aca5905000000b003551de8de62mr1107478oib.59.1670517521096;
        Thu, 08 Dec 2022 08:38:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c5e5:e5dd:715:ac2e? ([2600:1700:e72:80a0:c5e5:e5dd:715:ac2e])
        by smtp.gmail.com with ESMTPSA id g15-20020a544f8f000000b003458d346a60sm10952332oiy.25.2022.12.08.08.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:38:40 -0800 (PST)
Message-ID: <3a47b7ac-25dc-5f70-9ab4-08c781df4cda@github.com>
Date:   Thu, 8 Dec 2022 11:38:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] Optionally skip hashing index on write
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <xmqqilim6bhh.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilim6bhh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 6:27 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Writing the index is a critical action that takes place in multiple Git
>> commands. The recent performance improvements available with the sparse
>> index show how often the I/O costs around the index can affect different Git
>> commands, although reading the index takes place more often than a write.
> 
> The sparse-index work is great in that it offers correctness while
> taking advantage of the knowledge of which part of the tree is
> quiescent and unused to boost performance.  I am not sure a change
> to reduce file safety can be compared with it, in that one is pure
> improvement, while the other is trade-off.

I agree that this is a trade-off, and we should both be careful about
whether or not we even make this a possibility for certain file
formats. The index is an interesting case for a couple reasons:

1. Writes block users. Writing the index takes place in many user-
   blocking foreground operations. The speed improvement directly
   impacts their use. Other file formats are typically written in
   the background (commit-graph, multi-pack-index) or are super-
   critical to correctness (pack-files).

2. Index files are short lived. It is rare that a user leaves an
   index for a long time with many staged changes. That's the condition
   that's required for losing an index file to cause a loss of work
   (or maybe I'm missing something). Outside of staged changes, the
   index can be completely destroyed and rewritten with minimal impact
   to the user.

> As long as we will keep the "create into a new file, write it fully
> and fsync + rename to the final" pattern, we do not need the trailing
> checksum to protect us from a truncated output due to index-writing
> process dying in the middle, so I do not mind that trade-off, though.
> 
> Protecting files from bit flipping filesystem corruption is a
> different matter.  Folks at hosting sites like GitHub would know how
> often they detect object corruption (I presume they do not have to
> deal with the index file on the server end that often, but loose and
> pack object files have the trailing checksums the same way) thanks
> to the trailing checksum, and what the consequences are if we lost
> that safety (I am guessing it would be minimum, though).

I agree that we need to be careful about which files get this
treatement.

But I also want to point out that I'm not using hosting servers as
evidence that this has worked in practice, but instead many developer
machines in large monorepos who have had this enabled (via the
microsoft/git fork) for years. We've not come across an instance where
this loss of a trailing hash has been an issue.

Thanks,
-Stolee
