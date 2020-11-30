Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23357C64E7B
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4B320684
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S79ULs8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgK3O1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgK3O1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 09:27:08 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A6C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:26:28 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id p12so3793775uam.1
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=11iZIUDDoagOHUOoIdm9rARB1Du3VyphodrcMxaXrBU=;
        b=S79ULs8oFZsJ1JarJ7Bwp1gPwDEHzJV/EIhKesujXAp/la8cQNiT1dD/QVMbulNza8
         W4lMAF2KRKg3WiY5pdytmUt2SFVIG9JVEOVs6Vlk8PM+mISj9JbX1jgQJhrhuChh5j4M
         +tRvKVjy2wAMJJFSqX+d3Vb1l22fUSVlxr5hWUpVoMCpoPA/u2zJLM7tHpSeaFkF7El8
         QQAo2Xydv6zaVEKSvhEkaVGnEzFLvW0XL3ZwAAkGxlKk98Iwfa+C36Iz8qz8qQI7FMhi
         fVKPkCUCJhSCHDyKkWOi6Ah173yVFvbAa0D1Xosp+ujK+AOrEuJgTvkPuy1Iq3zRNffc
         wiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=11iZIUDDoagOHUOoIdm9rARB1Du3VyphodrcMxaXrBU=;
        b=iRgdZWoDB9WluA8KcU1wpjM79jR4+Idr4KG48JbADz+9Me/CiUGGUu7Z9PPzxTlidF
         SttfmQgvqDDqMQwR642JW94cnDX3aBhXDVX+MBs47ukfh67lSBTb9hgek7HacxV7VaaC
         qQ2K3uSOngdlsLndkWVV/P9NUs1RJCXqHQAgxUuVgRMziLP7sbLyfPA/UFOPoq40HCh3
         X33Um7AGqlPk4Ix05jd+8OTLynInbXpLRr9YZwLU8LUCsV0gnjmfHnPscMJZtsTnOGcM
         RnbdOE89DVCBfDOUWcWivES3J7DVSqmWWt+bK2thlxVN/nDr3mG39rX2prv+/Qu1uQ5q
         /w9A==
X-Gm-Message-State: AOAM5324PRXCeW14Ew8FOsvGr48OjYmaZ4lF7wqIG8SUd5BSqt3/SGFu
        HmJWBoLWdDh7V7kbgSJrFOoryaLgfkJR7iURzmkj8VjastP75g==
X-Google-Smtp-Source: ABdhPJxIzHkOuv5hzFXxcuRtebjPOMR3gJfSK9SD7+uC0UqGw36JA5F7yHuE8Kg690JUdxMcBazCC3EPqjo3eC+sQdY=
X-Received: by 2002:a9f:24c7:: with SMTP id 65mr10452400uar.112.1606746387748;
 Mon, 30 Nov 2020 06:26:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Nov 2020 15:26:16 +0100
Message-ID: <CAFQ2z_M8N-9pCh=+rQvGoOJNYAxnMo1upJPEgsqMT9VxP5X=YA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Minimal patches to let reftable pass the CI builds
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 28, 2020 at 7:44 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> These patches fix the PR build failures at
> https://github.com/git/git/pull/847/checks?check_run_id=3D1460683728, and=
 are
> designed to be squashed into the 16 patches of the libreftable v3 patch
> series as submitted at
> https://lore.kernel.org/git/pull.847.v3.git.git.1606419752.gitgitgadget@g=
mail.com/
> .
>
> A smaller form of the first patch was offered on the mailing list on May
> 4th:
> https://lore.kernel.org/git/ff60fde10919b6b8c54ecb8f38b710fac37624e3.1588=
599086.git.gitgitgadget@gmail.com/
> . The next three patches were presented to the mailing list on October 2n=
d:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaq=
bjf.bet/
> , and
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaq=
bjf.bet/
> . Some of the patches required slight adjustments to accommodate for cont=
ext
> changes.
>
> Going forward, I would like to avoid the impression that it is the
> responsibility of the Git for Windows maintainer to keep the CI build
> passing on Windows. I am happy to assist in case it is unclear how to fix
> certain issues. I am not happy having to implement and test those fixes
> myself. How can we ensure this doesn't happen in the future?

Thanks for the build system fix. I think it's OK to leave it to me to
solve the logic problems in the C code that you found.

Would you mind if I massaged these contributions directly back into
github.com/google/reftable? Google has a corporate CLA from Microsoft,
it's OK to accept this from you. For better or worse, this is still
where I'm developing reftable, until it has landed in git-core.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
