Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C3C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE02260724
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhIKKIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKIw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 06:08:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7E9C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:07:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jg16so9550775ejc.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=41fH0wK9Dy9f2lhVtNZteP/lyZ4xt7hVs9iQcCVAF+k=;
        b=bxF0Tbc9R2Y80HvHJMEoGADyKvKcu6iR/NMO5C4Meth3b2J4vMZuozOYKJw9oBSDHz
         QQXc69PzYY2bBmj7jWpMn8ZZ7o9rfMCKN4O6oUSxEychkyxsiLgfLTYhJqx8aTiX1xkj
         vWS6QHBHZ9Z/Rk3JDwo7weTsBt9Ifu7CZH8IACoxMr3akPRCJpU+m03Ef+HrLB3bTe9E
         3T107DBmwAphspJlk/uhiyzAVOtumBCqUTWJSjkPH2ZSbHgoHzNh1TLYk1v3Cdot/NhR
         6zyolci0LmSDGW5t5ErR/I29LFygVxHVD/weKXK1h+tf0mFbeYe9RkgeunFK0hEAHbYT
         JmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=41fH0wK9Dy9f2lhVtNZteP/lyZ4xt7hVs9iQcCVAF+k=;
        b=YVHM5gRbIah1kCiXYhYO7TChQOswbCVpU34JxYTSmP+zhhtrfJygeSrywUBtlewfSF
         xKyj2Eg9yRL6wSILQLkbHMdq//7vo9zenQPmuYmH2u3c0Qfrxi6xTuR/HoBzhQjmXy/l
         eTFCcMmB3B/GdtiAatrNNV//czekH8gO988aCduKh36p1MZ6799VPDWp2i6s9hL5ZcEV
         bJrYAqhHGyvLVrOUDbZMeJkWY/QizZeoO1L3cc11CmrlKZ2Vb4z63SXty5g86HzCLA1l
         MneB3ktUItnGbop329XLsfgRq10Dcc2OgUCKU2fKVQnui9ZQEC/Ibzd85FPvcoyWb7ZZ
         mLaQ==
X-Gm-Message-State: AOAM530S9dvf16AhSziI1dH4QTL7RdY+Fe5ZaB7U1ugu8prP4Nv81yBj
        VcVP2T8D1cMCjnN8gXEsnX7l4aHxgi4wFQ==
X-Google-Smtp-Source: ABdhPJzhwUZOO3xYHmZX8f8aLHrURYqoZD/1+CyGCix7QJQHZfF87N/ekOJ4fRi44Jm2vTMEAhxPzg==
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr2182380eje.296.1631354858751;
        Sat, 11 Sep 2021 03:07:38 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v13sm571744ejh.62.2021.09.11.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:07:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
Date:   Sat, 11 Sep 2021 12:05:05 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
Message-ID: <87ee9va0ie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Taylor Blau wrote:

> +	struct strbuf buf = STRBUF_INIT;
> +	while (strbuf_getline(&buf, stdin) != EOF) {
> +		string_list_append(to, strbuf_detach(&buf, NULL));

If you strbuf_detach() it...


> +		struct string_list packs = STRING_LIST_INIT_NODUP;

...init the list with NODUP...

> +		string_list_clear(&packs, 0);

...and call string_list_clear() you'll leak memory, since the
string_list will think that someone else is taking care of this memory.

I had some recent musings about how this API is bad, and I've got local
WIP patches to fix it, but in the meantime you need to:

    packs.strdup_strings = 1;

Before calling string_list_clear(). I.e. we didn't strdup(), but during
free() we pretend that we did, because we did, just not in
string_list_append().
