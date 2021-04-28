Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B540BC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E84161423
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 10:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbhD1K4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 06:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbhD1K4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 06:56:05 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE77C061574
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 03:55:20 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id n74so943526vkc.6
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cMhNRA+9wyd3tL2/PL+dfWaIojevGgxOG5juIxqNobg=;
        b=urYRUhyDI85gqBjm85LBGy/mwtvJfrxNSaBgeIcU5Dy5Q9T3IzeyRBt4QGR6BRPWyz
         Q9gulatxPqZ67vVm2DpLIeGF82plVPgLK1BMJXOBKKqmMgeC3O30U2nJ8ZnkzyIni8w2
         YMd/ZV/5s7Y1KDkTr9iS/+ojYiMhWm5WxjnRbtNdyZ8LrsmJl17EsTFDb2OIEUl59h81
         H9WfF113+lpqJSVmTDdE5oU8oPXtlER1KwcpyEgwDVeHi8ZJZeslwCgz+IW+gQqY2OxB
         IHiAbmwGQhTs+bQeX3h2wwndkjTR8sMEX2JMJWjU1TX/ohHApDORH359MAxAiVInBo5+
         eYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cMhNRA+9wyd3tL2/PL+dfWaIojevGgxOG5juIxqNobg=;
        b=Cm24EX1oTGnK403dPpxCXcz0awwmncQgITe3qu70NTp9F/qR4kQBcXEW1lIo2KYvVX
         0t6B58a0bAffgAPE8ajYcQO6jDc5Z1nRgxAuku9yCAy2SY/sowvpd8BdvQm17pXNiPBp
         UIz7gjH2Goeaye66HXjor/BQLibH3DeLdA7B7XbbKWcK63l1PgnTuVet8JWCnqOpBmJt
         7QuXeWtmNpDEcyTgUlgHWgp6XoA7bggpDeOHE0rJ0huPUbCLrYonqM82HcJFdtNI4XUK
         PS2qKv8xirg76jwjQgupgWjR04ayChfHShkqtPZrortMxyiVwsIIxKtmozsR34fDzeWP
         MeKA==
X-Gm-Message-State: AOAM530rvElvW1jRO8VlAopWNuJXbfyQ6UKcJHujSOy3buMii4zb+dzZ
        JErs+rGrPzkDXhsIwRLXsyPnxg+dbuUvuewHtDlvYg==
X-Google-Smtp-Source: ABdhPJx3nekg10J9RpspLkg8heExiqEnDjHcsGWkRXASadNmJ6Ytp5tFbo/bhhynTZ2nXcDHKiU2xPRw8GcZ2hahm7g=
X-Received: by 2002:a1f:43c3:: with SMTP id q186mr2294301vka.25.1619607319547;
 Wed, 28 Apr 2021 03:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
 <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com> <db5da7d7fb5178c14c1f5733d35bb69813c9c644.1619191907.git.gitgitgadget@gmail.com>
 <xmqqzgxjavks.fsf@gitster.g>
In-Reply-To: <xmqqzgxjavks.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 28 Apr 2021 12:55:07 +0200
Message-ID: <CAFQ2z_O=4sUjh1wk6nRijp9Gz2eeqX4=EY+Q-OTi9ppb9ikg3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] refs/files-backend: stop setting errno from lock_ref_oid_basic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 6:20 AM Junio C Hamano <gitster@pobox.com> wrote:
> > These calls do I/O and therefore clobber errno. They are not inspecting=
 the
> > incoming errno.
>
> Hmph, are you saying that these calls do I/O and always the I/O
> would fail?  A system call that is successfull don't touch errno;
> only the calls that resulted in failure do.

I'm saying that callers cannot reliably observe the errno result of
lock_ref_oid_basic, because it might be clobbered by a failing
follow-up call.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
