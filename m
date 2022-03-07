Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DACC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiCGUTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiCGUTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:19:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7D237DB
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:18:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m2so9066672pll.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1HovAzom/N3TjiVMl7bRT8Hr481zaCZz+m37Co95BM=;
        b=cEYyv12EpdefGBGU9Ko3V2/3GI4URGDJKbXMi0PGeDTrItY3NvL/o3pXTTXpNXjETD
         BlG8pUYwLE2TmTuPTpq8gZ6SXvrh3IAiSayLoTCxH4TZXW6ShlTIZCKWrNNoYxjv7EXd
         9vbd43leUuUesnGp88vwt2Tz3Diut3n2s7AbwQyaevOYUYfzMhFVYBE0QLN90NMt4bY5
         dKEhDoPEkv2lI/RsxcHYNnx/6fMvC8vaspMQ1mWbqBCyFRkVenZuA6OnHyKTGBJzzL4d
         UuV2CeYSfZFv0mZHcUmydGLIMNTJ6XD5wc74C7vB168OVI49awtN9qOsCPARMoJwWoIX
         HGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1HovAzom/N3TjiVMl7bRT8Hr481zaCZz+m37Co95BM=;
        b=Jgh+Jr6R7UGCwPDM5IvoMIZjjS6M1BaB0TD6N3JeNU13Ci6TeAk4mb5ao4oVgZkCLn
         WmuW16cOR7/jYljazLARN4IeARctyM6kDlejK4bQqGUJ/lpXss/aeF55tIz6CfNnG9q4
         IN0E5qOQlzMJpETSv1gT0Cj9yyRe0I3sWtECjZa2pyWrhoGKS6fEMcWOp4UskzFzvCJF
         h+gbw8xgLWfTa0mRPTG6ve7TE2U6nWWCbiXg3GYJm8bSeQ+2hCTsDg2SSNxIaQVGD3Pw
         NL5rlZQn6RUsuz2pzSrcnRhwozcoedSnbKFYe/DaF6VND6Oa67Hy3jP9999JkmJxuTZu
         dTHw==
X-Gm-Message-State: AOAM530VlCHymauBO1JldX9lgm7epBhz8aHSPN9h49OX8OgDu3xXZuWB
        PXMRK5Q19u6PObrrEow92l0=
X-Google-Smtp-Source: ABdhPJyfLRxpVYkrPcstBkEFi3M46q1m9hbR9edBrv7HA+kDlLdDi9YS8P+dBaRiMgB//LR4gToB2A==
X-Received: by 2002:a17:903:292:b0:149:460a:9901 with SMTP id j18-20020a170903029200b00149460a9901mr13753163plr.44.1646684324787;
        Mon, 07 Mar 2022 12:18:44 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:7d6c:e74e:dfc4:f2bb])
        by smtp.gmail.com with ESMTPSA id hg1-20020a17090b300100b001bf70e72794sm186318pjb.40.2022.03.07.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:18:44 -0800 (PST)
Date:   Mon, 7 Mar 2022 12:18:42 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
Message-ID: <YiZoojeTodMr+Ypw@google.com>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
 <YiZJiPVMZwPXbfrK@google.com>
 <YiZMhuI/DdpvQ/ED@nand.local>
 <ebfac323-7567-6327-f5e6-0fd9e0356550@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfac323-7567-6327-f5e6-0fd9e0356550@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 3/7/2022 1:18 PM, Taylor Blau wrote:
>> On Mon, Mar 07, 2022 at 10:06:00AM -0800, Jonathan Nieder wrote:

>>>  2. Marking this as a repository format extension so it doesn't interact
>>>     poorly with Git implementations (including older versions of Git
>>>     itself) that are not aware of the new feature
>>
>> The design of cruft packs was done intentionally to avoid needing a
>> format extension. The cruft pack is "just a pack" to any older version
>> of Git. The only thing an older version of Git wouldn't understand is
>> how to interpret the .mtimes file. But that's no different than the
>> current behavior without cruft packs, where any unreachable object
>> inherits the mtime of its containing pack.
>>
>> So an older version of Git might prune a different set of objects than a
>> version that understands cruft packs depending on the contents of the
>> .mtimes file, the mtime of the cruft pack, and the width of the grace
>> period. But I think by downgrading you are more or less buying into the
>> existing behavior. So I don't think there is a compelling reason to
>> introduce a format extension here.
>
> In particular, older versions would first explode unreachable objects
> out of the cruft pack and into loose objects before expiring any of
> them based on the loose object mtime. There is no risk here of causing
> problems with older versions of Git and does not need an extension.

Surely when older and versions are acting on the same repository, they
would fight by exploding out unreachable objects, packing them back
into a cruft pack, etc, no?

Thanks,
Jonathan
