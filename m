Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93299C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbiAGRny (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiAGRnu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 12:43:50 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0034C06173E
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 09:43:50 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s16-20020a63ff50000000b0033b6e4cedc8so4254014pgk.8
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cl6RB4ugciBtBBMvVmip+Vh1B944h1wyF3Iaca0WL/s=;
        b=L3fVHjGYig/mInLcgrNAYpnGWlkw95onU3/2Sel5NBvx2OyXCfR7332MZXDaCIqpTu
         HNUMBe6qI8/jgq7eb5QCnEhhaNjc4dZa0JPZWeIbHSmyaTfyL2T6+PGt97NOFJiXojTh
         66B1xLo8HqZWpXNUjFvr3oBkuHX4HJn9VLE22lH8d2xxLeC01QKnpKTbxY96Smk3xUPE
         f0Qp9+NHd1SDjXhbDJCII/qyde0UoehSn7MEBNPxOnDpeBmOeptv0KK3P+RtdGHExSOM
         +++Zc10sfi3iuc73naA1fW7sHUOGlrrpHhaKmpofOp4j0QRVCFKVOJbbE9QP6pFQ8HdV
         uKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cl6RB4ugciBtBBMvVmip+Vh1B944h1wyF3Iaca0WL/s=;
        b=sJIEKxB6cCrho4+BpEyAMotyKwmo+gB/n2z7b6d44HuY8Vcy173fOmz5hlEFGpQNBQ
         eT58DThjEIIr0KjcCJyDZbd5nLFp+30nglPsgn3+ngvueJ357fQHtxWIY35mCJJX7HXG
         xDQY79IX1Mk2jb2YP8wImaTP53zrqQBhleKRle7KBsnW+IFd+mcAsU6VMR+8vaHu6SQJ
         AsYTphOmzNj1szZsuZClaqJvf/omM73zCIOYK6Ya9TzAfsdERZoiF7m8XjH4gM6jzjFo
         hOXWzSQGvp06gb1Jv08egZSEb8oVcHJPXK4KqRzTNyHWmUx/D9P3MlOEijoX6+2H83XM
         LLtQ==
X-Gm-Message-State: AOAM533j+LynQ57pcaW47XXbq1Z/mqAW1wCg3VJdjtpz0V9tz6+Sf/Im
        p5/cjaHG3Cn40poJAaiywjcrF4snf8nCsg==
X-Google-Smtp-Source: ABdhPJx5rGIrhDDxF/h1sAVl/TXr10YxWp1R2hK216Nr73W3EVgslemdJQMxxBd1tyWShuoa1ho3VHlBwoqbCw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:8d3:b0:4bc:3fe0:98d2 with SMTP
 id s19-20020a056a0008d300b004bc3fe098d2mr40945704pfu.3.1641577429989; Fri, 07
 Jan 2022 09:43:49 -0800 (PST)
Date:   Fri, 07 Jan 2022 09:43:47 -0800
In-Reply-To: <3160705c-d95c-c389-e929-f1f6bbcd80fc@gmail.com>
Message-Id: <kl6lczl3786k.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1111.git.1641410782015.gitgitgadget@gmail.com>
 <xmqq1r1lhobf.fsf@gitster.g> <3160705c-d95c-c389-e929-f1f6bbcd80fc@gmail.com>
Subject: Re: [PATCH] submodule.h: use a named enum for RECURSE_SUBMODULES_*
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> 
>> That is, many changes like this one.
>> 
>> diff --git i/builtin/pull.c w/builtin/pull.c
>> index c8457619d8..f2fd4784df 100644
>> --- i/builtin/pull.c
>> +++ w/builtin/pull.c
>> @@ -71,7 +71,7 @@ static const char * const pull_usage[] = {
>>   /* Shared options */
>>   static int opt_verbosity;
>>   static char *opt_progress;
>> -static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>> +static enum submodule_recurse_mode recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>>   
>>   /* Options passed to git-merge or git-rebase */
>>   static enum rebase_type opt_rebase = -1;
>> 
>
> Yes, this is a parallel effort that could be done, I agree, but my patch
> was meant to help in the mean time.

There are quite a few sites that could use this
s/int/enum submodule_recurse_mode change. I suppose one _could_ change
all of them at once, but that seems cumbersome to review and prone to
conflict.

So that this isn't debugger-only, I'd be happy with at least one change
(perhaps the one that inspired you to name the enum in the first place),
and making the other changes when it makes sense, e.g. I can do this for
the fetch machinery while I work on enhancements to `fetch
--recurse-submodules`.
