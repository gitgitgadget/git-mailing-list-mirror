Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4016C43467
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B386C20795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8D/T+xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgJJW4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbgJJTJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:09:34 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E2C08EAC2
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 10:32:20 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id c63so2873452vkb.7
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=66/wvmw4UqfuPEBYp3TqxE0zSzvkU1U9494bQaqwP5g=;
        b=H8D/T+xpbbFAdg2zGbXHDDBm7TwrfSX5h5rrCjOQLuqqymOuiGo01NcysYzy+VVPLH
         u54Fejlf8V/dGE2XPC3c/9B+PnzZ9O7LqZhH3i0opiZu18s54/jVdjB9ElBB/4GwJ7KZ
         BOG2w0/W8mJ2ADm8sfoKUwtM/XuerKBnZYCxVFVK/Q2Qmcpb7fm+CebX8CjRMVe11J7Y
         gAGQA6eu+Sw9TvzUAZ6cwDxdjWjgBdw3W9r4NCU26p4eTnyzMcBFBSyFpC8YFftyCBkq
         yZhpmeA+G7YXRq9tIsMfvOeFXU92qa0QydsyTShkg4Vs6IYlomgZOP+jDkwbGya1z/KC
         tBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=66/wvmw4UqfuPEBYp3TqxE0zSzvkU1U9494bQaqwP5g=;
        b=sckeoTkjhker0PjBnb6BV7WWX2/iXQHIX/5r/aMTEO7ZiixQqpGZgtqT3Sv08+PhCQ
         J5Xh1UbPtWcpb/0pfwZIrZVzAhi1m7Ywn6YN1MDLA3GCfPChmfeVSwLlPuKKppNVmEvW
         fB8i8D+rO9QJNmJOBzhQQ1GI8Leh8I4CpsNfMirYpGx0mYjqoUImViO4x9SJ2t5MrjG9
         nMhDJswib2rwL1GTbn7QximLkYaQPTSMlTRFXSIis6NFo5CiZ1Apq7x0Qt/DDs5ard6F
         XCfrFtqbodUPQp4GU3P7IXQBsy0a3mU72DP7srW5rKqS0dNWvTjCCSbARXhWzG3QSu5P
         u2wg==
X-Gm-Message-State: AOAM532/oPJMv5t4ASAty6IJavjsfzWuHkouGaxsUkhV6fDqE2/MhIwy
        QpTXGI1j//5ug9omxdnTLo/Kp6mzVWpISY4wNsxN8g==
X-Google-Smtp-Source: ABdhPJx2kuAPsB4Wxg4dEpA6ikx0C967sdW0zXh62uRum+OGahzqy6LNspMYeZ7dLHezxaE5J3TKi9k1fEWPwxG/6Ss=
X-Received: by 2002:a1f:1c17:: with SMTP id c23mr10729103vkc.0.1602351138650;
 Sat, 10 Oct 2020 10:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201002041214.GE3252492@google.com>
In-Reply-To: <20201002041214.GE3252492@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Sat, 10 Oct 2020 19:32:07 +0200
Message-ID: <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 2, 2020 at 6:12 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> [...]
> > +int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
>
> How does this compare to stdlib's bsearch?

bsearch gives you back NULL if it doesn't find an exact match.

> > +     reftable_free(a);
> > +}
>
> Are there other callers that need custom free?

The libgit2 folks requested the ability to set memory allocation
routines, hence reftable_free().

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
