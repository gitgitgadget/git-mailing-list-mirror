Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE3C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 12:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKXM4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXM4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 07:56:46 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834912AF6
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:56:46 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so881505oti.5
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miAQ1XipH7DAoQzvBFPW5XwiglTbkmQVx3xo2NFqsq4=;
        b=ZyQcpd+KyAJmxArzdlNIx2xL2yGeTkNQDgwvrwdbfkhNUzo0KJw6QC5WM86gu+DZ8A
         5d/gxWauoh6p7CBj2HhLP7jg8sTA7HHiIvvs/U1/svT07FVEjX4BMGZymYZZiF4dyH50
         TLqSVNQNETn8lc801zIwGw5TiY7kAtQS6r10wvo14+55Ph20codnYV5+4pKoUcD0vcpR
         9V1pUykqjPdBF/1kOhwdBhazPgH7wh/VGZRgk+PBn/JB/MP7UeySmMvT2MtFJD3iLScU
         h6v9Z0zvrwlX3XiI0Uv0hNWM1oRDhLdNTTP1od0L1l6v2y00ngoKXqq+W15AbelKOMos
         pfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miAQ1XipH7DAoQzvBFPW5XwiglTbkmQVx3xo2NFqsq4=;
        b=CpSt9aAVzCVXL7dEVmp6AoiRGe1Ym/XtER4eVP7PnX+Q/08L1T82dscq1r+jUEk3cR
         9GAns3FYeGVQb9Ja03ITfqbk3ZSck/BqFZvV5QhKzZ685I7z1UkREmKhg/bcIDiycuQp
         8dF/tfdTB6KUBjMW4BhUcZYCLpSDwjBMa+Ma669rNWz5tvcVEQpb/r5gl8gePlX1Nx2r
         Sz/1v7LzvreAm4hcnl29DgQCJKMORSLMIdqFUIlmGD5kykDON3VEuyryUkqiY2xti7GJ
         Mu6BnEmGGYWCmJ5YDutvKwS1iGvBTfZF5bNRKmb2oZfnIk75d4gBe27uFSKwahAYZO8g
         ixTw==
X-Gm-Message-State: ANoB5pksfjgKk/LdxoAfa/aQ8Iyd2h9H1DFt43XTk8wF34lqAxln/fN3
        Nt9VbfzFk9BzM1lyJmqgzCUlll/le5HpOTb5nMo=
X-Google-Smtp-Source: AA0mqf7QGcEBoCgBvU9xqkZnLyDKfP2olCrjbwPXyVrkJyUfQg8TrL9KUhpmVHuIjh6xTR0luhg69dHCncAzbIvhhSA=
X-Received: by 2002:a05:6830:134f:b0:66c:68e7:d673 with SMTP id
 r15-20020a056830134f00b0066c68e7d673mr7312711otq.31.1669294605372; Thu, 24
 Nov 2022 04:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-3-worldhello.net@gmail.com> <221124.86ilj4pqfn.gmgdl@evledraar.gmail.com>
In-Reply-To: <221124.86ilj4pqfn.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 24 Nov 2022 20:56:33 +0800
Message-ID: <CANYiYbGMdECEWzCOgBrU3su4m=hrp8MND17cZ8ZaNjpgUbXmuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ci: upgrade version of p4 to 21.2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 7:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Omitted from this context is:
>
>         # The Linux build installs the defined dependency versions below.
>         # The OS X build installs much more recent versions,
>
> That part should be updated here, as it's now out-of-date, they're now
> installing the same version: 21.2.

Yes, the versions of p4 for linux and macos happen to be the same. We
can use one variable to define p4 version for both linux and macos.

>
> >       # were recorded in the Homebrew database upon creating the OS X
> >       # image.
> >       # Keep that in mind when you encounter a broken OS X build!
> > -     export LINUX_P4_VERSION=3D"16.2"
> > +     export LINUX_P4_VERSION=3D"21.2"
> >       export LINUX_GIT_LFS_VERSION=3D"1.5.2"
> >
> >       P4_PATH=3D"$HOME/custom/p4"
>
> This is a welcome change, but it would be even more welcome if you
> followed-up and unified the linux and osx p4 logic as a follow-up.
> I.e. after this we'll install 21.2 on both osx and linux, so the
> versions are no longer different.
>
> I think we probably won't need to install different versions for the two
> ever, we just drifted on the linux version, or maybe (per the comment
> we'll need to adjust) there was some problem before with upgrading the
> linux version, but no longer?
>
> I didn't dig, but covering some of that in the commit message would be
> most welcome.

It is commit d1c9195116 (ci: avoid brew for installing perforce,
2022-05-12), which changed the installation method of p4 on macOS.
There is also a note about the obsolete comment in ci/lib.sh in this
commit.

> So can we just s/LINUX_P4_VERSION/P4_VERSION/ or something, and then
> change this in the "macos-latest";
>
>         wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx101=
5x86_64/helix-core-server.tgz"
>
> To:
>
>         wget -q "https://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.=
macosx1015x86_64/helix-core-server.tgz"

> While doing that we can just move the "LINUX_P4_VERSION" (or whatever we
> rename it to) from lib.sh to "install-dependencies.sh".
>

Will do.

--
Jiang Xin
