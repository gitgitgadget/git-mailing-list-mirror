Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3706C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72EF613BA
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhFRQOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhFRQOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 12:14:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC786C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:12:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s23so11066804oiw.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=iojyTJKxb3umHni2QCrW0Sj3K0qYm1TU2fa6FVBJDtE=;
        b=KVfd53Qv8S+NAGwp2DLILuIGJRQ2oFMyHzOMgq1SubykLKNDQ8SAEa4iGVikit8JB1
         QDHR3B6f6KOfxh0T9+WQ+dKzwRXs/Z/VyeZkqIdd/xBT3+6Oy8XERERxwujXIfaF7GN9
         mnN6VsfKeUq0jgFrUNwAPZR/wcf4gSCeNE0ZbZyEKJtQD+28eWWImpJawBG7rYOq66sP
         rSGyf3MBcfrYqj9yRomeUQGlW4jvE4D44iO6AqlQP4yAIHAxAV7g4nAerEOT8dS1PwxO
         HLcA7AsmJe3kOLFfao8/hcDKHyCC/xfBjPwMGB3qJpiRho2U7JrlQXYDY9J9RzQ7VsY4
         PBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=iojyTJKxb3umHni2QCrW0Sj3K0qYm1TU2fa6FVBJDtE=;
        b=jhtXzf/zZhzzfGinTZ35YefHn1+/iJEhg7XTFpfKEsmzDO1dvJ0BjCG0v0flsTpmkD
         t/DL9+KYC9Wq38mP2ZuhokRBG8lMicsWz8ft/36ota1CX/jMEWxuKAJmKlOoTPo2QbKX
         vk/NuuqmcAXYPpntsBhtcE0CigP+FUa9gH4eGxTboetFP6oNYxLy/GB3rWJ/EBwyrKFn
         B7c9g8NIMz6/BrFh44oS0YtIYlhIxsmYOfnUaSMg7ywaP/jxXK5Tsp84E4i0iptjnb2X
         iHIqzSCC6ef2b2KSUaX+7Z/BdnuplHl0tkxk13txPbr5FLssMaSSEpTvuz0waFlM40KB
         G1bA==
X-Gm-Message-State: AOAM532n/WbKqhF5n+D3kckKoZoD4BcRi0yuQimw6rmUcboA+gHhaNcx
        diGProyTFCYCkk9lUchsfZ8=
X-Google-Smtp-Source: ABdhPJwm115+5jla8lCf3kYdEXkACP54+lgsDut1gE2K9nDuto8NSHAo4RTc5A40jKJ9UbedfDGafA==
X-Received: by 2002:aca:654c:: with SMTP id j12mr15068834oiw.45.1624032742284;
        Fri, 18 Jun 2021 09:12:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r12sm1104256otc.38.2021.06.18.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:12:21 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:12:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
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
Message-ID: <60ccc5e45e720_5eaa220892@natae.notmuch>
In-Reply-To: <YMvoNcFXnHo0KXH3@camp.crustytoothpaste.net>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
 <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
 <YMvoNcFXnHo0KXH3@camp.crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> And, judging by the amount of discussion around this topic, it would be
> helpful to avoid rehashing the same discussion again and again.  I
> certainly would prefer to not have this discussion multiple times.

I'm sure plenty of people would prefer not to have a discussion about
abortion multiple times either, but that's the nature of living in a
society.

There will always be differing opinions, and as long you are trying to
impose your opinion on others, there will be discussion.

-- 
Felipe Contreras
