Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0BC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiLBQrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiLBQrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:47:05 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4EECAFA3
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:47:04 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id i2so5183098vsc.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oAtu6SjGH6yVtVn0VuLss0uyIxRS1ZHlkspWx4l+Mo=;
        b=d74waH6ReGR82SkfExw8n8U/mLIvirzKY6+rTFrFrb+Ht667vvp2OjdInHpGoHmakZ
         bFMLyfWivPBo0BKZtNHF9+VaExOnjIvbHLhzrITS7sCbV0a3nh8qBVReJt+rs0kfJCN5
         zaIO8g8acVIU3IH0jm7/8ResVeZJTnS/oib1/Np966rjg5M21v/o6iLrIuLhjMgoK7at
         CDBOayA2jttAYXk9+MH4YYZM0gbfbfvu4imw75sddsbdMT4LQ7I6IsAaE55v+j3+mMtk
         f0tGB6dpjDXJkyVvmgAhxLxCanXYxygWyv027MZDYheK98j+604kPiECOwlEJm3o433e
         +nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oAtu6SjGH6yVtVn0VuLss0uyIxRS1ZHlkspWx4l+Mo=;
        b=QnBFrbd6ug7R8bYYE8mpWtYkJIQ53r2PHonO7ZZecOZTS0tljX1MdSNn12AkXcMgs1
         OU/3GGC6LAbj7RuA32G4u4r0NryZ8EtpDkxXpvrE6Edi7NKcsbUa07ZD+ZloCe5nssK0
         p49q52QCg+fxd974/umJtI5bK4DYK6rthRkwUeGYUCGYq3YXnJQGb8XiMBSS5oln3fSE
         YEgp/V6OLBMNW2Sf8pb+a5nodvVPigBlJzj3dVpkvkZIyJ4zaa0cJb1R3x+fIXl4h2HL
         lmrODTl0WRs8zvovd+Uke7lNrTRF1IhoKrdE7crmbs3C+/FnYstqJYBW/ppY52Greoxl
         /5Kg==
X-Gm-Message-State: ANoB5plr2GDUpV8JlnDge25gfwLrE2aER65kirJ4XuYgf1zbvHaEkzjR
        ZiHW0FGsDpWjjtag91LPt6+kKXweqVbDxa1/g5R2YQ==
X-Google-Smtp-Source: AA0mqf4QSJRwCN3Qr2Bsc11SP00eepCnsQPLEuIX5aiv8ZnmcHYDElefmcBn70nLeaDkRTYRma8GfP4ZWOY7GHJdn5g=
X-Received: by 2002:a05:6102:34f8:b0:3b1:106a:d834 with SMTP id
 bi24-20020a05610234f800b003b1106ad834mr3623044vsb.31.1669999623216; Fri, 02
 Dec 2022 08:47:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
 <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com> <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
 <f5370fec-d517-eaa9-8e16-82fa20ac8532@github.com>
In-Reply-To: <f5370fec-d517-eaa9-8e16-82fa20ac8532@github.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 2 Dec 2022 17:46:51 +0100
Message-ID: <CAFQ2z_NKpgsEsrDdkdp=HDajrzpUDjiUcUdR8TMkYpXZBU0k+g@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 9:19 PM Derrick Stolee <derrickstolee@github.com> wr=
ote:
> >> The reason to start with this step is that the benefits and risks are
> >> clearly understood, which can motivate us to establish the mechanism f=
or
> >> changing the ref format by defining the extension.
> >
> > I believe that the v2 format is a safe change with performance
> > improvements, but it's a backward incompatible format change with only
> > modest payoff. I also don't understand how it will help you do a stack
> > of tables,
> > which you need for your primary goal (ie. transactions/deletions
> > writing only the delta, rather than rewriting the whole file?).
>
> The v2 format doesn't help me on its own, but it has other benefits
> in terms of size and speed, as well as the "ref count" functionality.
>
> The important thing is that the definition of extensions.refFormat
> that I'm proposing in this RFC establishes a way to make incremental
> progress on the ref format, allowing the stacked format to come in
> later with less friction.

I guess you want to move the read/write stack under the loose storage
(packed backend), and introduce (read loose/packed + write packed
only) mode that is transitional?

Before you embark on this incremental route, I think it would be best
to think through carefully how an online upgrade would work in detail
(I think it's currently not specified?) If ultimately it's not
feasible to do incrementally, then the added complexity of the
incremental approach will be for naught.

The incremental mode would only be of interest to hosting providers.
It will only be used transitionally. It is inherently going to be
complex, because it has to consider both storage modes at the same
time, and because it is transitional, it will get less real life
testing. At the same time, the ref database is comparatively small, so
the availability blip that converting the storage offline will impair
is going to be small. So, the incremental approach is rather expensive
for a comparatively small benefit.

I also thought a bit about how you could make the transition seamless,
but I can't see a good way: you have to coordinate between tables.list
(the list of reftables active or whatever file signals the presence of
a stack) and files under refs/heads/. I don't know how to do
transactions across multiple files without cooperative locking.

If you assume you can use filesystem locks, then you could do
something simpler: if a git repository is marked 'transitional', git
processes take an FS read lock on .git/ .  The process that converts
the storage can take an exclusive (write) lock on .git/, so it knows
nobody will interfere. I think this only works if the repo is on local
disk rather than NFS, though.

> * Step 1: replace packed-refs with reftable.
> * Step 2: stop writing loose refs, only update reftable (but still read l=
oose refs).

Does that work? A long running process might not notice the switch in
step 2, so it could still write a ref as loose, while another process
racing might write a different value to the same ref through reftable.

PS. I'll be away from work until Jan 9th.
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
