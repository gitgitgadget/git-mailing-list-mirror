Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B8C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DF961026
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhD0JO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhD0JOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:14:25 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D6C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:13:42 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 2so29689738vsh.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sYXj0lk4L6/OFIVEAG4uBfN001uvBmkQNWDecFILkxo=;
        b=FLYl4zPpoYrwX4oGLKrlli1iNQ54uCCWfPifUqb6NTDw2G+EIRkD3SHHawt4PAhZgl
         +K/CrqY175bhHas9ntsv10Iga8/ZYDP3ToqD7vgleQtYDUZ/rS8vK69WIDv04o9ZyILU
         oMf2hCgERzf8hVbBboms97d3DUJWZLaB+jrkKHmq+Ptb/4AdtC4xHJSd7LgpjyDKlv6v
         9CFSJu/mRYXbqvt5Kp9oPQeyNeh9DJcGsM0m9wwrpKrVklAJQ4onu0E/opEkoThglSha
         oHd2tsdohEax829iE7Pih7Wt1gseZM9dWW90S/p/QaeUd21aqan55uXixw106w+Opwkz
         /Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sYXj0lk4L6/OFIVEAG4uBfN001uvBmkQNWDecFILkxo=;
        b=Xdy0hfsPTbrUdRC9WbHiJ3dKcWXvRPkkfxRcVwnNiOaf96RceWcVW+rjBCnfQyl8Au
         rhz94LaVwtB6ItSS05v+EPxGKAaW+lfEjFRnbUIEUdAJc4AqHF+w9QnAxhfxIQ1gQEdY
         6qa/5pd9vbY5YWXrWYDIhJBdswkO19BbeGKF8fcetTTG30X+Yrz2vGRutqtoS3qNTkxe
         fGtWra2ANhK70kLi9zNGZ1l+XI1IhA0/K0OvFmLDJSxfp386LHKp1/aoH5Vdg3RW1KTa
         Ts0jES34UD+NCMzBler3IhqI1BKV7RqjKP613Dhvh8/Fnp2vebTG4nT3f4vp28QyAhj3
         2Jlg==
X-Gm-Message-State: AOAM5305cjA8wJY8tbJCL5scR5+9RWGGXrISoFk0gc6KWHOjZ8aLXRtk
        unsyp/ntuOrY/DPHn5ZVrDnel11GItfpGmp0zQlvpw==
X-Google-Smtp-Source: ABdhPJxLTZk/1QqWRhlDKCySg8zj94z8JUbLbMq2wk6dob7V5ky2vVYIU0X+JMrHNpxdnhaxD7Wl86D+XrXgtKLfMm4=
X-Received: by 2002:a05:6102:20cc:: with SMTP id i12mr16081746vsr.12.1619514821569;
 Tue, 27 Apr 2021 02:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <20210419203835.GW2947267@szeder.dev>
In-Reply-To: <20210419203835.GW2947267@szeder.dev>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:13:29 +0200
Message-ID: <CAFQ2z_ObrsJ+SgvY8s0_ba-8aZxLwvXujT9ERPRnC_oAhJs+Zg@mail.gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 10:38 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> > +     git symbolic-ref HEAD > actual &&
>
> Style nit: no space between redirection and filename, i.e. these
> should be '>expect' and '>actual'.

Done

> > +     ! git symbolic-ref NOTHEAD
>
> Please use 'test_must_fail git ...', because otherwise a segfault
> could go unnoticed.

Done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
