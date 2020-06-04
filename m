Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D48C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C146B20823
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8CZYM7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgFDOcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgFDOcv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 10:32:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB3EC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 07:32:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g9so4874416edw.10
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSS7rkAZyjwq2+BVLCayTQQsJLRjTWTj7whb8WS1LFw=;
        b=i8CZYM7YGsYAhiFsBGPmJwWTLkQ5p3jeRKQ/UF+URCJQfuaZTmY4Zk/G+wrwJ9DI60
         L9s2dKDFAL2HbiXuYz14mWlrGf0lGL9ZpvMANgEN4WooVfvSUQ631R/LQ/8ginf4EGAR
         GIkjxt76u6O/ac4tG/ibJmgePlV5mZLMq39wyvG09Ixdvassqt1PrUvDa1VEg+T252mm
         +LzoBTtP7iFrIAGcnXMLu6qXsOMLJ1RbaHC/RsLQTsfRAbNpDlfvlV0uxl27g4bOPE8v
         VhJGTOegF0dwaLjLW7U9vkGNN74zU0A8xP87JGN/CDbs9rE61NeyFG0Qv1EcXFCt0DzO
         HpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSS7rkAZyjwq2+BVLCayTQQsJLRjTWTj7whb8WS1LFw=;
        b=Il6UuW2wUQEk83VS7ujfWCX3SZ2NFbPrNAyerhjbfan0jnwLln4inMDr/qaKVBe4GW
         w4riWuLqNeHOefTFZ1MoygXb/U+E/jh7rM0vqzeVj6zHkqIcLnNxoZVFxJH00VIVdtt9
         74SwL65J8mtX+rj06KVBGUQURVBQtXlY+hieVygMZxsY0BD6dPX841/teHxyHBbed0Mp
         au08y74uAq0qHH5tLkqsFVdeQaLMgyyeoZE/m6e1OGE+fuqs2Pig/bnDWQg2kzi/Tht1
         CKfXD4MPqgXqvL+bbpm3EpxVgAjA+FMx0Mta+i2KjEc5FZe2820cmSkwMXgLPCdB5XoS
         QaSg==
X-Gm-Message-State: AOAM533HMVMc7YjV/ycha1QPWaKwUAGt6Jva9PLAnPuDZ2hqK/qdKyYt
        7ci8hKpRANTrYaS4ZOUjxMxx1JLds+Ah4rYK9Go=
X-Google-Smtp-Source: ABdhPJxCebeRm5Z//9zVGUybn7fPTAOX4mjPLQsnutsHFIgI02sgsbxNeRVWDtED+9/Kos6nkg0flyGco0tNRpJbaI8=
X-Received: by 2002:a50:954b:: with SMTP id v11mr4632322eda.273.1591281168369;
 Thu, 04 Jun 2020 07:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com> <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
In-Reply-To: <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Jun 2020 16:32:37 +0200
Message-ID: <CAP8UFD0V+=tq8CGFk_Mz+N=HjRtkhkMbX9Cy2-=WfHL8wrj6=Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 11:20 AM Elijah Newren <newren@gmail.com> wrote:

> On Wed, Jun 3, 2020 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:

> Now, it's possible these regressions could just be a reflection of the
> fact that I'm focusing more on fixing inconsistent behaviors

I agree with that. It's very difficult to implement big changes like
changing the rebase backend without any regression at all.

> rather
> than adding new features, which is a type of work where it's much
> harder to avoid fallout and reported issues.  But it's also quite
> possible that I'm going about these cleanups wrong or at least
> suboptimally.  I'm open for suggestions of what I should change, or
> even experiments to try.

It's possible to add more tests, but it's not possible to test
everything and it's hard to know it the tests we add are effective at
avoiding regressions. Not sure we can do much better.

> Recent attempts I've made to make things better: (1) I have in the
> past month or so gotten a company internal distribution of git
> started, with a growing number of users.  This distribution uses
> pre-release versions of git, mostly off master so far though I'm
> considering moving to 'next' for it.

Great! At GitLab we are slowly moving toward something like that, but
not there yet.

> (2) I pushed hard during 2.27
> for the dir.c changes to either merge early in that cycle or wait
> until early in the 2.28 cycle -- hoping that an early merge would give
> more time for testing.  (This was an attempt to learn from the 2.26
> rebase issues, since that merged late in the 2.26 cycle).

That's a good idea.

Now to go back to Junio's question:

> ... people are eager
> enough to help by reporting issues they encounter, but there are not
> enough people who are eager enough to help by testing the tip of
> 'master' before the release. Are there things we can do to help
> them become early adopters so that they do not have to scramble
> after the release?

Yeah, I agree that increasing the number of early adopters could be
the best way to avoid regressions report just after the release.

Maybe we could just ask people to test rc releases or 'master' in Git
Rev News? It might work better if someone wrote a small article about
what is coming in the next release before asking to test. Then there
is the issue of making it easier to build Git and to understand and
fix build issues. We could also perhaps coordinate Git Rev News
editions and Git releases, so that the editions are published for
example between rc-1 and rc-2  releases.

Best,
Christian.
