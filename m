Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E403C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767902074D
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+tCYHcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFPICL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPICG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 04:02:06 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE20C05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 01:02:06 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id er17so9053935qvb.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0FaczZKI5/lTd0UsQOLrvEk43A/IkGx3A376Z9arq80=;
        b=p+tCYHcLr+nrTrfgjs4nfVZvy4hAHQhjluiuiD3f1BwkvjZKrLjcyVa0d/XTgZmpPe
         QDJnucTMDTHoefDD6vN+MPIUHmwMHj0ArB8oRLVY2G8Qlp1+fUa8rsHzjShsVsuXrMFx
         xmjgT1hjHm4d0ljxkJSxJN3m96wRiMl1+pmzcD9SzpVwIsOnRcyQrUBsoTIpspj+lqJd
         FBhILcXexvdlPsi3ZD3LP2+CcAj9u7esPPSEar/yJBDhJ8aXNP2fWphyTcU0ipdtYVKZ
         1JskukoawTFAVp1oK8UhwEpHaFmKwySVzogOX+BTzJ++MpxLWYN/5L3dbvI2kPu44843
         Updw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0FaczZKI5/lTd0UsQOLrvEk43A/IkGx3A376Z9arq80=;
        b=ceSIvJEvTSL34Ej33XsIa+9MU1ltk9agn4hRwV4j/mVYgpApJi2WrFJcIqTtu2OjeS
         5WKXczQyYFjwJy07amTkQYxaXjkKiwRq0t9hbRX6JxYnxe9NL3HTJq/QsMW1RPgfyM4k
         BLIUsTqHcMXJU3ErOMFl+ZDU31puLWVLeAS5M1BcHBv7t5lvpIZUMajc42Sl1jULW1vQ
         tZTmCDsm5iufzPXG+lG2uzPRXQb6pobnz3lT9+NHRiC9Fe0AtqGP73Z/8WF8OqV64sHT
         fbDfYjZJHxhsMfbKKcScmCa1Bys8qmDp9KxZ0k9XWgPtfHADysXJM/4zkiV0cjiwrKAU
         bUvQ==
X-Gm-Message-State: AOAM5338446g+VgUsb/rfBCvaPM960YVrCR6sztI4O76o7zwAg5rGxUa
        f1+VagQyOG/sYt5NGGUcGh5InI2kbp+xNseN8Ps=
X-Google-Smtp-Source: ABdhPJyq37aUtpJU4mBHPolCgPHGMB/i99tJwtZ+53ihuJ3NCHuL9JfzntewQUbbsYzyC2CW0RPgud9gk+TUSNTngBM=
X-Received: by 2002:ad4:54c8:: with SMTP id j8mr978939qvx.111.1592294525911;
 Tue, 16 Jun 2020 01:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com> <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz>
In-Reply-To: <20200616074316.GA21462@kitsune.suse.cz>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 16 Jun 2020 10:01:54 +0200
Message-ID: <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        don@goodman-wilson.com, Git <git@vger.kernel.org>,
        newren@gmail.com, philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Jun 2020 at 09:43, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> On Tue, Jun 16, 2020 at 09:36:59AM +0200, demerphq wrote:
> > On Sun, 14 Jun 2020 at 20:24, S=C3=A9rgio Augusto Vianna
> > <sergio.a.vianna@gmail.com> wrote:
> > >
> > > Ok, can you show me a single instance where "master" was confusing or
> > > not descriptive enough?
> >
> > A: "No you need to fetch master from the remote, then you need to
> > merge it to your local master and then push it to the master master".
> > B: "remote master, local master and master master. wtf kind of master i=
s that?"
> Which falls on the wording of the FAQ, not the terminology itself. If
> you were confused I am sure there are ways to bring this up and even
> submit changes.

I think you missed my point entirely. Sergio asked how "master" might
be confusing, and I gave an example where real people found it
confusing. I have had the conversation I just outlined multiple times
while teaching devs to use git on repos with "master" as the default
branch. In fact at work we renamed "master" to "trunk" when we
migrated our old CVS to git about a decade ago exactly to avoid this
kind of confusion. Consider how this conversation goes for us:

A: "No you need to fetch trunk from the remote, then you need to merge
it to your local trunk and then push it to the master trunk".
B: "Ok."

Similarly when the perl project migrated to git we renamed "master" to
"blead" to reduce the possibility "master master" confusion.

So I would say there is ample evidence that reasonable people consider
the "master" branch name a bit confusing. Furthermore, claiming that
the existence of a FAQ somehow makes this term not confusing is a bit
strange, as I would say that if you need a FAQ to explain something it
is not very obvious to start with so you are essentially proving my
point for me.

Personally *I* have no problem understanding what the "master" branch
is, I am pretty deeply familiar with how git works, I just think it is
an inherently bad choice of default name for a distributed version
control system for reasons entirely unrelated to it being also a term
related to slavery. The latter to me just makes changing the default
and/or providing easy ways to customize it all the better a move as
ultimately it will produce less confusing and more inclusive software
with little to no real cost to anyone else.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
