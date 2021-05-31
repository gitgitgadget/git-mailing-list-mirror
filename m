Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A984C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21FC6124C
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhEaPbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhEaPaH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:30:07 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024DC04346B
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:21:14 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id e2so3899821vsr.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cCcFVooa11GOIbhgSsJX30SpyxO7BCMIUkUb6dBzxqY=;
        b=G/4UFukDfgOVUJ4uuuJSHJE9CdxEAQ5858zEUsZuo2EdIo/I/2ObMybF+f2bmq0I3F
         QwdzFPqjHqJrmbFWNaYVOn2eg4MfIIgdG/xZlXWfGmaqltk0qTW/o/zzOSP/XkE1glLB
         N1KY3keNwGrjNBghQhAUs2yuV9o/WkMyFbXQqVQwI5fV0sA4yncy9vVfSUulLt+/RbN1
         Nc/vR4M2zT8WqWT3CWSq+Ywksfs0gRJqrUsOlKMVXLPA5q1aJl1rkI0j8Ik70rEEPFYo
         6RHUQvJzReL3dGr2R45xtDTHEhu3r9AVgyNIcRIbaZOJIPq2kRvS2hUfNgrtpCKoIaqo
         vUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cCcFVooa11GOIbhgSsJX30SpyxO7BCMIUkUb6dBzxqY=;
        b=TcHfyJcfjBnc00BH+xCGyLb07MDejAv2G3aeBzOqbQ3VLRPpD4BycZECSSZbwshu5F
         T5zDKDM+81fmTWSOml0nG+IXgh58IZdV/3JW6vR1D3oI+yI84mzw+ZsR4BmpgTKitbjp
         /4/3gwW6Yw/g2Bh9EAl15XmKCR3q+BT6hfRgi+UdDaumeySyn2Iqu73OCzcTEbhueXEi
         ttzvXIlTWwO0ZhcB6ITIsEGDid2MBKGzAoBrzG3F69FVwDwkXEiOL2Tg+HcEXVmmOAnA
         YmChjqT5Dabi8MkHr1c4k+e3EQGHWn3lGqVFaOv8P0XYkiquYJ+QW0TY+LuJvGfCWCeG
         LG8A==
X-Gm-Message-State: AOAM531Adiw06zRBjhGc2G1NcaSvu9zNBLhgeE4vIMa27gZuByRFnYzA
        apHewoJEdgLjRBzMck55bMJ3DLnEivX04qFC8vq5ew==
X-Google-Smtp-Source: ABdhPJzOg16PWoO6oItE5Fcns2LV0weQYF1JnHm+7WvdnGzrmj4U/Nz4hkFuZdWRYRI1sxFJHckRRlX8Pd/RwABEvwQ=
X-Received: by 2002:a67:ebd7:: with SMTP id y23mr13905199vso.54.1622470873297;
 Mon, 31 May 2021 07:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <a33cdfda74ff55fbc8242d3486e1fd5a26ad4c00.1619519903.git.gitgitgadget@gmail.com>
 <87eee1pfzk.fsf@evledraar.gmail.com>
In-Reply-To: <87eee1pfzk.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:21:02 +0200
Message-ID: <CAFQ2z_O6GufrNyfzPtddmW4KOQtMr6OhUZx_LUT2kcyQQ1sY6Q@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] t4202: mark bogus head hash test with REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -test_expect_success 'log diagnoses bogus HEAD hash' '
> > +test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
> >       git init empty &&
> >       test_must_fail git -C empty log 2>stderr &&
> >       test_i18ngrep does.not.have.any.commits stderr &&
>
> Okey, they're correctly formed by design, but the first test here is
> just checking what happens when we do a "git log" on a repo with no
> commits. What does that have to do with reflog's guarantees that we have
> a valid-looking SHA in some entry in its database?
>
> Surely we also want to test for the same thing, the ref backend doesn't
> change that we have no commits or refs yet, no?

Done.
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
