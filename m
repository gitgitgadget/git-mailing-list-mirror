Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486CCC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE8120C56
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 08:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk6V6WFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIRImu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIRImu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 04:42:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E018C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 01:42:50 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so7079386ejb.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QGuVgZznOJwoJNIul3Xr+kFiVuOIZ5eEP1Ib1PRiuc=;
        b=Mk6V6WFiuMKS5mXbWicKZd2naFv3J6W5qDpe6jMXn/mXsTguR0Nry/OjcMvEHCvC/I
         9iPtM/F7Mm+etiHTlA/EQP+ZVERvEgap3G6n3ZEdT0PaCBAOnOWrxhxloEu3wiYprVfG
         vIA3pzkibB1ZZpeo5oEaYPPCS7vkcO78+OnE5lLBZJMh6+QIgQ2HffvCzeK6IY6pigIg
         GFhjzEFOdU9NivTy9KDWBU+mWKtCXXn5h1zqBYxwt2N6QGegZrXCa6TAOGn9SsEYqA2t
         TYnQADnGuGdl8SYQWVT3tNhthN1jycNntKTKa7kHc373eiM3hG6o7KHheUn/IRnF8xVd
         ptYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QGuVgZznOJwoJNIul3Xr+kFiVuOIZ5eEP1Ib1PRiuc=;
        b=fZ7YOxzAz0ybd0ZXDjf2WrJd3wp86d/emYAgBC5LQb/N+O/qhHj3BS3NBpfeZfTcb+
         Yt36kknBDzyUZFFWTvidMLHd2cRC3q3vdcs600uGWsWkJcvM5KDhk5zkwA3dVSPr1NHQ
         PmopVcZKwC6HFsD+UEbaf99yt2jXhwr2wQ5p18V6JWVXcvHQJ6UB0IvVByNEYQshGAOX
         xnrUd13r7aQB8I1hrfbIWzirWZWft0qnmUH+0Ly2AwNIUHz/d94Y9MjO66JTDy73Icii
         7UJkIbodvpSv66enoxTGnok//dAIMI/5o/YBjEWARxI5Za/YB8zes3OTM87R73mvSsVz
         zT3Q==
X-Gm-Message-State: AOAM533xIN7MfrOSC0zmHCEYIAbsUlYIERE/Slg3UoZyvx2FuP+sJza2
        IZlceJFRTxiWJQPjEYL6M2ga5NUYzbX5/h9d/Aw=
X-Google-Smtp-Source: ABdhPJzxbGs/UIxiMtYx1vblp0NR4CJU6BVC8oXa569cz4juDwPv5/+IvxTZQdlxt6wZQhsJOqgQqP1jelPFhow1rBI=
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27mr36657917ejg.283.1600418568849;
 Fri, 18 Sep 2020 01:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet> <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
 <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com> <CABPp-BHV5-UUio69b1ZnwuRwyj66HUEy3A24wvxELorR_1FB=g@mail.gmail.com>
In-Reply-To: <CABPp-BHV5-UUio69b1ZnwuRwyj66HUEy3A24wvxELorR_1FB=g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Sep 2020 10:42:37 +0200
Message-ID: <CAP8UFD1BmhT29r5TtZJt5DMTsrPaJ11wNb-Hm-N7yTrppgn3Vg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 5:35 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Sep 17, 2020 at 2:47 AM Christian Couder
> <christian.couder@gmail.com> wrote:

> > Proposed on Outreachy's website:
> >
> > https://www.outreachy.org/outreachy-december-2020-internship-round/communities/git/accelerate-rename-detection-and-the-range-diff-com/cfp/
>
> As a heads up, I'm going to be sending many patches modifying quite a
> wide range of diffcore-rename.c in the coming months for accelerating
> rename detection.  Maybe I'll get them all upstreamed before outreachy
> starts, but that's not so clear.

It starts at the beginning of December, so I think there is still time
for you to get them upstreamed.

> As I mentioned in the gitgitgadget
> issue, the ideas outlined there and the methods I implemented are
> different and complementary, but there is a pretty large risk of
> conflicts we need to resolve if I don't finish landing all my patches
> first.

It could be a learning experience anyway for the intern, and in my
experience it has never been a big problem before, so I am not very
worried about this.

Thanks for the heads up!
> >
> > > - Add support for drop!/reword! commits to `git rebase -i`
> > > (https://github.com/gitgitgadget/git/issues/259,
> > > https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)
> > > - Invent a way to retain reflogs for a while after the ref was deleted
> > > (https://github.com/gitgitgadget/git/issues/236): I guess this might
> > > be implemented as part of the new `git maintenance` builtin.
> >
> > I will also likely submit a proposal for one of the above projects.
