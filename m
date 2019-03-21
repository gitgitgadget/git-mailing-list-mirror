Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA4E20248
	for <e@80x24.org>; Thu, 21 Mar 2019 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfCUIbR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 04:31:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCUIbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 04:31:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id w2so5522873wrt.11
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0XIVFGzxcT2wD3rjoLaWCxxOYFyiVKzMOBYDjTPBZ68=;
        b=Od+RjZtKvOztYhkwJToi3ORDyMldFlmDV03sXNQYpQTtPeSlqGJsASU6E+palf9iS5
         Syy5OXT4++ST9/jDjsHFMtNZQM9alBpYfkZuEHr9R6IMfPihMYWDdQNOQXVeDW0QhzEZ
         hdUZWGx+L4jtaWPc4lK4VaBFUcBSMWr6Igzmxae8OJcf9fuL2lYtORtGn8c1KaSl8UoJ
         KXp89eZXc5HXlnlEKHvAy2azcO6cBUwl6H+BCH+WcKVHuwmKjvtQ9YQwkho50iRuspDa
         dZ6DxLkLqCG93oZCv6Qdr1/zRziyjk3dg9wU8jIlWFcjVGvk5kPsiyUYjmmVSrJP33w8
         jC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0XIVFGzxcT2wD3rjoLaWCxxOYFyiVKzMOBYDjTPBZ68=;
        b=OgoYeEDjoy6i5R5ov2WlobLmLlV0BFAxWBoSgscEwHUyeon3tjMEX1DkemStOHdKnP
         T92fnNKCHeL2Rczrv3iPKmVi4+dT7BUS4+JVpIqywSn+P+dRg/zJ/pCPj9wi/RyL624e
         iqBwEziTmFOIG33a8GLnnc96KOVLO8iLe3tPQHjzEaz0vKUAIoBenkTwcVnTWCWynJ4L
         L2oiFlD9rSkhf5B5ruLsxxkRHNS6MSlke+e5C9+bwB18DzDumEy8kzOtRZRygqRW3Xbd
         epNogMU05czfeqLae/BowsV8ZJ7QIyQlDuhAt2bT6stO/wdf6lwpkkKdk+XWShPls9bW
         TIJQ==
X-Gm-Message-State: APjAAAVxOubSOeB4P2PLSfjBGhMRVtCfRrJGYcU7I38d2x+OvaPZNRpJ
        G5b2F0y/BhDdCloSV7NcL0Zyo8noEtA=
X-Google-Smtp-Source: APXvYqzd14cDXhG8ToKCX4w+sZNSsGa4AGmqtq16oOGbPKPJ7wjAfWK6ysOeyf2PQyJ6vESDuPgodQ==
X-Received: by 2002:adf:b651:: with SMTP id i17mr1518610wre.108.1553157074767;
        Thu, 21 Mar 2019 01:31:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e1sm8729833wrw.66.2019.03.21.01.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 01:31:13 -0700 (PDT)
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
        <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
        <878sx8lpqw.fsf@javad.com>
Date:   Thu, 21 Mar 2019 17:31:12 +0900
In-Reply-To: <878sx8lpqw.fsf@javad.com> (Sergey Organov's message of "Thu, 21
        Mar 2019 09:12:55 +0300")
Message-ID: <xmqqd0mksk6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> The same effect can be had by just reverting "let's allow -m1 for
>> single-parent commit", can't it?  That is a far simpler solution, I
>> would say.
>
> Those one didn't introduce the issue currently at hand, as we still
> don't allow merges by default, so why do we need to rewind it?

With it reverted, "[alias] cp = cherry-pick -m1" can be used to
train the user to blindly pick a range that has a merge without
thinking, which is what I meant by "ship has already sailed".

With it reverted, a range pick of a straight single strand of pearls
would still work just fine.  And the user is forced to think and
chop a range with a merge into a set of subranges each of which is a
single strand of pearls, plus picking individual merges (if picking
these merges is really what the user wants, that is).  As ensuring
the users to think is the whole point of excercise, the original
system before we allowed "-m1" for single parent commit was after
all giving us the right balance, I guess, without another new
options.
