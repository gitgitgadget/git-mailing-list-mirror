Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9721F453
	for <e@80x24.org>; Mon, 29 Oct 2018 02:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeJ2LOu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 07:14:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39673 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeJ2LOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 07:14:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so6410277wmd.4
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mCO+BFQoSkEHV8P/y9gqbsoa+x+rcNYgr1N7i92iAPs=;
        b=riOh8Couk8PhNco6W1CqOEiN8+Jf6ZUinAIH7ZwVBPsnL84dK331IA/72i/uIM5eWU
         /jYxhAkZOImplQ0KIZ7Hxyhmalb+CKDdtEcRUh9NQVF8CbWe5YJJ0beHjTc/CLGYOZ72
         HXifh6ooI6CvdQWl/dxcTcklGAYwJj4LH8+7+/+citTrbGLjatkgfWeABRJ8Es9oqYjk
         Jm7cbu6VCTpFp3BtIqlNpm/vKvBSPpOKEcbfDDPM6+5onXDOtq4/p4pQUsHhdgAIoCYp
         yzHPsJVE1g4yChqyaR/pO6SNSZNDdUok5nf0CILMoTQ/GjAdY7+B0CHSsiuXqz5O8NKR
         oWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mCO+BFQoSkEHV8P/y9gqbsoa+x+rcNYgr1N7i92iAPs=;
        b=QJOvmoxKojmgBLTCsSqNzCVD8wJGSXP02+xQhy8jhMShPjzquu+R59ruy/aH/nd9Qj
         +wHpQ2F7kzm91v7Pm99Fz8he1xzQxz4FPfBsGOdRac1pKRptu6ZltRbYs7fSG0Bpmr+p
         RaXo14tIeTOGxBKVE0//mTHfEpWJnz76IOL7LPX0EdkEZ2ramrNYk8J7Krm1MVgWSjg/
         rrviZ9ZRRMnEFDc5N5DwfkI8YiJNC6n9U8aWcUJBxjja6SdZLEjkGg6e47As26PC+N2P
         xoD9BOOWyTZUbqrbOn/4qYyiJ+fAZsRZyVAvWzZRpDVkWrUL5O2pt+7pjqqKpl15pYen
         H9Mg==
X-Gm-Message-State: AGRZ1gK7/lB1uwFlpXEJrPGGCx4gIXwQaNCyVRm6tN2MooC6qOVesFk6
        XMicvBAqLZPJpCmQqhzXsNA=
X-Google-Smtp-Source: AJdET5ciPplUjfeU//0O4/5kWseqpAgmkkZaMtphlluLNB36NRGVBqDxIPrQq4oMNG5uttPfxcgfww==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr12469667wme.12.1540780091487;
        Sun, 28 Oct 2018 19:28:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x17-v6sm13714059wrs.84.2018.10.28.19.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 19:28:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        dana geier <dana@dana.is>
Subject: Re: [PATCH] wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
        <20181027084823.23382-1-pclouds@gmail.com>
        <20181028062533.GA15061@tor.lan>
        <CACsJy8BoWmWaVpXnSL8Stm_2XDnKfXSaj2i0UwZg7aEgYF9i4w@mail.gmail.com>
Date:   Mon, 29 Oct 2018 11:28:09 +0900
In-Reply-To: <CACsJy8BoWmWaVpXnSL8Stm_2XDnKfXSaj2i0UwZg7aEgYF9i4w@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 28 Oct 2018 07:35:38 +0100")
Message-ID: <xmqqin1l8p1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Nice analyzes.
>> I have one question here:
>> If the user specifies '**' and nothing is found,
>> would it be better to die() with a useful message
>> instead of silently correcting it ?
>
> Consider the main use case of wildmatch, .gitignore patterns, dying
> would be really bad because it can affect a lot of commands....

If the user gives 'foo*' and nothing is found, we may say "no match"
and some codepaths that uses wildmatch API may die.  And in such place,
when the user gives '**' and nothing is found, we should do the same
in the same codepath.  In either case, the implementation of wildmatch
API is not the place to call a die(), I think.

And yes, treating an unanchored "**" as if there is just a "*" followed
by another '*" makes good sense.

Thanks, both.
