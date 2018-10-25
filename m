Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22791F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJYRMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:12:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36626 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJYRMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:12:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so617069wmf.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tPnNSmf2RLTDTcIBGMArFgASxPeJCSQN/lDJui/3mVY=;
        b=r27XBx7CvshS5Jvl6pG6CqGG9EvchI8IMDsvFV3gaPAoeYJWNQm17ZJhMCa/wpbYDp
         LHc8TFYWu4BC9+sid4bUwfUQA9TT2JpEQ1KyKzG+nBjnrZ6oSrMMe2XlB8sGhvef7vB9
         YzpdzpiYMaN4UtwlsDJCyuXs2TY9P6esJRUitk1s4SjNNJs3pWA9orauvn9/DuO2KHjx
         jxTHihho7qtDqJ8lhIih6sZQ2mTBjqkZ4URBE7brgFuyw7IGJuRyoIEGeEmhINPkB0wu
         Gyrl1OfJxlwNKod3/rwxLAE4figbe+BzsZs8sCqSMTRFLSPgiaTedf7md1iK1z1OnxRt
         Pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tPnNSmf2RLTDTcIBGMArFgASxPeJCSQN/lDJui/3mVY=;
        b=AVARjU/Fqu401SBhM+tgOvd77OQ2VOSgG1pMarxaWnzCkyl9DlBQA62noj264DpzF0
         avMkW/x1xAhSvqEKft1yl+lA48MkEihwe3hK6ZeLXFO81oJKyCmzgyKbcmQJrs7ajduu
         LobDgg63f9PrTXmayNyJRMOCbiZYwFe/UFnJ4lM5/gAkibb36ZYPmcaBKdZRW72wgvu9
         1mHz7rLofZIP60tI1Z4Zm+BJ7jFGtAUO73BqQOeOxWKlx2G4erUGZNNPx4kcp0GdrzhC
         y6+Nwi/MPQ7Tn1eKZ0z4tOZeTF/1C71zxeqSCcjJkTi/5cfH3e4TOJ4xdNKGEgBpg/kG
         xlig==
X-Gm-Message-State: AGRZ1gJu+8RFBt3WkTSq4e3JWiXUX23CP7nK7bYLfsaxcK5HQ+5png9s
        CuXvC5szArwFcyAAe5dgXzo=
X-Google-Smtp-Source: AJdET5eWwfqkLMn5x5ABhPWGH9t3X077+qNwd3hKFNC3wQp7HG+2xJQ1oDtPlZNtOBT1wMl5IJUjzg==
X-Received: by 2002:a1c:3c82:: with SMTP id j124-v6mr128983wma.62.1540456849269;
        Thu, 25 Oct 2018 01:40:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c2-v6sm5076233wrt.77.2018.10.25.01.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:40:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/10] Make submodules work if .gitmodules is not checked out
References: <20181005130601.15879-1-ao2@ao2.it>
Date:   Thu, 25 Oct 2018 17:40:47 +0900
In-Reply-To: <20181005130601.15879-1-ao2@ao2.it> (Antonio Ospite's message of
        "Fri, 5 Oct 2018 15:05:51 +0200")
Message-ID: <xmqqd0ryiflc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> this series teaches git to try and read the .gitmodules file from the
> index (:.gitmodules) or from the current branch (HEAD:.gitmodules) when
> the file is not readily available in the working tree.

What you said in [*1*] the discussion on [09/10] sounded like you
are preparing an update of the series, so the topic is marked as
"Expecting a reroll" in the recent "What's cooking" report.  At
least one topic now depends on the enhancement this topic makes, so
I'd like to know what the current status and ETA of the reroll would
be, in order to sort-of act as a traffic cop.

Your answer could even be "I have been too busy, and I do not think
an update will come for some time"---in other words, I do not mean
to tell you to drop other things and work on this instead.

If you are too busy, I can even see if other stakeholders
(e.g. Stefan, whose topic now depends on this series) can take it
over and update it after re-reading the discussion on the latest
round.

Thanks.


[Reference]

*1* http://public-inbox.org/git/20181010205645.e1529eff9099805029b1d6ef@ao2.it/
