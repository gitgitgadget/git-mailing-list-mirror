Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050861F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeIZDty (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:49:54 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41857 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIZDty (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:49:54 -0400
Received: by mail-wr1-f45.google.com with SMTP id j15-v6so20760794wrt.8
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q7WDsLavcTjIy87dJ0t/NjCKcLrgfY+iZ1s6gOHQPkE=;
        b=fRf+HnCFxaE3fLunVsz0wnA7jLuf3QT/oCKdHNCoD/6LCbHPSBCW4YNiLu1DrDgz1V
         rPKo8608+QuvBZ16HktVaBA1XCRD/AS5dRc06PF1bXd1RhgLIXkHNDCwb3NS4kUqkG5y
         xOdO0q7tVpdh8tcUAJ2NPzA9tAaJW8fyQA6WI6atHTrp/XMjwFDfX2zcpBw9iT+PqhzX
         xyq/CYmHj5Z1ni7arsaeaTi10ZmiLdpyOIicTzPKzLtfthmKfBpgrubl8wrk8/zs2j0n
         TyEdzFhDkq4h+dvtuPyM4QiKvvc0czDs5D4OUrz0yi3WNtoT+g/4lBY6r5EVKx5VkN86
         RyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q7WDsLavcTjIy87dJ0t/NjCKcLrgfY+iZ1s6gOHQPkE=;
        b=ad0JpVMRURUT0lF6+Rf9Kp09RF3LazIAFOuZflOamqDgfSK3Gtd0IISaqb+iw3hyQE
         7tAjXCrQQgC0n064jSh1Z5N8gDHD+4r4a4Goq+6nJj8bF4sWo49JQtIgUgZ199nxFNQl
         ClrIpTOJmH4ZMOa/41coOOgz9zeLqQgPwr46w99aO2myI+kQg+KxxT5UNj2mNlZRvuwp
         0b38rCwE98U8EhKBsFUSiHChKo1wgyo5XBJlZfCduXJOGTK8HAxEMcYazoEwXjF6x280
         QCwPjAGbmgr2iJQ0T4b5zgYLr8TC4bRBO68M03SPuTaZDIEGRkAlDP+W/m73PQiNnaXp
         PlAA==
X-Gm-Message-State: ABuFfoj7Xw4m73+gt98SfxUFkz3+TISglx47Kr70AGeOj0lB6RlaJ2BN
        XLUtIa3opVFk/ITt40wZFgiUGuMo
X-Google-Smtp-Source: ACcGV606+/NJBUTgOQc8VgKVjJPPe9V9qchC9SCsDxErjiLOxLrWyCijX2hm0w/Rfup+EbzKqeY/3w==
X-Received: by 2002:adf:a708:: with SMTP id c8-v6mr2692291wrd.56.1537911618434;
        Tue, 25 Sep 2018 14:40:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 139-v6sm4963130wmp.4.2018.09.25.14.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:40:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
        <CACsJy8D_37U+4sb7tb8KqGM=_3CRrTaZX1ZE9VqDVrYJT-AhnA@mail.gmail.com>
        <fa6d37b850177f7f2ba31c596d5986962eaf7382.camel@gmail.com>
Date:   Tue, 25 Sep 2018 14:40:17 -0700
In-Reply-To: <fa6d37b850177f7f2ba31c596d5986962eaf7382.camel@gmail.com>
        (Kaartic Sivaraam's message of "Wed, 26 Sep 2018 00:14:19 +0530")
Message-ID: <xmqqpnx1ntmm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>>  Also please try
>> "git fetch" again with GIT_TRACE=1 and GIT_TRACE_SETUP=1. Hopefully we
>> could catch something with that.
>
> $ GIT_TRACE_SETUP=1 GIT_TRACE=1 git fetch origin next
> 23:10:26.049785 trace.c:377             setup: git_dir: $COMMON_ROOT/git/.git/worktrees/git-next-build-automate
> ...
> 23:10:28.402815 git.c:415               trace: built-in: git rev-list --objects --stdin --not --all --quiet
> From https://github.com/git/git
>  * branch                  next       -> FETCH_HEAD
> 23:10:28.437350 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
> ...

That looks like fetching only the 'next' branch and nothing else to
me.

Perhaps your script is referring to a variable whose assignment is
misspelled and invoking

	git fetch $origin $branch

and you are expecting the $branch variable to have string 'next' but
due to some bugs it is empty somehow?  That explains why sometimes
(i.e. when $branch does not get the value you expect it to have) the
script fetches everything and some other times (i.e. when $branch
does get the right value) the script fetches only the named branch.

