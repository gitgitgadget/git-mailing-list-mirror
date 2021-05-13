Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C995C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A5161422
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhEMGjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhEMGjY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:39:24 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBFBC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:38:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j75so24460700oih.10
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+smzRgu1aGj29GUkGLq+PDTX0Ur/QZ0Zbk3NS0w3kzo=;
        b=SdDYqqQz0NsYrr7tTddam/hA1oTqb+l45nSLWz0LRL+5paHaot97nWoxUcU+y1iiQP
         q4EMb/d7uDfTIYurk7kiU3E5kyBD3BF26aPB5RPfWJ/pZJTZe3E6DukVIqxSTxHWMHq/
         YGYP9E0DDieeQGiPJtmNyjWbv1Vw/4MkE8jAnNyZPOT98qEFATlOxmNAhKULkgBGsMyS
         lE+9uTMnrGRWJbSUw3QFEYQ0TSWE48oQR8iRonUb5tNE66fKlIrWcrKBdJOFjmaf4s2J
         +m9MSVXTvR62xVnd74nq5Y5YbC9hCtQos3YOuEDkxRUHGJrwWj6KuIVLLXMPJ+oVAAEg
         1tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+smzRgu1aGj29GUkGLq+PDTX0Ur/QZ0Zbk3NS0w3kzo=;
        b=TwIMcCSIGNDdeyCrKm73w11+mFNwXSmJA6/I9T0/0aQpriv3prufVuy6NwL3m1l5Ea
         K3jANSlAuQBvyPgrYRO49216Ov55AuNuPyhPYQBYtefa3hsgNwjK4Icm+f+zEEwdNZ62
         km/GbAi0q4aIRhpo9uZgCyIFI6Ep0/FT5NxO+bzK530lwopqdmaprOLnAsVqA9Fvsnfd
         sGc1tT68op1AxoDpd8SzWR2V+WsKX9BugsZKIu0sMaYL3/EBVFkNBZLijFEgIMce6Dej
         r4yfRaB5H0Cz3aD9XTaN5C93+JVa5faVu3rjtgwIlqbhe1DTYGPjUd/tl9dHaISPtDIs
         vUEA==
X-Gm-Message-State: AOAM5308kR4CUTM/jFcD9cLjNJ2+GgIKyMkx/3FyE7DHBd0Cy5iuHsYH
        oCbfAw6m1prV21Kg4tvAaKg=
X-Google-Smtp-Source: ABdhPJz23H03P4Uvwwmi+UbxQBRLq0Wkv1Dr1UMvGKZwZtxoucBZ9U7KEefSAwvCCKfR4MJAcXXivA==
X-Received: by 2002:aca:1b12:: with SMTP id b18mr1890430oib.130.1620887893692;
        Wed, 12 May 2021 23:38:13 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id y205sm471984oie.58.2021.05.12.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:38:13 -0700 (PDT)
Date:   Thu, 13 May 2021 01:38:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <609cc953e0ade_329320811@natae.notmuch>
In-Reply-To: <20210512235136.GB10785@localhost>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
 <20210512235136.GB10785@localhost>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> On 12.05.2021 10:45, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >There hasn't been a release of Pine since late 2005, in Alpine the
> >no-strip-whitespace-before-send switch is already the default.
> >
> >This documentation was initially added in 9740d289ee7 (Update
> >SubmittingPatches to add MUA specific notes., 2005-08-26), at this
> >point it's safe to say that it's not useful to anyone anymore, let's
> >remove it.
> =

> What is wrong with keeping it in there? My latest version of the
> etiquette patch moves my Mutt MUA config notes to this section on MUAs.=

> It could eventually become a somewhat exhaustive reference of MUA
> tweaks. Old tools may not be popular but they sometime have niche uses
> and/or userbases. My recent switch to Mutt has been mixed at best and I=

> went back to take a look at mh/nmh to see if I liked it better and I ma=
y
> give it a go for a while to kick the tires, likely making me the only
> developer that uses nmh.

Have you tried notmuch? There's multiple clients.

-- =

Felipe Contreras=
