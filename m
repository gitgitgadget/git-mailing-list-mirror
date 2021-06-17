Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693BC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E1061405
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhFQPOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhFQPO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 11:14:29 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F767C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:12:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso6439072otu.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xQ2nT9M4gS3BXXTv22rNh7A9HTsCIxzAC8zMK9CGyHI=;
        b=mmiOcOw2q2zjONTNQ6a0tZ+np4phB9RyRc9kNxdGT0WhOZDaG7tCrN99gwGqfQmjkr
         TtlUQGtNLnwcs6FnckAwcKoCzQ9zf9kjv4yEY3QERQ5Z1Vvx3rD7LJpQq81r0lq5wj6J
         eTIWCwaL8vgmYESflbQsomhBkZA8A7y+SG8kScr2sKMYL+pW3GjidMNzeNUKoVQSsOI1
         ptA/673W2ePkNcpXN+sTdId6sfGks3uvFyXBsElyJNwoIx3OtrDut+sPYZJlnwQ6t4Gy
         UC34NEOsLJcvH8doNH9sh20+eHmw61ndodzxpK/ZF80kQMhm5nIIxI2kQngEIavC0vVW
         Lc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xQ2nT9M4gS3BXXTv22rNh7A9HTsCIxzAC8zMK9CGyHI=;
        b=SVjoiFeg2aZTP2iaML0gsP/abPmyzshJ9+oQpWhb7G5cPoMa2QdZq3/VZ5mY7iu2Cu
         dSdlgepAx5ErQ3yuY1IJ3oN2x9jsQncIifHZHuAK8RMdrhy5ZT5Dvj9etJ+sNwWXXh3F
         ScnGKoxuou9g2jK8Aijbfr2nxz/njWTpP6JNO/vCsA8GCpHFqEHGxcblH+slybJFx+mZ
         Pfkzi2PL9S79BfQiy9ASe1OiAklqy2JYWifMoYd23/sXBTFVmRUBsAspKsatPDF3Mta1
         LGfWKLj0vkls6F3cSFsYwe88Hfn3JCNGgjks6gv6gFU613DUl1uUOGwAY5u+Pz6J+WTg
         JeDA==
X-Gm-Message-State: AOAM532Y8f0OMxo0Wx73xFNruCRw200ZI9Z4+VB0xe7VaeFhEqoYuM0C
        5e2FCHMvPo/CKr3oF/XX+TE=
X-Google-Smtp-Source: ABdhPJwVSUy7nSq1AxR+uzQ0V8kKID0JqsztqzhLL3KpOwd5owoUe0zQZ7O7DEJMIN7JL3I0AgLWww==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr5049620otq.292.1623942739367;
        Thu, 17 Jun 2021 08:12:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b22sm1192474oov.31.2021.06.17.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:12:18 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:12:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60cb664c7a493_13057208fd@natae.notmuch>
In-Reply-To: <xmqqbl86qtyf.fsf@gitster.g>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> -  - Removing the example person might make the sentence more
> -    clear and efficient.  Instead of saying "The programmer
> -    chooses between X and Y as she sees fit", it is clearer to
> -    say "Valid choices are X and Y".
> -
> -  - If you need to talk about an example person, then try using
> -    second-person to allow the reader to be that example.  For
> -    example, "If you want X to happen, you'd pass option Y",
> -    instead of "If the user wants X to happen, she'd ...").
> -    Alternatively, replace the single example with more than one
> -    person and use plural "they", such as "Interested readers
> -    can read 'git log -p README' to learn the history in their
> -    ample spare time" instead of "an interested reader" learning
> -    in "his" spare time).
> -
> -  - If you absolutely need to refer to an example person that is
> -    third-person singluar, you may resort to "singular they" (e.g.
> -    "A contributor asks their upstream to pull from them").

Here is another escape hatch recommended by linguists before attempting
to use singular "they":

 - Use a generic alternative and count on the reader's common sense.
   Instead of saying "she made a mistake", say "a mistake was made".

> -    Note
> -    that this sounds ungrammatical and unnatural to those who
> -    learned English as a second language in some parts of the
> -    world, so should be avoided unless the earlier techniques
> -    fail to improve the sentence.

For the nth time, it's not just foreign speakers:

https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they

> +  - Prefer succinctness and matter-of-factly describing functionality
> +    in the abstract.  E.g.
> +
> +     --short:: Emit output in the short-format.
> +
> +    and avoid something like these overly verbose alternatives:
> +
> +     --short:: Use this to emit output in the short-format.
> +     --short:: You can use this to get output in the short-format.
> +     --short:: A user who prefers shorter output could....
> +     --short:: Should a person and/or program want shorter output, he
> +               she/they/it can...
> +
> +    This practice often eliminates the need to involve human actors in
> +    your description, but it is a good practice regardless of the
> +    avoidance of gendered pronouns.
> +
> +  - When it becomes awkward to stick to this style, prefer "you" when
> +    addressing the the hypothetical user, and possibly "we" when
> +    discussing how the program might react to the user.  E.g.
> +
> +      You can use this option instead of --xyz, but we might remove
> +      support for it in future versions.
> +
> +    while keeping in mind that you can probably be less verbose, e.g.
> +
> +      Use this instead of --xyz. This option might be removed in future
> +      versions.
> +
> +  - If you still need to refer to an example person that is
> +    third-person singular, you may resort to "singular they" to avoid
> +    "he/she/him/her", e.g.
> +
> +      A contributor asks their upstream to pull from them.
> +
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the world.

These look OK to me, but I wonder why we have writing tips in *coding*
guidelines.

We are not writing a style manual, there's plenty of other tips writers
of documentation, commit messages and comments could use, why are we
only giving tips for gender pronouns?

Why don't we have a section on passive vs. active voice? How about
avoiding zombie nouns? Adjectives and adverbs? That vs. which? Who and
whom?

I don't think there's much value in trying to codify what is a good
sense of style while writing just for one particular non-issue.

Cheers.

-- 
Felipe Contreras
