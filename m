Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DEEC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9ED6124C
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhEaPmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhEaPk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:40:27 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E3AC08E89D
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:27:33 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id m23so505536uao.12
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RspRjlen7EkAuKt+NNGMA78sZ04pGueSt1zolAdCA2o=;
        b=sRgR1H4VUWS2rNlHnnxDrPu4PymwG3hEYc3hDJd/WfG/2vtYtjw7ZR3SPkvTLX0vOu
         zeWfvDyu3XCHG5iuv7lSWzljs9LcGyBwdLffb2+1kRS55lRplKpixtliVF+gPZbNLkmO
         4xXX2LTxPU5Eic1IZ5sVS5F1EdP/SwvmBJT9wI1h2z6qceZCdmviSkioj4/Zdlf28hDq
         Fzat4MJ0GmFjaojK7ed1odAYe+3hfeGJlg48SD/sNktmXA4GQ8gQFmloMVK/oOcocE7u
         A/9LW+kcUH6oMhPW/U0kPWstcOZDCvOdc9x1ug6Hc3rzpRHDGRLipC+jr8Wo13hHAeHK
         5ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RspRjlen7EkAuKt+NNGMA78sZ04pGueSt1zolAdCA2o=;
        b=db7dPvRoptxtGP+Q6rbI/hMwGApLf/goEjHFjD0xWhFwKI4/XHC7LckTlmSfnz8Ihq
         oX16lrmxy1K+ZpxKag9qCjlpuH4uVpCgQDK3X0Lmk+5NnF3EFssWH3IUS2FKU+jI5rVk
         AevImEZaETqeE6KY37rF+kHA/KhllCtL61azvgR1iSrmPwzhvKlDVztaukZMIBwCUB36
         Ag3KYa4PGlyKNra/Y66jYTkt2im+waXYvWEFg1QBh6PAx+5H/hK5a50OLTsw7s4Z+K50
         X9Bg3oXvPw240eUEaX2xsmuRbw7BAUEVoVYVKAdslqxvGYu4GFtkq5LKhvPzmBN/K0mD
         uZuA==
X-Gm-Message-State: AOAM531tiCrJOxw7uvr9cwzvAKJutBKiTjO83uLS6vGFT7HLsLJTJRnE
        +r8DuQCzHkNHdGIcUq7AKVUS0MWr3CIl7aiNFX3L4A==
X-Google-Smtp-Source: ABdhPJxhU9Rv1UyK8rU4eahzA+V+Wke9Mx/RmztlplKOVjGtYYMlm45MtRRShJM8JDfMdQDlukG8VdNOpqvhgxLW3E8=
X-Received: by 2002:ab0:6f90:: with SMTP id f16mr2687304uav.112.1622471252558;
 Mon, 31 May 2021 07:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <24dcf05d8fa6172d04ca047a860ad5019aad17b7.1619519903.git.gitgitgadget@gmail.com>
 <87h7ixpg2l.fsf@evledraar.gmail.com>
In-Reply-To: <87h7ixpg2l.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:27:21 +0200
Message-ID: <CAFQ2z_OC_mOZO5+V4qtg66FrsDy5PyyRXdECztuW8owpZ9WD-w@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] t7003: check reflog existence only for REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -     test_must_fail git reflog exists refs/heads/prune-entire
> > +     if test_have_prereq REFFILES
> > +     then
> > +             test_must_fail git reflog exists refs/heads/prune-entire
> > +     fi
> >  '
> >
> >  test_expect_success '--remap-to-ancestor with filename filters' '
>
> Ditto chicken and egg, but isn't this conflating "we always write logs"
> v.s. reftable just behaving differently, i.e. shouldn't this be
> positively asserting that we have the log *for that branch* still after
> its deletion?

That is a great topic to discuss on the reftable series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
