Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD32C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7AA613A9
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhD0JPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhD0JPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:15:13 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D505C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:14:29 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id o17so12778231vko.8
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2khRl4k1IW/uMTbEcGYN+ttfXXx0wwqjZO9MzTG6aI8=;
        b=lV7dfZ8xqM9HjXJ0v+EjLJ7d0Z0DVA//dirN/MUq7jz1BUXYtJNB/2in5QeYQf34mf
         GFpG36tF3sCIQNvU++1B426oNe/pTxBDdF98W1GIhMROypi69s/BcFBqcz86pRPGnvnO
         xiY3rBuTu7rsU1rUrkV4FtIA6ItY/2NijG4Iv9S34zjN+XATcNmfz+xuFS3aYrvffyKk
         oPGMiiCmfI7rlBNbs5ArF02wXZcNXY6gYwZFnoGOn7X/KxiEOZgO7ahhSV8hxupKBDVd
         yihOTYojKMFGHyYqlZrpvqeLeAloAS4KfoK5pw5TNQRCDG1CazxHTIP7wvFmMl/bnBNK
         g7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2khRl4k1IW/uMTbEcGYN+ttfXXx0wwqjZO9MzTG6aI8=;
        b=Mglpsu8aPdN121PFmTpJpml6Yyk9U99VwwwCzwl5oLsL6C8biP9ZLkDCPb5srEJJeL
         BwurbscyROJSynxrgPCDm2wGHNLIphRqT3tQovW61L+RQszCPN23DqsWr56BkR6caztP
         Bslk4+JFS9Y71y1t4IzWVAv2sfbXbec9qWzvbprag+3pZYYdpbEa1I/jqDCpnFRVv01D
         yhLkdhd24Zz+X6mOq1b/fwVg8GSZL6PgM3JpXxcccoasKBnxghfbf6DAnk+Y0n83z9HR
         KKRqrBXMAlDdRlQfrn3qTiLm3K5OIDwkH/5i1NDl/As1pBcHnXPoM7jRAgWZoDYgibmN
         SOcQ==
X-Gm-Message-State: AOAM532PKkkWP22re2QanNztPni+BsykSJaBydw2wDN7vzOAdqKZQ8zf
        CjXPfks2FXZX4QUhfOJRxC5mwVCGhVXJdboMprC1ow==
X-Google-Smtp-Source: ABdhPJyHefZZKKQFe++wXLd7MpCPVY/dZXBlQJW+bi1e1tYJLbAeUoYq751PZ0Mmxk5soMERJjNf1xXMHkDxRxTW18Y=
X-Received: by 2002:a1f:5c97:: with SMTP id q145mr16393130vkb.25.1619514868105;
 Tue, 27 Apr 2021 02:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <91ef012cbcc9a3106fa51236e20458f108e50ce9.1618829583.git.gitgitgadget@gmail.com>
 <20210419211108.GX2947267@szeder.dev>
In-Reply-To: <20210419211108.GX2947267@szeder.dev>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:14:17 +0200
Message-ID: <CAFQ2z_MzjQyaqCkoy7mpwf+gFVmFktaSiPdQc8KbyAKGNkPb2w@mail.gmail.com>
Subject: Re: [PATCH 01/18] t4202: split testcase for invalid HEAD symref and
 HEAD hash
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 11:11 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> > +test_expect_success 'log diagnoses bogus HEAD symref' '
> > +     git init empty &&
>
> ... and this test create a new repo in 'empty' as well.  Or rather
> re-initializes the already existing repository there.
>
> Is this intentional?  It surely cases some confusion.

fixed.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
