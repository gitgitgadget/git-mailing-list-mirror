Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98563C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A010421973
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbhAUQQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbhAUQPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 11:15:30 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BB2C0613ED
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:14:49 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id w187so1336706vsw.5
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MwR4MmlSOJNTIWyDmsXqBLthRY0wkuFgemoD0MHgZGE=;
        b=kl7D/Q722YjmJtnGWViphfR8MsyQHaiSE6tJlg52QKMniI4IdmwPiCz4eC4cTSoOhL
         Ziy7vErSCRrgJnogCHfZyxGDCh63eDBK7g3GJD8NusMVAR+2Sb3aK4dmgadBsVze5PXK
         zk3wP4W6tTgvMw3+kON5H/0nGk3kORc7Cn0omuCdIgWUU7c/XZplS/dEC7S9eGzp/Urn
         bCJTpo9/85ZJXmUuP6sglqs8+lz+H1LzH/a3y3B4w1BrqF/y6gbOCufYULYPp8PyO+mf
         WlAZ0cRueUVVKYzWajCK1Av7hgJ0OS656hzpFCIknlD+Q//cn1pAyAZZPGuY+Jdd0TeB
         zFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MwR4MmlSOJNTIWyDmsXqBLthRY0wkuFgemoD0MHgZGE=;
        b=G8xx/JZLbj60W+TJOKmSRT0AT5Z9GlnRki43pIlgubJTCwFZhvYrK7MHsGj0LOrMfE
         VbCw5nYlRJVaQMc7/KmTilS/0noOaw2U9LpZXUo3u7KiFJM64X0c1rhbp77cdSTKSg08
         hbQlhFjMpznHX2T/wT+Iy4QFRNQYiqtNzZfTl0LLz9d9Q/Os+/xO/xPkYcrh69fiz3nF
         /fRSBtoW7iK5WJA2jyf6s8aVDAxUOXqDA92FGEX4Ynf7U4wWWBMo7ZkqrEF85CZqqhH5
         69YR5ZSlDrKnFXhoDvyISMljfQAuHRUfv8LKTPlPveheNyfCnxw4E86/qNHZRIRGa0EY
         GNjQ==
X-Gm-Message-State: AOAM532qChvBiBr/m/Cr5WpDKBQn3OIoOA0ae4wF1sFqH9BsJP+8yu6L
        5R+2Vg0CWrvKd+9mLDnhvkAFznk3hNNn7XkUlbkWIAr/v4mOEQ==
X-Google-Smtp-Source: ABdhPJxneGNEjulCb5GfBO+iqWgEAHKUhFfhoWHR97Ntjlqfm7NKSnsO8iNBujGqUHp/YBFmNEg88xqKZ8xO/7rSnRM=
X-Received: by 2002:a67:b42:: with SMTP id 63mr427228vsl.50.1611245687947;
 Thu, 21 Jan 2021 08:14:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com> <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com>
In-Reply-To: <871ree8eto.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 21 Jan 2021 17:14:36 +0100
Message-ID: <CAFQ2z_Py46k71fHyBHyS2jqjhJJm-N0AV4X8YZZVawoZyVyhAg@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
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
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 4:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I must say I do find it a bit more concerning in the case of the
> reftable series. I.e. the git_reftable_read_raw_ref() function seems
> like a faithful copy of the general logic (at least this part) of the
> refs_resolve_ref_unsafe() function in refs.c.
>
> That I can remove error checking/handling from this place means existing
> general logic was faithfully copied without checking that we have a test
> for it, or adding one. Or perhaps given the history of this codebase
> there's out-of-tree tests for it somewhere?

One of the earlier iterations of this code didn't have the errno
handling, and it caused a bug that I tracked down to the errno
handling. I'm fairly sure of this, because I remember being perplexed
and flabbergasted at using errno as an out-of-band API mechanism. The
first iteration of reftable code was about a year ago, so if you
checkout the Git source code from that time, and remove the errno
assignments, you would be able to see which test exercised this code
path.

Or you could check where errno is read-back (I believe ENOENT is the
case that has special meaning)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
