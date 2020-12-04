Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA56C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CC822582
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgLDSeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbgLDSet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:34:49 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A2C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 10:34:09 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h19so6151913otr.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 10:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhARzHTxHaLbC77FcvBd7RIj1H0ZjPsXaFzvzBYZaP0=;
        b=IkzjzCyl3hs3FidQXKupGlkCWLbAZ53GaDbLrTDWUEtLWT6zeSiMd66270VCcDv6wY
         XWrqaIVf+eNeosmiyHmJ5TZxLlypXBJZhd0yKsxB/EFoQrdq53fetcvj2SWsYoZ3RoXi
         B4PzgCDSJe/0dib7Pdho5QZk0ZQUwGjVk1Pq8mTn803nBDAll+vUGddquMOAxHuxwoo6
         4D+e4SBVBapA6SZHaaEHSFhpYcWfu8Arva5LxUuuXmgOaC9GIitGFsnObSWmBBsetklY
         QKFI2SbU2KnrpPmRx3q263nalUWCWHN5CfxAUW8/ohe5uibTkAQ8c58JhOUa5coiaDzc
         L9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhARzHTxHaLbC77FcvBd7RIj1H0ZjPsXaFzvzBYZaP0=;
        b=i58s3kR7rtEjTPBKdh7oC68HV843bql+REky7T0M+Pi6CGXYa5DD2MfCmBu1zd3uEE
         8faJCREdWEQ1zR5lKA7rcd6A2aL9xm4URCNC3fsThjTIQElsI1nWkqoaNlnfuDlbWnWR
         89T3M/4W0oi/HwsvMSXXg6x8nruocrL5X7Y80wrGI/IhgUz+BhbrMO/gWcNfhZrPK/eq
         4fsFHnT+ljz70AKRPNc1fX36rSuehWtwCJmeVtf2uytj59GWeuN11r0vbiw+Eav1PE+v
         TXjVvcuwfhw0QkKOJwHLaclefSh/wdUngdB4Mthh8M2EYNSxknEDmhwJa0PCnevn5+4V
         KRDg==
X-Gm-Message-State: AOAM5312WslWza1xzWX0CwFPa7xVRFOz8RbEu+dCDTijrEooFpJsRNuI
        N4EkvWcJpoMCDXcy66hGkkFgR0c1Rl7ATTVlzh8=
X-Google-Smtp-Source: ABdhPJzBxUFE2gbWf8bOKeRG1KdOI4e9DgnIAyop3KmEuTCfVZRsGbg7jhfpnxjb1OxemHmxC2pSvNu2z/9gdxOD9Xc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr2691904oth.316.1607106848597;
 Fri, 04 Dec 2020 10:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <20201108213838.4880-25-sorganov@gmail.com> <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
 <877dpyhefj.fsf@osv.gnss.ru> <CABPp-BEyiLDZ5Ums1D5gL679EMmKXpqxWDF_xGT4scXLMkwseg@mail.gmail.com>
 <877dpxpjae.fsf@osv.gnss.ru>
In-Reply-To: <877dpxpjae.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 10:33:57 -0800
Message-ID: <CABPp-BH1ORV8XYzM1ESH8NibAb2B-OszqZ6r2xnU2pxvR5AZwQ@mail.gmail.com>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 9:34 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Dec 3, 2020 at 11:34 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
>
> [...]
>
> >> >> ++
> >> >> +--diff-merges=(off|none):::
> >> >> +--no-diff-merges:::
> >> >> +       (default) Disable output of diffs for merge commits. Useful to
> >> >> +       override implied value.
> >> >> ++
> >> >> +--diff-merges=first-parent:::
> >> >> +       This option makes merge commits show the full diff with
> >> >> +       respect to the first parent only, exactly like  regular
> >> >> +       commits.
> >> >
> >> > Not sure that "exactly like regular commits" is helpful here; I'd
> >> > personally rather cut those four words out.  I'm worried it'll be
> >> > taken not as an implementation explanation, but as a "this treats
> >> > merge commits in the natural way that regular commits are" which users
> >> > may mistakenly translate to "it shows what changes the user manually
> >> > made as part of the commit" which is not at all the correct mapping.
> >>
> >> Dunno. Don't have strict preference here. Git has no idea how the
> >> changes in a commit have been made in the first place. Changes are just
> >> changes.
> >
> > If you don't have a preference, can we drop those four words?  ;-)
>
> Yeah, sure, dropped.
>
> >
> >> To my excuse, I took this from git:5fbb4bc191 that has:
> >>
> >> +Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> >> +will never show a diff, even if a diff format like `--patch` is
> >> +selected, nor will they match search options like `-S`. The exception is
> >> +when `--first-parent` is in use, in which merges are treated like normal
> >> +single-parent commits (this can be overridden by providing a
> >> +combined-diff option or with `--no-diff-merges`).
> >
> > Yeah, I can see where you're coming from, though the context change
> > feels like just enough different that the four words you added bother
> > me a bit more.  However, this existing wording does bother me now that
> > you highlight it.  Even though it's not something introduced by your
> > patch, I'd really like to drop "normal" here; I think it is prone to
> > cause confusion to users and as far as I can tell provides no useful
> > meaning for the sentence.  (There are multiple types of single-parent
> > commits?  What is an "unnormal" one?  How do I tell which kind I want?
> >  etc...).
>
> I see your point, but I won't change it in these series. I think that
> it'd be better if you change this yourself, independently.

Sounds good; I'll submit it after your series merges to avoid any conflicts.
