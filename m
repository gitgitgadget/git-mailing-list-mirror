Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E741F597
	for <e@80x24.org>; Thu, 26 Jul 2018 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbeGZTL1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 15:11:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35389 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbeGZTL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 15:11:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so2902929wmc.0
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MNp3LnXW2w0U4g2jiPaGIjfnaIVsYkDZU82kei93VoM=;
        b=bbbKkVdHTXUE6sw0KO+2vy9CRUYjptjUxL1LMd883iVSFshcILiJfjRy8fPKEZHa6H
         yS22hRPyLkhUNWE3nG8p4Oq/Jw90xRBQWpV4ZrEzcVQcbb4HE36pJD4tmWCJZst6pLGJ
         txeVl7uzAvaUp7CF9Twlo+uR6gAIRh/6TWnVUGQMoqk5Dg3IuGrDWfGgIdn4IAxbW/on
         SN1CadQ67OroFn3mqdDIrmnc67tIfgCQer2qV/vRHzqHvcpa7QtRjhxs6xOz3Y8caa+G
         Nn0qU9CuZHrfHJR/Juod/cAx9WIToeSf42Ss/id09L/+39Fs7U7yO776rzSy3HiVswTG
         HbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MNp3LnXW2w0U4g2jiPaGIjfnaIVsYkDZU82kei93VoM=;
        b=kgAUBNb2hfGxrdhu3AgZUYrK6MXjUEkD2E0y78f/YxRIZzjxlhXFt8v28IqtNCAozI
         qbWjYvi74YQLvjdY+reXZM9xeaRHBfxrgzFdQWoueJQw6rPJetCgJFzpG/XJb40aLVTu
         84AJYfsCSRTVQnPI4Tllyzk3My0TR9Yc0MZg0MngBsVpjZ259RccXqzfCV1fu9dXu1Uy
         dQ3BW8P3/MzalST2P7jynhFNb36gqZjlAOMxO9eT/kFy62SofS288Jr7yD3hsyi+OzJh
         vf3BLZQMrRrM24bQdW39+A2rfHc9qlvstTpJ5/5fVZojd2lYRECqFchtNc/r9hxfXtaf
         w4vA==
X-Gm-Message-State: AOUpUlEEIanSUCvhnvm1C85pSJlbBPMfFMrLNCevItcT4Kfb26dWtjgF
        O3ri6CQyhrzKaQf2Cze/gcc=
X-Google-Smtp-Source: AAOMgpeOMQLcxIMFzt9xrGbSVE0ZcwsqYZFYCcB9S80F4fW0nBLk2ynWYqZIsHZhKzXEY1eQL2WYWg==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr2321802wmd.44.1532627612142;
        Thu, 26 Jul 2018 10:53:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b2-v6sm2763947wmh.20.2018.07.26.10.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 10:53:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Akinori MUSHA <knu@iDaemons.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
        <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
        <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
        <xmqq7elslayl.fsf@gitster-ct.c.googlers.com>
        <9ecdf160-bc8b-b91d-a70e-ca6fb9d2a756@talktalk.net>
        <nycvar.QRO.7.76.6.1807261434550.71@tvgsbejvaqbjf.bet>
Date:   Thu, 26 Jul 2018 10:53:31 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807261434550.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 26 Jul 2018 14:39:18 +0200 (DST)")
Message-ID: <xmqq7elhrihw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> You're right, I'm not sure how I missed the calls to sq_quote_buf()
>> yesterday, sharing the am code with the sequencer would clean things up
>> nicely.
>
> No, actually Phillip was right. The `author-script` file written by
> `git-am` was always an implementation detail, and as there was no
> (intended) way to call shell scripts while running `git-am`, the only
> shell script to intentionally use `author-script` was `git-am` itself.

Well the thing is that you did not write "am".  When I wrote "am", I
did so with a deliberate design decision to keep the author-script
in the same format so that it can be read by shell.

You are behaving as if you made a silent decision to improve the
author-script by designing a better micro-format that deviates from
what shells read by doubling the backslash quoting and losing the
single quote at the end of the line for only the last one, and your
justification is that it does not matter how broken the new
micro-format is because it is an implementation detail nobody should
care.  And worse yet, you did that improvement without telling
anybody else why the new format is better.

That's just silly.

Just like everybody else, you are sometimes wrong and you sometimes
make mistakes.  The rest of time you are not wrong and your design
decisions are not mistaken, but trying to defend an obvious mistake
like this one with silly excuses is an easy way to lose credibility.

