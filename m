Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1FBC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46A8610A0
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 14:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhKAO3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAO3H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 10:29:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181FC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 07:26:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h7so65593427ede.8
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zUquemhYEuvpk4II5JkWDApYx1ULy8CfVX60dj5DqSw=;
        b=Cy6HaU1yPyMwaU8vG2gw+vpw/3BSU93hI+TZMQQr+vR9ozMfXGA5ePqdseOVtR166j
         X2VRkCTd6YKpD7N7nCV6nHLH1sEWDk0BdVZMbQxZQMqK+azqRh3BOEcBi2AdIrPJ3IJ3
         asBamWfsHLDJH/YrbOGDsvanzKJbEwDhYmnedRVhMcArYBi4lSWShDhUOVHhRmzHrQ/Q
         RzZVkLUMemhzGHcoau9YHsCsDzxBx0ON75bxOeDjZ/VsRA51yvXrq/pUBIe5IpKMPP5F
         u10rW9FqPIqrqkluxOV7LV1RMi5RZwNdc1YwYNW1eIa4hjK1GO1cLCPvejmyTl33goaE
         20aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zUquemhYEuvpk4II5JkWDApYx1ULy8CfVX60dj5DqSw=;
        b=O9meFT+UchM6VfCvgvPwnkIOKy9v8Qeq5DbK4YMVxSVJu9l9Rq1NbzibFm3ku45NDN
         u1kGp7BNghgTTZgeNI/rCOe3RNHGPq9vQHC/oyf107c5y4SrcJHcjmucoSfU0I7UFsNN
         9GOVrkh2s+G3LezgQt6w9nb0s8fSETita3VzGVQ3mTZXjWgUI0xzZ/xooebKrv7M4b/3
         M3+iVFWO22uRJKNT9U4zrj4MVSac6vZgn7Zry1qD1pr95wx8GGmHEK0xeTm4jEC9REPw
         83Be/Gv9oZ0WXQXCFeqgRy2w0MMevbcC2ITOidEi5rFKvNAb5dmDAXBRHqkAHM7b7xX1
         l1DA==
X-Gm-Message-State: AOAM5310iZFUtsWfA1a9u6BNhDg5Wj5oMr6rZH64VJZRMp3MvmtKD2vU
        WWqv3ps7jt9j5gFlUoZT0IV6LB/gtleMIw==
X-Google-Smtp-Source: ABdhPJzjz35sughtcOw0p545+pqxAh9v7xiOKIjQ8X1AWgQ4WyQQ2Y7T7/WMA/HJpD9IKzjmZk23PA==
X-Received: by 2002:a17:907:214b:: with SMTP id rk11mr23719649ejb.541.1635776792241;
        Mon, 01 Nov 2021 07:26:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p25sm8839250edt.23.2021.11.01.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:26:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhYGd-002AXg-Bc;
        Mon, 01 Nov 2021 15:26:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dominik <dominik.seifert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Q] How to check git features for compatability?
Date:   Mon, 01 Nov 2021 15:20:13 +0100
References: <CACgoU8qhHunXwX=uG6AZrM=M3ofiM=AH37nVXAvN22Otwq=1eg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <CACgoU8qhHunXwX=uG6AZrM=M3ofiM=AH37nVXAvN22Otwq=1eg@mail.gmail.com>
Message-ID: <211101.865ytc3qaw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 01 2021, Dominik wrote:

> Hi,
>
> Scenario: I want to offer a simple utility that (among other things)
> automatically checks out git repositories. For that I want to use a
> specific feature (that is `git clone --branch`).
>
> Problem: Some user might have an old version of git where `git clone
> --branch` is not supported at all, or not supported in the same way.
>
> Q: How do I check which features which git version has? I fail to find
> the (rather commonly seen) `changelog.md` on the official git
> repository. Where should I look for a complete list? Is there a more
> complete documentation that lists the "earliest supported version" or
> some sort of "history of changes" for each of the git features, as is
> commonly seen in the API documentation of other CLI tools (e.g.
> https://nodejs.org/api/cli.html)?
>
>
> (PS: First time user here. Let me know if this is how you participate
> in this mailing list? I could not find any info on
> question-asking-etiquette either?)

In most cases, including this one, the best way to do this is to simply
run the command in question, and guard it with some wrapper that checks
for the 129 exit code. we'll emit that on usage errors:

    $ git clone --unknown-future-flag 2>/dev/null; echo $?
    129

If you're asking how you can find that without running a command like
that, the answer is that there really isn't a good way other than to
scour git.git's history. Even the release notes aren't always complete,
i.e. you'll find that there's options we've introduced that were never
explicitly mentioned in the release notes.

Even those that are are in human-readable prose, not anything machine
readable.

For "git clone --branch" specifically it seems to have been there since
2008 at least, so unless you're supporting some truly ancient
installations you shouldn't need to worry about it, but perhaps its
behavior changed in a way that I missed from a cursory look.
