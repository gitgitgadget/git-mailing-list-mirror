Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17291F516
	for <e@80x24.org>; Tue, 26 Jun 2018 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeFZRo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 13:44:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754619AbeFZRo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 13:44:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so15898037wmc.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Inrxq4vEpFoFRpTLghRHWKZsfvULIrzn5LREn56Wxho=;
        b=lVIsXceeQ333jwZwPmt0ipXiNae9QnRhYVX8J8eeCRzMy8L9AaXFDi8sNZeRYBLnbZ
         t0UeugUrQ6d30+Pw/RD5JCYa6EhwNxU8vbQu4RLZTw+EdN3XtkXOEDVQVUXyCfi6h5Nl
         hcn2mTEGDIt9RgYI2j/jvZY9K2Rn0HsPKcHGhCcZgDOEUNOc2rSfnkiDjqbXGV9ZPMVZ
         wkRv5VwQXdt27iFpjU5ce4nrzlrsuIl1aRb7aumJgIxydAhIykCJJwiad1Um4VTZFbka
         pzAHWgP+BIMn8r/5EeI+xHcUqdh4HktXlUDMtp+rJNheg4EAJQM7qzbVJSuic2AJ2i+Y
         FY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Inrxq4vEpFoFRpTLghRHWKZsfvULIrzn5LREn56Wxho=;
        b=pYQnHW+ND3nqW3OvFyL3xtPtRNi0Fr0aTqVsfSZJJOuUhttTfC8wRsti/j7WWlF1Dw
         n46eXkF6EphBrvxmtLRwLiCLAZtmA2B8mGkbrcj1RfQM1nAl1iPxbY4vao3dPQ7J0AM6
         ETrcCO4w418NWYy4IdjQ3yXeHg7YzYWgUVxIFh8okCj6Kuja7JbEVbCniUy3ryW2rtQw
         Q6Sq8dM1WtwdymJdIQatg+q/qe+PFXGBx7t/O7RqlAqA7oSBO3XNjFyTTBxo+qNjAGZV
         hBpgmK4Gsva3TIZU9OL3rCRx1l+bqU93KeqPiG7YkCKEnwXSJp74Liox33VduLM7yaC9
         aFXA==
X-Gm-Message-State: APt69E021VXNbdDnsjN1Uo/UpPWhelz9d6R0/ADxMiXZyjKZ1M57OhZb
        qQC6JSHuVl7wXA+oLwjhrnQ=
X-Google-Smtp-Source: AAOMgpeqpLpT6uadbuhuSAj64eKOO0lSVqAdSFgxnCOeB1I74J3TWzHHT6SkAuARa7y6VYgISaDyQQ==
X-Received: by 2002:a1c:9253:: with SMTP id u80-v6mr2527702wmd.52.1530035097303;
        Tue, 26 Jun 2018 10:44:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k17-v6sm3750554wmc.23.2018.06.26.10.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:44:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in C
References: <20180619154421.14999-1-alban.gruin@gmail.com>
        <20180621141732.19952-3-alban.gruin@gmail.com>
        <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com>
        <7094810.i0lmrLi0k7@andromeda>
        <xmqqr2kuq3qg.fsf@gitster-ct.c.googlers.com>
        <4dfaa8d4-09d0-1156-43a4-687c3389e039@gmail.com>
Date:   Tue, 26 Jun 2018 10:44:56 -0700
In-Reply-To: <4dfaa8d4-09d0-1156-43a4-687c3389e039@gmail.com> (Alban Gruin's
        message of "Mon, 25 Jun 2018 20:21:31 +0200")
Message-ID: <xmqqo9fxl9wn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>>>> I do not think "base_commit" is a good name, either, though.  When I
>>>> hear 'base' in the context of 'rebase', I would imagine that the
>>>> speaker is talking about the bottom of the range of the commits to
>>>> be rebased (i.e. "rebase --onto ONTO BASE BRANCH", which replays
>>>> commits BASE..BRANCH on top of ONTO and then points BRANCH at the
>>>> result), not the top of the range or the branch these commits are
>>>> taken from.
>>> ...
> Now I really don’t know how to call this function.
> checkout_top_of_range(), perhaps?

If this is a straight rewrite of setup_reflog_action, i.e. the
division of labor between its caller and this function is such that
the caller blindly calls it without even checking if it got the
optional "branch to be rebased" argument and this function is
responsible to decide if the preparatory checkout of the named
branch is necessary, then any name that does not even hint that
checkout is done conditionally would not work well.

How about callilng it "prepare_branch_to_be_rebased()"?  This
function, at least the original setup_reflog_action, responds to

	git rebase [--onto ONTO] UPSTREAM

by doing nothing (i.e. the result of preparation is to do nothing
because we are rebasing the commits between UPSTREAM and currently
checked out state on top of ONTO, or UPSTREAM if ONTO is not
given) and it responds to

	git rebase [--onto ONTO] UPSTREAM BRANCH

by checking out BRANCH (most importantly, when given a concrete
branch name, it checks the branch out, and does not detach at the
commit at the tip of the branch), because that is the first
preparatory step to rebase the BRANCH.


