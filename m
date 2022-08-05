Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B3BC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiHEOst (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHEOsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 10:48:47 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E81FCDA
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 07:48:47 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so3160788fac.7
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=M7eElAXI//OulkqMJ68oUQY668ss4wS2KbchX6x49os=;
        b=gLfnjPuTbxtMjLhDi1h31ZzcIfN8uukz63MiRb8UQgAEebE2GzaIU4L6aMxE6q5vCF
         Hw67u1y1t0cLi0ypINrdUBT1bN6JscdpCoVgWZPA1TPCFwznTI4RAiH3Ln9R6Bq3EnJ7
         m5+s/O3OP/Dj/h07uNgFK4F2YAdEFbp5Kj67ts8fI8ngmvg/9lOqyW5IWo8cKXcLxRPP
         MJuQmQXklXZzTWj73klYBhoUbyr8/bCDJz2JInrBQXtomysHACkqIpmMAbAXewrUmXYG
         PniZ19nx15HFapZV+J0BNVWAwQkPFJv3eNTVqUGF1NMyN6+SJoXAEo2CiOfaddGTIOY4
         fV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=M7eElAXI//OulkqMJ68oUQY668ss4wS2KbchX6x49os=;
        b=pqt2PK7hksBR3mJ5kXj/PkWNCvd6CVqQ+eXEiGxRlEBHwVf1iHyVnAtd5nxjEsCYo/
         LiC42AdbbhRjSRBEDFf0fQH/UMibHy0Fuwu83njKK7yeayOd5SzyBGIvwRh64NjL3MwX
         6LQudTsYeclFGhERRUtUpc0NxPRb2BP+1IlEcLoGbHWqyEYCTHc+V+WfqyHb5Mtnqqfp
         oWDJ00aqsKQ3Yd1U463sTvrhLO/U1olit8WODkBwDf9mLEx7oGBMZLA6zDfiavvzoNkk
         36pFM7h33RRYvm3mEL3zJSsNK/F63AfHnIIeVw1PnWd5F2IgrrSv12Gc9IljutbFyW44
         oxyQ==
X-Gm-Message-State: ACgBeo2i7w9CaM0p5ShvtT8lmcv0bvPP0/5rsBn4PL7GdDagKENJ7eRs
        gRoLh8ZnTt5AU/DyDm3s6MZz
X-Google-Smtp-Source: AA6agR5zlETloIFr5d/fIWSZSdcKrmUSV6WYj6LsvBHhiBo/B7jXgXkxTeJ5gV0b1ZMcfAXG2BrqAA==
X-Received: by 2002:a05:6870:b613:b0:10b:db5f:6026 with SMTP id cm19-20020a056870b61300b0010bdb5f6026mr3337828oab.159.1659710926618;
        Fri, 05 Aug 2022 07:48:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id y12-20020a4a650c000000b00440ed1f8c45sm717462ooc.43.2022.08.05.07.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:48:46 -0700 (PDT)
Message-ID: <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
Date:   Fri, 5 Aug 2022 10:48:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault in
 pack-objects
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Noneman <emily.noneman@gmail.com>,
        Jeff King <peff@peff.net>, Paul Horn <git@knutwalker.engineer>
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
 <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/2022 10:24 AM, Ævar Arnfjörð Bjarmason wrote:
> Narrowly fix a segfault that's been reported against pack-objects at
> [1] and [2].
> 
> This fixes a segfault in "git pack-objects", see a reports at [1] and
> [2]. In that case we'd go through the add_index_objects_to_pending()
> codepath being modified here, and eventually call into
> new_untracked_cache().
> 
> We'd then segfault in new_untracked_cache_flags() as we tried to use a
> NULL "repo" extracted from the "struct index_state".

>  		struct worktree *wt = *p;
> -		struct index_state istate = { NULL };
> +		struct index_state istate = { .repo = revs->repo };
  
Thanks for the fix. It is definitely narrow to this particular
stack trace.

It is rare that we create an index that is not 'the_index' in
this way. However, there are similar { NULL } initializers that
could be cleaned up in these files:

 * apply.c
 * merge-recursive.c
 * builtin/stash.c
 * builtin/worktree.c

Of course, delay these for a follow-up since these uses are
not causing segfaults in the wild.

Thanks,
-Stolee

