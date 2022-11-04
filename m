Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801C9C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 04:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKDEYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 00:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKDEYi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 00:24:38 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3021266
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 21:24:35 -0700 (PDT)
Date:   Fri, 04 Nov 2022 04:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667535873; x=1667795073;
        bh=cZIBDRTbAXL9tyD+IkQntLprvnElLvAQJuaYFOp0YH0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aRw6uh1ftudQgnIFTVZpq+RNbaGt5xwvzIP8M2MtMl6ECRhKPZbFEigrGQRCyXjKi
         Kqg/sCjwNrgFGbEaAMWE/mpKisrHyVGIS8Llu/6SDstexYuN4iizTYyIvB1KTrojc9
         xkawUhrWJG74UQ6iXdSmWwJrC3etELkSnwtNPROSuo4pbODSBo27cxc0uHw9qgCUHU
         YCKRKN7VJQibtaSBfrDKMC5GAjnN1EnXmUzap1uWQn/cEJ5+/joBkY7TJ4sg7rEsVQ
         ZJjx9q0PmFaPYId1KYSAv8CGflF1FhoicY4hZhdaODeJtTzwlRw0tG4Eq/PPdfbekj
         MnGJs1bd8LyhA==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] worktree add: Include -B in usage docs
Message-ID: <20221104042422.p5jv4thc27zkiiwr@phi>
In-Reply-To: <CAPig+cQA2b6-WVvSjb5iopFO3hmB1RveEBNCuwAXBVa8sV-6Og@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-2-jacobabel@nullpo.dev> <CAPig+cQA2b6-WVvSjb5iopFO3hmB1RveEBNCuwAXBVa8sV-6Og@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/03 11:05PM, Eric Sunshine wrote:
>
> Thanks. Some historical context...
>
> Omission of -B from the synopsis was intentional[1] for the sake of brevi=
ty.
>
> There was a previous "complaint"[2] about the omission of -B in the
> synopsis. A response[3] to that message suggested that a patch
> addressing the shortcoming would probably be welcome, though it
> appears that the author of [2] never submitted such a patch.
> Summarizing [3]:
>
>     Whether or not the omission was actually a good decision is
>     questionable. [...] Of course, that decision does not assist
>     newcomers, so adding "-B" to the synopsis would help the page
>     better stand on its own.
>
> Which suggests that this patch is probably a good idea.
>
> The patch itself looks fine (though the noise-change in the position
> of the "\" line-splice seems unwarranted).
>
> [1]: https://lore.kernel.org/git/1435969052-540-17-git-send-email-sunshin=
e@sunshineco.com/
> [2]: https://lore.kernel.org/git/alpine.LFD.2.21.1711140324580.12112@loca=
lhost.localdomain/
> [3]: https://lore.kernel.org/git/CAPig+cRc7Yqeys=3DoPEgPnyR4qT7qKYLbH1ifn=
p+6F6N+mSzNVA@mail.gmail.com/
>
> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> > ---
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <str=
ing>]]
> > -                  [-b <new-branch>] <path> [<commit-ish>]
> > +                  [[-b | -B] <new-branch>] <path> [<commit-ish>]
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -15,9 +15,9 @@
> > -#define BUILTIN_WORKTREE_ADD_USAGE \
> > +#define BUILTIN_WORKTREE_ADD_USAGE                                    =
                    \
>
> This is just a noise-change which (IMHO) makes it harder to spot the
> line-splice. (Presumably this whitespace change was made by an
> automated formatting tool or by a "too smart" editor?)
>
> >         N_("git worktree add [-f] [--detach] [--checkout] [--lock [--re=
ason <string>]]\n" \
> > -          "                 [-b <new-branch>] <path> [<commit-ish>]")
> > +          "                 [[-b | -B] <new-branch>] <path> [<commit-i=
sh>]")

I appreciate the context and yes most of those noise-changes in this patchs=
et
were courtesy of `make style`/`git clang-format`. For v2 I'll clean out the
noise to make it a bit easier to review.

