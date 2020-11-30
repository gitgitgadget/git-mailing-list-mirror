Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83686C64E7B
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E67206ED
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bq/pqfZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbgK3U0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgK3U0h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 15:26:37 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D0C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 12:25:57 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id y186so3313656vsb.12
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KjeEMxGJ8wdEAyq4L5OxwSOqGCTqhzb+7bFDEyyN79U=;
        b=bq/pqfZW+EkYHfK5ubmSzeKOjfXB8UiZzNhVA3yJpjwuLbIY+/MGqhFbWcMLDEwDDJ
         V3xpk7N2lU+KMpQfqyyB92izb7bE4Mfj+7NbQ4YYCtLMV2F1rKp/5cTYvUZ1XiBwM8rv
         moaMbT9+Fz+Phw4uYavP9g/UGTDa/jysuUjLGKrBIGbI1VaXUzjjeLKVOJ7EVGFoMSGo
         1ZPTQR0QChJYNpoH4gOPtvnBTNQrUK9tentveOwzD6Mr7wjz+mxKF2iSr4NbURo6kdJt
         Yb4COUmmaHe3Vps4K9arKoH/F+e9lvFPMn2kM3ktBhic9CNBUhSkBTLs3NxkcOj806X3
         Ahug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KjeEMxGJ8wdEAyq4L5OxwSOqGCTqhzb+7bFDEyyN79U=;
        b=tzWPg26IO3HpB/IJBDxu2ZLMEPZOvRWY3fUUyd7ztnjI7jewmCmuctVfN1LsbsflBs
         Z4gg1qL++MfOhooN9oDXtBzwdH9ldqs6xdZ5qapTov6PSdQptpGvdG6SyLo3rct7r9eN
         fmuZSMEA1E/pfZ5Q8sK07HKQUiY4I2Kd80QtlnCGeQBtrC6unhLvtKOwXKdl9FZOqWIT
         R1YVrZJvo7Db58OVbX6jy7bqho5CX5nGskDyEpnbNUuFUg0OpKhDn3/B+gDdFm52DY9B
         L7etxBgopQGytBT2cIoMR8eiJtV4na2vUspsg5tjHnrrPG6Gb65wW7OS3ETS3gN49UtC
         E0DQ==
X-Gm-Message-State: AOAM533QuFKPC99MHGGg8iAxMWFsLHjRZDc+mknDiwWPdS1osJhifMtN
        PXChIQ3E8cWvtYy6OOK32PlKDu12FJfrodK5n6kusw==
X-Google-Smtp-Source: ABdhPJymxJoXdbskVh++x77W+yaBiysx+vDjfbMDf3mtrTR1XN/joSeTJSVImaVd2H67dMJz6KU18LMbDi1TnpmDAQc=
X-Received: by 2002:a05:6102:154:: with SMTP id a20mr17745308vsr.50.1606767956051;
 Mon, 30 Nov 2020 12:25:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
In-Reply-To: <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Nov 2020 21:25:45 +0100
Message-ID: <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 12:26 PM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> Until the reftable code is actually merged into git, I work on the
> reftable library itself at github.com/google/reftable. I've asked our
> opensource team if we could switch off the CLA enforcement for this
> repo, to facilitate back & forth imports of fixes.

I've asked our lawyers, but this is not currently possible, unfortunately.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
