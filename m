Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F4C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 05:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLCFXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 00:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiLCFXH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 00:23:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B31A1C24
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 21:23:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10144625pjs.4
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 21:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBbteuEtD8vjhT4p47cmGeGBdGXRbSmwTiKik1oJQac=;
        b=d68xEJ5iAOlRKEJZ+nVmd4OAHS8r68TundcYdx+Y0j8UOw69V7Jj4nLBFqEP2mlyBk
         XgHhqZdAT7NL+dIis2BhJjUkKqXxqJXZA5PwgXaRM2cIEhhmBgpBR90a5MHSx9aJiE3m
         WD2ttiuZ1ZFKLJP1Y/Tv5Y6qtN76ysbVSzvj67Rw9WbEDXT3dl47HIqBG/zFYH8oqT/l
         5BuyE/a4YbpWTnMFzCBtv2tDEK9mG4fY6+aLdWv7qT5EiPPqihyaIphCyhTlpzQpe+OO
         mflT289cd4jB3+U8lCzJQ13tiyc9uHFjEDX+FwTd3wxXbFGrEhnQX0fPdW0ddRWJ6inb
         +Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBbteuEtD8vjhT4p47cmGeGBdGXRbSmwTiKik1oJQac=;
        b=B5GlpJjuDjKDEPNuFPobGh3W9RHZ0M+HWHcgjQZbt2PvAoDtCTxz3YtVGnVAbR/b/8
         i3EygK0KUPM0O4oYqYgku3MJX1OhKV0RzCIO6U0V/e8SgPic1NXkf4fuJJY3IO++l1zQ
         r5ERF+y9G0f7e29ngBKpsdGaW/SfD4X9jbtJd0m6tmHZRKXMNmu7B8wIJJXmXDu8RPPU
         gCg9bthlnComUlYp7C9dhTi9sOaS3BzIV/N+9fRKuc69ITA+U2fcpTXrGuuCObpMI+wy
         PvsHxkoT8zxtKzaU+vlSniHr/MRbdP0pTDTtcHOquRYWiWFV+hFLIjMGoWMILSoqyyxl
         Fh+w==
X-Gm-Message-State: ANoB5pn/UuWSyh05AYGOozj7nweZ9Y7MSOeb7LpT2AJQCUv/Cibpc+J0
        93xcchU6tdehw0swQ2Y2H7AJQqeK6bvzJx6LAPk=
X-Google-Smtp-Source: AA0mqf6zz5XDnZq48XQwU6PDuNhHlhL7WeTzeOYq1Pu+OEmm+NnOeqZQtzPv0Zh80A+V8UtIXzZXX/fUSdPaRTlwJ3Y=
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id
 g11-20020a170902868b00b001868c19d472mr56484887plo.12.1670044979911; Fri, 02
 Dec 2022 21:22:59 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
 <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <patch-v5-09.15-df5aea35bbd-20221202T110947Z-avarab@gmail.com>
In-Reply-To: <patch-v5-09.15-df5aea35bbd-20221202T110947Z-avarab@gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Sat, 3 Dec 2022 00:22:48 -0500
Message-ID: <CAPig+cTYjzEvMqMMBnaVBaZzfctxiWQXJE+CqV6kJyXbyijgdQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] test-lib.sh: support a "GIT_TEST_BUILD_DIR"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Compliment the existing GIT_TEST_INSTALLED variable added in [1] with
> one that allows for testing a git built in a directory that's not
> "../".

s/Compliment/Complement/

> Instead of "test this installed git" ("GIT_TEST_INSTALLED"), this new
> "GIT_TEST_BUILD_DIR" is a "test this built directory over
> there". E.g. this will pass all tests:
>
>         git clone --depth=3D1 https://github.com/git/git.git git1
>         cp -R git1 git2
>         make -C git1
>         [apply this change to git2]
>         (cd git2 && GIT_TEST_BUILD_DIR=3D"$PWD/../git1" make -C t prove)
>
> This facility and file-based instructions to have the test suite use
> another build directory[2] are mutually exclusive. In a subsequent
> commit we'll make CMake and CTest optionally prefer this method.
>
> 1. 6720721e152 (test-lib.sh: Allow running the test suite against
>    installed git, 2009-03-16)
> 2. 350a005e366 (cmake: avoid editing t/test-lib.sh, 2022-10-18)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
