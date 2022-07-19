Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C49C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 09:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiGSJSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiGSJSM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0927B30
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 02:18:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so14626387ejc.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Q+NA3phPyewrrTXNTo6H+sI4p8BOf5MClE/v0NDykhY=;
        b=ZgraV9LkY0uknWH7NmixMg2sCMdf7G1iTPEH39RJaH4yHbYXnQfZotcZMnb7p8hUhE
         e+03MFG0HgEcC/OGQCY7maVNoBpsgqEaygsPqXq8Ke/DwoBC7udAVcyJbQDzRiO71JOQ
         SS0mYr3az7etegKrAnM1bnb9flt/xGcuiF1wtJFWdb3eKjtfDGRLvx4uMdaZcPwX4WRZ
         6ew9asTDcJDs904H6/Z0jpL2wDSjfRxsOAobEd9GXrkGXxxAMdZhXtjkpNUJjmXFNcO7
         M7hqqtumza5AUKN3R4RC+ssROLFg/OazWKMI6icK0GbZC22QQ/hI1bjo9FvuQ3x6KcTR
         +DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Q+NA3phPyewrrTXNTo6H+sI4p8BOf5MClE/v0NDykhY=;
        b=nOPzFZ/yFhBP+vq6uoEbeZxCtbkT2IH87DnRbg9sqDMP/KMl/2haHTBFL4wAw0P0ot
         7ysY6y1+tvbk8T61uIvYeEsgZ8Qh0J5INSwqqwADMHT2D3ZzDFKm9k7yJdRKQYKo5k7O
         Jevba6B63PLe5Ksml7LvQJZDMbRKODZqIwkScOtzDTn09r9ocSIuoNlX/IUzr9OW5CEh
         L/EqKQJmuenNkom7A6ek5M/GJs9FKedLGxfOriMihsfr7lPLmVxQm3QvWqJjpAiPwmPh
         vI10y96TuM4Kwv1vgMw/AGYk6l9SCH9olGzd0N4CuWvIawwaU5GLvjk4F43iuTgsnMmp
         w3Vg==
X-Gm-Message-State: AJIora/iLUmQauAlmaU3tf/8z9HBKEWP77zPV6vSf7FKItW7vwz4kY2U
        2ATNm4pJqZMNZffdDtm45A6yLEKjiZogXw==
X-Google-Smtp-Source: AGRyM1slHwcAbeJt2mjbMqlhjEy0/nkhR2kv/MkQBwbKDGnX4ukSXTNOyxmTcjmTeOxt6WItsVbvpQ==
X-Received: by 2002:a17:907:b17:b0:72a:edb8:7529 with SMTP id h23-20020a1709070b1700b0072aedb87529mr28486511ejl.749.1658222289378;
        Tue, 19 Jul 2022 02:18:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b007052b183d51sm6430015ejd.132.2022.07.19.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:18:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDjMl-003Xxc-4I;
        Tue, 19 Jul 2022 11:18:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-repack doc: remove discussion of ancient caveat
Date:   Tue, 19 Jul 2022 11:07:29 +0200
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
 <xmqqsfn21fmt.fsf@gitster.g> <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
 <xmqq1qujt334.fsf@gitster.g> <220718.86tu7eyhvz.gmgdl@evledraar.gmail.com>
 <xmqqk089ewbx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqk089ewbx.fsf@gitster.g>
Message-ID: <220719.8635exwje8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Which I may have misread, but I understood as going beyond suggesting
>> that we cover #2 over (or in addition to) #1, and into speculation that
>> the change being suggested here was suspect because I hadn't carried out
>> a "solid study of history".
>
> OK, so there was a study of history, but the resulting commit did
> not interpret and reflect what's significant in the history
> correctly.  Sorry for mischaracterizing your mistake.
>
> Lets put it this way.  Here is a statement:
>
>     Since 1.6.0, people started to need to worry more about
>     compatibility with 1.4.4 and older.
>
> Now that statement, while it may be still correct, is irrelevant.
> Why?
>
> Even if there were tons of people who still use 1.6.0 (or 1.5.3 for
> that matter, which happens to be one of my favorite releases in the
> era), as long as nobody uses 1.4.4 or older, we can safely remove
> such a statement from our end-user facing documentation set.  Some
> archaeologists in us may care, but it is irrelevant to the general
> public, as long as 1.4.4 or older have died out.  "As continued use
> of 1.4.4 by people stopped being an issue long time ago, remove the
> warning about interoperability" is the only thing we need to say
> about this change.  We can add "that we needed to add in 1.6.0 era"
> at the end but that is already too verbose.
>
> Please do not be one of those folks we had to deal with in the past
> who for whatever reason cannot admit that they were wrong.

I won't, and I think on the subject of documentation & commit messages
you (as in me, in this case) have already lost the "argument" if you're
having to explain what was meant by the text, which clearly should be
self-contained enough to resolve any such ambiguities by itself.

I was just replying to clarify what I was trying to go for in the v1,
which in my mind isn't an argument *for* that version, but just an
explanation. I.e. sometimes the solution is to more clearly phrase what
I was going for, and sometimes it's to take another approach entirely.

In in case, I we may have crossed in E-Mails, here's a re-rolled v2:

    https://lore.kernel.org/git/patch-v2-1.1-98b6de56019-20220719T000847Z-a=
varab@gmail.com/

I tried to make the dates & versions involved clear, and also to work in
your preference for v2.0.0 (or possibly later) as a cut-off.

It may not at all be what you had in mind, or maybe you're willing to
queue it as-is, just let me know & I'll adjust it.

Thanks a lot for the review, and sorry about the misunderstanding.
