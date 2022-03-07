Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2EC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 18:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiCGSG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbiCGSG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 13:06:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E17DE30
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 10:06:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s18so1360446plp.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oJmGsDDyvuyZQlNxYIlA2D5Rps//8+envhti7ONAVA0=;
        b=d+aWXTwQbm8oQq+p9ZYnIXkvpyvn2uKJz+RD9jyr0uX22HkUNEQaooUtxsarVhr+9x
         d+E3LxmWeveQFnW2j3E1zCjqW2EVRFSXUh7fF0lOVrKvEtY4KDbX63oLA3YtEQYo5EFW
         50e+n3tTBItlSBzhr71ZzmuPlxDoAbMhHbvPM0jE11fVFcvAUxw7pPDOe6aAohzBZp01
         FqJzITixvqm39gET8jIn2rKOYgf6/Ls4toOoinqC0zCXMrk9AfJsFv2PqisEj40O/cmQ
         HA15FWaVffyq6hS5iSOJSq3SxHQWZjvGMEJJLRSKV9Bax5DMRYseUoMNXEZaNb6kZWZB
         xZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJmGsDDyvuyZQlNxYIlA2D5Rps//8+envhti7ONAVA0=;
        b=GqAoN2QW8L1O4WdxlIlWP6etZTDxUnsek4MFTPRRoyryUVp8u/ae80JzJvgk7kdoOV
         DtptD7m5H3EzRug1hOv36DG7SqCo6PrhEONcjrj91TAJ7u629JhXv1k/A0l2lcJceSdm
         fXeKz6dMSwJKJmOA1gDGSCKf1zDsiH+C3QX+6K7JnNVQLbSfoiHcOdhqxd1tE6jZhdJl
         CeAsciy9Z8Psfqw+076w8bcOT/Pm03WE2ua0NN+o7N1hOTrHUinA0suKlipH3FdgK1Mn
         JPHMd3+4gt5WlI1a6gflY7sBb0sbfNRe1s4xPTcHi/T52+MtHbA+t01VeHAWcMBLbT3n
         Q6ZA==
X-Gm-Message-State: AOAM530V6rYVvPmcTxpVxmDmxSFYnJVVt0nMWjnZhF8sfhdEpBeFTl7+
        JSD/Xv5UjWnPnYpVnx04m6k=
X-Google-Smtp-Source: ABdhPJyxOGIVgcI3z+w1imxqjzz9UDLPFn7bPg58lFRRr7aFXrnQ96luqBPuzp/i+uU6fnHDmBz3hg==
X-Received: by 2002:a17:90b:4b4b:b0:1be:fd9a:c279 with SMTP id mi11-20020a17090b4b4b00b001befd9ac279mr145738pjb.83.1646676363084;
        Mon, 07 Mar 2022 10:06:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:7d6c:e74e:dfc4:f2bb])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm17280763pfi.13.2022.03.07.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:06:02 -0800 (PST)
Date:   Mon, 7 Mar 2022 10:06:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
Message-ID: <YiZJiPVMZwPXbfrK@google.com>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:
> On 3/3/2022 11:31 PM, Junio C Hamano wrote:

>> * tb/cruft-packs (2022-03-02) 17 commits
>>  - sha1-file.c: don't freshen cruft packs
>>  - builtin/gc.c: conditionally avoid pruning objects via loose
>>  - builtin/repack.c: add cruft packs to MIDX during geometric repack
>>  - builtin/repack.c: use named flags for existing_packs
>>  - builtin/repack.c: allow configuring cruft pack generation
>>  - builtin/repack.c: support generating a cruft pack
>>  - builtin/pack-objects.c: --cruft with expiration
>>  - reachable: report precise timestamps from objects in cruft packs
>>  - reachable: add options to add_unseen_recent_objects_to_traversal
>>  - builtin/pack-objects.c: --cruft without expiration
>>  - builtin/pack-objects.c: return from create_object_entry()
>>  - t/helper: add 'pack-mtimes' test-tool
>>  - pack-mtimes: support writing pack .mtimes files
>>  - chunk-format.h: extract oid_version()
>>  - pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
>>  - pack-mtimes: support reading .mtimes files
>>  - Documentation/technical: add cruft-packs.txt
>>
>>  A mechanism to pack unreachable objects into a "cruft pack",
>>  instead of ejecting them into loose form to be reclaimed later, has
>>  been introduced.
>>
>>  Will merge to 'next'?
>>  source: <cover.1646266835.git.me@ttaylorr.com>
>
> This version looks good to me. There were some other comments that
> seem to have resolved without a need to change the patches.

I'm excited about this work!  I just sent a quick review to the
design doc.

Before merging to 'next', I'd be interested in two things:

 1. Marking the feature as experimental so we can learn from experience.
    Clarifying what aspects we consider to be stable / set in stone and
    what are subject to modification.

 2. Marking this as a repository format extension so it doesn't interact
    poorly with Git implementations (including older versions of Git
    itself) that are not aware of the new feature

Thoughts?

Thanks,
Jonathan
