Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E240C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AEC61494
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFOO30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhFOO2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:28:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57EC0611BD
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:22:02 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l3so15414949qvl.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yJbdPIkcjdbLqzUw8XHdh0y0jK7nsAH9dTDq9g/bdJI=;
        b=hX7G0sFaa7Wd9ymXA2s+QEOTTAFa3KuVfEMO5CwE4iEmoCxZdBDV0M+kLBOWCGF+NH
         sPYR14hviPonPTI0z76Q6YlpThzLoLMesjWVBcueYhi5Nklk+4xdp0nXaqWt0oo+76ki
         7lr3R6QHf+L89DDzxzL4kq2yBY0VNSDmYkzZTx1x/fV0CjBX/szPteWHmGOUaZ+doYl6
         4/qnRIXWmxINXrRlQGokrEVHTsiCpHWQqFiR5XqqNuaL/6q6FdzJIsfhwnZMks8d3khZ
         Q5QpddSaxVlBom/BkrTHrtaHZllke9OK9yMDGDinBMHsWudH6Ms4bJDBvjUucR4SOM+Z
         HE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJbdPIkcjdbLqzUw8XHdh0y0jK7nsAH9dTDq9g/bdJI=;
        b=DCijcYVwKCK4Tkui10YhrOrJxWXO1WTlqy3ceQ/hQDBlIpPNe1WkzD/sO07DaMmNeV
         xG2fExYH8wqDJCmm4DZIvY8MzngS6HQNrqPuS5db/aeNV82MGRpZXJN4vMYDiQ+oEug5
         v1b8YYXzQUmZsjdO0/+JukjVMeiWOn50z/DkgVr1FpJUldAm3cI0/UCUbK4cBhE5wipz
         9J/Zms3K3+peENUk25xfM86KfeblnrALd4o0oEOgZ5EWpKl/qR7UwcE9TfWKTwtQB253
         kLALWLjEq9qp1q/rhnTtM9GIkSurKzpEhj2R6ULPL0I7tUO1OESKTaTrg2Gz4ZEGWbs3
         DpHw==
X-Gm-Message-State: AOAM531Djaj2CHEFNWQHMye3dD2Y0Ccn/0ME/atbhdvWxftv6XYqfEcs
        tY4cYe2ZoTbgGYCh8wWNWoQ=
X-Google-Smtp-Source: ABdhPJyCF4+rm3CBMYejWvjK004gDOeOcrwW7Mnc3tUvlEO/q95Z2Y+Na29EXgXau+hmOrnK4V14nw==
X-Received: by 2002:ad4:4631:: with SMTP id x17mr5060963qvv.28.1623766921196;
        Tue, 15 Jun 2021 07:22:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:113f:4437:94ed:3bef? ([2600:1700:e72:80a0:113f:4437:94ed:3bef])
        by smtp.gmail.com with ESMTPSA id l14sm11909613qtj.26.2021.06.15.07.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:22:00 -0700 (PDT)
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
References: <871r9a2dol.fsf@evledraar.gmail.com> <YMJKcHpN/gL5U6KK@nand.local>
 <87mtrx1cdr.fsf@evledraar.gmail.com> <YMKzOgOU9lj9Nt0z@nand.local>
 <e85bb66a-d70d-1861-07ef-82a74bcce4d7@gmail.com>
 <YMOzDGOo/HbqzkPa@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb5e2df7-25d8-a878-78ba-cca771265978@gmail.com>
Date:   Tue, 15 Jun 2021 10:21:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMOzDGOo/HbqzkPa@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2021 3:01 PM, Taylor Blau wrote:
> On Fri, Jun 11, 2021 at 01:47:28PM -0400, Derrick Stolee wrote:
>> On 6/10/2021 8:50 PM, Taylor Blau wrote:
>>> On Fri, Jun 11, 2021 at 01:56:31AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>> So yeah, maybe we can just unlink() them right away, or another way to
>>>> handle the race is that load_commit_graph_chain() could just try again
>>>> from the beginning in such a case, and presumably picking up the fresh
>>>> just-rewritten chain.
>>>
>>> I'd probably be in favor of the latter.
>>
>> I want to point out that on Windows we cannot successfully unlink()
>> a layer that is currently being read by another Git process. That
>> will not affect server scenarios (to the best of my knowledge) but
>> is important to many end users.
> 
> Right, but isn't this already a problem today? Since the expiration
> window is zero we are already effectively trying to unlink all merged
> layers immediately:
> 
>   - Marking merged commit-graph layers as expired via
>     mark_commit_graphs() by setting their mtime to "now", and then
> 
>   - Immediately removing all layers which have mtime older than an
>     instant later in expire_commit_graphs().

The commit-graph management we built in Scalar and VFS for Git uses
a non-zero expire time to avoid this problem. However, since we will
clean up the ones that fail to unlink() in a future cleanup, we did
not do a similar thing in Git's background maintenance and have not
had any issues.

> (I almost suggested that a race already exists between multiple writers
> that merge multiple layers of the commit-graph, but that race doesn't
> exist because the commit-graph chain is written before other layers are
> marked and expired.)

And the maintenance buitin solves this by using a maintenance.lock
file to avoid concurrent processes operating on the same repo.

> In any case, it seems like the return value from unlink() is
> deliberately ignored in case another process is holding an expired layer
> open when we try to unlink it. So we'll eventually clean up all layers
> that don't belong to the commit-graph-chain, but at the granularity of
> new writes.

Correct. It also requires new data for the write, or the commit-graph
write will leave early and skip the cleanup IIRC.

> (FWIW, I had to re-read 8d84097f96 (commit-graph: expire commit-graph
> files, 2019-06-18) which mentions that a configuration variable would be
> introduced to change the expiration window, but we don't have any such
> configuration option. It also doesn't make any mention of handling this
> problem on Windows, which made me think that the unlink() calls weren't
> checking their return values by accident when in fact it was probably on
> purpose.)

That config option never appeared, probably because ignoring the
unlink() return was sufficient to get around this problem. Thanks
for digging in and making sure I remembered this correctly.

Thanks,
-Stolee
