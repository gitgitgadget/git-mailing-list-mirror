Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE5020248
	for <e@80x24.org>; Thu, 21 Mar 2019 05:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfCUFrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 01:47:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCUFrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 01:47:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so1418294wmj.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 22:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7+8yJFQsSLqonitL+g4rDdRZPQ3ayn4v94GwGAxWj5A=;
        b=nCe0cN2fsdGPEM0Ph+mN6kl3/rGgE+EhRTqbXms/GBE4oMzcY0pCoNXY53LvvkPSP3
         nx65pjzqqC2/UTtUUGT5N+BpjYLLAvXTPeKVqLVljHB+LNdNOHjSGbI1I+6qYAdmibhF
         Ek3H9Ys4R66yyV5mLU+cz8xd9MiwZJCqHSjQgy/4fLjTFVwqYx713Pm32jO0yRcvOhbp
         669aVtJJaBqLBFzA1DVKnIxGX2JwyDrYbgD8uYL7aPV60ntF7/1mArgUNua1AHQmBfmA
         ECcZMjHgGh4ij7h/Tw7wI2LXZRKMnqKWUAw6spQEmSs1q4qbOVOvuSHz0qj+HeI23vNu
         M3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7+8yJFQsSLqonitL+g4rDdRZPQ3ayn4v94GwGAxWj5A=;
        b=hUUHWCjQWpzKM6ns0pLsYF574z/6Lq5nq+6JAAy2FIycJNLq5waHlBkIHEgk6gYkbn
         qWyC9ka8FLlpbVyJBlT6K8/qO2JgeEY3A4mT8rKfhyL+uboOCOXej54eohH5D8IsTPhK
         ypdi+T1+dd5IYdzu+tlNFomUrao85p5QHhfvE50+fXiqm6AAGhG7faLdCM9p1Ooi7yRh
         bTIO50X9yxJnTVM/Yhd/bcVA9mWI7Adli7wJbchsfg/XeZ8P5hrARzddFQZqw55Un+nw
         Y4+CBHwsSIHinau3bKwvHUrRlSHfA4qeP8ovKO5LvIyYPgdGJpch1Gu3bafrnCftxqzH
         0Xag==
X-Gm-Message-State: APjAAAWUdI++mtVOvhNRuWK/Kmj+Kp0PW0yH1XkLA6/iH6Na4FAeP9Xy
        /CMwDXAlPnGINVcxa4zkaWY=
X-Google-Smtp-Source: APXvYqxQYQ0INjovPTg8kbewyAHYzUy3pR55Z7QgyD4e3u50IBh+irhH5m0fT5pUmYi0Ps1zjGaPhg==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr1136974wmd.84.1553147243446;
        Wed, 20 Mar 2019 22:47:23 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j1sm4520173wme.4.2019.03.20.22.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 22:47:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
        <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
        <87pnqklr8a.fsf@javad.com>
Date:   Thu, 21 Mar 2019 14:47:22 +0900
In-Reply-To: <87pnqklr8a.fsf@javad.com> (Sergey Organov's message of "Thu, 21
        Mar 2019 08:40:53 +0300")
Message-ID: <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> To put it a bit differently, I share with you that picking merges
>> should be deliberate and it is safer to make sure allowing it only
>> when the told us that s/he knows the commit being picked is a merge,
>
> Something like "--[no-]ban-merges" then [*], having "--ban-merges" as
> default?
>
>> but when we started allowing "-m 1" for non-merge commits in the
>> current world where cherry-pick can work on a range, the ship has
>> already sailed.
>
> Except that it could be a different ship, provided we've got
> "--ban-merges". Having "-m 1" as default stops to be an issue, and
> explicit "-m 1" could then imply --no-ban-merges, that could be in turn
> overwritten by explicit "--ban-merges", if necessary.

The same effect can be had by just reverting "let's allow -m1 for
single-parent commit", can't it?  That is a far simpler solution, I
would say.
