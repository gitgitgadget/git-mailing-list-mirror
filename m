Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F33C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182F6208B3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSHKAo8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgFPTdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgFPTda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:33:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4EC061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:33:30 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b8so20369208oic.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMRdAqnNfxgy8n+9uYfE/r5IU0OxkghNfiYKpp19Yqo=;
        b=jSHKAo8f0/coBqfL3ovEr/Y7Z4ETAC+GoHuVHCO9oZ6zpfWKdqQ4UAU0z46YdWtxq+
         aZyORspec3Jm+UASoVgC2Ac/iAE7fmB3p/jgB2P365rV++r9h8aRoNz4udyB3rhpm2uO
         4SGxfUbRRIAYx8tYiHh9NNXKKHWwh/1Y70v3RBEmpNzQNp8jCg3mInf4yMm40BvWmU6w
         AZElGG2cDENGP7+IADTEVEZbBhFawx0xLhei+sNNjZtTU4l6cLS3ALunqvlMZDkJRz4o
         Za3io1bz9OFNDuJUByptQai+ZU3b8iD4n4871oprSv1AXeqTBmgXklyyf3qG+abkfeiA
         uRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMRdAqnNfxgy8n+9uYfE/r5IU0OxkghNfiYKpp19Yqo=;
        b=Ly7fFNsicZZZvUKzak3B9PF4a2KZF9v2koY5simvE871ErXj49AcqNcYELH8qaGWPW
         a5ytN7+WYikkpE6d/XWtD1hnKwQBnpkxpi4mPtU3XU1WVoYIWFUzEh6WtXcbO4ANrlDI
         wkLUHe5Y3clrV7JtTISGmHNUpy9iWXFv7I82oTLaVtM171ByHKxRk80Vt+yvK3m5ZK7W
         TOnT9XtW23FbeXIDd8DK9uAGjNTHXnNoLxBXjdRN2iYYKPluZGNwaR9dI6ncVs2qLHkn
         r0YCIHcFp20O3kg5oaadcca9BPfO0DVmPhrUR5bsrhwyACLZFQRojwhasWNT+9GTgP6D
         c2ew==
X-Gm-Message-State: AOAM531RrqIs1wIOSsYidAUnoQ90GsAZLR1jCOPL+UzYuvXvEcW9QD7A
        ipUsw4LRiRXEI11Hvg4I/d0VO+prUWHdhtP4lwxlL+Pmve0=
X-Google-Smtp-Source: ABdhPJww455Tcz/YY+86720kayPnoA/fAngEG2/BA14UKSHtSIU9yhS8WZ7Nro+g78pAv6vs2RbnaWqJCCiytCszkEg=
X-Received: by 2002:aca:6287:: with SMTP id w129mr4908011oib.167.1592336009700;
 Tue, 16 Jun 2020 12:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com> <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
 <CANgJU+Vs-hzU-Fg+iWAn349_azb3k_6PCzyY+S2C_5ZUTv7o=A@mail.gmail.com> <20200616083405.GA17381@legohost>
In-Reply-To: <20200616083405.GA17381@legohost>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Jun 2020 12:33:18 -0700
Message-ID: <CABPp-BGV-CVZ5swYNQpF-su3+yc1=P96g-tKxKtcrgvxhA+AYA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Oleg <lego_12239@rambler.ru>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 1:39 AM Oleg <lego_12239@rambler.ru> wrote:
>
> On Tue, Jun 16, 2020 at 09:31:43AM +0200, demerphq wrote:
> > On Sun, 14 Jun 2020 at 08:35, Don Goodman-Wilson <don@goodman-wilson.com> wrote:
> > > But to deny that explosive content on the basis that you don't
> > > personally feel it, that you've never experienced it? To claim that it
> > > is "meaningless", that some people are "perpetually offended"? That's
> > > willful ignorance on your part, a bad-faith effort to engage in
> > > serious intellectual conversation about what is good and right, and
> > > has no place in a discussion about creating an inclusive space for all
> > > developers, let alone trying to bring about a more just world.
> >
> > Well said sir. I might quote that sometime.

...
> The stupid idea.
> The stupid discussion.
> All world use this terminology and it disturb nobody with sane mind.
...
> Because someone is completely mad...
> Fucking hypocrites.
> Are you all really so stupid?
> Just do it and feel better, liers.

Please stop.  Bringing up reasons why proposed changes would or even
might cause harm are perfectly welcome, especially if details and
examples can be provided.  (In fact, it would be a lot more helpful
than simply asserting that the change would be very harmful.)  Name
calling is not okay.

Emails like this one from you are not wanted and not welcome within
this project.  Please go read the project's Code of Conduct
(https://git.kernel.org/pub/scm/git/git.git/tree/CODE_OF_CONDUCT.md)
and only continue to communicate with this project in ways that are in
alignment with that code.

Elijah
