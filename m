Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56286C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31518207D4
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0AedwWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgFOUoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOUoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:44:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B85AC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:44:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 25so17135531oiy.13
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FVjumNS0+Q7ryw5y0i2FEsgMlm9jyG01ufykqRLnrBo=;
        b=F0AedwWz/Zo3vbnn6wpFRkbZR9N3nkcEqdKMn8K5Knzl+v08AsBZZH6zcA7eWAUMkr
         X2cveA84KSuTxIX+ZiNYynJ6WrVoEpSaotsBddz19k27GlBthV54datpIqpU4L+UmutY
         P+RKhsRN7mFjsVl7Dj2PBqAP7BaZSarP/+pEostqzPmzSz6EWDcrcPthuVFs+K5JJRCp
         lDXEK5YMbHvhRGmYHuMGV2U6HFau7p3XUdTRqy/rpOvhl3ekj5RilDiLZ8dJeYcyG50x
         GJfwO+05GeO1TJodJqPgN9HZEujlXI4WG4m6kOjoTTnf22bVBfDhUmwtLiDKhjOMUNVs
         oBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FVjumNS0+Q7ryw5y0i2FEsgMlm9jyG01ufykqRLnrBo=;
        b=M9DhIJfVHhI1kj6ueIBFOHqYfauM46e+r6FiiQDeyK2bgz7wM5gDzDaEvUsj8dPWpr
         IU2M8+TxVYrFIxCSLb2LOinBz9UylPO0ZNdRFZkvLfInHu8NT8LHdo06NEukJ45TWJYj
         PrqKRxUThAvYQ+2Hgw/1xj8n/PooChaqOtBueR7pXv7Ieirb60SzZLaCFC7pTVQkPsjh
         HRcFzmLvNZxWpe32Pke/ig9h89TyFblPn633QoEnhTAdod8K+4RAUwd0OQpYDPtRUfVp
         Sf+59tjUu77JDhqiFwBGlz26giAJFB7p3dbJw0eAJSZGAxTey0NMIVpkmWrXyDkfWcp3
         gMGw==
X-Gm-Message-State: AOAM533Sgy8cXtpge+RWhuFN2vcCmiNMJAOGVQ7XhNbXq9A1c1DksLdG
        gAqrZQEx8cJFlOeZcCl4jBLGrC32yxnVs7XwXAU=
X-Google-Smtp-Source: ABdhPJxI6JUP2X2tl5GgPmSnUkCB/3qHWv3b1n6QNu/RB+UK0D/ECpko8bOyYd45ysVuroZK58YCyHhmBvIDwtZr5kI=
X-Received: by 2002:aca:2b0d:: with SMTP id i13mr1013064oik.39.1592253856521;
 Mon, 15 Jun 2020 13:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200615180744.GB135968@google.com> <3cef6084-e632-c9ce-c0da-a2c250c2f512@gmail.com>
 <CAAwdEzDgJuoQJAZsrT0piuZPVP6nJTSB9RCbcuXO03-BYTnmOQ@mail.gmail.com>
 <8f9193aa-43bf-2ad3-d067-6330385e1788@gmail.com> <CAAwdEzBNwEVFcW5bTE-aWxnoQYamJH+DRhqRgc6abgo+bgYUzQ@mail.gmail.com>
In-Reply-To: <CAAwdEzBNwEVFcW5bTE-aWxnoQYamJH+DRhqRgc6abgo+bgYUzQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Jun 2020 13:44:04 -0700
Message-ID: <CABPp-BH65boQvYG-p7sag95h8BwfHHUXYV5GEskOCd6E1GvvBg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?Alexandru_P=C4=83tr=C4=83nescu?= <drealecs@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Philip Oakley <philipoakley@iee.email>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 12:51 PM Alexandru P=C4=83tr=C4=83nescu
<drealecs@gmail.com> wrote:
>
> S=C3=A9rgio
> On Mon, Jun 15, 2020 at 10:37 PM S=C3=A9rgio Augusto Vianna
> <sergio.a.vianna@gmail.com> wrote:
> >
> >  >But the people that contribute to the code and to an open-source
> > project are the owner of that project so they get to get the calls.
> >
> > Ignoring everyone else's opinions and needs and just exerting your
> > authority is the very definition of authoritarianism. Yes, they do have
> > the right. But if they ignore the users, they can just use a fork that
> > does what they want. Have anyone considered that a breaking change in
> > git might very well result in a fork?
> Well... fork happens sometimes when two groups of people completely
> disagree and cannot work together.
> I really hope a vote here would be enough to settle things.
>
> S=C3=A9rgio, I'm actually with you on this side, just to state my opinion=
 as well.
>
> I haven't yet heard of a person that is offended by git master branch.
> I've heard thou about persons that think that some others will get offend=
ed.
> But most of the time, I've heard about people that think this world
> got crazy on git master branch naming :).
>
> But I guess you've heard that already from other participants already,
> so I apologize for repeating it.
>
> And I believe that both of you, S=C3=A9rgio and Jonathan, were a bit rude
> to each other :)

Calling out violations of the code of conduct certainly takes some
directness, but merely calling out the behavioral violations is not in
and of itself rude.  S=C3=A9rgio's behavior I think is exactly the type of
reason we adopted the code of conduct; insulting others is not wanted
and is not welcome on this list.  The harder part of having a code of
conduct is trying to coax people to follow it.  Several folks tried
nicer responses to S=C3=A9rgio earlier in the thread, but to no avail.
From my view, a more direct response was clearer needed.  I'm grateful
Jonathan jumped in to do so; I thought he did an exemplary job.

Elijah
