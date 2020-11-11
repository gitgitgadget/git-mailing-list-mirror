Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B199C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDA2208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG2qHHTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKKUfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:35:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B00C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:35:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so3525047wmh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tDtBrUaK7qJpAbbmi54X0IKWwQwAPRm//prAbcoq2Yo=;
        b=EG2qHHTm/q9DOD1po9vIu8RiprZu47ebZTNfEzxbNSvpLBoan0D7daoV/0IcSUQ0sD
         143/0p+jpILZtAOVmzQ41PT9Xisnmt4UhJj/MdOWfrfhAVYPU6i7zvhjbwb0ILXDXg/Y
         j5IFv8CSTVNxL4Wcz1PTcu1TipSzji6y6lgZvNT77b+0ybAEiJsFS6YA65OOqR68jdQn
         HC1do2KgGKg7KJwCAxeSkV87/8AR+D4NYjKYrM76t0v0t6bOFsCsOylDMG4QS5Ua7Et9
         YLZ2ZaP3fXc/VKwn54TibEFiJ5XjlhEfbOho29fc+ZN0eI7p6jA27mFJjSOoxeRlXVtq
         k8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tDtBrUaK7qJpAbbmi54X0IKWwQwAPRm//prAbcoq2Yo=;
        b=lJODkkIXyB2hYB3pr1IGXHnKMI0iJOvUve763fDexBLy6wZVMLvUkFmilIY1//4XQH
         zwt/23Eb+JpdP43Y63FSBuwOE8FlSDkilNS39dQRgYG25o+E7fveDtqgiuNk2X0oFgWh
         ZJAmFxEwOkwtZF8J88uu0CEleqvqtGeevmKAuUK01i2gQT5xvWADIxkNGf0BUI3LtB5n
         sFpUuvW5YopSxMfINB1vkiGiDWqiofh39SG9KnV0UHr0b9k/XYDY+gMdM0Rx7AE0aPpS
         QzZABSrVmAzLGLs9nxApnXvbQa89gmYy1XhpcdQgB4H3VUSttfO8cOoJaQqPoK/75xZN
         PFIA==
X-Gm-Message-State: AOAM5335he+OUHzCSAoZ0dYNfxlYEgIn6IS9BVkWR1zd5/A8qDJhgdPK
        exwA43dMom2T9cSP7lj3Fedr7/JrSeKvZ+NM2Uc=
X-Google-Smtp-Source: ABdhPJzU9h9e9jazM1WDS3iL6+mooPeqvnyowS3UAiZ5svpNBj6gD5ziSTN0rPHwOTTO1SYEby5USYagZXO2O40JuOM=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr5804459wmj.37.1605126910606;
 Wed, 11 Nov 2020 12:35:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com> <34f542d9dd846da5fd81274966ee2ebe0660dcef.1604622299.git.gitgitgadget@gmail.com>
 <fbaa60c4-ee6b-02b7-68b5-e5873f8ec713@gmail.com> <20201111190121.GE9902@coredump.intra.peff.net>
In-Reply-To: <20201111190121.GE9902@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 11 Nov 2020 12:34:59 -0800
Message-ID: <CAPx1GvfXMnhgQDan7N=Y4WWdcS6p6WrekYkDyfx4nwnDtSuMQQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] strmap: enable allocations to come from a mem_pool
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 11:02 AM Jeff King <peff@peff.net> wrote:
> Even if we're only using a pointer to it, we still need a valid forward
> declaration [in a function, but not in a struct definition] ...
> I'm not sure whether this is a seldom-seen corner of the C standard, or
> a compiler-specific thing (though both clang and gcc seem to allow it).

It is standard (and not all *that* seldom-seen, in that many compilers
have warnings when you put these in function prototype scope).  The
forward declaration is implicit, and occurs *in the current scope*.  The
trick is figuring out what the scope is.  At file level, the scope is "leve=
l
zero" as it were: file scope.  So it's as global as we get (C separates
"globality" into scope and linkage; *variables* have linkagebut *type
names* do not).  Function prototypes, however, have function-prototype
scope, which ends at the end of the function declaration.

Overall, though, I agree that the nicest style is to have an explicit
forward declaration (in C that is=E2=80=94note that in C++, struct is just =
a
class with everything public, and class definitions have scope!).

Chris
