Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3971F453
	for <e@80x24.org>; Tue, 30 Oct 2018 09:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeJ3R46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 13:56:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJ3R46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 13:56:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so11648676wrs.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nBBv20z+nMJuzBc5YOnoXa/AhWD60bayGiXcSWKAR5I=;
        b=SgZSzKmFBy37DZtxp/GO7nXcCdUss5Kan04cSWqEoybGdr7XSazgSz0FsF95MCa/xp
         iHRPYJ29edlNkMK5fQMGAYJnPGX9sr+CmeZO8ShHIcjfo8OcbkltYYHalT94zTGbQIfC
         Rlz10RicCvlG/RNiiNn5nVP09s5zWls7X80NRAMMf24/osCy7HQotMgrforHgDSbCkdC
         +gurR+iE6grxjIZeMT8OcHxMH3ZzfBUremqeWKLedqguSC1o+WcZ3YuC8lk2KR9YVlLh
         xQ7QhHdvpbhFhrUxnTci4B/lawXiXgarpVO0RmA3dLFEtIhYooLvoF7xSnDq0kLoq8p6
         gVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nBBv20z+nMJuzBc5YOnoXa/AhWD60bayGiXcSWKAR5I=;
        b=QJ61g73FCpQT909J0oJsff/fYzjsqVdo65iOK/MqFei6GkJ1Nd6VzomAt/db6VfS3Z
         HL5PZzpo6vYNz2Rvd+rfjLe/sofwo+aBAgJmRCewFKMoDWbCgtrsuGchYvKA8BNTPdg0
         dILScwGVk1xhMs343ZIPCpiBchXq9KmmySS97GSXfb9Mt3GH+a5UsIIkom8qoAvCDuYl
         klBROeA/S37rTdRAcSeR2RN8mZiPk3s/iRCrURzJBVhXYnHSfk2ny3BwF3DuOZHKhWNO
         a5rJZ3C+EnbLhJO7lE4GL4knShTd7MxS8sjEtj49xrDRM5uv6hZq29Lhykqwtzcl8bAh
         1pZA==
X-Gm-Message-State: AGRZ1gJu7W9H2GBeXBk9lqKyQVP4ygEGH/eGdncETTooElzmo/0dIXRx
        98kiyWCFawFJoHnd9kLWKkk=
X-Google-Smtp-Source: AJdET5ek1byGJZpTszJrdZc0ZU508g7zCS6HL6aZpP/258Ww2xd7uiD1SUJwHgC0m92XSWAyvrd8QA==
X-Received: by 2002:adf:e388:: with SMTP id e8-v6mr501697wrm.321.1540890262368;
        Tue, 30 Oct 2018 02:04:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 74-v6sm16436236wmi.23.2018.10.30.02.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:04:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Petr Baudis" <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] index-pack: optionally turn off SHA-1 collision checking
References: <87lg6jljmf.fsf@evledraar.gmail.com>
        <20181028225023.26427-1-avarab@gmail.com>
        <20181030024925.GC8325@amazon.com>
Date:   Tue, 30 Oct 2018 18:04:17 +0900
In-Reply-To: <20181030024925.GC8325@amazon.com> (Geert Jansen's message of
        "Tue, 30 Oct 2018 02:49:26 +0000")
Message-ID: <xmqqefc724by.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Geert Jansen <gerardu@amazon.com> writes:

> Maybe a better option would be to check for the non-existence of the [00-ff]
> directories under .git/objects.

Please do not do this; I expect many people do this before they
leave work, just like I do:

	$ git repack -a -d -f --window=$largs --depth=$small
	$ git prune

which would typically leave only info/ and pack/ subdirectories
under .git/objects/ directory.
