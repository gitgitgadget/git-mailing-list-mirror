Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B213C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8FA6136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhGNBJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbhGNBJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:09:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD561C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:06:17 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so785957otq.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLTBJ4yBX7Ju3ng800ENPrAnn0sILzAj21g9rYDeyLI=;
        b=acq26Ag3kcGvykW5ZUqrO9d/Ujhmfgm34ZiA75kudeLPTyxzWz2GA3h+BZqW9BXLdh
         qvQTnJnw4Is697gTFgz/QUZyZmRJVOdz9bPabWECCSLkOC9uHT0YCmMSusUL+AuV4UbU
         AdQSpC8pT7Pr9mWEskyUkJukIUyC1ZgLb5tavjGWSTqlR7DvMhSevHPEyCPCgoeU512/
         jfWSGhsd7faCKtXtKw8LAmpFQ1r6KZLvxTE1qQEveqNk6Nfv+mwfpanmsPtgOhwcLIXu
         ds0tZyPFhMLubnXUkPEEOsM3HqslYubukkxJAEU+imj2rLpCS4WPQ38JIpCCpIP/eDEM
         qCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLTBJ4yBX7Ju3ng800ENPrAnn0sILzAj21g9rYDeyLI=;
        b=snZzgq3tuKDuSKanfGd9Can0Gyai+MZXZDZtWm+26MUIbrHSW9opAltM7SBcgWlUMS
         xT6vMdovfnlWB51zqYRx1c+AlpQrKUVtiOseT6wwNqfrgDQWbD1WKri0OWEBgPGp3wDH
         UAPQjaBNHqvOqAa4IcwPyc5eiexVvaKI4XGHjPVgnTc3j4DrVPAuNq5OiMlzWFIklWPR
         gB6ctzLo/KhyJkcfbl63gjeLnTVjQ0UK9qyZDD82xsZ5EhvmQFoboX/1ri7GQSbCIt5R
         4pfRBRyQiOIOIODF1t4eA1OghvqQ8GOWVhD/QmSaSRzjB/cJug39i3Vgha+z6SRvtUOT
         E+bQ==
X-Gm-Message-State: AOAM532zAhCS3Rr4UST1rZ/+X9KM/lNSmXvop4qe2fkShhKvQ729MKGI
        5RlYLs0luy7DyJbnwqAaHnwILgGcZh1L3ZFqB3I=
X-Google-Smtp-Source: ABdhPJz5VKKxEu7bOBiZGySDgfHMo+cQ0VaY/06lerQWHH9pR+dpAD/LPrqZh+EPGpqFXm1KuBkqvIBlD7XS69IFhW8=
X-Received: by 2002:a9d:73c1:: with SMTP id m1mr5804601otk.162.1626224777149;
 Tue, 13 Jul 2021 18:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
 <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com> <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
 <xmqqzgupzppb.fsf@gitster.g>
In-Reply-To: <xmqqzgupzppb.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Jul 2021 18:06:06 -0700
Message-ID: <CABPp-BHdAZYPf0QPOTiekU914u6pNxUSRQEmdN0xOLGv5hdkzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit exceeded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Mon, Jul 12, 2021 at 8:09 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> Since the steps that find inexact renames without the quadratic
> >> algorithm are heuristics, perhaps this portion could instead be
> >> called "exhaustive rename detection" or even "expensive rename
> >> detection"? It perhaps implies more directly that the limit exists
> >> as a way to prevent an expensive operation.
> >
> > The name "exhaustive rename detection" seems reasonable to me.  I'll
> > resubmit using that term and see what folks think.
>
> Funny.  In a sense, since computing content similarity is _more_
> precise way to find a pair that is a likely rename than the more
> recent heuristics, the more expensive "exhaustive" one can be called
> "more precise rename detection", even though it is tempting to use
> "inexact" to call it, too ;-)

I'm afraid I'm not following.  The more recent heuristics use content
similarity as well; in fact, they use the exact same function with a
higher threshold: estimate_similarity().

The exhaustiveness of the quadratic portion comes from comparing each
file to more other files, not in using a different type of comparison.
