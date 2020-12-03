Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DE9C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674C2221F2
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgLCUY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbgLCUY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 15:24:28 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D62EC061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 12:23:48 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id b23so1981667vsp.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Un/D9Pq05LGu4plekE0S96T5AdhBSFVtdq/+CYdxQVo=;
        b=eEZfQErAglVXhjF+6E39tp9+c8oTAB18VymsLUK7NO9PD9pJ/IUSBp09Vi62iz6/y4
         Xc0krYngeGEmPa6DEtOdx+gYIZobF9QFyL2+N1nfigzmFE2Ds+R4DTkvxjP+4F0IwVxE
         XmqX+BGCSqi9uOLd9rvPmXuL4eTfCrqb1YDBciO51ntDJ7hduuI2HmsVgdJTa8TVQRNM
         rOCLMI85dP65Hi6EC0hVi3dK2sf5a9dBG68DS5uotRMezzHoBdtOc3RViQ6AIMNaNnqt
         dXaC4IsWUhDsy5M2pd3ZpoFyTJLfdYinUsA2HA6PE+Z1mQSOZ3Gf1ECCwOX7mQeoa0NN
         Ed8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Un/D9Pq05LGu4plekE0S96T5AdhBSFVtdq/+CYdxQVo=;
        b=SNOorC9FVoStu2ZIOIeNirHlSBaf6vAHpfeE+o5zqzNzzaPhvm71JUXtKKLjkV7748
         pzxN40VchCkDb99SyyGRs6oDxQCmiOw3dqihAZc1/sJKFnya26N2/DK/d+1duAK8Wd3Y
         1fzceHjB8zI+QrVWZ5MYl/VxZcB4O7YoABhNrhuG227vSJnqUY/2UNbihYkpOR4MPElD
         QnccAKM3AAVsBc74N2YNGfbrzGfvLwbT/jg4I8DWIoqI8T1oqBQA2WSleTYor4KHCQyN
         KsuwM/Ntjn467IkQURP2pBCb9TlO9g0h7nhAXcYakAEIss47odYgtRCSiqPYc0syJ9Rg
         +IRQ==
X-Gm-Message-State: AOAM532wytpsjXY/w5fshgZ7MzRmWhmaN6XOYv+jCXYOHbbB+szY2Xar
        bAhkplg40yWqMtdW42rcQ163pEIPAVvlYLJ7DTTcvQ==
X-Google-Smtp-Source: ABdhPJysLJda1ZqA3T6C8V3mwspjVADtVrdKOTzwVAlzsyHpkj8Dku8wJ2XDnNT2BiLWDrDbPQYXnf+Ia8fOgkbiFtA=
X-Received: by 2002:a05:6102:154:: with SMTP id a20mr1142986vsr.50.1607027027437;
 Thu, 03 Dec 2020 12:23:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.924.git.git.1606419582190.gitgitgadget@gmail.com> <xmqq5z5mruia.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z5mruia.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Dec 2020 21:23:36 +0100
Message-ID: <CAFQ2z_M3OO_nR6dhw6zzE0orYxcawP1DaJ_EOL5=+RUiZgCo8w@mail.gmail.com>
Subject: Re: [PATCH] init-db: init the_repository->hash_algo early from GIT_DEFAULT_HASH
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 6:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > The reftable backend needs to know the hash algorithm for writing the
> > initialization hash table.
> >
> > The initial reftable contains a symref HEAD =3D> "main" (or "master"), =
which is
> > agnostic to the size of hash value, but this is an exceptional circumst=
ance, and
> > the reftable library does not cater for this exception. It insists that=
 all
> > tables in the stack have a consistent format ID for the hash algorithm.
> >
> > Call set_repo_hash_algo directly after reading out GIT_DEFAULT_HASH.
>
> Seeing that there is no mention of the_repository in the entire
> init-db.c file,

it's not because it's hidden in the call to refs_init_db().
refs_init_db accesses the_repository global variable, because
get_main_ref_store() takes a repository (and not repository_format)
argument.

> Isn't it the matter of passing the hash
> taken from repo_fmt to the refs API to initialize that part of the
> repository, instead of relying on half-initialized state in
> the_repository?

The refstore is created in get_main_ref_store(). I can't add a
repository_format argument there, because it has a lot of call sites
where the repository_format isn't available.

If the_repository is only half-initialized at this point in init_db(),
then why are we passing it in refs_init_db() just a couple of lines
further? At what point the_repository considered initialized?

> It's not like only the hash_algo member is yet to
> be prepared in the_repository instance at that point in the code.
> Most of the members are, except for a very few fields initialized by
> initialize_the_repository(), not filled in the codepath, no?
>
> So, this might have been the most convenient way to pass hash_algo
> down but the patch does not convince me that it is the best way.

I'm a bit at a loss here; I never learned how to cleanly work with so
many global variables, so I'm happy to take your suggestion.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
