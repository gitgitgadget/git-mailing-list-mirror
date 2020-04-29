Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A8C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6798A2076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 08:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnXrw7GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD2Im4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2Im4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 04:42:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA487C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 01:42:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o10so1186991qtr.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oex1v82heDfHUzxd4CNlqucLIDWKuxsI9n4vc8qq74=;
        b=tnXrw7GRJEtn0WN4jjrNvXr3c8ieLTzLbyi3yKQJbZiKzIy7hgpAEsy7RHoq2RSJQK
         BEeB4E+IGmVLUq0pBZkqjSztwqrgd/0p07gPA4w5RmnghTnNWizP2YIaG2zzszC/htks
         KCbyF6PPcgAX7XTKGfjQegBnff0xFCouHMVh4dzmH3exEAHF0m6KqSiyWII/q+Wqq11w
         1EsQCcN0BuL/wmhG9479GL+X7N5BvJMw3UMgZrpY27hNPUVsiKDPpePl3VnYlBnupGQm
         jBkbVYeBUSGLHl6CflhwKUpfSh/JI1ETaGw2YIBSBLch+rxhHEr5B6Zs5AiUhLUZdba7
         iUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oex1v82heDfHUzxd4CNlqucLIDWKuxsI9n4vc8qq74=;
        b=Pgzr3XmKgTwMDz2GwojX1+GNIMfsJ6Ntnv48gf9SCrW4TVUNwLelANRk+GdYh1CaSO
         Q2ie58DKQ6dJ53qBqxDn/Pg2Tq3L0dowyRJlnZ4A7yg5WsIh48EbvXTcrwUDLnFbkLQU
         R9I6b3nL5wyxUOnbRovncMHIGoJ7iBVIg+b/x4iqPlgbZONia7YQt0ZKgTFvIW/uwggF
         ZIsR5fWv+H0ZRaaUMs1h9RoxwKcwYCWYdLzWU2HRHHUz16KVOlQoscA3LbVkyF9IcobA
         SxGTLAKYc/tM0XKLtIa3Nbz1815DnzcHwMyiKJB5Qyad4nxjzPbuUR+ZR6APJx0k4mY/
         fgrQ==
X-Gm-Message-State: AGi0PuY+rELZEo4f9Q2Gh7okYBL7he90QdX1Ls04gifgFrA1JFeSd0Qd
        j22gipZy0p9K3mpDfnUjzjcd9JzBsqECKvJUm0g=
X-Google-Smtp-Source: APiQypKT0NmTa86GwdwOtiSrI6Sr+h3p+KA6vY0nyHL+RC82dVj+Vbw9aSKTDjIm4fV1OcKlz1/Zw79chuSjIg/f/wY=
X-Received: by 2002:ac8:19fd:: with SMTP id s58mr33245066qtk.222.1588149774958;
 Wed, 29 Apr 2020 01:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
In-Reply-To: <20200428210750.GE4000@coredump.intra.peff.net>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Wed, 29 Apr 2020 14:12:43 +0530
Message-ID: <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Jeff King <peff@peff.net>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding the CMake script to contrib/buildsystem is a good option.
Is there any changes (apart from the CMakeLists.txt critique and) that
I have to do on my part?

Thank You,
Sibi Siddharthan

On Wed, Apr 29, 2020 at 2:37 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Apr 28, 2020 at 08:52:37PM +0700, Danh Doan wrote:
>
> > On 2020-04-27 16:12:28-0400, Jeff King <peff@peff.net> wrote:
> > > On Mon, Apr 27, 2020 at 04:08:52PM -0400, Jeff King wrote:
> > >
> > > > Skimming the patches, I do wish I didn't see so much repetition with the
> > > > existing Makefile. I know that some of the logic will just have to be
> > > > ported manually, but surely we could be pulling things like the list of
> > > > libgit_SOURCES from the Makefile as the single source of truth?
> > >
> > > Thinking I surely couldn't be the only one to think of this, I dug
> > > further into some of the sub-threads. And indeed, it seems like you are
> > > on the same page here.
> > >
> > > IMHO it is worth making the cmake file depend as much as possible on
> > > what's in the Makefile.
> >
> > Please correct me if I were wrong (I recall this from my memory
> > without checking anything).
> >
> > The worst thing about CMake is we can't override (Make's) variable
> > in Makefile generated by CMake.
>
> I really don't know enough about cmake to say one way or the other. I
> can well believe there are parts of the Makefile that will need to be
> manually translated, and that it may not ever hit full parity.
>
> But as long as it just a tool for people using Visual Studio, and if
> they are happier being able to use that tool, even with a few
> deficiencies, then it may still be worth doing.
>
> -Peff
