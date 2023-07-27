Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1306EB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjG0UBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjG0UBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 16:01:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EBA30DC
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 13:01:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9338e4695so20799141fa.2
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488086; x=1691092886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VqBFQbG/vw/mEkrHWtBHiTTrb6PPYADt/21npEAc5M=;
        b=P65icQTCU2vpXxVGNaAeIZWqXKtWvlwva93/ISxEYbOLwqA0NlIZSGyxP9hQwLgdZR
         aIuTMUztMGxsOATNDuwVapArORBU2vlphn+54Tb8XR5L+zm9z2e6soAWvyD+GMShZeou
         5N+FBEBsj9jdSFOLBgPsgAiF/0j9Y85NpANHCWfMB1Ukv3RhpoTVxV8umfYINqS+T994
         gM3Aic6B3012mnLDa2oLFLnfuiEJeImGojT06prYpoHQ4ySJkVErEi3bXn3iMScsLMyl
         DQHWMjYOE2gS9pO1aVS7/D85GD8RPTYkPkKbud9/DF9/F0fNIjmJYC0tDaCapYwr9XNK
         WWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488086; x=1691092886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VqBFQbG/vw/mEkrHWtBHiTTrb6PPYADt/21npEAc5M=;
        b=cnMMLijwu9T7+5NMp637hzkytMqonss3K71Gn6XIgmnmvYSvwJar+xmaFJu2rJRe/m
         JBysUTYS78BSDidNBPxSbjNhaNC3oGrWiEkBniAUMNbyyQriA8D7b+IiY44u3yivwn22
         16FqPTuAKtF6FtxNITR5IhbU5+kpPnUm2/I9ui6dyokOswYy39wzHGlJvvz6ynpgwSML
         bYqx2pTMtqdvLmA+Bx7z5D0ritKk4PTs30IEWfxQUV9mDQw/qMVssiAnCt52QSmJToLw
         3jhmUpVMaBREFGIvum2uYYZ8IkXbN9GdqMT/jFrUvOwZJxXmkMrFcSIgd5UeAA7XWwAh
         dj2A==
X-Gm-Message-State: ABy/qLaYew6YxAVzz+3x0tIFQsWlIq74e/YVN5kaGWEqjsH9Xw0sR0CI
        2/ICHf/YVLOShHcCEIvyCHWjJ8OfHYj2jojhzRKAGw+lZtk=
X-Google-Smtp-Source: APBJJlESmsh0bp2GUOWSyFOb6GUh6C+tf7wMYbPmJW1LgzUIzvC4HFOP88BU2SfRWY07zOkgsOhMDCbXcWSWCZZ/7jc=
X-Received: by 2002:a2e:b704:0:b0:2b6:f85a:20b0 with SMTP id
 j4-20020a2eb704000000b002b6f85a20b0mr41607ljo.16.1690488085351; Thu, 27 Jul
 2023 13:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <DS7PR01MB758914BD44E20CF8185B7C5BF64B9@DS7PR01MB7589.prod.exchangelabs.com>
 <m0a5w5etlu.fsf@epic96565.epic.com>
In-Reply-To: <m0a5w5etlu.fsf@epic96565.epic.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 27 Jul 2023 15:01:14 -0500
Message-ID: <CANaDLWK+UYLgVbqjDxq_euYeJh1CCVMm283GZdQFSwUsBfTKSA@mail.gmail.com>
Subject: Re: Git monorepo - recommendation regarding usage of sparse-checkout
To:     Sean Allred <allred.sean@gmail.com>
Cc:     "Mor, Gil (DXC Luxoft)" <gil.mor@dxc.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To add a data point: we have been using sparse checkout in non-cone
mode on our very large repository at Salesforce. Non-cone, because we
are a monolith, 99% of our files are actually needed by our single
build, so we need to process by exclusion. Our repository has been in
production for a bit over a year, with now between 1k and 2k active
collaborators, and the only issue we've seen with sparse checkout, is
when a user really messed something up bad enough in our scripted
environment setup that they end up running a very old version of Git
for some reason. Recent versions have been seamless.

--


On Sat, Jul 8, 2023 at 9:20=E2=80=AFPM Sean Allred <allred.sean@gmail.com> =
wrote:
>
>
> "Mor, Gil (DXC Luxoft)" <gil.mor@dxc.com> writes:
> > Hello, we are experimenting with migrating a large-ish code base from
> > SVN to a Git Monorepo and it would help us if we can get some input
> > regarding the usage of sparse-checkout.
>
> We're in the same boat. I haven't been able to keep up with the list as
> well as I would like, but I can share our experience so far. We're
> writing developer tooling for a team of ~2k devs.
>
> > From our timing experiments sparse-checkout is the only method so far
> > that reduces our times to good results.
>
> You should also look into sparse-index.
>
> > The only issue might be the Disclaimer that the sparse-checkout
> > feature is experimental, and that the behavior will change.
>
> It seems vanishingly unlikely that the feature will go away at this
> point (even if the CLI changes). We have automated integration tests set
> up for our automation and have near-term plans to start running those
> against `git.git:main` and `git.git:next`. This way, we'll get advance
> notice if something we're relying on starts breaking.
>
> > The command is already featured in GitHub and GitLab articles about
> > reducing Monorepos size but we are still not sure how un/stable the
> > feature is or how commonly used the feature is already.
>
> We haven't encountered many issues with stability. There was one issue
> a few months back where the pattern syntax changed, but as I recall that
> was more of a problem with one of our developers going off the beaten
> path and trying to write to GIT_DIR directly instead of using `git
> sparse-checkout set` or similar.
>
> > So, we thought we'll write an email to see if we can get a bit more
> > nuanced answer about the safety of real-world usage so that we can
> > make an informed decision whether or not to start using
> > sparse-checkout, despite it being experimental.
>
> One of the goals of our tooling is to teach people how to actually use
> Git (i.e., use our tooling to automate the boring stuff -- not to
> replace Git itself). To meet this goal, we're using the more 'ergonomic'
> git-switch command instead of git-checkout. In our case, as long as we
> can react to changes in git-switch syntax (which we haven't seen since
> the project started a few years ago) and as long as we can get the same
> side-effects, we'll be fine. This comfort is largely driven by the
> existence of integration tests.
>
> > We are not looking for 100% assurance, we know the responsibility is
> > eventually totally ours and there are no guarantees, but it seems like
> > a game changer so we are just looking for a bit more information so
> > that we can make a decision.
>
> Sparse checkout is not a silver bullet, but it does make a difference.
> We still see commits take several seconds on Windows (even with sparse
> index). This is *several orders of magnitude* better than SVN on our
> repository (where naive commits on top-level folders can take tens of
> minutes), but it's not what folks are going to be expecting from Git. In
> the long-term, we're looking at what would be involved in splitting up
> our monorepo and seeing whether the rewards really outweigh the costs
> (both of which reach far beyond source control).
>
> Best of luck!
>
> --
> Sean Allred
