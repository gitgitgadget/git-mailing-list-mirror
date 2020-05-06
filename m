Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D57C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B102070B
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLZDO4Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEFUtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgEFUtF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 16:49:05 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED31AC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 13:49:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n11so3141561ilj.4
        for <git@vger.kernel.org>; Wed, 06 May 2020 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1h2r5B1DbhCLa/ll27gySFGWosq2r3Yn/qosANkOEPA=;
        b=MLZDO4Y7younQVr6x6KZeJdn35lpJ4XUNkId8k6FUj2ukG4N6Ov/IF8020Qv10NRds
         aherEXIZvOgaiEoSDnr2/V2o0cEIEf0RBrmeEEZeoyo0UxXc5LW/zo9LjFfQL8vxLVJp
         eKIH+Iaav6QyZzpvFXf4xwTfSaL2btWsY5zs3ciZN54FbaHFlG3ovxkF44yJ1Y+iqBMn
         k3m0KN04gqI+v5mcJpUNKqiY9DyJ6wzuWst+04De/HkwdpDpmsh2seaZ56JpqOE6tJpf
         X6BTvc6OuaJ5spTRCYoUKR7BkebcCyPHs+nC2fPhEf4uVipR1kW9uiIW2r+XZ2bFbJhO
         yw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1h2r5B1DbhCLa/ll27gySFGWosq2r3Yn/qosANkOEPA=;
        b=Ag4F6DtOTsAAuKg0DwLeH05XG6g7p1KhwOT3PpupPpMnh+Z1zi7b0vca5RoGltYUA1
         fAN19pkQI0F+Ayp1yGiXKUNfH1RYcsONno0pinQB3FRd7oS0sDHYsA/kQRIbfRRyvUS0
         cytfN/jQ2HiG9Qpbh53ervSH49+/23+R0SqEqP2awKFsOsdejzB4cJSGwP2hT7IF8EX7
         O6bBcKIlNiNWDxQZgEXjFyYNyijeAXTI0Eo+tcXfikur8p2MUzhnZoSidHpgjoDopxzj
         nDQduScyrXZT8QcBC+yAYSGWh6k9Co2Gra+JqXyTlphx7avwLyPWegFSa9+8nOlZ8DMi
         u5YQ==
X-Gm-Message-State: AGi0Pua7wzvD1ov5UDn/EeWAmpUIId5HyLYGiWi9k0LLdkm94XREt/Kp
        RJDPe+5ydMkzri1c9zxqF0tfniW/dSsxI8AtVdC1F4rM
X-Google-Smtp-Source: APiQypLEGmH5Z4mpam8O1ceOk2tMqbwhsIL9vtHzen05hf4ZBQnk1S5k8/IDbBknR7ByKBWx4kBypW9fTBJkr3BO5yw=
X-Received: by 2002:a92:3652:: with SMTP id d18mr10775972ilf.212.1588798144107;
 Wed, 06 May 2020 13:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4> <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
 <20200504201944.gh3zykhil3txdwnk@tb-raspi4> <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
 <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com> <20200505041033.w2q7h5k7otetfrus@tb-raspi4>
In-Reply-To: <20200505041033.w2q7h5k7otetfrus@tb-raspi4>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 6 May 2020 16:48:51 -0400
Message-ID: <CAH8yC8=YfjUqYmAs7AVtwK2MtVi-W+LfiidkwAVcy4S2TYm=4A@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 12:10 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Mon, May 04, 2020 at 05:39:50PM -0400, Jeffrey Walton wrote:
> > On Mon, May 4, 2020 at 4:30 PM Jeffrey Walton <noloader@gmail.com> wrot=
e:
> > >
> > > ...
> By the way, does
> ./t3910-mac-os-precompose.sh
> work on your system ?
>
> So far I am not aware about any problems with iconv from MacOs
> being reported here on the list.
> Which problems/bugs did you found in the iconv shipped with MacOs,
> especially together with Git ?

Thanks again Torsten .

So there are several problems with libiconv. First, sometimes it is
too old and carries bugs with it. For example, sed and awk fail to
build and pass their self tests because they expect a minimum version
of libiconv.

Second, there are some modern bugs that needs fixing. They were
reported after libiconv 1.16 was released. It needs patches.

Third, libiconv cannot get through testing with UBsan. It causes a
number of packages to fail to configure or pass their self tests. It
needs patches.

Fourth, libiconv cannot get through testing with Asan and Valgrind. It
leaks resources like a sieve, and leaves memory and file handles open.
It causes a number of packages to fail to configure or pass their self
tests. It needs more patches.

Due to all the problems with libiconv I just patch it and build it
everywhere I need it.

The other option is to wait for the maintainers to fix libiconv. Based
on some reading about the UTF-8-Mac problem I don't think that will
happen. And they are not interested in fixing the resource leaks. GNU
has such low coding standards...

Jeff
