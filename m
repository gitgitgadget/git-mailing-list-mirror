Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696FC07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B056A613B6
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGNQif (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhGNQif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:38:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7DC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:35:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h9so4337032ljm.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S1Q34jQjeNWCowzsMeYLHRO5jPU9oNKSI6G3UQPqwDM=;
        b=AqedLHPd9AMLowSZFQrfNDrUngRgG/OJFYVeyf3ep/8QaMqrBEhD4BfjOsSM7nN8JV
         dH1eJ3OqpD1Ar+IvOUXn3fSgSWePskvyKhu7tVu/JkNQdj/Kut1mj4za5Qrx7XtN1osL
         cugLOS5EyWGVTLborWDumwDwJxC7J1JhNDFMqJOI5pk1oBexyL/YKiQ/J0JOo6MEOfvb
         3NZj0Hw8K6Bi2w2Fae03VgNS0O5RG6I19aoY8rUL6CRm1J976zDKvV1eA9Vg6kiJJhr4
         EFUVfmDK9gPpib0w54o/MPOj+5sh6v9b7B5ZQ2c01usPbJwNuzanieg1dwb7AVC3KlgJ
         XyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S1Q34jQjeNWCowzsMeYLHRO5jPU9oNKSI6G3UQPqwDM=;
        b=ejCtjScplBmvwnI/A/HT0UDjqcp8Q3oD/KZ+/6vdkyreHsPb9UhfT+vK4DvwxegYts
         GuE71BZQf50GxycT5HvpYKWwmz+biEJWLtsD8DGtqfpsr7AuhOEUeZpxVmLPCQ+SGBn2
         XKxEgf2v/eFC10/9ImCZZzq37BPQuitgOJcW4B667T3f1G0kChh6e/1n8c5XeSLZTEFU
         qIsLHy0uO5rpSOhaURUfVtoCmtR0V4wPUN49oUnAwifQvKUEc9AQF8VvgEU3X0coTTRs
         suTKzyKOip3BYLFnu+2GO0iusAFXQ/Fmt/lXVy80jCf2eYfHHUGo1tyOOUsOmgq0XlIz
         L73g==
X-Gm-Message-State: AOAM530kFOllLZnDcCpHmoFsalhC3g6Ef7AHPASy+GjOoe3TpR7am9VX
        IaVPbmw0ZqNwh06LkzQi04OBnQ5RrRAN3YJVePk=
X-Google-Smtp-Source: ABdhPJwg6AZLL8/vzjr5Jg2vgMPe+JOtqXqj1zFSCclC+IywHXCEBlu+7VSg+wirlis8VTaRlgcfCNmmDbcWlt53UMA=
X-Received: by 2002:a2e:a233:: with SMTP id i19mr10047933ljm.261.1626280541797;
 Wed, 14 Jul 2021 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net> <87a6mo29dp.fsf@evledraar.gmail.com>
In-Reply-To: <87a6mo29dp.fsf@evledraar.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 14 Jul 2021 10:35:30 -0600
Message-ID: <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
Subject: Re: progress test failure on fedora34
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Jul 14 2021, Fabian Stelzer wrote:
>
> > Hi,
> > The test t0500-progress-display.sh in current master fails on latest
> > fedora34.
> > The break was introduced with:
> >
> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> >
> > Kind regards,
> > Fabian
>
> I have not been able to reproduce this, it seems the below E-Mail was
> word-wrapped by your mailer, which is especially bad here since getting
> to the bottom of this requires looking at the whitespace.
>
> Is there a way you could tar that up and send it (to me personally is
> fine, or some pastebin or whatever).
>
> I am able to reproduce something that looks like this if I
> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we set it t=
o
> 80, and that the progress.c code just ends up with an
> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other fancy
> logic) in progress.c, I'm not seeing right now how this could happen...

This test also fails for me when using QTerminal or Konsole, but it
passes on XTerm and LXTerminal.

-Alex
