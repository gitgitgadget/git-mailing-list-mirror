Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC0CC433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6060D2065F
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6D7L26Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEQSQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQSQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:16:49 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F47C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:16:49 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id k3so2656152ual.8
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=R3LG033r/ZTy6YAatm+KfmsVX+t38CKAB0paKLs0Yno=;
        b=N6D7L26YE2xjKzmupBn6kAKpSbGopjhFemKa8YGQh1/PSVt7yKwhsuxHDEowl7TSYm
         xUCGfAewbWFkKfOM2lFQqEddWMTCEbaIW6xTE8sIkEQOamgfo55fMDk28zBz0LvQajFr
         7fADzHZySPWceb1jLxpBsViw3gfSQ9vj8p2PYkgPTHmU8+hxddCkGlXAdsE+bdACFB7I
         mWM/oCBUTgTmyxXHWQ2KfHlTGMS9BUxeN+BqtFLhER5u1i1wKZmHuOJijYuIz9QE/+cl
         BHvyYx2bxE6StrhFNguY+QHVslqViDY6CrUdtdJ8lRC6Vnqk7BqGm0t0zknzGWQnv35t
         VYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=R3LG033r/ZTy6YAatm+KfmsVX+t38CKAB0paKLs0Yno=;
        b=gI1QVEhYB3WYwztBHfCL9PYWqNR/WFff7QVv7kvKZPbuJ6DypK0EO+lW5pbrCR56iE
         iiiEF40EZSblwZxD4+8L3PwEQEFBqeaVzYNWms2di3jRkkSy9zfVHm7ay1OxPQdZXYnp
         sKoRlYYsZoJIlyyzAMNj+C3xhmbmMwk38gJ6gZkNb0tAMA7HcnbwnNMjBm0WZICHoS4x
         kgrApZfnh7dQ2X6Wnwd5gSkp4LK8ZcmbyXzzZ0RsMDDIzGErOT2HG/41DWMfxh0E2HCz
         AlgTor+ucO7Sou8e0Zd3aDyocML8VRH1NAWVYZgsXwtaVsFGAe7CAaAN64E8o/cQ+evx
         sCfQ==
X-Gm-Message-State: AOAM533JwHxnh1M0MZtaH/SjqHeCe+KNjq1KJB/3x4ShnH4B0VnNFjnM
        1R61xE3/GklQz5omLt0ysRFL7aYCXqXrhxjyPdo=
X-Google-Smtp-Source: ABdhPJxhJsAXOEpc8u16MGCQvnWlhTzHF7LeoIcA0gZxXD1KZAj0Ap08AEp3wQXOkJiGWXxJ6HhCmKJMmpEHbCzu50Q=
X-Received: by 2002:ab0:7845:: with SMTP id y5mr9321545uaq.34.1589739408481;
 Sun, 17 May 2020 11:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-37-sandals@crustytoothpaste.net> <CAN0heSqpqAyKyaz+Er-SppR8k5W=zfw31rLR=Z8yZzqu=BCnTA@mail.gmail.com>
 <20200516204710.GI6362@camp.crustytoothpaste.net>
In-Reply-To: <20200516204710.GI6362@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 17 May 2020 20:16:37 +0200
Message-ID: <CAN0heSqXSPXG38aqQggxA6yjkg_+PVVdh3M01RQKJM0gO0wAPA@mail.gmail.com>
Subject: Re: [PATCH 36/44] builtin/index-pack: add option to specify hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 16 May 2020 at 22:47, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-05-16 at 11:18:12, Martin =C3=85gren wrote:
> > On Wed, 13 May 2020 at 02:56, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > git index-pack is usually run in a repository, but need not be. Since
> > > packs don't contains information on the algorithm in use, instead
> > > relying on context, add an option to index-pack to tell it which one
> > > we're using in case someone runs it outside of a repository.
>
> > Similar to an earlier patch where we modify `the_hash_algo` like this, =
I
> > feel a bit nervous. What happens if you pass in a "wrong" algo here,
> > i.e., SHA-1 in a SHA-256 repo? Or, given the motivation in the commit
> > message, should this only be allowed if we really *are* outside a repo?
>
> Unfortunately, we can't prevent the user from being inside repository A,
> which is SHA-1, while invoking git index-pack on repository B, which is
> SHA-256.

Ah, I see.

>  That is valid without --stdin, if uncommon, and it needs to be
> supported.  I can prevent it from being used with --stdin, though.

Hmm, that might make sense. I suppose it could quickly get out of
control with bug reports coming in along the lines of "if I do this
really crazy git index-pack invocation, I manage to mess things up". The
easiest way to address this might be through documentation, i.e., "don't
use this option", "for internal use" or even "to be used by the test
suite only" for which there is even precedence in git-index-pack(1).

On the other hand, if we need to detect such hash mismatch even once the
SHA-256 work is 100% complete, then I suppose we really should try a
bit to catch bad invocations.

As a tangent, I see that v2.27.0 will come with `git init
--object-format=3D<format>` and `GIT_DEFAULT_HASH_ALGORITHM`. The docs for
the former mentions "(if enabled)". Should we add something more scary
to those to make it clear that they shouldn't be used and that you
basically shouldn't even try to figure out how to enable them? I can
already see the tweets and blog posts a few weeks from now about how you
can build Git from source setting a single switch, run

  git init --object-format=3Dsha256

and you're in the future! Which will just lead to pain some days or
weeks later.... "I've done lots of work. How do I convert my repo to
SHA-1 so I can share it?"...

We've added "experimental" things before and tried to document the
experimental nature. Maybe here we're not even "experimental" -- more
like "if you use this in production, you *will* suffer"?

> If you pass in a wrong algorithm, we usually blow up with an inflate
> error because we consume more bytes than expected with our ref deltas.
> I'm not aware of any cases where we segfault or access invalid memory;
> we just blow up in a nonobvious way.  That's true, too, if you manually
> tamper with the algorithm in extensions.objectformat; usually we blow up
> (but not segfault) because the index is "corrupt".

Ok, I see. I suppose "some time", we could tweak error messages to hint
about an object-format mismatch, but I don't think that needs to block
your work here now.

Martin
