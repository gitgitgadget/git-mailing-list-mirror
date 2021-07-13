Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF7C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0875A61003
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhGMIQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:16:51 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4BC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:14:01 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id t5so349197vkm.12
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7kKjw/kO1JGEGyuifo3yzb4sxCAx+t4Z38/XA3Pbcig=;
        b=hlk1adOgjOBRPHzEJjZ7wveEItYHPeHgff2D7enhXqL+H2hVegTTSR+w9dzw74MZUm
         t2p5yJQ8Xf8S1wLQf4hcRriEzQOK2ryg03pr9C8Zc79ASUAYgAwm2FrICusY+LSczM3t
         9rLICrhoBwx9jWDIR+5nWuTgXsI7oLMay5qjhvxff8K3LWguHWumQathU3YBISX3hlJ0
         eoSsrvTP1o9N7TjtpRHPvUe91qS+DV76mL4aigWqNUnA6tChcdkM8rMBQ/KV+BakQd0G
         Oo6cTFm8IVj5g7IArWPkFcipLgZmoujqE/GFls82dCxlL1/+zM8ZS8LrsNob5pjrjGPh
         RwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7kKjw/kO1JGEGyuifo3yzb4sxCAx+t4Z38/XA3Pbcig=;
        b=HJS8jNV9ZDw+RFYBh+k0WiMrtq83+3/+4M3sbWWzvv9QKFwLh95W2wNixYqyl98/52
         yQayW/OCx0DlJg2pq8Uq09mlFvmCey+FQcao9vuKGYJTX7N4L6EvhcsP+JBFhspeuP5E
         XtQrBflg+Bt/w0zNw5HWr2+w4eAUr3VxtYiI6wtVWjp7v5ykB8tk+cROLeue1L2zpPLX
         komttMyu+CqxvVwL6vnXLKGH/t/UBmuHLD0JCA/6ozBMqk7Ynyf7x32XFSxaNCjEaH1j
         U5untEdv+kcJq/Uqb29GrU0ZqIIjnVpyiNqr/dPZ2FvPxP1NlbTYyROVovX7Ph0pJAzW
         xOGQ==
X-Gm-Message-State: AOAM533Uc6mNvm92B7pkE7nXTcSfzjaKjIgNEVcWof+X084CG0Vd0bMk
        lBOZYAaeUJcbpz1LD0e1+w1OFtLyjRXDJjM4URnB8g==
X-Google-Smtp-Source: ABdhPJzgfpBC/bsBkj2eukKv3JruqF3eFB6QrFtlFSHcquKP4vLNWKDFcgzwIU2Ayk28jsvwfGo/cy6YCqNyBu+4NZA=
X-Received: by 2002:a1f:a685:: with SMTP id p127mr3707960vke.1.1626164040146;
 Tue, 13 Jul 2021 01:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com> <patch-15.17-446b50280be-20210711T162803Z-avarab@gmail.com>
In-Reply-To: <patch-15.17-446b50280be-20210711T162803Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Jul 2021 10:13:49 +0200
Message-ID: <CAFQ2z_MNEb=tb+iVjE3n33Lq8tfKNKnaMOvxm6z0cwXChbuSQA@mail.gmail.com>
Subject: Re: [PATCH v6? 15/17] refs API: make resolve_ref_unsafe() not set errno
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
> +       refs =3D get_main_ref_store(the_repository);
> +       head =3D refs_resolve_ref_unsafe_with_errno(refs, "HEAD", 0, NULL=
, NULL,
> +                                                 &resolve_errno);
> +       if (!head) {
> +               errno =3D resolve_errno;

This adds another place where we'd use global errno to communicate.
Isn't there a die() function that takes an errno value explicitly?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
