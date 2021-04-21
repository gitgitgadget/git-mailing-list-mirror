Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA0C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616CD60FDB
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbhDUR1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbhDUR1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 13:27:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22FC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 10:27:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o2so18384427qtr.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4F7l45C+TSP+oEBm+LpcPiy9xAwiwkVRPOJnr1AXmTQ=;
        b=Kfgt0D3TYgyinehjOmEvay0Vlbvocoa2UDgQpWqxUfTuNOCS/SzaCGRnLpZYoo4tlo
         XNphjCHQjrYJrVs/LPAiEALj3rLPKi1r16sVm4tO/YsEE53SnGTFDf76DKU/yPpG6WS8
         LduiDCajgnCwqg+QNFTfJQxKZ4SmQgVY6kAitPSQVR5RCoIO9+1bEGNXclRlrF6OC4Ij
         wOgiCRJpLfTdBAcB3EOk8Ir82nY5ghHnwHrMf/DiXm3FYX7cnwD/irw2HVXbjf50sYlE
         vfjsEBSNqnYGw+S1JpWxyeGXE4G2opK7wgWFTjDrp9mWc/tQtmb8GNCQ0Laf4g6yxYZj
         uBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4F7l45C+TSP+oEBm+LpcPiy9xAwiwkVRPOJnr1AXmTQ=;
        b=jcXPxms1p7JqtVoKJV0wPmsqI164hfzZrpL5xDBMFtMrn8Maczz79uESZXgbdYtO3l
         o/XuX3kVuP/HtlDc2jYqjr9K+sO+fSsO18fpU/xMUds3wmxJI98RxnjDfS63XiXxnzvz
         s5w3cmyTdqSvfIVq3dav9yK1qucHDDogg9ZORVjc6RKmaFdqtlGyLNXYYdNzal79MouO
         Uyl/0kyiIUBsTHahMIhuD0ugzSn5r2PpjGeGRWe59rS4BspxOUomxml3A6PE5T50Rtel
         RjuAfW3LIBuoYV71jXy9+N2mkeC1dPhfVk6lbdW/q1b2NxorQR8YtmsVCepcMxrT7USM
         M4cw==
X-Gm-Message-State: AOAM5336G+u1y+3RLExl6MWudtkiEVL8bba8osLuUKsxYOttLocEAJN9
        PU30036IY323ikBLOdREl00=
X-Google-Smtp-Source: ABdhPJyQqEKoBtlf3gZLMQowVViXiRa0O7em2XNtwNT/6EN/06JXzJq8/Yx1IxXOFBsR/cD/R8yl4g==
X-Received: by 2002:ac8:6715:: with SMTP id e21mr22358295qtp.239.1619026027883;
        Wed, 21 Apr 2021 10:27:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id x7sm147408qts.42.2021.04.21.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 10:27:07 -0700 (PDT)
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com>
Date:   Wed, 21 Apr 2021 13:27:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 7:00 PM, Elijah Newren wrote:
> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

>> diff --git a/read-cache.c b/read-cache.c
>> index 29ffa9ac5db9..6308234b4838 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
>>                         continue;
>>
>> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
>> +                       continue;
>> +
> 
> I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> !ignore_skip_worktree and why it'd be desirable to refresh
> skip-worktree entries.  However, this is tangential to your patch and
> has apparently been around since 2009 (in particular, from 56cac48c35
> ("ie_match_stat(): do not ignore skip-worktree bit with
> CE_MATCH_IGNORE_VALID", 2009-12-14)).

I did some more digging on this part here. There has been movement in
this space!

The thing that triggers this ignore_skip_worktree variable inside
refresh_index() is now the REFRESH_IGNORE_SKIP_WORKTREE flag which was
introduced recently and is set only by builtin/add.c:refresh(), by
Matheus: a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
2021-04-08).

This means that we can (for now) keep the behavior the same by adding

	if (ignore_skip_worktree)
		ensure_full_index(istate);

before the loop. This prevents the expansion during 'git status', but
requires modification before we are ready for 'git add' to work
correctly. Specifically, 'git add' currently warns only when adding
something that exactly matches a tracked file with SKIP_WORKTREE. It
does _not_ warn when adding something that is untracked but would have
the SKIP_WORKTREE bit if it was tracked. We will need to add that
extra warning if we want to avoid expanding during 'git add'.

Alternatively, we can decide to change the behavior here and send an
error() and return failure if they try to add something that would
live within a sparse-directory entry. I will think more on this and
have a good answer before v2 is ready.

Thanks,
-Stolee
