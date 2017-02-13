Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0F81FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbdBMTmk (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:42:40 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32906 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdBMTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:42:39 -0500
Received: by mail-ot0-f193.google.com with SMTP id f9so13210150otd.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EpuIYonAxjO+Zj9heiyrqDi8YYDLfI16vahnZ3x+6o0=;
        b=jit9MVwt7kDbSWtQMwEFyarRk9OHCX79wS3yAqBwG5AOVcOnmkn0dQ7zEaQhEV1Lck
         v8m9d6UnRPwsSXW9Ixnsidmk005OJ4eXhtdYOYryk27LxqAycg4NNAksI1Y5UGUjB5XH
         +yeLMS63RMnFPN3AN3vsb5k5knrIi3qdAeCbHbpbKHQ6dUBMLt0ogkU6Tvy+8XJ8BfH2
         9ca9tXQ/M9idgqI1K72/NKAdGWXuG1AxkISYeyk5dJdu8JVVjz7p0tWr2mYU0IjUhL3m
         HXTrqbnGAqQ/J0DDJQK3Jx7sOAIGM4+e3NbUDbjLUtZHNn9mLIaNhoZNrER6e73vY64j
         iSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EpuIYonAxjO+Zj9heiyrqDi8YYDLfI16vahnZ3x+6o0=;
        b=UqjzOQFME7qzFV7FIKTUcdiSuwz8stIXVQj35F77m26PjbZGvpvA/P5SlThcJSD58e
         gnHVmOikzGrRARmXyLUCocWHiQWIoInizMVEWXRsolWw6ih9qFm8o1MpEuAzM5Er6Mj/
         +5ebRs7TYy5mraBczOu6qFo8ah5TAcUjsXxIyOzjPyQIzmO5P72cW50h8bwxxyxUNiHK
         AuR1RMBixCURhOAQtKq53KMVy68B1DHXBxoDxMuIHh58SaJq17du/0Sc/KaSkqkrExtI
         uEKLD0sMuXGgaYMIFYZkfqK2JFEfS/zcfa4/6KsY1PfqSeSS/uFyX8XqBgyoSfQ3NiTs
         KwYA==
X-Gm-Message-State: AMke39nT3k+FpiVjyi2ovwlDiceOMLRaF5Me0+2A5+1f1a4OGwZ3JJfRnJFuAkFeQmvdBQ==
X-Received: by 10.98.41.5 with SMTP id p5mr28080047pfp.183.1487014958129;
        Mon, 13 Feb 2017 11:42:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id 199sm22418652pfu.91.2017.02.13.11.42.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 11:42:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
        <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702101647340.3496@virtualbox>
        <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
        <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
Date:   Mon, 13 Feb 2017 11:42:36 -0800
In-Reply-To: <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org> (Johannes Sixt's
        message of "Mon, 13 Feb 2017 18:46:35 +0100")
Message-ID: <xmqq60kdev2r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The patch does add a new runtime dependency on libcrypto.dll in my
> environment. I would be surprised if it does not also with your modern
> build tools.
>
> I haven't had time to compare test suite runtimes.
>
>> I'm open to the argument that it doesn't matter in practice for normal
>> git users. But it's not _just_ scripting. It depends on the user's
>> pattern of invoking git commands (and how expensive the symbol
>> resolution is on their system).
>
> It can be argued that in normal interactive use, it is hard to notice
> that another DLL is loaded. Don't forget, though, that on Windows it
> is not only the pure time to resolve the entry points, but also that
> typically virus scanners inspect every executable file that is loaded,
> which adds another share of time.
>
> I'll use the patch for daily work for a while to see whether it hurts.

Thanks.

I need to ask an unrelated question at a bit higher level, though.

I have been operating under the assumption that everybody on Windows
who builds Git works off of Dscho's Git for Windows tree, and
patches that are specific to Windows from Dscho's are sent to me via
the list only after they have been in Git for Windows and proven to
help Windows users in the wild.  

The consequence of these two assumptions is that I would feel safe
to treat Windows specific changes that do not touch generic part of
the codebase from Dscho just like updates from any other subsystem
maintainers (any git-svn thing from Eric, any gitk thing from Paul,
any p4 thing Luke and Lars are both happy with, etc.).

You seem to be saying that the first of the two assumptions does not
hold.  Should I change my expectations while queuing Windows specific
patches from Dscho?

