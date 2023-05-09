Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D614C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjEIBcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEIBcY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:32:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E39422E
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:32:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac87e7806aso45205651fa.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683595941; x=1686187941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAr4pP76RkLfkXuv0Uo+tZMstHwYx0igqXPx1frY+M8=;
        b=GC+yakUPnTmflFGskxkWPL+yvskW1CIyzxIybYa5UyIvJD9k1czOkf+RicEUwOmgDh
         HmDLELr5nfX/2DeuRVp8ScWfDIvUNjO1M8cBJv+Xpbo1VhegIPjDEByQPPHEnwSC2wkH
         yr5tRfhNyyWeB62ebcAv4LgXzBEk9yXTxsHc6fQ/iTOoxIouSsk4/GEe1BZQWp+8HiB+
         FkVyqadrCJ28IdhBF1IDsQ1EhkEmpwZHsrTcE7lv7H03IC5jqCYKt9iN8JcuODeizu5V
         vCYfRYm3l/HeKcYBmLnnNOYardEWM54BmiYjUtM2XSceGrppj5UKMP/3VizoRXlPqSu+
         A9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683595941; x=1686187941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAr4pP76RkLfkXuv0Uo+tZMstHwYx0igqXPx1frY+M8=;
        b=FyIPaTjXkUxHdt2lcS9gCe3g22t/AnyYcCmsGvjWiGl5M8sfrbo/wMGE2odfrVO6XC
         AN5Aocm3SoMfzmQxijOwnu7Rfm+CmxfnHY6D4toPUY09UxuFc+lx68sGHbiSAzy97xiO
         Nknb0RUBFQf4/VcY8ZGypSt07yLgV50/60is9IDRaIBXkrErMlGlQFGBIyDoEi8StHba
         6zRGJp43pwLwbKGfe/5XK5w8iORugOyWF3YhLGolA7CPgVP4B6FlTMNm0+z/OPo1640k
         EUoKfyCbFGFaRPYQjgBTh++jAClubo26BhYSSDvLSeM0mdygkMKaRY53TD6mwR0ZUw5P
         djiw==
X-Gm-Message-State: AC+VfDzmizqc+p6v328xYZoadDlcNJV9TKAgKs5hjyXAa40rfQB6o2Kg
        Se1N+IkyeCWJASGn1MOpgKtO+oOb63Fan7+Ux/Eh3mrGgjs=
X-Google-Smtp-Source: ACHHUZ7YKH6qYvL3mZI7PXMmwCa25qgmERAnPC7Y9bk9Bnq6Er6TpqXz+jNbTNvfcOaPqZqDD0TPy6vE44lpVYWQfRs=
X-Received: by 2002:a2e:7203:0:b0:2ac:819f:f73f with SMTP id
 n3-20020a2e7203000000b002ac819ff73fmr246363ljc.20.1683595940642; Mon, 08 May
 2023 18:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com> <xmqqzg6ergdp.fsf@gitster.g>
In-Reply-To: <xmqqzg6ergdp.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 May 2023 18:31:00 -0700
Message-ID: <CABPp-BErrVUnuDjL73edDpmkKUvs6Ny6cYwvueXw1toB4JcF-Q@mail.gmail.com>
Subject: Re: [PATCH 00/24] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 8:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>
> >   hash-ll, hashmap: move oidhash() to hash-ll
> >   fsmonitor-ll.h: split this header out of fsmonitor.h
>
> If you are introducing a bunch of -ll suffixed files, wouldn't you
> want to either rename them to ll- prefixed, or rename ll-merge to
> match them to make things consistent?

Sure, I'm happy to rename ll-merge to merge-ll.  I prefer a suffix
since it is common to see files sorted by filename (whether by Git or
by the shell) and the suffix tends to keep similar-ish files together.
