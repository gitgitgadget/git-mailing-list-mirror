Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC49C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CF661446
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhDUJQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbhDUJQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 05:16:20 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB0C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:15:47 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id s184so10427038vss.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=voxojwJfhcUSJEQCSm1rwnJG36rAOB7oGQn73nH5LAY=;
        b=ibczeUAWoEH/TaeQ+qnTVDmXqfkJ8z59ZhHyzbECOs/j7rJ4Dd425q1Q5agEy/cHlS
         XxQbKU+4/q+YtRnsRks+6QbcVpwEYS+hU3SRqgL7++UvzbGT7vv9wxH7676T7bGsvciu
         zt8AqGC3oZCA0ChkNLfSk1RyKwSk3GFX5hHlG+OzEDOTkbQqhFrJnMquqU1itgbaJSEN
         EHPQGcvngAwVi5YDQ3Z95cpUml2wiIgH+Od/U++bvzRXiCZkURaOQwUqKHX+NjV8Kh6q
         +86RwqAIz5q0kX8S4FVVQwvEOdmcL6clKiUXiLDHrosk4tZV4+HII71aHekXvD1U8yXL
         ATxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=voxojwJfhcUSJEQCSm1rwnJG36rAOB7oGQn73nH5LAY=;
        b=iL1OQcbH4aCN4v1HrM2BakLb1B4k6/c73WSG736ahnHZPizpovUJ+fwjuKGuO07J+l
         plzZdvP5hZIEctveTekZq5YTARvSGhft9Qg1ZOOAgz7YG9g6CGlqWIwbQ7NUlkekdDIz
         sPUuDFA+DjvMkvXa6kj09CZAUhLusnRadEGUcxDk8RQE/MThJgTBEzucbxcOu35dVGm4
         d6e9suJmh40uyMPvJniMwbhanKztsYJW9WklckoS8rc40z6Zg490sJXYyQRy/zCDKsXZ
         JFDtN2uU55Mi/FeQa+UuFo4cDnx76x0DHNSzb0VnU+PyDNInD3abewzL+mtnfTnrrISj
         EE/w==
X-Gm-Message-State: AOAM532m+GqHWwoVAgXfTFr0H8GrD7hlAISd+PjpE7opUai9TcLCXQLY
        SmGF/n/fVCA9Y+n0fIB0gxAfec4aZhE1a9QmUVZI1A==
X-Google-Smtp-Source: ABdhPJyHM55+qd8bg/Suj+c2VAeMvNorbk6Vq5G9pG35uk1BW0U61qHpUblAeFhy5GbwD2q1PHAysoSbkgOIjkqStH4=
X-Received: by 2002:a05:6102:20cc:: with SMTP id i12mr10872892vsr.12.1618996545359;
 Wed, 21 Apr 2021 02:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <8a960fb77fa9117009119ce37aaa9885749bd1a5.1618832277.git.gitgitgadget@gmail.com>
 <875z0g3wp9.fsf@evledraar.gmail.com>
In-Reply-To: <875z0g3wp9.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 11:15:34 +0200
Message-ID: <CAFQ2z_OwTzb03MPsER1QVxro3D06rdbPABb6s3JnjC5F0b0BnA@mail.gmail.com>
Subject: Re: [PATCH v7 06/28] reftable: add LICENSE
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
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 9:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > TODO: relicense?
>
> So, still no resolution to the questions in v6 in [1]?

I reworded the commit message, but that update was lost in one of the
copious rebase operations. I recovered it from reflog, and changed it.
Hopefully it survives this again.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
