Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1EC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0A5613EB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhGORRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhGORRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:17:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F120C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:14:11 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so6906819otp.8
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymVYEIlwxfsQxoVxUKUsvm5Mz7WSN79RAxrBSDlMWMc=;
        b=iuUdSDaa4h9np537MAL1OJxYRewzKjtznZ+C+lRehQcmIrRu2j1yFLlrggfcpkpmn5
         YCXqNs8TLYTkgWLSn5HjD0YtiYUfVn1A/I8v6hs71nmuhfnqGXy2qKgeJ1HY6jcwrOU1
         vOORXzKT78b3+nM7pkH8keiIc9aYZgcq9y5L90oSk/maNBsO17c19Ofsg93hDMx0L/SQ
         tpLEUH7L9S9nmXUtyy+qHXwnvaQwZmr673oK/RYCPZrLFOPF009hzG87K7CcOFfj6bHk
         v1HT0W4kWGfdt0PQlycEc4NSwklWGl2GOM5LUbSDYVB8Pxo24FMRyeXY80Em/1g8Czu5
         pF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymVYEIlwxfsQxoVxUKUsvm5Mz7WSN79RAxrBSDlMWMc=;
        b=cqqcI8JeCAK5HcZYuOrmdKqGduQGmAAXsyRuuAIJ5HjOtVTTVzqoZqaVB2bzAUdU1O
         4D6DWS6YY1vRJx1VE6rw3av7ox/XVzyRyxrYeoG6mDYersULvFwaIZ5hZ4a5PrFTRCQj
         Ja5zOAaZj3r5wt0qCfLKKi0Ts81cRCbBp4ELktVQO+ETLRJ1PC8xEzjRu3NbSDpFFE27
         YaAl1nBCaGnW6Uygg0mccRSzu+IHACka2We7fUq7NBLPjpkNdChHR4PDz3ThX0prfrUL
         VqcKNsiPGOb/rdK/H20uzNf1l5K2qzFbbUd1oEudHL4xXyT/VWt/kYO51BaOYnKWaZ7Y
         KQTw==
X-Gm-Message-State: AOAM531SePp1T0EgEEpQ4dGLvYAHioSgpV0+ZB/5PyMLmF9JMtywsDsX
        Cu5mGeGLDAjEQP8qNaABQyNuE44cEhlBXm/Y5cI=
X-Google-Smtp-Source: ABdhPJwtFm7FfGuEPEAhOfRjNLwiFjlokuWpFTBrSs/cDz2n/LMHUkA1HMT0U4XbffmpTBghn5nfG6PhexcHfuLtjaw=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr4544041oti.316.1626369250547;
 Thu, 15 Jul 2021 10:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <CAPig+cRZ7gFACO9eNtGmXjt_SG2oviXR7JjuW2w0wZeV7pMjkQ@mail.gmail.com>
In-Reply-To: <CAPig+cRZ7gFACO9eNtGmXjt_SG2oviXR7JjuW2w0wZeV7pMjkQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 10:13:59 -0700
Message-ID: <CABPp-BENqG5Mr4uPzbNQOxaj--f+mMe=fbeC1UTLA_zwqX34ew@mail.gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:00 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Jul 14, 2021 at 10:41 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The --rebase[=...] flags and the various ff flags are incompatible,
> > except that --no-rebase (or --rebase=false) work with any of the ff
> > flags, and --ff works with any of the rebase flags.
> > [...]
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> > +test_expect_success 'report conflicting configuration' '
> > +       git reset --hard c2 &&
> > +       test_must_fail git -c pull.ff=false -c pull.rebase=true pull . c1 2>err &&
> > +       test_i18ngrep "pull.rebase and pull.ff are incompatible; please unset one" err
> > +
> > +'
>
> nit: unnecessary and inconsistent blank line at end of test

Good catch, will fix (assuming the relevant folks agree with my
general --ff-only & --no-ff vs. --rebase handling approach).
