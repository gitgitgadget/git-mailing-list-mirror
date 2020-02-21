Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA10BC35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B214207FD
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpUmZtLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgBUK1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:27:50 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40906 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgBUK1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 05:27:50 -0500
Received: by mail-ed1-f51.google.com with SMTP id p3so1711693edx.7
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 02:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+55HiHb9OGk2o2CvYirAjnB1ZIPDlqIDvUh1mP6y2Yw=;
        b=lpUmZtLa8G6ikS3pe1HEMbo0iRe3q17GTh1UkPYv6QeMsBfjFNkUJBLp+1rRxOzeFg
         M5h4PibzLAvN7W91jwqIsytW0ocCcfFvDnX7CdBdJsjG1yk/bmubcW1gcuXC8mR/XwFi
         NCe87i8qTlkbOlxLOv9NhI31FRlGPTigv88kzH1CZ2f6QumTTd9npDA2rVzArR9wp29S
         0AErn41R8k4BoZL+CIiUc8mW196/zZBSmH/uJpLMBO9ai96/5deJLg518Eiqp25/hCHQ
         rsw/BVDTuX1QaKVt8E/M4nF7OP/WUFTr4T6/foTQk4BAWE0L4X212aYHo0bfCmGEzYHi
         h+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+55HiHb9OGk2o2CvYirAjnB1ZIPDlqIDvUh1mP6y2Yw=;
        b=Fchg6m3nAjdFuJ0qV6QQ94uvguH4hq54WCYRRZWYJ8cTmyESCoq6c8DhMqsJXpUDAI
         tdnQvWnf8oTJy+wUTFQeWat8V0+H8ywe19yWabO6IGcLwKiDSTIjXiSWwkFSNS3LGFGa
         Eis07YO5Duh1pzWB7OrFUlNtvV3fi89gIRQ9ru6SbZrJRWkcIr5jEIETeSCd1ya1Ky32
         a0ce/L3vE/02OhLcR+mN2Dq63HSUXAHSMaZbktTYr0CWRAyPWS50wYR5/C2BuhTVHsJQ
         Gj+oQa4ib9iK7h7zA2sk8YhOgoNz5oYzbjFzL2Ojgn7s0xbc0BHSv/WkUzWOFWPfw5vf
         WKSQ==
X-Gm-Message-State: APjAAAXFY8DaGqpPgum+mBOWXBtgGt53naEplNss0dqZ2dafPDXcw7GG
        1AnQt30W9MrLOHy2CHRa7zKiZBkVjq4YHRE4qUU=
X-Google-Smtp-Source: APXvYqwAXQa6rSGM1Bad8EB8kNQYNCn47CCLmjsfe8+jLsUk4/J6TPdaUQD08m1A4N9fAktwGqDauetgXQA3Xj2AOOs=
X-Received: by 2002:a05:6402:b47:: with SMTP id bx7mr32848604edb.362.1582280867238;
 Fri, 21 Feb 2020 02:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com> <20200204163716.GA7308@coredump.intra.peff.net>
In-Reply-To: <20200204163716.GA7308@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Feb 2020 11:27:36 +0100
Message-ID: <CAP8UFD0tGZzLo2=u06mzd5YbiEEHREByWk8j91CTedfaFNw3PA@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 5:37 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 04, 2020 at 05:11:20PM +0100, Christian Couder wrote:
>
> > > As with https://github.com/git/git.github.io/blob/master/General-Microproject-Information.md
> > > the idea is to not have separate documents for each year and each
> > > program (GSoC or Outreachy), but rather point people to the same
> > > document that we should update regularly.
> >
> > While at it, I just applied on behalf of Git to the GSoC 2020 and I
> > sent invite to possible Organization Administrators. I am one of the
> > admins already but we need another person to accept the invite before
> > tomorrow as they require at least 2 admins. This is the only thing
> > left we need to apply.
> >
> > The information I used to apply is in:
> > https://git.github.io/SoC-2020-Org-Application/
>
> Thank you for getting this going! I'm happy to be the second admin (and
> am signed up now).

So Git just got accepted into GSoC 2020, and is listed there:

https://summerofcode.withgoogle.com/organizations/

Emily and Jonathan, If we participate in both GSoC and Outreachy this
summer, I think it's better if we share as much as possible, so I
would suggest we just create a "Summer-2020-Microprojects.md" and a
"Summer-2020-Ideas.md" that are common to both GSoC and Outreachy.

So I am planning to rename "SoC-2020-Ideas.md" into
"Summer-2020-Ideas.md". I will also create a mostly dummy
"Summer-2020-Microprojects.md" that we can fill up with micro project
ideas.

In the future we can perhaps continue this way by creating
"Winter-2021-Microprojects.md" and a "Winter-2021-Ideas.md" for the
next Winter Outreachy round if we participate?
