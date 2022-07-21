Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653C2C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 11:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiGUL6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiGUL6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 07:58:10 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376B2FFDA
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 04:58:09 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 94so612537uau.8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G7UigfGbMHMuPk0oCLIzJyTmoLtS4d6WGoLew4dCkTo=;
        b=YWsGWpfR9oNSLWTySsO+CnAhsDCTdYFm7uDU4oDp1biWWR86y45i7ZeTq9+10hMsY6
         TqHDB9zNJnYZEK693r3XeQRLIQ0oAHJ31jjN2qphUYFq+n9yxuqjmq7FbQL/tlEsFkOp
         ScqsCNMTWBm2MTBOOyNrYcCMXdTByObs+WdguvVuZkwuWNE4wMRwFK2iu8VT8lBssqk0
         0yblvCS34GYCWpzMiz1psFfe06uh3kFgGESlRFSNjXWuenDSKlOBJ8sv4+UnL8HE7eZ0
         402ZcoOIUOTzdZlIv08Po6AldZvWLKq8nzJ/McbyiefAaxy6pH3bWYiCjm2xOpzd9MNj
         Dj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G7UigfGbMHMuPk0oCLIzJyTmoLtS4d6WGoLew4dCkTo=;
        b=xNQNkI7JRI1JmG1dxnppwZZgnT8vIMZ8eEI+SaVMljaTXCqOfLvZmunrJDZSi4zRXd
         8hnZkhI/OAO/t8NiFyQzZf+nmuE2xcPc5lUyDbAAG3bR2wYN23leH3P2fKfayDPx/APW
         JPzKH/IMO4dB1svQ+cIxcwaa3DDKA4de/HR8QFO7lz75ItyFGJKrN9vuTQy4tygrOnCk
         xlqJ6hos/rdv6FHMnzTmqpK2+2TLsk7JjJOAgtkph9uN2B7caycyNO0PkrCMqjLvMq1Y
         NvuykPqkhu0Fu3xaLlMv9J7e2IK/Eu1tMsIZevj0itkrVRbSOkcMy9a693HxHQYqb8+l
         t+gw==
X-Gm-Message-State: AJIora9CUfNGHLV0jkp+iFJvv+jDevtilpYpUfKusyuE1qnDATpQizDq
        TEz6VDDqgL1gLMMlr0/nFfnwCzdiFDzUEffQsaU29g==
X-Google-Smtp-Source: AGRyM1tPfPrbaDXrLerh0zbCRbvz7sbJWzO2OeYcdpRRil1BQ8ntEpOY2VdS1cjaeEFO2nZmhVSr8j+GrOFHfPzeP0Q=
X-Received: by 2002:a9f:3dc6:0:b0:384:54ca:ad6f with SMTP id
 e6-20020a9f3dc6000000b0038454caad6fmr1976921uaj.26.1658404688842; Thu, 21 Jul
 2022 04:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local> <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220720192144.mxdemgcdjxb2klgl@nitro.local> <Yth9TCCEXfmagaaw@mit.edu>
In-Reply-To: <Yth9TCCEXfmagaaw@mit.edu>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 21 Jul 2022 13:57:56 +0200
Message-ID: <CAFQ2z_Mc6Z-FyFkUURMCM11yQTH+Y2PLBrAKB-16BXv159=oOA@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Glen Choo <chooglen@google.com>,
        Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 12:10 AM Theodore Ts'o <tytso@mit.edu> wrote:
> On Wed, Jul 20, 2022 at 03:21:44PM -0400, Konstantin Ryabitsev wrote:
> > The kernel community has repeatedly rejected per-patch Change-id traile=
rs
> > because they carry no meaningful information outside of the gerrit syst=
em on
> > which they were created. Seeing a Change-Id trailer in a commit tells y=
ou
> > nothing about the history of that commit unless you know the gerrit sys=
tem on
> > which this patch was reviewed (and have access to it, which is not a gi=
ven).
>
> The "no meaningful information outside of the gerrit system" is the
> key.  This was extensively discussed in the
> ksummit-discuss@lists.linux-foundation.org mailing list in late August
> 2019, subject line "Allowing something Change-Id (or something like
> it) in kernel commits".  Quoting from Linus Torvalds:
>
>     From: Linus Torvalds
>     Date: Thu, 22 Aug 2019 17:17:05 -0700
>     Message-Id: CAHk-=3DwhFbgy4RXG11c_=3DS7O-248oWmwB_aZOcWzWMVh3w7=3DRCw=
@mail.gmail.com
>
>     No. That's not it at all. It's not "dislike gerrit".
>
>     It's "dislike pointless garbage".
>
>     If the gerrit database is public and searchable using the uuid, then
>     that would make the uuid useful to outsiders. And instead of just
>     putting a UUID (which is hard to look up unless you know where it cam=
e
>     from), make it be that "Link:" that gives not just the UUID, but also
>     gives you the metadata for that UUID to be looked up.
>..
>     So if you guys make the gerrit database actually public, and then
>     start adding "Link: ..." tags so that we can see what they point to, =
I
>     think people will be more than supportive of it.

Support for the "Link:" footer as a change ID has been implemented in
Gerrit as of https://gerrit.googlesource.com/gerrit/+/8cab93302d9c35316d691=
e848b67e687a68182b5
(available in Gerrit 3.3 and onwards).  I'm not sure if it has seen
much use, though.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
