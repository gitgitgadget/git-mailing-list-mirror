Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC59C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391737AbiDUTIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388267AbiDUTIX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:08:23 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE96457A0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:05:32 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id c4so2754175vkq.9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AB/EIg3dExfCZxMtSaGBl0GxGmyS/vPvCPJEJde7P3k=;
        b=kdIjtjyWm8G2myDdjoaHB4yEIxXRnlzDHNj7mjfwlnbOalAkjNogAOaW2XyuSpAquh
         qbASxbhHl+C3oCczsxGuddbSf2I/WgZyeLlMd17yQVSm6dx86bQ7Cu0vxy1s6d5NZ0Gw
         l6MfIBCFy1UAEYVpfo0jmCOJV70AZv9zbSl7MwHXwMIR8TGg1FECl3sLxwNaEKDVqDGH
         9FVkeHX4K+r0LnLrM8dchUw2ZFOYNck3OuUOaw0dNmKAWsGYWfxckRQcmBHtelPxwj+o
         jPUmRwaF479802Oc+6it/vroYtSphUpdqJ5HpLUULGgQ9Vuxw0zKF8KeB/LJEKEdzrdy
         +WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AB/EIg3dExfCZxMtSaGBl0GxGmyS/vPvCPJEJde7P3k=;
        b=tz0Wq3wzkhnBrbsRfPrzTkm0YkvpnAUht/EIj2QNnR+ZwnnHz6a27cpFN5G2AC3KDN
         1pqc5Mw7dueC2qMW6k0iDPaCETUfOaJ4T9+WSwvTJD2T0gfj6kQU7iWZfpdVeNGWH/vF
         UZ2B6pzjvbgb8cNbIn0yJYK/lsq1k33eYe97GccroYdOgqwJnGIYzvSOkLtZ8Mm6mchT
         wf75l2eNnV7pWtQgoMs7/EHW6IgzfJYnKsMkvQ/mQEnVqxvIQKsyQ51gMSv9ryrPTE0u
         oLDZdK1blyh5DXXDxf4nO6yX7sybRF5k7lvdof3VOdt0qBcYFGoVBn8ANgwWtpVzZ2g/
         jYsw==
X-Gm-Message-State: AOAM530QylBO4NWs8TgiQTA0MuJ6SW+GAXM2//bZ+qKaGOFENkMdNGHV
        uVJ9TK+opC7be0SRhmHwrc5vylpzepwRxfJasro=
X-Google-Smtp-Source: ABdhPJz+Mz6TdCaA0t4A40hQ5oqd8ZgHGurfsS8VOKCSHTRfWzRHlEF41w9RHtaQt4oeqxph2XlXAUsgiEPLjGCKsDc=
X-Received: by 2002:a05:6122:118f:b0:348:f961:5814 with SMTP id
 x15-20020a056122118f00b00348f9615814mr470877vkn.14.1650567931547; Thu, 21 Apr
 2022 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com> <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 21 Apr 2022 12:05:20 -0700
Message-ID: <CAPUEspggNfra_C8PBcVqjZrxxnswg27WFLg2kT6JOCMB8f0FGg@mail.gmail.com>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 10:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Reported-by: Carlo Arenas <carenas@gmail.com>

to avoid confusing the attribution scripts better use my full name:
"Carlo Marcelo Arenas Bel=C3=B3n"

> diff --git a/ci/lib.sh b/ci/lib.sh
> index cbc2f8f1caa..86e37da9bc5 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -122,7 +122,7 @@ then
>         test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
>         CI_REPO_SLUG=3D"$GITHUB_REPOSITORY"
>         CI_JOB_ID=3D"$GITHUB_RUN_ID"
> -       CC=3D"${CC:-gcc}"
> +       CC=3D"${CC_PACKAGE:-${CC:-gcc}}"

minor nitpick, but most likely still relevant considering your other
"bashism" fixes.
the POSIX syntax doesn't use ":" (documented in CodingGuidelines)

not sure if the compounded assignment is valid in POSIX, but at least
the following worked with a recent NetBSD 8 sh :

  CC=3D"${CC_PACKAGE-${CC-gcc}}"

Carlo
