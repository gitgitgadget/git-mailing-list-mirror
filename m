Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEEBC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D483611AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhGMILr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMILr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:11:47 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C5C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:08:57 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id j8so11839312vsd.0
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yVsj54yUBK3Bp7IxSRG1Q2u5KMX88erQoWc1hODxHZY=;
        b=WJbaG5aM6ZTUGUu4F29sCdpMUHNi3V/IaLtcxAr5qyaOAaqXa3tYuxxAXWFkyUUGJx
         MQzcTKEQtylnP44vTVR1V0KCWQvKMeM2BvFnH3bSnaVweJjntCPr3RQUJo2KDYK0w0lW
         QFjNqiMNkHzlkHdmCh4W+8nirqSh+vP28g6Lca5A/iltJLBo6Eo1T3zmbbbta5R2cJSF
         HevyG0jPU8pdCWTZKHGQpkDzoQ6dpyerH1SAavl/fpX24mntSsheKf+JJW487Dwhys1c
         efunUkGm9xVY7Ix6N1kSXroy9SZD2pH8FOODYaKwiJnM8Janh+lmrZzr4tCkne23brtC
         icdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yVsj54yUBK3Bp7IxSRG1Q2u5KMX88erQoWc1hODxHZY=;
        b=LYp+Jldhw/1RMorY0h0HROWlbg3YyuH59UK5PMdRyP6kXjijnquMO8waK4/jwVUtZI
         Rh8mPndPYofXdTBj1iBV00izXpfQt7GRpgvGYpdPPH/2mrEtwiWduWY2S8YVHi0jKDF2
         xqdhRxFPTYk5ESWSrif23PnTF1NJT2GQD2WCD0Ib8IIjbxuM8BHun8qq3GOzU1SsqhcB
         OR5oQ3ES2SQqWxZtjep4d1zWAliKZejjsks/Nx6Gj530c6HELNyIhPyUWgFxgxBp0EUw
         XlveS2Qtm13GObwbRuhcs0T/zEi/lHjYI56aLByirYPqozGhQgksGFxiS7amphbK663E
         t0Cg==
X-Gm-Message-State: AOAM532JQCY8w+yR21vndpKu8uhjqRmtMCeUURkNwmN9eD3nAqiCAano
        p8TCE8LOsAZ/A3Rxxlic/LYNrHkwPQJ9v+9DcYUA+xPssjs=
X-Google-Smtp-Source: ABdhPJx2Niw/FkvwqpA82BvtviZA+vbhplgegbsW1NILBNVGpn5XBHtQXKoYlFK2VCR9CCS6JTfrfCkmNF6IKrYtzvo=
X-Received: by 2002:a67:69c5:: with SMTP id e188mr4789810vsc.2.1626163736448;
 Tue, 13 Jul 2021 01:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com> <patch-08.17-ff38a3f1936-20210711T162803Z-avarab@gmail.com>
In-Reply-To: <patch-08.17-ff38a3f1936-20210711T162803Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Jul 2021 10:08:45 +0200
Message-ID: <CAFQ2z_PNLBCwZhfgk-9GBsBqoM_LSdeYR0ALSJhgF-h1uokWQw@mail.gmail.com>
Subject: Re: [PATCH v6? 08/17] refs file-backend.c: stop setting "EBUSY" in verify_lock()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 6:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This EBUSY was set in 835e3c992fd (refs.c: verify_lock should set
> errno to something meaningful, 2014-06-20) to fix a bug in code that
> was later refactored in cd94f765720 (fetch.c: change s_update_ref to
> use a ref transaction, 2014-04-28) to not use errno at all, the two
> were a part of the same series.
>
> So this was only ever needed for an intra-series bugfix, and we kept
> it around for no reason. Removing it makes subsequent commits where we
> refactor code surrounding verify_lock() (which may use errno) easier
> to reason about.
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a4e9344ac8b..abed0572fea 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -880,9 +880,7 @@ static int verify_lock(struct ref_store *ref_store, s=
truct ref_lock *lock,
>                                mustexist ? RESOLVE_REF_READING : 0,
>                                &lock->old_oid, NULL)) {
>                 if (old_oid) {
> -                       int save_errno =3D errno;
>                         strbuf_addf(err, "can't verify ref '%s'", lock->r=
ef_name);
> -                       errno =3D save_errno;

your message talks about EBUSY, and that change looks good, but how
does it relate to this change?


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
