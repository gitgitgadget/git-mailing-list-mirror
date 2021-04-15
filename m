Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3831DC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE1461184
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhDOPC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhDOPA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 11:00:56 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4DC061756
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:00:33 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id l11so3829929vsr.10
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qesJpivVWpeD2MA2cN4Ziz6Udykcmvft4U33eY4J5aM=;
        b=ShPUkodResImEZTNn0Jx2eQqrxAMXEsFsJhahNuFvG+OaX683wVRrQtWT400xoAzDu
         74/zLw98hO4hp0vijATH1PHjKdaoQiD4JLLm0ke0XO+lHIiXe8LKTOFBQ8FkHLUYPSQK
         O9TZCtfwK8/Gco8IEfMhbJfYKXBAQgN8ZaY+uK/tbF4Xe1FaMsrYHhu/ii1sMp5lzCSl
         p4bIVnVv0yzZjsWcd2wnumBRHMhM0E58dL/1Ski5blz+kLqV0vR+cLd1RyFxOCZf9WfX
         8lB9OHMJ5DCfa1WGbcQEi/lSvhuKLmaiSAErj8xVgxVyRzEabIamNEfKsl3ncEA0bukf
         1hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qesJpivVWpeD2MA2cN4Ziz6Udykcmvft4U33eY4J5aM=;
        b=eFV28lOU6ggU6LVA8is//x78KGP5tmyQavFHsWiDICI/+OtFzx1FBkMaKbF0WaC2qW
         wnNO2kdPCzySI+JUr162pkRbMf05PAWOwujHi7dLPeHAsjsefXn2WHsUvQ3HilIrr9EJ
         /5khH+gTR6QeRgXotLlJJJ8xejDN1g/jf49a331X1b2/x5OHANPQpYGttQjmGaw0U62h
         2jMtoyZt5O6F13Q2UuNky6FthmWd0jX1zj9SXfePriKeMXK54oBlawXbSI4yiozBMkQL
         YcnKEUAYajBKrtw0W9T7PFwTK+po14q2RSjL5t66BYEo4cPg63Z2Wu72c2s9A1/Myqk1
         OS5A==
X-Gm-Message-State: AOAM531I0P69OpU/WbmiWG15NRMsitU8YMM415L7tv+L9Y/iMpSFHZDM
        iP+XLHgL9TpqPGhAnOAGqGn7M6GEuA8cdkegjC2+4Xs8ABR+3Q==
X-Google-Smtp-Source: ABdhPJxns8l4UTEIAOzN7OKePDGlWf/uBjmUUpvEaK+CQWslKzTTsZeXNH+sp1JgZer14sntI+VLmPDcqTizL9onqgM=
X-Received: by 2002:a05:6102:38cb:: with SMTP id k11mr2514165vst.28.1618498832000;
 Thu, 15 Apr 2021 08:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com> <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
 <87r1je2up2.fsf@evledraar.gmail.com>
In-Reply-To: <87r1je2up2.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 15 Apr 2021 17:00:20 +0200
Message-ID: <CAFQ2z_MaqYTWr2haHVF=oiSbYCct+oFpdwD+VtnpKKMFNgvkJg@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] reftable: utility functions
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

On Tue, Apr 13, 2021 at 3:14 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I'd think that rather than duplicating magic constants & one thing in
> dir.h we'd be better off having some leading patches splitting off the
> relevant parts of object-file.c & dir.h, maybe THAT_NAME_minimal.h?
>
> Or: why not simply include dir.h and object.h etc? The compiler/linker
> will discard the unused functions, and if the worry is overuse of
> git.git functions creeping in I'd think that would be better done via
> some test/CI job that checks what objects were used.

It was useful to see how much (or how little) of Git I needed to make
it work, but it has served its purpose, so I followed your suggestion
to use dir.h and object.h.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
