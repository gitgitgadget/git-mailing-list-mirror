Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F32FC433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2020822B45
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbhAUQWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbhAUQV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 11:21:56 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E23C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:21:15 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id u27so834452uaa.13
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0bPZURbnJHfox8k1C/apn/pCf3C1bqMWMXiPfYMAHVg=;
        b=MNQzJXti61PrVoMXFAlvBVi6qEo8KKABe+i/85Ekt4B0wUs5jQFxKAcQin/tMLS0Ou
         73gb/ayyM9VQCFx6l9QHQk5KCPn2l4gSK0JoKm7ZrVwKwjPlrAONU79SFPLE0gWartmi
         seMIRX5rkvvlV8sS1QGc5DLVkRJy3V/rfX2WM+i18xgDcu1LvIfBa8715nX4wdA/4g3x
         BDtoKQRDR1UQuj5NF3/wBNtIdILmsN7WFkFAUPC0F13IB+ga8m+CjFNgzrIfsYyxjBo1
         kYK9IaBXC74iQXHgSRJb7vD12xChLDxIGQe7CSfsXTZjZkpONX1kzS48UCJm5j8kcKgb
         5jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0bPZURbnJHfox8k1C/apn/pCf3C1bqMWMXiPfYMAHVg=;
        b=J66uBHIXQRQusjsGLEn+MIY24pNrgrmE9DvZx/zp42sCTPMHcEv/5GdIRHa/erjR/g
         I2bcsMfTcXUrSwte7jdUJw+xLGT1jFezdSYXFavYjpIFwBSnapwvDhPQK6XEb+mD5feh
         /0exbhvMkPXAbjCfByMCaiTvEmbwF0513p5K126vzqWIiIHLJi99Cc9PlQXlSvEHsgcO
         iJuIICA9AwCQKo0g9lPpMl902NFdvGQzXdLfD5hXh7DX1DwxJbu2D7DeEzhNfqdNc5YV
         gtsgDeUBuIVwIGdozBiTIoimoD72BcwlJQCvh3yTSY1jd//71qxLonN8jYoZfziKsSZd
         dWCA==
X-Gm-Message-State: AOAM530LQArq9/9m9Hox++PyY8U4w0c4LRTJB/hQEJEAqAfMc7Qotipi
        XK1rZEee9p5nDCtjyTPmRU6WfRDmFJmcgim3E5h/gg==
X-Google-Smtp-Source: ABdhPJwDYjyU196v8undr3oaQ5BOJUnKtkcLfn1WqLrD1zRurvK8aGgcFFNo1Pv3ZbAde5NVAINqJISQddO19Mwkl38=
X-Received: by 2002:ab0:e14:: with SMTP id g20mr484589uak.112.1611246074720;
 Thu, 21 Jan 2021 08:21:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com> <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com> <CAFQ2z_Py46k71fHyBHyS2jqjhJJm-N0AV4X8YZZVawoZyVyhAg@mail.gmail.com>
In-Reply-To: <CAFQ2z_Py46k71fHyBHyS2jqjhJJm-N0AV4X8YZZVawoZyVyhAg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 21 Jan 2021 17:21:03 +0100
Message-ID: <CAFQ2z_PPnmCHYvse-V8QG2zG2MouHxuvraMmWD=cv_bRWpakEA@mail.gmail.com>
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

On Thu, Jan 21, 2021 at 5:14 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> On Thu, Jan 21, 2021 at 4:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > I must say I do find it a bit more concerning in the case of the
> > reftable series. I.e. the git_reftable_read_raw_ref() function seems
> > like a faithful copy of the general logic (at least this part) of the
> > refs_resolve_ref_unsafe() function in refs.c.
> >
> > That I can remove error checking/handling from this place means existin=
g
> > general logic was faithfully copied without checking that we have a tes=
t
> > for it, or adding one. Or perhaps given the history of this codebase
> > there's out-of-tree tests for it somewhere?
>
> One of the earlier iterations of this code didn't have the errno
> handling, and it caused a bug that I tracked down to the errno
> handling. I'm fairly sure of this, because I remember being perplexed
> and flabbergasted at using errno as an out-of-band API mechanism. The
> first iteration of reftable code was about a year ago, so if you
> checkout the Git source code from that time, and remove the errno
> assignments, you would be able to see which test exercised this code
> path.
>
> Or you could check where errno is read-back (I believe ENOENT is the
> case that has special meaning)

In refs.c, there is behavior that depends on errno,

if (refs_read_raw_ref(refs, refname,
      oid, &sb_refname, &read_flags)) {
..
/*
* Otherwise a missing ref is OK. But the files backend
* may show errors besides ENOENT if there are
* similarly-named refs.
*/
if (errno !=3D ENOENT &&
    errno !=3D EISDIR &&
    errno !=3D ENOTDIR)
return NULL;

blame tells me it has something to do with dir/file conflicts and
commit a1c1d8170db.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
