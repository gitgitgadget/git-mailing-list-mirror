Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B143E20248
	for <e@80x24.org>; Sun, 10 Mar 2019 00:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCJA45 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 19:56:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46866 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfCJA45 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 19:56:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so1266491wrs.13
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 16:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tFPCVSHMiXKZ+A/3tGTOjnAFE0BoYIhN+egz1js5JfY=;
        b=nhOk+X68kcke30KsMF+5itFTTVqpBA47ca3Ep6iRQ7CZWRJSwedo+mRuvFRuKGMnfr
         eWOFOumQqureAy32ZU4kbCZjDehb6LXOSEtfmUjOIWE+89FlXBoB9nO4AO8TXRT/I+AQ
         xaqb1SOtu9Tg5HTyf+zbLgASX0tOsxre5WaHJcbIojvrsmfELiN6DC1H52baWuSFX9+P
         VgSLTBPmwCkj1PyMU7XnWc3ugjLXY5NgJk8xEdaw8+vUFXnZPMbYEFVgoD8Oiac2EHS1
         BcWADxfj9N+LG2OPFYozLw+mPXsg5Ei188oOhxi/H0w4mqz9R5SX8cNGwX0j+CgWGRey
         gPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tFPCVSHMiXKZ+A/3tGTOjnAFE0BoYIhN+egz1js5JfY=;
        b=UegWhj0kdjJbLGCYIvPj1WHg+w6rHPuMu6DEKsaE41AonaIkmdSAxq8qjcZTx6BsVM
         Z4Y1v0OA/eCyWZyszlSyMe3KzbcQNa7m5B3uXOkmwMUZiterpsWgjwEDUqpAN+oSiQ84
         qB7hJiKRU1QyaFwuBzSQt3/TEfJepIAeGN1DSbxcq77z2cYw4+NKre04EB57Ybw1NsrB
         BsiM1l+pWntlltPqwwGg/qdFB/xoV9j1avNHw0gbs1BEri1vt+mgRr9dyf32uFCx6khq
         U3/0nTWrdkh5fX5NZGDairDmDcFOR2KG72Z9CVgLKZIVP+sGaVrtxgMdkDOPD6TPrqhx
         VpqA==
X-Gm-Message-State: APjAAAX8NSmqb8ixogYBDWUyICShzH6acykU0QGbu0cYoKJDQRh+0yXp
        aeYlWGvQ5Me40MiJOS8bf98=
X-Google-Smtp-Source: APXvYqzkco0DYp0zNfrMkXnhhDVLbqLRTjpU9D5pk6tLx4vviX0rEYRkgZhEPCnLxogsmN1ClbOKxA==
X-Received: by 2002:adf:a10b:: with SMTP id o11mr14783197wro.91.1552179414914;
        Sat, 09 Mar 2019 16:56:54 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i10sm2026812wrx.54.2019.03.09.16.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 16:56:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] stash: handle pathspec magic again
References: <pull.159.git.gitgitgadget@gmail.com>
        <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903081709220.41@tvgsbejvaqbjf.bet>
Date:   Sun, 10 Mar 2019 09:56:51 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903081709220.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 8 Mar 2019 17:12:02 +0100 (STD)")
Message-ID: <xmqqva0rmtrg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you care deeply about the commit history, I hereby offer to you to
> clean up the built-in stash patches when you say you're ready to advance
> them to `master`.

What's the goal of such a rebase?  To rebuild the topic as a
sensible sequence of commits that logically builds on top of
previous steps to ease later bisection and understanding?

Thanks for an offer out of good intentions,, but let's move on and
polish the tree shape at the tip of this topic.  The history behind
it may be messier than other segments of our history, and future
developers may have harder time learning the intention of the topic
when making changes on top, but this one was supposed to create a
bug-to-bug reimplementation of the scripted version.  What matters
more would be our future changes on top of this code, which improves
what we used to have as scripted Porcelain.  They will genuinely be
novel efforts, need to be built in logical order and explainable
steps to help future developers.  Compared to that, so the history
of our stumbling along the way to reach today's tip of the topic
has much lower value.

Besides I think it is way too late for the current topic.  We
established before the topic hit 'next' that reviewers' eyes all
lost freshness and patience to review another round of this series
adequately.

We at least know that the ordering and organization of the iteration
we see in 'next' is crappy, because some reviewers did look at them.
The rewrite will see no reviews, if any, far fewer and shallower
reviews than the iteration we have; nobody would be able to say with
confidence that the rewritten series achieves its goal of leaving a
sensible history.  Doing so just before it hits 'master' makes it a
sure thing.

Let's just we all admit that we did a poor job when we decided to
push this topic to 'next' before it was ready, and learn the lesson
to avoid haste making waste for the future topics.

Thanks.
