Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCB0C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhLVSNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLVSNY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:13:24 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A78C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:13:24 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id r15so5918440uao.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ISBpZRK0Y9WrsGoP/6iORN5wzB3LjPjbaLYluFrhZ70=;
        b=l9PFKkoEIlAdIKYFJG09lUZaHru4qP9/EAqhwKlK1Xh9+eKmplqdg9aDHGUFNnfCIc
         ce1dKC7nrjmESZjIgkNeY5GT9W2XK79IGD/STe2m0gIjguu+B/xNCyGvf6TRkd66bITA
         uUmHySxjiM5d9vo6zFR2Qrk3jPnhvXp7GWtQpCAvyN3Pd3/rR3dbZCNrgDHlPdwPG4Qu
         ZxUN+UKXbScbzC4x0wpXLiToOme+ceovmzx1oItWM+5Zr+apFJMHBL6z/5ARInIPyfVT
         lxSpGkdiYBY0B1Z4F6RKGgJm5aikUZUOuRvEM7/RsKEJoLYCDcYRILMOdDIW/CJ765rQ
         LQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ISBpZRK0Y9WrsGoP/6iORN5wzB3LjPjbaLYluFrhZ70=;
        b=d1VcggUauRB3qw4O6LlnBwXSXdcEKIcBM96sFw0hIKrn+zpmkzcyAXOL3sjHuv3/Ti
         MUimNIPnNR594SLHvOvRAehvkJ6bhdsVx5nacHQsr4LQE8fE/wST4Lc9J1PWieVKgYex
         EqziF74x/nFA5iNjpjH2VMz0gWS3qSgRcebHuXN9lQSvhmn0dCRIvO8NloTiBLiFSxNo
         S+xG7XDOphrWysCcgEY1ha89SvBByQisrmtAR5Zm/c5/fMR0j3C4iK6zo9VAZ6t6CO25
         QL7bJ+r5z3Ui1ZNr6ouRyF3r/P3+jSJOIZidJjER6ClDgi8Oq00UawhAUR3Hbjau/1aL
         Ke+Q==
X-Gm-Message-State: AOAM5323fhUWAV43+XngXcKRk7vB95pprcdv9RVm2D5W05y2j24tCRIj
        hqRZcIjHxwg0KQ1Vr7f4YMv/4NBhtmOzM8YbZ5shPbyZr28=
X-Google-Smtp-Source: ABdhPJyT41zQ+sJ6aZQnnHlA9N5mKzW0c0slwoUEJ2veIG3CdNF7GRb5G0E/AkxS8w4mR7rrkFdcFBPhIf4EOzSmtJw=
X-Received: by 2002:a67:e15a:: with SMTP id o26mr1425924vsl.83.1640196803293;
 Wed, 22 Dec 2021 10:13:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
 <75e5392032dbdbdedf8a2b76a7098e4dc1133d82.1640090038.git.gitgitgadget@gmail.com>
 <xmqqtuf1kwob.fsf@gitster.g>
In-Reply-To: <xmqqtuf1kwob.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 22 Dec 2021 19:13:11 +0100
Message-ID: <CAFQ2z_M7S_gC2AfuPZptYAY3E2XmUMhQONq5iv90OJZHXWrq-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: set the repo in debug_ref_store.base
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 6:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This is for consistency with the files backend.
>
> Hmmmm.  Could you explain what it exactly means?
>
> I can see that files_ref_store structure has the .repo member and
> files_ref_store_create() uses it to remember which repository the
> ref store is for, but that is an implementation detail that is not
> exposed outside the files backend, isn't it?
>
> To put it differently, what is broken with the current code that
> leaves the .repo member in refs->base uninitialized?  We are
> presumably helping the caller that wants to know the repository the
> ref store belongs to via this pointer with this change---what is
> that caller?

It's confusing for the base ref_store to have fields that are
sometimes set and sometimes not. I sent an alternate take on this as
v2; hope you like that better.

(sorry, I forgot to update the cover letter.)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
