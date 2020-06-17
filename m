Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ECDC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 01:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE27B2082F
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 01:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkweLrzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgFQBRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQBRj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 21:17:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5AEC061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 18:17:39 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z9so750404ljh.13
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2YRc/jHN3VxfIyoT8ynZB54BZZ5aigZCZ6uFKmIX4U=;
        b=QkweLrzszXJq+sdfbLBGTkEmzC38qq1Wn9cX/xbwwuHBAacbZpIZA3wb7445aUv31L
         ViDvMGG+Z+najcZ64eESSyixePMtbFyd+qGNFSS0x0FUjpe+hczwfkAAwd1z06ZAF6yH
         KfLyn5rsk3EEU0CWvzviJAh9EktmfiyxcE5goFOdZWP/hXh+gRGhLELchUqFYjANdfp2
         eoHhC++KC1lvMrB9R1SA1/Yc8/8qTDmLrzbYAK1t4S12eqZkhJITPv28Mo1fxU3Jzugr
         +DO3+zHncyh004u/u4GsCRU8jYNLZ2jgzfprivxTZgJY/9iCYOZTmhqxesgmEFsDJoEq
         JjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2YRc/jHN3VxfIyoT8ynZB54BZZ5aigZCZ6uFKmIX4U=;
        b=M/cvM6aohsw/J0c3ZjMgqiBI8cU+7h0u/3HOXDfnRhasuDq/D+IGfF6fqPFuklPhB2
         /XTLwr17gVI9shJgpxazE4VBoRsAgr294PL50w45XeFU7mFaR0pBpH0SryH3Ax5RYjjf
         YgpMIM3f+U7XHHRZ+WlNhjxVibCsUFK+Xg5R+YozbadVXBgc0ew++tSQx52ITmOVqJwc
         MGenJYwbw+3Y8nhJvwzylZdqMlHjXiWLNeLEjohiAhTwSosCdv1noG8Le02ZicdV9h7I
         8WkXExppZCZsCC5pgZ+ftPP5R7ZjDIGSpXPT7Oi5GFPmNvmQxlteL3Do1gZom6o3CHu4
         GniA==
X-Gm-Message-State: AOAM532rr7pv9flQhOKVmJ4hnME8xSimkcw0dvSoQzcedVOxm3ay0Bdr
        /+mmQf+UnohuIP9bW2+yDKXFHxvvboQFDfu1b3gS4oHn
X-Google-Smtp-Source: ABdhPJwZjuzHVEft3c4rYMYMGKWIfNpPxsG5fk30++yn57MgOBO+83xpDbq09QnAoX0wHfJPZK+Gkhpg5CW51/jVcLw=
X-Received: by 2002:a2e:8903:: with SMTP id d3mr2458693lji.298.1592356657902;
 Tue, 16 Jun 2020 18:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com> <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
 <CANgJU+Vs-hzU-Fg+iWAn349_azb3k_6PCzyY+S2C_5ZUTv7o=A@mail.gmail.com>
 <20200616083405.GA17381@legohost> <CABPp-BGV-CVZ5swYNQpF-su3+yc1=P96g-tKxKtcrgvxhA+AYA@mail.gmail.com>
In-Reply-To: <CABPp-BGV-CVZ5swYNQpF-su3+yc1=P96g-tKxKtcrgvxhA+AYA@mail.gmail.com>
From:   Sergey Lapin <slapinid@gmail.com>
Date:   Wed, 17 Jun 2020 04:17:26 +0300
Message-ID: <CAFZPMobx0grpMjdJSbYmre_SRu1OuC1rANZVdpkfohK4jXDqrQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Elijah Newren <newren@gmail.com>
Cc:     Oleg <lego_12239@rambler.ru>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, that is why CoCs are implemented - to shut up everyone and do the
right thing.
Congratulations on your winning. There is nothing else to show what
the state people are in.
Please get well.

On Tue, Jun 16, 2020 at 10:37 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jun 16, 2020 at 1:39 AM Oleg <lego_12239@rambler.ru> wrote:
> >
> > On Tue, Jun 16, 2020 at 09:31:43AM +0200, demerphq wrote:
> > > On Sun, 14 Jun 2020 at 08:35, Don Goodman-Wilson <don@goodman-wilson.com> wrote:
> > > > But to deny that explosive content on the basis that you don't
> > > > personally feel it, that you've never experienced it? To claim that it
> > > > is "meaningless", that some people are "perpetually offended"? That's
> > > > willful ignorance on your part, a bad-faith effort to engage in
> > > > serious intellectual conversation about what is good and right, and
> > > > has no place in a discussion about creating an inclusive space for all
> > > > developers, let alone trying to bring about a more just world.
> > >
> > > Well said sir. I might quote that sometime.
>
> ...
> > The stupid idea.
> > The stupid discussion.
> > All world use this terminology and it disturb nobody with sane mind.
> ...
> > Because someone is completely mad...
> > Fucking hypocrites.
> > Are you all really so stupid?
> > Just do it and feel better, liers.
>
> Please stop.  Bringing up reasons why proposed changes would or even
> might cause harm are perfectly welcome, especially if details and
> examples can be provided.  (In fact, it would be a lot more helpful
> than simply asserting that the change would be very harmful.)  Name
> calling is not okay.
>
> Emails like this one from you are not wanted and not welcome within
> this project.  Please go read the project's Code of Conduct
> (https://git.kernel.org/pub/scm/git/git.git/tree/CODE_OF_CONDUCT.md)
> and only continue to communicate with this project in ways that are in
> alignment with that code.
>
> Elijah
