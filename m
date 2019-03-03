Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77894202AA
	for <e@80x24.org>; Sun,  3 Mar 2019 01:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCCBdd (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:33:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36150 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCCBdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:33:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so1473920wmj.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hiSWmJFghSdHY4ILM8ZJSwDLRYTTwKWDU+qWL9tWoRo=;
        b=pa5VF5AaoJsI3eIt94MARdDOptqQXQ71WWxkRuflrnZICywswtwfT96CyyLeukovNX
         Q+2ZJWgGiK5/G6etdB7k1vZK9TNGZwAbMagPypyw3lMqjbq/OAy5TRDV4wFB5R7Q5Itj
         b9W1uEM9VxnjJx3lNgMKWdEwniFIFNTAN9oRLjftq90gTT6L9cL7ip5v3TSMyVzpSG0+
         /YnI5tsC4XPfYXSi1iiP1stKOwStolvdlkyb/w2iRT7l4XMZ1KLE2gg+EQNSbbrog9CI
         5X0D0rs/VGVt56BjDMMzk1XSDU6tHiaWVM5Pqls8Nq/7jbNzMbfT67XC/Psb0qnOkQWY
         42BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hiSWmJFghSdHY4ILM8ZJSwDLRYTTwKWDU+qWL9tWoRo=;
        b=GAp3uO9/4yYV2kCwhkuZVc5Ftvl4XsWuNFzKh1L2ikZEGvdNusKShoJREMyEsXOptX
         s7fxXH71ZDsHUb8CP97RMmkkUAcDfpklnyjuFVmyNMoQXdVd4E3o1Ji2Kqp0xB1ALJSb
         MW4pMRp3FXhuidUUhBZ2Z8fJTLnXg+MfLZkvRJm22YOU/pMyqV3kTqXKQX9/RMhkBqdO
         mC41wbhpdLbOK4wKAOxAIwCkCbnA4Z/Vu+xZ9WxkKa+U1u3sFv57iQyg1OqCa3uM9efL
         DLyx9cXT2ZdkTUx1tH9GnVR89Q/0WjW97K47Ys2RZmpCwMGxJP/CwACxwYxmBMLuguVC
         qXFg==
X-Gm-Message-State: AHQUAubk2fklrCzgzAVT9wMJjwYVLq1vnBfboiJvWR09j8Va1WrWHJvQ
        KQmOuyxmr0/gfe79UflG4WU=
X-Google-Smtp-Source: AHgI3IbQrvo5ZgD3r8uyDXMlacG8gKgjcQfpeuqUxiLei7vImYpb+ZiNSwkmAQD85gS5JQkbiXL3OA==
X-Received: by 2002:a1c:eb19:: with SMTP id j25mr6848463wmh.123.1551576810661;
        Sat, 02 Mar 2019 17:33:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j41sm9083855wre.9.2019.03.02.17.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:33:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit that moves fewer files
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
        <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
        <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
        <20190227164056.GA2062@sigill.intra.peff.net>
        <CABPp-BGOqQ0P8ywCK_sybPOeASxPnkTq7NXW8678f=345=68-Q@mail.gmail.com>
        <xmqq7edj9uh2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFdbC2Shq8BrP=Ht21ZbjvEZVL_uQC0=3_YwbLJVbBU+g@mail.gmail.com>
Date:   Sun, 03 Mar 2019 10:33:29 +0900
In-Reply-To: <CABPp-BFdbC2Shq8BrP=Ht21ZbjvEZVL_uQC0=3_YwbLJVbBU+g@mail.gmail.com>
        (Elijah Newren's message of "Sat, 2 Mar 2019 15:48:17 -0800")
Message-ID: <xmqqimx03fo6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Whatever we choose for the default could be tweaked by some new option
> (e.g. make it less noisy or don't mark such paths as conflicted if the
> user has explicitly stated their preference for or against directory
> rename detection).  I'm struggling to see directory rename detection
> as "risky" (though I certainly feel that lack of it is and thus do not
> like the opt-in option), but if others feel there is risk here,

I do not think it matters what "others feel" at all.

The simple fact that we are seeing a bug report that started this
thread is enough to say that the heuristics kick in when the end
users do not expect to and when it happens it is harder to explain
than other kinds of rename detection heuristics.

