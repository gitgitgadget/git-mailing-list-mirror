Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEFC43219
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiDFFFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836183AbiDFAfO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 20:35:14 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765AB168084
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 15:48:02 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id h7so649581uan.4
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aGlTeJoPLqIjcOAjv6OqPO3gUzxfoZqjPBC5iWrZyP4=;
        b=LdVZ6n+8uYcfliPHMa1LelAku6Udr5yldrx4IjtcSjsyfcC9YrWfv09EXXEcUJ8bK3
         nMKpVEM42EbMgJ2Y50TgLk2djtRTr5eiRolMwnijAkrPkXeZ3tyBr6U04hJGyMIXnIwx
         Gm+HGVo1IsDwCop1ZkO+gowAYrdNVhYsD8RA0/xPy/GA4Y73HpyZ3Koa12p4TeAv9T3T
         Y+fSE8X7SR/KIbC2jFIhr/fkAIvKE6CMG7Xt9vynOXagdv/+iOMwrk3InkXPJtVDxMIq
         j5Jd0caol8WZ55nqED63mZG0gx8gF/zh/4titf7PXlHoo837Dq/gqqkEL++J46JIkrx5
         nX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=aGlTeJoPLqIjcOAjv6OqPO3gUzxfoZqjPBC5iWrZyP4=;
        b=jeYcyQMMylwKKe88TVMI0f0aIV3zeW+P1Xt417ZI99w5LTmKROtFqIvVJU8tHzvRou
         EkNJb214eVGZg019dWJnnFz0msbBJyQ5aC84DxLA71Q/2Y7nYN1ZdxDQOu9ztNJ7wSUg
         eNIn/nFXwbdQYnDXrRh3QxXGm0fHVFaGR92QXGPU1qb4V2eURCVf65OCKFT1Fx0wH9ar
         LXap1Ztw6DbChZmi545pQrXIEd4pxVJm2GLjx+j06HPXn1zcKUmPRUTbSHBkoXS5u+74
         OXEkw6RGGx0XrabeuyszmWNEywDPj3MF47ym6ToytvCkQuYHJJ1gm+LdcjN3f6Myniem
         4wfQ==
X-Gm-Message-State: AOAM532/0aOlofxqCOzvj+x/AWnY0N2lDM1lzIgZzRWnGoj1QGqKfV06
        d5ZCdA9SEzYHTKNaYTusyDMAvNx7U8AP5yz8IVM=
X-Google-Smtp-Source: ABdhPJwvJFt8v6tD/rpMly5R0FsvijdauUyhUU1D5TH+u+43JKWDpQGeK9UxltVEGytf/izCoWKXgCoBb/omk2ktnzI=
X-Received: by 2002:a67:1a02:0:b0:320:a51f:8067 with SMTP id
 a2-20020a671a02000000b00320a51f8067mr1981794vsa.38.1649198868643; Tue, 05 Apr
 2022 15:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
 <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
 <034701d84875$030bfb40$0923f1c0$@nexbridge.com> <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
 <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan> <035b01d84899$3cdc5b20$b6951160$@nexbridge.com>
 <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan> <Ykv5dCEv/gl7aHMq@camp.crustytoothpaste.net>
In-Reply-To: <Ykv5dCEv/gl7aHMq@camp.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 5 Apr 2022 15:47:37 -0700
Message-ID: <CAPUEspjAiXKz00VgP16RRA+ZKYpG0QjpU4XxwJXYnZm+MQwwqg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 5, 2022 at 1:10 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I didn't consider the case that we had NO_OPENSSL=3D1 because it seems a
> bit bizarre to say, "No, I don't want OpenSSL=E2=80=94oh, wait, I do want
> OpenSSL!"

NO_OPENSSL is definitely strange, for example in macOS it means: do
not link with openssl if it comes from homebrew or macports, but maybe
use the one that comes with the system, which happens to be based on
openssl anyway (based on libressl, boringssl, or even a really old
version of openssl, depending on which version of the OS you got).

Either way, the choice of using the openssl function this requires
could work with any of those if provided with the right linker
settings, but it doesn't seem worth the trouble to do, especially not
for rc0.

> This patch also didn't seem necessary for me on Linux when I tested, but
> of course it might be necessary on some systems, so if it fixes things,
> I'm in favour.

Not sure if the required changes got somehow dropped in one of the
rebases after your tests, but it definitely didn't work for me when
tested on Linux (using debian stable or sid) and I can't see how it
would work unless the crypto library is pulled in some other way, and
even in that case the lack of the header should break, at least with
DEVELOPER=3D1.

Carlo
