Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F4D1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGRRj5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:39:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38646 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeGRRj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:39:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so3590711wmf.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cwEg+xZ1/CEesGUFE3CTAoaca8QjzaS1HZG30z3TqHc=;
        b=cwdDbCPZJYA8qegnYahP8ZvPyLLp4piJO4GUzKN1aGQ6VrpPB17/jje8mTFMHiowbt
         4G9d89N6aOzfnZXDqh+b0jnbwSMzGAOvvhwC4c+eaiMfX5IW5jno8anaXyowkA6t2ZVb
         gXs1nhK55fMP1bBgCMU2wrfCA8Ow2kn6qxnpuvOEN6K0+kG+wbzTYTBKqlI+uzMoSUD9
         wBK7Cev+16Vwj+X0Q1kHUscpsRbB6jqneSztfGe7kuUGVcs40062ddMmHxKTDI8wJlNL
         n4PXIAll5jYz2lJ7hyOo9u9Cfkk7sMfQ7sL41bBqeFeIyVd2k+0LfpVgC9LsLTYBLd1N
         Etqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cwEg+xZ1/CEesGUFE3CTAoaca8QjzaS1HZG30z3TqHc=;
        b=G58mbCwn21fKnxf8izS77ql/UXZ7sbQR9sSFvKGmCJuYj+yaEzIvH+KCsP2V1R2F4u
         Gt8Dej+I77A9baZPuFaIWeH1EphOpEjE33CKUTR2NClHxVE4hk5FRFgiYYuzLfO2brgy
         7UpuGskE8/3+dxPoPWW06vE3MI23+5Mvn8z3wWLoqi39aMRMQtSKmshPRJG8UnrQPSSc
         0dzfcQmdK3vKOgb3nrFLilfwyjSqbqajtsm6VatE6yV6LxJ1GhIaq/r6JMV4kr2Kxjba
         d8KhcjDXs41R4wZ7es+3Yfhc3m3arXf3tA2OT83JjVO0Y9UXik01JQ7XopilyuOXs620
         xzug==
X-Gm-Message-State: AOUpUlEGZNPWRJIjHmW4QxudiJCFWBDxjajyzbCd6mUlhDQY4jPRoJ9z
        eWuqvkJnV43GHUIK3VnpP8U=
X-Google-Smtp-Source: AAOMgpe8VU16ysxefJtQosISjWCgSLy+dzQVYnvvh4WcnXPgFJ2jAIh4odlaL7x7afyYkiE/RgpFbA==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr2218461wme.70.1531933267136;
        Wed, 18 Jul 2018 10:01:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f20-v6sm6206299wrh.89.2018.07.18.10.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:01:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
References: <pull.10.git.gitgitgadget@gmail.com>
        <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
        <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
        <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
        <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com>
        <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet>
        <CACsJy8AbT3=wzKecGqvj8ibHmquU=NfP872f1cAM-VFOLSLSGQ@mail.gmail.com>
Date:   Wed, 18 Jul 2018 10:01:05 -0700
In-Reply-To: <CACsJy8AbT3=wzKecGqvj8ibHmquU=NfP872f1cAM-VFOLSLSGQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 18 Jul 2018 17:01:52 +0200")
Message-ID: <xmqqfu0glbqm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> In other words: if you see something that you don't like about
>> GitGitGadget, get your butts off the ground and contribute a fix.
>
> Thank you for the frank words. I will choose to not review any mails
> coming from GitGitGadget.

I wouldn't say I will choose not to, but certainly I noticed that
I'd backburner reading a series that are way out of order in my
mailbox, no matter who authored them or how they were sent out, as
they consume way more concentration-point out of my mind than they
are often worth X-<.  While there are easier-to-read and more nicely
organized patch series, I'd deal with them first, consciously or
not.

No, fixing a tool that throws such a harder-to-read patch series in
reader's mailbox is *not* something I'd spend my primary focus on,
especially when many contributors are perfectly capable of sending
reasonably formatted series without using such a tool under
development.

That won't stop those who want to improve the tool.  But I'd wish
those who want to make Git better spend their time on making Git,
over making GitGitGadget, better.

