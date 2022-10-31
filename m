Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C6ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJaU0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaU0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:26:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA412ADA
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:26:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt23so32272068ejc.7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDGc4OIPjA4+ZRVHA0qAXa4jDtRjhVoZdtoHYjFdYDc=;
        b=C2Ns/Ha7nIxoUVVoOYuPmiE+uCGXsNRKGCvE9dEN1t6s4r0cWjHf1Y7HMPGtzKqGK9
         sHJXHr55PZRf7uz9DCfHz8BNPuJaW5M5FzmTFFhfg5nPdDcMLj8cNIvXYWIt8KKu46v0
         NrY9dh9C2fbLJEofsbEZGfVlp+8iIxX2Nk9/XwjtDdy2PDdNtQwgClD8B4rZG32M5Sba
         FZinjc7x14WaV4g7UWQPiuhOqBiJWwG+4GJF2vhuJrchAvgYTWWTnF2VqqCZTK3AyG7L
         5unsa+9LDeDtNHals708TGoUB+dOQs2c2vhrTZ1k5ioFFSWwd/CXXZyBk5mFAl8B+RZn
         GVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDGc4OIPjA4+ZRVHA0qAXa4jDtRjhVoZdtoHYjFdYDc=;
        b=PU6UlixtRVRsEdKyWm1XUQX3nDHXHXmwu3UOgnntMu1jSYRE7WfL6U++FQwCVYgDCN
         c9+FZ65XdYDZtcDk1n551xiAorczN810sB5WHWECEGA6N97HYLuM1e1kBlnMDl3UKLf3
         9UjdzYuI+jaWZKm38N4Lm45fT3xyn8dcIpp66wV0KhM7ORhMJAL5bapOg+26HhyVuUB4
         IsB1Xj055y3QUlgw4qY61bYfqkpIqH89tIZG2sIMKo9ujC4HY79b/7u197ui2nTG4npn
         CCO6LZ9XvhFJ9FmZ2RPFrnrGf5JzhFVJb8bY2hfUWwOprjEWkWLkMCYspVs6S0y2LxHq
         Q4CA==
X-Gm-Message-State: ACrzQf1zfTLQ8OgM+2j6EJTdHaND8YlNxH7LPiE++hWu6GJctveRAq29
        2v75mmJ9GThtxHJU1bBfduyD6jo9Nn8=
X-Google-Smtp-Source: AMsMyM4YaD8PGAiDgr8oator9IqIwXzl+iBMS59RYRmomSi2EYwntaaQIKIU4yirBrvXSkOZ0wVsTQ==
X-Received: by 2002:a17:907:7e9e:b0:7ad:bc80:c003 with SMTP id qb30-20020a1709077e9e00b007adbc80c003mr10893871ejc.198.1667247994006;
        Mon, 31 Oct 2022 13:26:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0078d957e65b6sm3350000ejf.23.2022.10.31.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:26:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opbMe-00ApT2-34;
        Mon, 31 Oct 2022 21:26:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mark Hills <mark@xwax.org>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: Consist timestamps within a checkout/clone
Date:   Mon, 31 Oct 2022 21:21:20 +0100
References: <2210311614160.25661@stax.localdomain>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2210311614160.25661@stax.localdomain>
Message-ID: <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Mark Hills wrote:

> Our use case: we commit some compiled objects to the repo, where compiling 
> is either slow or requires software which is not always available.
>
> Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS upgrade) 
> we are noticing a change in build behaviour.
>
> Now, after a "git clone" we find the Makefile intermittently attempting 
> (and failing) some builds that are not intended.
>
> Indeed, Make is acting reasonably as the source file is sometimes 
> marginally newer than the destination (both checked out by Git), example 
> below.
>
> I've never had to consider consistency timestamps within a Git checkout 
> until now.
>
> It's entirely possible there's _never_ a guarantee of consistency here.
>
> But then something has certainly changed in practice, as this fault has 
> gone from never happening to now every couple of days.
>
> Imaginging I can't be the first person to encounter this, I searched for 
> existing threads or docs, but overwhemingly the results were question of 
> Git tracking the timestamps (as part of the commit) which this is not; 
> it's consistency within one checkout.
>
> $ git clone --depth 1 file:///path/to/repo.git
>
> $ stat winner.jpeg
>   File: winner.jpeg
>   Size: 258243          Blocks: 520        IO Block: 4096   regular file
> Device: fd07h/64775d    Inode: 33696       Links: 1
> Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
> Access: 2022-10-31 16:05:17.756858496 +0000
> Modify: 2022-10-31 16:05:17.756858496 +0000
> Change: 2022-10-31 16:05:17.756858496 +0000
>  Birth: -
>
> $ stat winner.svg
>   File: winner.svg
>   Size: 52685           Blocks: 112        IO Block: 4096   regular file
> Device: fd07h/64775d    Inode: 33697       Links: 1
> Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
> Access: 2022-10-31 16:05:17.766859030 +0000
> Modify: 2022-10-31 16:05:17.766859030 +0000
> Change: 2022-10-31 16:05:17.766859030 +0000
>  Birth: -
>
> Elsewhere in the repository, it's clear the timestamps are not consistent:
>
> $ stat Makefile
>   File: Makefile
>   Size: 8369            Blocks: 24         IO Block: 4096   regular file
> Device: fd07h/64775d    Inode: 33655       Links: 1
> Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
> Access: 2022-10-31 16:05:51.628660212 +0000
> Modify: 2022-10-31 16:05:17.746857963 +0000
> Change: 2022-10-31 16:05:17.746857963 +0000
>  Birth: -

I think you're almost certainly running into the parallel checkout,
which is new in that revision range. Try tweaking checkout.workers and
checkout.thresholdForParallelism (see "man git-config").

I can't say without looking at the code/Makefile (and even then, I don't
have time to dig here:), but if I had to bet I'd say that your
dependencies have probably always been broken with these checked-in
files, but they happend to work out if they were checked out in sorted
order.

And now with the parallel checkout they're not guaranteed to do that, as
some workers will "race ahead" and finish in an unpredictable order.

But that's all just a guess, perhaps it has nothing to do with parallel
checkout, such dependency issues are sensitive to all sorts of other
things, e.g. maybe git got slightly faster (or slower), so now files
that were always on different seconds (or the same) aren't in the state
they were in before...
