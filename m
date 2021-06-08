Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A79C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1782561168
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFHBuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:50:32 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35350 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhFHBuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:50:32 -0400
Received: by mail-oi1-f175.google.com with SMTP id v22so20061089oic.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KCU2yXSK6FpkJh7IymTtKYMnDXqrmzYQZkrO/hu5+50=;
        b=T7XlbRmfCnhDpPKQ80M/AirindW0UglBdBq31mqQRDcwEu0lT7BsczdPjFmKhLSXav
         x1hq9IqExeF7ff9VX/xvl9ot6HvJt4OuXitekcLcuMkTRCMSELaurzoDRz5Jm/PFjjgh
         Z6H4fjC6dYilw58m8dnBDjdOsg2O89LVL4iUW458Tx/Yjps2zXQqp50/ycz9aIqtDFZq
         w/MbpRlXlCgnMZ65AN8TL6hqghbWVAzlzMoz8nxO8UjqLZBEgfYkam8cMaWGl/wIFnCY
         rKfPTtlnDGL4ZVfUpKHFQKKIKlISJPoMcsTk1u1xMiW8/GMH7fKfTr8oplUlDjK9kYiI
         ga/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KCU2yXSK6FpkJh7IymTtKYMnDXqrmzYQZkrO/hu5+50=;
        b=uJ68YTRwxZyDehWzVVA2r4JBUkOXBSCRKU2ucVdENGlXvVeNe3yyuVUbiw2OO5u/zU
         hNMCTgPIrH9X+0INwkWjoHcy3ATxKuSunEsaPXnm0ze+KPpXgjl3+EczhTc36a5t1bPd
         Fn4n1PdcoRy+Bov33OkHQfpUTCLCe95x/wHfo9QMo8KKKJN439ufvqtBCA3rdNh7JUrf
         mcG2ow9lvAtPVWPSANdagLu+tXN7dy6ZhRcz1dV5xJVd1+52rwTuSWX4uvtFDH5a9ed5
         FqdlOjE76O6xBaG98gc2yiNN/dMJac00crwjeKAx85HJepSEhMI6wHHhiuXoSZyFaexZ
         4rCA==
X-Gm-Message-State: AOAM531+eZypCoMPPGxlaNSGnR5wOfVpFfwS3Q1Jwz6ZXu/4nw+Gxmot
        V3+JvgI8R75aroJSQdweCYY=
X-Google-Smtp-Source: ABdhPJyq8lTf6Q5MkAl7/zh/pZrlJ6iXmL+t7WrL9tE5dd7CcuxtXV9AzPU95HrJsOjPJmdDAQBAiQ==
X-Received: by 2002:aca:bd86:: with SMTP id n128mr1377619oif.75.1623116844577;
        Mon, 07 Jun 2021 18:47:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s15sm1984885oih.15.2021.06.07.18.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:47:24 -0700 (PDT)
Date:   Mon, 07 Jun 2021 20:47:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60becc2adf199_dcf6520847@natae.notmuch>
In-Reply-To: <875yyp4fun.fsf@evledraar.gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <875yyp4fun.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:

> > If the reader does not consider that pronoun to apply to them,
> > then they can experience cognitive dissonance that removes focus from=

> > the information. [...]
> > When choosing a gendered pronoun, that pronoun no longer applies to
> > nearly half of possible readers. Even if we alternated between "he/hi=
m"
> > and "she/her" perfectly evenly, we would still expect male and female=

> > readers to experience an incorrect pronoun half the time. However, so=
me
> > readers will not prescribe to either of these binary genders. Those
> > readers hence suffer an incorrect pronoun the entire time. Singular
> > "they" applies to every reader.
> =

> I'd expect most people to not actively read technical documentation and=

> try to personally actively ascribe themselves to prose that clearly
> forms an example of something they may or may not do.
> =

> If that is how people commonly read documentation and find it
> off-putting I'd expect gendered language to be the least of our
> problems, since even with s/\bhe|she\b/they/g so much of what's left is=

> still referring to hypothetical situations most users won't want to fin=
d
> themselves in.
> =

> Maybe I'm overthinking this, but per the above I'd think if this is a
> problem with losing the reader that we'd need more structural solutions=

> to it in the common case, e.g. more guarded language that you should no=
t
> read further if you don't care about XYZ aspect of the technical featur=
e
> we're about to discuss.

Personally I have no trouble at all reading instructions mentioning a
female user and see how they apply to me just the same.

Using a singular "they" for semantically singular antecedents does sound
totally broken to me, and that does distract me from what the
documentation is supposedly trying to transmit.

I have trouble parsing the documentation as it is--which does feel to be
in a very detached and unpersonal style. Changes like s/s?he/they/ only
make the situation worse. I would rather have the documentation speak to
me more like a person, and less like a previous-generation AI.

Cheers.

-- =

Felipe Contreras=
