Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8159BC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3B4613BC
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKQgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:36:11 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43567 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFKQgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 12:36:10 -0400
Received: by mail-ot1-f42.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso3681835otu.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=5MFLPPwbqN9DjohiDZueCgDB6wtu0p0jUs0NENlsOtM=;
        b=cillJ8UkDT5e6MFT3l8qVEh+3mhB0fdGbcOuvkheeacQ5OTHmrFyXUG0HtCWJ0d7JG
         trPCCoj8U8+55m5dVOesUiLwGf87KeHFdrOs7gWVpmQWOFmAvCMR0hRa9W5wHKD7NqJ+
         eRs3z/IJNUsYY+z6yTbHlOHrs/aPuDVTCcJPrEb8beg++Sn44GzyZKs8PaY21G2rDMSJ
         EdeHNagNHg+bqRCjtPHe4hoMJG4yRn7dExjg/NwAfxJGungKODdbCnTszEkhEdKnyZac
         A6TEP5Mh5+CoLmBNz20cK371C1Y/W/gjJVyL1OaNapb7Ywcobdqln1jfAt6vY19r20h2
         FxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=5MFLPPwbqN9DjohiDZueCgDB6wtu0p0jUs0NENlsOtM=;
        b=lBAdFLPOzWQG1WoMsZ01IvPzwq4hYwGmTMBrIfLWsGtuftW2evafcX9GujbjnVqF1q
         an0dGVhFiDU/mAngL5xD+MsQZHEJ1panatvoT2wJ3Ieoeupg9PmsPdOe8H4h0UEWnqbv
         Lk7hfX+XVdKTgF3wvcOqzo2G4w/9PdjlgyNNZmO4qKOJf+G5JjTzCkrmsRnAhDWkxM6N
         OMGmqlwjrDESrnHPq2bEKPIUmjQ34IX+jSXGzthMxRfUtRFqpV4Bwx4XC46yHjS/dvi2
         tegFFIbTUiCW/BqtNb3gMbxcE+V/1yvFw63kTqYjC1FHniEPCNZMncAuLnw3CX0OltZ+
         qBLg==
X-Gm-Message-State: AOAM5329YJaDH1uln9oOPvI9zmCXNX/JvDHrJ4G54SrsJpNnw+U0Y9Gl
        YZtdoHvydYhu/nA8xnO8X/k=
X-Google-Smtp-Source: ABdhPJwSXNshSYeWqSNzl7Ag08Gvcea59KbyfJfvlH/A+mPXh4abbVsFD0uxuu/jK2SxCJxl2EPE3w==
X-Received: by 2002:a9d:4f18:: with SMTP id d24mr3750420otl.16.1623429191836;
        Fri, 11 Jun 2021 09:33:11 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id m23sm1380402otk.55.2021.06.11.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:33:11 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:32:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <60c3903bdda34_85c8208c0@natae.notmuch>
In-Reply-To: <87pmwt1dz3.fsf@evledraar.gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
 <87pmwt1dz3.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> That's why I don't think this proposal is useful. If we accept this
> series we're going to be left with an active recommendation for a
> pattern that's already almost nonexistent in our documentation.
> =

> Perhaps that's because we're doing it 98% right already and aren't usin=
g
> "he" or "she" but "they" or "their". The multiple ways you can use
> "they" or "their" in the English language makes that hard to grep for. =
A
> lot of our "they"'s are referring e.g. to a command-line option, or
> "their" referring to "their arguments", as in the argv vector of a
> program.
> =

> The skepticism about this being needed at all isn't an opinion I hold
> about software documentation in general, but about software in Git's
> problem space specifically.

Plus I find it odd that as soon as a progressive issue comes forward
everyone suddenly flips the rules not only of proposed changes, but
logic in general.

The burden of proof should be on the side that is proposing the change
to explain why it's better that the current situation, not to the
opposing side to explain why it isn't.

"I like X" is not an argument in favor of a proposed change, you need to
explain why the current status quo is not OK.

Every patch is subjected to this standard, why should this series be
exempted?

The side for the motion has not yet explained what's wrong with the
current practice of avoiding pronouns altogether, or using "she" and
"he" interchangeably. Even worse, they are assuming they already won the
debate and are not even engaging with the opposing arguments.

Ignoring arguments against your beliefs is not conducive to growth.

Cheers.

-- =

Felipe Contreras=
