Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE417C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E11B65250
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhCIVDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhCIVDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:03:39 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42DC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:03:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w32so359061ott.6
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cirqLpHBEfwL+3LJ52gvBIR/cf/5YowN8phkyhUeYdo=;
        b=ReHA/qROT1mZPJ4S6XWRA/T1SBT9CTmsukzv46u1x2fBqqIdbNCyR1rXRiOEnbWKHI
         v9RHY7NUDOBlruMQne6zUmkN7a+t/eVkhSVCm9H4HRhqQYlv/8iDoVJZdroiggtGnIB8
         xiajs/X+llpRj/qO82N+jEpkc6Zet6kUiPKM963Vzr16Bsl11e4nnkaR8KNz1QMDGmTd
         +GU08HwK0AWJM/U0i/DroSgIJ2hpsi3kE4dhKV0kj0490skS3t5P8iTJT4Pb+hCgEE7P
         se2cMKz3wtklfWqH1BFhzrLVJowUwWL+CfFcGFxivX0jjD2zAnfwdTs0MkRKQ5+m1klQ
         Ri7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cirqLpHBEfwL+3LJ52gvBIR/cf/5YowN8phkyhUeYdo=;
        b=DQAK5B3C2hW9DVJJZ73zQdwvmgIDEJJu1QOgaFpFiChoSK8Oycjc/PGi+zUJM9sQA8
         5L2MDMRGoScyr3PMmfBnUMl2db05CCCOWPabAOvxncdSxYEX1/DjMVHhopQ9kcWcDD6t
         bnIsaV/6z69KG7Oz/UJFUL3xGmccpNP+ZXUurSAQ6TgZcAKjfSR4hDu5kByPrvaJWdFO
         w3tGVrlQjNOeol0hWsGo1djKDyKph2jwWdrvgOJLnfEc8sI0nLwOx+53SrZ8M0C6vdc6
         gSvfjOGb9n9Iw/RiRrS5+jhy5f+oA2D1ZVq1n6gKt5GvnTurX8qw/CuzaIwXRBK1btUk
         SoMg==
X-Gm-Message-State: AOAM530P+VgJRxTO7LAvBMITcxczMk6Yq6TmdhbvXtmdAtKufefdN8aq
        UBXGhSDwXGYMemIygI9zkdTPci9Xo+DQFWISaQ4=
X-Google-Smtp-Source: ABdhPJxSW82CBR/TdpAEWlZhNgNZIGJfJFHTc4B5PaK/0Sb17ehRvNdfBwW2bdz398R7n0UcUZcItFXPG2oxswLyAts=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr49902otf.316.1615323818495;
 Tue, 09 Mar 2021 13:03:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
 <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com> <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
In-Reply-To: <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 13:03:27 -0800
Message-ID: <CABPp-BG8Jox=tgVihxOvHXWC2t2wDvDr8BN2VLBmHrJ-r9B3Pg@mail.gmail.com>
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2021 at 12:52 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/24/2021 2:11 PM, Martin =C3=85gren wrote:
> > On Wed, 24 Feb 2021 at 00:57, Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +that is not completely understood by other tools. Enabling sparse ind=
ex
> >> +enables the `extensions.spareseIndex` config value, which might cause
> >
> > s/sparese/sparse
>
> Thanks!
>
>
> >> +other tools to stop working with your repository. If you have trouble=
 with
> >> +this compatibility, then run `git sparse-checkout sparse-index disabl=
e` to
> >> +remove this config and rewrite your index to not be sparse.
> >
> > While I'm commenting on this..:
> >
> > There are several "layers" here, for lack of a better term. "Enabling f=
oo
> > enables bar which may cause baz. If you fail due to baz, try dropping
> > bar by dropping foo." If I remove any mention of the config variable fr=
om
> > your text, I get the following.
> >
> >  Enabling sparse index might cause other tools to stop working with you=
r
> >  repository. If you have trouble with this compatibility, then run `git
> >  sparse-checkout sparse-index disable` to rewrite your index to not be
> >  sparse.
> >
> > I'm tempted to suggest such a rewrite to relieve readers of knowing of
> > the middle step, which you could say is more of an implementation
> > detail. But if we think that the symptoms / error messages might involv=
e
> > "extensions.sparseIndex" or, as would be the case with an older Git
> > installation,
> >
> >   fatal: unknown repository extensions found:
> >           sparseindex
> >
> > maybe there is some value in mentioning the config item by name. Just
> > thinking out loud, really, and I don't have any strong opinion. I only
> > came here to point out the typo in the docs.
>
> I agree that the layers are confusing. We could rearrange and have
> a similar flow to what you recommend by mentioning the extension at
> the end:
>
> **WARNING:** Using a sparse index requires modifying the index in a way
> that is not completely understood by other tools. If you have trouble wit=
h
> this compatibility, then run `git sparse-checkout sparse-index disable` t=
o
> rewrite your index to not be sparse. Older versions of Git will not
> understand the `sparseIndex` repository extension and may fail to interac=
t
> with your repository until it is disabled.
>
> Thanks,
> -Stolee

This looks pretty good to me, but could we change the first sentence
to read "...modifying the index in a way that may not yet be
understood by external tools." ?  I'm worried "other tools" might make
people worry about different builtin commands (e.g. fast-export, log).
I also prefer "may" and "yet" because I suspect most external tools
(e.g. git filter-repo just to name a personal example) won't need to
read an index format and will thus be unaffected, and any tools that
do read the index format will probably eventually learn how to work
with the new format.
