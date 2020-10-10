Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48973C35266
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E62075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scslUvdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgJJW4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbgJJTYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:24:24 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED807C08EA79
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 10:28:27 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id j21so4133698uak.5
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6RORPz4wy8MSn/bZADuLgB9C0yiekKz4s5u5P+RWCqo=;
        b=scslUvdMT/8K+hgcxQuVrC6j/r1iu43bbzawGfxvwBm6mxt5YjJSyMu6H76DwzLI81
         WO2LgCSNHLx1uGwOvCV79moZUaCbGLVV0Ffw6/zhULcnE3KTFMS+nlEun/cV6G8SlkEv
         P2n3c1sJ70u5q7rdYoe0K6lfWLIgjFTHlgplYTf67TnKHHBAPeSB+iuRcStqj3KJCJ2U
         AIVKCQk3r/bcuhmeDbklQxDXSrtiNIqFPqzHIfSoOihmxVCSJl10eDlDfI9lzYBjlDQ3
         gc5LlP6AXkiIxND+ee7poN6Jxgb8HJqchEj4HdqG7llQ5OyknI//cq24F6VQYY9x3/a6
         /FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6RORPz4wy8MSn/bZADuLgB9C0yiekKz4s5u5P+RWCqo=;
        b=Atk7vu0soQrqLGmjNkgn8/Sq3mcIpQqZPGrrD4XDIO0a8tXT09IvDU6PVqpG7ffqc+
         WiipQQSgtPy93K6rcfOXGpmX9902nqCAQkT0DfPaYJJ7jQOfU5cv1YgnOlGm6h2xA58t
         XnaFWrDm3ni0W1BFF4t2jRmXqk5uyuaJXEEswYHEv457Qm/x/QMAvseAGVV5e0d0JhjX
         zehXdoH5gLv5ozpx/tuBSA94FZoVJ4l8Q2UBPXxMoPMDYhfL/e31Tu5uGJKqyeTgfwQ2
         niBiVdL4zGWK0zJDB3AAYYM3bXPwoHqR26OYMUtHdYNll/vmmJWHwThX1veQOXp0epRQ
         S1VA==
X-Gm-Message-State: AOAM533mjB/NHWF/DrUyvzhk+hMqXduC+qGeHlBjEC/adIMncgn5tXAB
        QAdRFnWxGx59udyZ/BLR8SDK5pyiQk2LeAKbv66JMw==
X-Google-Smtp-Source: ABdhPJw4A9cUTkii5NdkogG6cvwoyRcUMH+Kj/LdFiMhyAwXwDC+kU1IKu2h0TJ3lgCueZ9QEof3LKESRwGVgJyrYFY=
X-Received: by 2002:ab0:4426:: with SMTP id m35mr7345864uam.83.1602350898871;
 Sat, 10 Oct 2020 10:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201008014855.1416580-1-jonathantanmy@google.com>
In-Reply-To: <20201008014855.1416580-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Sat, 10 Oct 2020 19:28:05 +0200
Message-ID: <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 8, 2020 at 3:48 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This commit provides basic utility classes for the reftable library.
> >
> > Since the reftable library must compile standalone, there may be some o=
verlap
> > with git-core utility functions.

> I think duplicating things like strbuf is an unnecessary burden if Git
> is to maintain this library. Something like "reftable will only import
> git-compat-util.h and strbuf.h, and any project that wants to use
> reftable must make sure that these functions and data structures are
> available" would be more plausible.

Sure, but how do we ensure that the directory won't take on
dependencies beyond these headers? I am worried that I will be
involved in a tedious back & forth process to keep updates going into
libgit2 and/or also have to keep maintaining
github.com/google/reftable.

FWIW, the duplication is really tiny: according to

 $ wc $(grep -l REFTABLE_STANDALONE *[ch])

it's just 431 lines of code.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
