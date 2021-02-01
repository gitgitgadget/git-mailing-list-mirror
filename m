Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F51C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D139560C41
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhBAHFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBAHCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:02:41 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0AC061793
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:01:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i71so2354132ybg.7
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAvuX5o7m5X485bbkAJ0C65abbc7/mTvbd1i7ZxOGSU=;
        b=M/9fAxKTcl9rfmK/2zb+ds/i9UV583ogJ48Q1zM/vjliInfDTVspAOINffXOmMuP3o
         YGkcxl+MdoOmSZ/o2i28dFS3IQYfBVPXY85UOOkfKmeX3prWAMaY9Vw/0Win/K1RfIma
         wIHQoNNt8Xy0RhNrewsNAkQT7ZcjRz06u9KNI6xdAD+boNdmqnzSCGnDU7nrO2bWKarQ
         ecVmU+0/jDS8haSnG3aC5t0LRAT0qyDKTcd2cawqBKkXMtc6q1fNisWOyRt1XjhkND15
         3kWYSzcKUX3zRHzCtVBhN0Tn7vYtMX30/144AxeWEiQTUqV9KAqGiR09m82xH9h5ZI0U
         9zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAvuX5o7m5X485bbkAJ0C65abbc7/mTvbd1i7ZxOGSU=;
        b=Tqsp9k/3IpA1sVpn1MOHdJV9b8Ve3d8skM5Lb7PA3fOMXpvbT4NpEFpkQT7Rww1CAD
         JGDjRi+dudqm+C09FlFm93/GndG79R0Vp00xVhlCpR2unlbVD5Dbqs9pyp9PPHq7IcrI
         7MdOucr5z7os1k7uC/NISGclYXEcO00PgiSun+ImfNG8wCiLd3ZGFGh06FyMxO7G4FFE
         Px6rOpzb91tdzCx4+5ZRvIZTBY+b81Dk9jivDUzD0xtL+B3AA7wdo0FVXrW23pY3EiQS
         806npYijN765Ji4QhT7dGOCgoHYZUJAxc7aa7AqqFxgnmxavVryb2Sxdbo7d/rrNuX9k
         ZRgQ==
X-Gm-Message-State: AOAM533JzeSgA8FI01qku0ywsF8IE8QBmKB3S/KhZNU84j6WC0XYub3X
        JR8BCxkXDeILDjHdOJap1c3zJ00G5vxXOKY8aoG9kCHtrVNgQA==
X-Google-Smtp-Source: ABdhPJwB6dwIXT+4J4OWclSETMIQ/jAWciHD1UJ7qqNguvJsew0oCbfYw5XfYqemSoEMQkubhCcIrMVvu8kYVTgRiOs=
X-Received: by 2002:a25:b94a:: with SMTP id s10mr21660617ybm.374.1612162895506;
 Sun, 31 Jan 2021 23:01:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
 <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com>
In-Reply-To: <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Mon, 1 Feb 2021 15:01:24 +0800
Message-ID: <CAGP6POKB1b=gCjd-rNCYrJKcp8bmRP_cpwAPi81udh61ZdZJzA@mail.gmail.com>
Subject: Re: Recover a git repo after accidentally deleting some hash files
 located under .git/objects.
To:     =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 1, 2021 at 1:54 PM =E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gm=
ail.com> wrote:
>
> Hi=EF=BC=8CI don't think so unless you have the commit
>  in github or gitlab which include this file=EF=BC=8C
> maybe you can use git pull to get it.
> By the way ,you can ask questions in irc chatroom #git or #git-devel.
> There will be a good place to get help.

Thanks a lot for your suggestion. BTW, what's IRC client and server
used by you normally?

> --
> adlternative
>
> Hongyi Zhao <hongyi.zhao@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:16=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > I accidentally deleted some hash files located under the project's
> > .git/objects subdirectory. In this case, can I resume the project?
> >
> > Regards
> > --
> > Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
> > Theory and Simulation of Materials
> > Hebei Polytechnic University of Science and Technology engineering
> > NO. 552 North Gangtie Road, Xingtai, China



--=20
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
