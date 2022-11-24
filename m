Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA009C43219
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 11:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKXLho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 06:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiKXLhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 06:37:42 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E21276C
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:37:41 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso751033otl.13
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZcRGAxd0K6ZdYYYhYoE2HDWPNYKn9qv2vbJK4qPeJo=;
        b=CvnGlP+IOAEZ3cAmPBh0El6YKUO1mmJMPuy1s17wmvdLiI+KLNI9s1yMzvX1103xza
         SJi68XwNo86VUkIR0akZ7DL5015Q+35BV8lOH+8Nx5cUJyBG9LXqIzUAC5GC3BnG5ZKk
         VX5H9Bjv389hBElkewnMNNSKEM8zN198oTiVa3xliXXZkPoS5SX/xTdSec+4q/DCGyxl
         3S5Mfun03X55ALL93/IoJAoA3eBG6vgkxNBKVQiwFD6WIooSIJejM+0y+SVd/3ZDI0TS
         1iyWujtHyQ8ZMmJsYp4hVpgU78JOYOEsU+b5qCxo6Ez1BkutECOcKSpmtmduTm6Nwnt3
         b9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZcRGAxd0K6ZdYYYhYoE2HDWPNYKn9qv2vbJK4qPeJo=;
        b=uMJc/IWrdI2I55a08OZlCVN4g83hVsBqfYDDotECqk6hyswv3GeP6dU2VScZ8+nyxq
         BtdEPevmqgjUlMccsiVTaZcxiJb3LSvEtef733wEsNlC7dpm3DI+eCaYCODrA8v+dGxh
         I+KJNPnFlLyzLX/I20Jr+U5ECkK2crCO5LnAt2NIhAwim0lIlvI6eUPvMlmu3iwlnDZ2
         3qPdSxmhiD/TQ2EAyGge+HHeSZ59BzhB/fl3VIr0sEWcl6Bpk4v56x4YUc1UmAbspR5A
         7zxgJ0g/U22eSnPPCqdJw5HMJt/MxubGhtYg0IAPNpwrMeGZRMPeBja5THT6qObMq/Dd
         XRsQ==
X-Gm-Message-State: ANoB5pkr/jt9+Viz8kJWq0IH1+a3rUQl2XprMlTjGnEHKuU+7krN05tf
        tIjPikM4sGEKXSqV6/UbDV12vvwq3i5I3Qeq6Zs=
X-Google-Smtp-Source: AA0mqf6+q1WOz8mIDl7paJKYh47fz1gjdhB5bC25e/JTkD4w+s7y6UMWzSn9wJxtb04jarWDNTLszv/lcxZy2ZtXg/Y=
X-Received: by 2002:a05:6830:4d6:b0:659:1976:647e with SMTP id
 s22-20020a05683004d600b006591976647emr16516655otd.377.1669289861331; Thu, 24
 Nov 2022 03:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-4-worldhello.net@gmail.com> <221124.86edtspq74.gmgdl@evledraar.gmail.com>
In-Reply-To: <221124.86edtspq74.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 24 Nov 2022 19:37:29 +0800
Message-ID: <CANYiYbEHXwXTpRiha+0SoO_7_6LrJ7iE5c-fc-uzp21+aXKgBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ci: install python on ubuntu
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 7:06 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Nov 24 2022, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Python is missing from the default ubuntu-22.04 runner image, which
> > prevent git-p4 from working. To install python on ubuntu, we need to
> > provide correct package name:
> >
> >  * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
> >    "python" package, and "/usr/bin/python3" is provided by the "python3=
"
> >    package.
> >
> >  * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
> >    the "python2" package which has a different name from bionic, and
> >    "/usr/bin/python3" is provided by "python3".
> >
> > Since the "ubuntu-latest" runner image has a higher version, so its saf=
e
> > to use "python2" or "python3" package name.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> >  ci/install-dependencies.sh | 2 +-
> >  ci/lib.sh                  | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 291e49bdde..e28d93a154 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -15,7 +15,7 @@ case "$runs_on_os" in
> >  ubuntu)
> >       sudo apt-get -q update
> >       sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
> > -             $UBUNTU_COMMON_PKGS $CC_PACKAGE
> > +             $UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
> >       mkdir --parents "$P4_PATH"
> >       pushd "$P4_PATH"
> >               wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index a618d66b81..ebe702e0ea 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -235,8 +235,10 @@ ubuntu)
> >       if [ "$jobname" =3D linux-gcc ]
> >       then
> >               MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python3"
> > +             PYTHON_PACKAGE=3Dpython3
> >       else
> >               MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python2"
> > +             PYTHON_PACKAGE=3Dpython2
> >       fi
>
> Let's not copy/paste and repeat ourselves here for no reason. Part of
> this is pre-existing, but if you just re-arrange these variable decls
> you can do this instead:
>
>         PYTHON_PACKAGE=3Dpython2
>         if test "$jobname" =3D linux-gcc
>         then
>                 PYTHON_PACKAGE=3Dpython3
>         fi
>         MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/${PYTHON_PACKAGE}"

That was exactly my first edition, but I thought it was weird to write
as "/usr/bin/${PYTHON_PACKAGE}". But if use two variables like
PYTHON_BINARY and PYTHON_PACKAGE, looks even more silly. So I choose
current solution.

--
Jiang Xin
