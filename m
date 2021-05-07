Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5EAC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F862613E3
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhEGFKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 01:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhEGFKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 01:10:35 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D08C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 22:09:35 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y10so6764586ilv.0
        for <git@vger.kernel.org>; Thu, 06 May 2021 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtlS6bIHOAlyzgI3seSgeWWJ5Rf7pKwGpGMAsi0GLv0=;
        b=LIYoPLU45+95QINup7epY3QvMZ1geDlkfBFwjO8sGi9JAvRa5yW7tLV0XFFF4SXBns
         t04p/XP6k9fj53pvtFzKtfBqCVfO3ZPIZ5eqXnjtfALC47LZ+9aKxENvDbrPhq46htNf
         IJO1Z0QaQmOkTYvikTUf1ukwbglZy6k39NhdXOUZfIRWYLQkCgS76XFkrZLhd+s5DGC4
         G2j+K0akJ+trQB/7YOKn+6tLUqSWm52SdsKXWYYlqm0a4QydUIDov93n+JrM0eg6OGTA
         fc+3nz6dWRyLaOqKEprohwFeKuC/expf/J+Oi8wU4hpCMrIftSmjwZ3H5Y+WUt4YGthC
         8mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtlS6bIHOAlyzgI3seSgeWWJ5Rf7pKwGpGMAsi0GLv0=;
        b=DXxCpb/iiOFIGpbFekmPiV3VW4RfYf19TVHujI86FEj7q5637eYgNMza/mN80tL/Kz
         NEKaLwGBx6BZjxKkumfKAYQU3ECIFFjVnY9y7Mu7ZJDq7ciLcrXL2JhU5jAFVEH3YAbp
         MGriqmV+dY58bA84NW0sHhp7+8RSsEeeDAdHLJ6oPS8f765bBKXgawLBrU/3gvoE7Pzi
         HGVXS1s/pky7IFikQAVn/r63+8xumZUBO2mjIdfjzdZ1fHPfjGQYog5XAW8R8ir5gZFW
         HIQoApx5yDYDkyeR9ZxfjPOAm9CS44zbGROfxvKVSOCNnspMuFaKg/y2Ev4nlS2RlPGk
         oYew==
X-Gm-Message-State: AOAM531k1o366Z87O6X51JJXaTK8nT19m6DHL3w9r222w4ehJdGc2BLs
        uCVEa74H2npT4kIOuhOmBS91sOMYXaWrmf2f1kc=
X-Google-Smtp-Source: ABdhPJwFArNBBB8wbAnOAgTJbmb+7XMUKTrBBwHBfpIKJZVysFNsPa5zKZtQJoG8vu20PjFZMTeTJ9gmK4yOm8up/ao=
X-Received: by 2002:a92:340a:: with SMTP id b10mr7631340ila.301.1620364175417;
 Thu, 06 May 2021 22:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
 <xmqqfsz01vc2.fsf@gitster.g> <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
 <xmqqk0oczao3.fsf@gitster.g> <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
 <xmqqtungxg4y.fsf@gitster.g> <CAOLTT8TQXAh9vu21d5rvaHe=+eqtFU8MCVhorfGmqYRohDThUg@mail.gmail.com>
 <xmqq8s4ry2ye.fsf@gitster.g> <CAOLTT8QWadP9ovrUC_7m86dKh1PsawUyZ=msK5tx1utTpuCXMQ@mail.gmail.com>
 <xmqq5yzvw3kk.fsf@gitster.g>
In-Reply-To: <xmqq5yzvw3kk.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 7 May 2021 13:09:19 +0800
Message-ID: <CAOLTT8RhVZQJX8z1gY5UM1jv0imZ4K9UnD14MgJFfvqBBiAZQg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If that is truly the concern (I do not know without measuring),
> perhaps we should add a member next to the union to say which one of
> the union members is valid, so that you can say
>
>     if (atom->atom_type == ATOM_TYPE_REMOTE_REF &&
>         atom->u.remote_ref.push)
>
> (introduce an enum and define ATOM_TYPE_* after the member in the
> union).
>

Yes, I think so. Since the content of this part needs to be modified for
 the parsing of all atoms, I will put it in a separate topic to complete.

> That would help futureproofing the code even further, as a new
> synonym of "push" introduced laster [*] would not invalidate the check you are
> adding there.
>

Yes, this enhances its generalization ability.

>
> [Footnote]
>
> * remote_ref_atom_parser() in the future may begin like so:
>
> -       if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
> +       if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:") ||
> +           !strcmp(atom->name, "a-synonym-for-push"))
>                 atom->u.remote_ref.push = 1;
>

--
ZheNing Hu
