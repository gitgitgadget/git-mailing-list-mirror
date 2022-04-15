Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F47EC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 22:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356377AbiDOWpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiDOWpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 18:45:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50AB9F398
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:43:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 64-20020a630843000000b0039d909676d5so4676285pgi.16
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Orh1Hf2EvVd5O1dwhD3Ubxz/Uw9MS4MgkYWUG2Ak5JE=;
        b=Oc2Gg9to0hfkMNUuzEif6vDiYVqtrH92fUBMQ1xWC+VpqeFEGIAINhJS/gwPZ3uTql
         2AZuOGiSZHEYeiNfafh2fQpdLvB+fCte4Y0I3wlYcYaUF5ayS4ZELmSroPM2J7s5rTDL
         y1HvFZcAtzevvOPcGjct34DI1VuY46aQTEnZl7xIU+0xONnxbR4SqwfTdAr4vprFwt26
         cjPvdFYzDvQat5y9DadYRkNyNLPlrbQ32K6/K2LIuJqAnWpocNi1CwBgvKHoC2VTGAim
         KLlIwdnwQaO6UWz3Tx7w2D3gBWdthU6NBSUFlL1qrAvP8mQ9DGWqVTydLBjRxtA7Pwj1
         +1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Orh1Hf2EvVd5O1dwhD3Ubxz/Uw9MS4MgkYWUG2Ak5JE=;
        b=rlbIk6MVmH9cp6Lid5NoESzPzydVn2Vm93o03bmrvMWck6MMbjOEO2qngK/3Mnwha/
         09jH0BPwfycR/ASVzF9Ds3zHCIeyjBL552R/I3Hr9oD5J9Q17YsCZy4F1d6ESY1ZKKaq
         w2YGQmI+TDuanqLJvffSLBer5Mlc8GkXp3FHVRuV1qSkDnkCITWL0YF4pvZ0eaVeFV6P
         neKOzaWsG89loqA24nVnphVyntlgirKBgrOEU8qgmhravbblx2o1ri/yT5bADz4Jzlcs
         fIxjmsTH90o+lI9i6BCjOgUsVF8/Wp10l8090xED7spE//MYdnoB9hp1ZhOcgZwClGto
         mb9g==
X-Gm-Message-State: AOAM530ckG2GC/utdRyftVpGkx8Te9iDMl3Acxv/Ab0txzLc6wtFtayS
        GVLcheajs1ctgyKu9+NLSy6yexkChnd2PA==
X-Google-Smtp-Source: ABdhPJwH+VbqecKgf6ted6Op/+/teUWUSj0RGaHW/V1BMmfU2zyXY4EElBjEfro9uYwgxPm/uSicTsUYkvoJDA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1c8b:b0:1ca:1ff6:607b with SMTP
 id oo11-20020a17090b1c8b00b001ca1ff6607bmr6422972pjb.244.1650062604193; Fri,
 15 Apr 2022 15:43:24 -0700 (PDT)
Date:   Fri, 15 Apr 2022 15:43:15 -0700
In-Reply-To: <kl6lbkx2821q.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6l8rs67yt8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnfs4kud.fsf@gitster.g> <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbkx31sc0.fsf@gitster.g> <kl6lbkx2821q.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> Yes, I mean that even the current directory will be ignored when
>>> discovery is disabled.
>>
>> OK.
>>
>>>>                                                I am not sure that
>>>> is realistically feasible (I am thinking of cases like "git fetch"
>>>> going to the remote repository on the local disk that is bare to run
>>>> "git upload-pack"), but if the fallout is not too bad, it may be a
>>>> good heuristics.
>>>
>>> Good detail - I hadn't considered the impact on our own child processes.
>>> I suspect this might be a huge undertaking. Unless there is significant
>>> interest in this option, I probably won't pursue it further.
>>
>> I do not necessarily think so.  The entry points to transport on the
>> server side are quite limited (and the client side is dealing with
>> your own repositories anyway), and they already know which directory
>> in the server filesystem to hand to the upload-pack and friends, so
>> it would be a matter of passing GIT_DIR=$there when they call into the
>> run_command() API, if they are not already doing so.
>
> FWIW I experimented with turning off bare repo recognition altogether
> and seeing what breaks.
>
> CI Run: https://github.com/chooglen/git/runs/6042600953?check_suite_focus=true
>
> AFAICT, most of the test failures are what we'd expect if we stopped
> recognizing bare repos altogether. One stands out to me in particular
> though - in t5550-http-fetch-dumb.sh, 
>
>     git clone $HTTPD_URL/dumb/repo.git clone-tmpl
>
> yields 
>
>     ++ git clone http://127.0.0.1:5550/dumb/repo.git clone-tmpl
>     Cloning into 'clone-tmpl'...
>     fatal: repository 'http://127.0.0.1:5550/dumb/repo.git/' not found
>
> This sounds to me like Git isn't recognizing the static http files as a
> remote Git repo, and if so, --git-dir doesn't sound like it'll save us.
> But I'm not that familiar with the transport code so I don't know if
> this is a big deal or just a quirk with our httpd tests.

Ok I think this is a false alarm - the previous test does some setup on
the server, which is a bare repo. It was the _setup_ that was broken,
not the actual `git clone`.
