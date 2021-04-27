Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCECC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC91161107
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhD0JRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:17:00 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF2C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:16:16 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b21so396242vkb.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zpeAM4Dj+b6AGqpLeoAN51QH3115kpVnSd0FpH9/XPI=;
        b=F0NzkR/5owDiKaIcGIozVHLt3leYShKYqhyWDeZ4fuyWv4OSJ1QqZGuqvXYEch/1Lp
         cq8rrbfCCWY5zMYHVexPi8s/8WmXJphW6bydMfRfZ8eb8vudN9xs59oOYsINyUPWAS3+
         xU1fIxstIlY39D1dhnZRXldPGSuArWmCYiMw0DYr9tmQJ6PBeap6TZjUUdGe/rBUOJIa
         6uUwL8dkv0BD1q6BmkBkaEKSk/EgcceNaYGJBcoATxdRlOyks2hi7IMbu73PzJZhvJOb
         y7+Zu0k5pLnHDcVui6835H4nGVDvCEGh65NE80Mf0sOI1u4RIn+jTb3uy0kOjZeojlpC
         LtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zpeAM4Dj+b6AGqpLeoAN51QH3115kpVnSd0FpH9/XPI=;
        b=C4xMUQQd4lJebZ0tfbu4/U8MUT8/GQ47TjGRjEGn6Zxz0iGbyx46rHJW+yqCprxlwo
         2cyjHj9j5Tp2yGMPoE1+eRrxreLB/TgAJnxGqWp9oDbrPGLhlJWefGjeXi2YSatAmuYT
         d8Hnnvy7pEkPQOBHbDA6UxiCH/q4WX+4VTON7H/iPpVRyBw2p3unu429w3m7QlMiNmV9
         9LreD8fGkNOshTUVT8dLsH7R6m5/3lbHrHzU4oQZWIakAGjfIQ8bdnO+UktjTaPdyyBi
         4f59vBCyqJJ/EUrw2ZzLZzFEtheWctsE7hAvh876pDuqiNMf9wjh+CaLoFxidY7AlCxv
         bxNA==
X-Gm-Message-State: AOAM531Bczh180NQKmjXatZCEynR68VqRkwpRKR1Txo5a+PgmAJQaCxd
        DwRY2+R1vXNs5WmvFCD6ZwhVIiZNAKARGgq1CyWBSA==
X-Google-Smtp-Source: ABdhPJzLUFCF/JeGuq3mbGU6WNXBtzq1XDjalr4RGGOFZpEQrqw6KovSl1rkHSNFdoAQNmU5zpgd9ffjxzQUlVIKwRk=
X-Received: by 2002:a1f:3105:: with SMTP id x5mr16761743vkx.8.1619514975268;
 Tue, 27 Apr 2021 02:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <3d3b733c31273a004e80d5cbab8f746a2010e9ea.1618829583.git.gitgitgadget@gmail.com>
 <xmqqa6ps36ow.fsf@gitster.g>
In-Reply-To: <xmqqa6ps36ow.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:16:04 +0200
Message-ID: <CAFQ2z_PNYG9sT8HjmQYVfw0--QE3m3+iTw=c5Rum6LHe+SxJEw@mail.gmail.com>
Subject: Re: [PATCH 10/18] test-lib: provide test prereq REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
> > REFFILES can be used to mark tests that are specific to the packed/loos=
e ref
> > storage format and its limitations. Marking such tests is a preparation=
 for
> > introducing the reftable storage backend.
>
> We'd want a bit of documentation either here or in t/README to
> explain things like how these two interact with each other, if both
> can be active at the same time, etc.

Documented the prereq in README.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
