Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1055F1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBDSSu (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:18:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34621 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfBDSSu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:18:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so10705052wmd.1
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bTTC/Vc0OYXm9hbdnkQw+HceH3avG9pVzA5Tvpz1FYo=;
        b=BAK9zQu0+tRMhc+N35CZ9IAddp1S9V2r3OOg/+PHbrzQxWTCgqRplqZ5o/J+p76e13
         ArZwQYxYEm1RD1EPsclpxTA7fOIicF3qKmNIPTiVK/72fW2I4w+9gwlye9YpWOq1Tzpi
         o6BOdYrG2AxnXlDYq0XMf5j9uAjyb6PREqDOlMn3XFmuXtLZyfr9CpFbW7b+8L3DOzcC
         zTo8fdBl5OXY+RJotNjlFw6sBvWxTYIuzO9+7mMJjlbIHCmReT8uhaJTuQxjAur40TWA
         jDap9BqU9ePFWCUCuPq9Np7XAvBFHDMwpSb83GndeNCd7Qswqu3ckGp6kkHsgETYuTff
         6x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bTTC/Vc0OYXm9hbdnkQw+HceH3avG9pVzA5Tvpz1FYo=;
        b=SxqgZhLoZwSoqaaV17v4apmqx9dN67CBDtyb2lGQ8YVYDrpEpHxE53LjUfTDlynfBq
         tWjwqJxFH1+z5xn4cTomQ8HE4meWRrXnhfrSXIlji0XGZV2BVgHTcqM0W74mowepm2+y
         d+jCpvWul8NGkBaA8nxsMRFnpWkY/qHYGgiIqNN1YVYKi82qZaRshDab6EhyZcp0wwvi
         xyZZDhxaMJBpNOKMcrNUFTzTVvj4WR7j9foZJ2ve4O/0PSVVPT/doUTbImM7HHEI5quX
         mexnmbqFmizdusz6fKEyipZgU6iLRSE2jsnhPn47+NFrbW9+6Sf2MYe+qlKxyStBuiy0
         Xe/Q==
X-Gm-Message-State: AHQUAuaj57KzxbifzAtyszAfQkPbELZhpClgA8jdA2YyZAUaA618MAFc
        +TTwrIQKwXXZo8al5g6a07Y=
X-Google-Smtp-Source: AHgI3IaguHrAPEkuGkR4jmuX1yVwF8Ekn7nsCIVmhJ8YeXZ6xM0aOybzD0Ib6C4Y6/zsOFlXNf5CPA==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr481065wmh.29.1549304328495;
        Mon, 04 Feb 2019 10:18:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w125sm28402945wmb.45.2019.02.04.10.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:18:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
References: <20190201220420.36216-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190201220420.36216-3-nbelakovski@gmail.com>
        <xmqqlg2zw25q.fsf@gitster-ct.c.googlers.com>
        <CAC05385Tnn+2x7Xx-Cy43S5aqjjY2gVkwcEzy+2=vYR72tNekA@mail.gmail.com>
Date:   Mon, 04 Feb 2019 10:18:47 -0800
In-Reply-To: <CAC05385Tnn+2x7Xx-Cy43S5aqjjY2gVkwcEzy+2=vYR72tNekA@mail.gmail.com>
        (Nickolai Belakovski's message of "Fri, 1 Feb 2019 15:12:44 -0800")
Message-ID: <xmqqo97rv2m0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> On Fri, Feb 1, 2019 at 2:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>
>> I had to apply and then use --color-words to see what is going on.
>> Please avoid unnecessary reflowing of the text that makes the patch
>> harder than necessary to read.
>
> I was trying to keep the line length consistent. How else can I accomplish that?

By relying on the fact that in the final output it does not matter
how the sources look like, e.g.

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa9..b64b3bf458 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -27,7 +27,9 @@ DESCRIPTION
 
 If `--list` is given, or if there are no non-option arguments, existing
 branches are listed; the current branch will be highlighted with an
-asterisk.  Option `-r` causes the remote-tracking branches to be listed,
+asterisk and shown in green.  Any branch checked out in linked worktrees
+is shown in cyan and marked with a plus sign. Option `-r` causes the
+remote-tracking branches to be listed,
 and option `-a` shows both local and remote branches. If a `<pattern>`
 is given, it is used as a shell wildcard to restrict the output to
 matching branches. If multiple patterns are given, a branch is shown if
