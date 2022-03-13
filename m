Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24840C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 02:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiCMCis (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 21:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiCMCir (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 21:38:47 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D0369FE
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 18:37:40 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id j201so6647423vke.11
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrHsj4jzcxSGBh/pvvhK1q9rZ6z7ROx3pv8vfvPXdDc=;
        b=NA85qmKuTOoL0bmfnu1uWjSwYLwiCpA1SkoqZXBKUWydFjsLpPTdpdBSYZVDC9ZA3K
         USg1vOJz/s32m4/y3EwBREBEzX1ipCbb4k6fn6PCDPgg7PML1H/kekkuDzMsBB52OFMW
         rrnq4AIOBS/9idEtfdburtXWivuu9EAm/4i6jWp7+2Ivio1hAwKSJ1/WzuWEoKmE+a9u
         1303u4iOjyGmO6W+X0ZsqC8dfiDrxWHIuI/JUF3rf8WgtNSXGtf5Yftq86HMdDtRncwy
         en9IyaqvOC7Yy+DwFrz8tP7gZwFT8aa1RyrX4LIdLf67GpMnY/iOC6lN7Dg4/j3PD7+l
         JzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrHsj4jzcxSGBh/pvvhK1q9rZ6z7ROx3pv8vfvPXdDc=;
        b=atLcAHwErCTf0tVeuAE+yoy1Zc8NUEA+h1bBiFWvup3JCqSzsW7SmiI3NJGhvC64G7
         k/i49V7GAExTlKjPs0VisPShZR7mGGmQQk2ttDDclPOpl0UfTb7W5Y/d5IPYyD9nuh1i
         S6miFb59N4c0Xr8/fWW7A1DJVwzeB2mVbKNEk7Q/c1N4uL1RhkpGMQv7m3Mdkw9lAprC
         ApTn53f/1imSLdOsv0uNiO80JsgyL6EyK0RmM47sOgMY3R8RdIOWggQtXUGSYaCAZ6+X
         VpKE4+SuYBM4fBErbAUdDzF2zUH8ebZXg2xtfwJGU4bUBfJ5xCeCjD10Bb6fYTPRHXyH
         9WuQ==
X-Gm-Message-State: AOAM531YPbmc5jMdtW05mRmV/AHWHc5VYNCM7JaxxxjrNPuIwZxTZoHL
        NZpfscz3vpoTcJJlMbgZC5PXz9UtxJjnyaqHNCI=
X-Google-Smtp-Source: ABdhPJw3+1088hHILrCBtM0Eb0NbS2QiGbGfuvWg/E9XXUHFKee0uBhx3liGW/Ig3NisWbHz+OTtRC51eRATF2cDiw0=
X-Received: by 2002:a05:6122:c88:b0:337:a516:6621 with SMTP id
 ba8-20020a0561220c8800b00337a5166621mr7701843vkb.39.1647139058601; Sat, 12
 Mar 2022 18:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com> <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
 <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
 <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
 <xmqqv8wnm30q.fsf@gitster.g> <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
 <CAPig+cQNeTAvWHm2GUGc2i=FKF2V6Gqkmmsw4kDOTzrSYEbgxA@mail.gmail.com>
 <220312.86o82bfo7x.gmgdl@evledraar.gmail.com> <xmqqtuc2lhis.fsf@gitster.g>
In-Reply-To: <xmqqtuc2lhis.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 12 Mar 2022 18:37:27 -0800
Message-ID: <CAPUEspgdmaztSShPd6vJpT7801_czRuBt_QaPu_W2JGOw+UqrQ@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 12, 2022 at 6:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > But probably better is to just amend that to call it as "test-tool libc
> > is-glibc-2.34-or-newer" or whatever. Then just do:
> >
> >       if (__GLIBC__ > 2 || (__GLIBC__ =3D=3D 2 && 34 >=3D __GLIBC_MINOR=
__))
> >               return 0;
> >       return 1;
>
> Yuck.  Then we'd have yet another libc-is-glibc-2.36-or-newer
> option, too, in the future?

Luckily that won't be needed, as this the original version (with expr)
is practically good enough even if it might be a little odd looking
and incorrect for 2.4 <=3D glibc <=3D 2.9 (which are over 10 years old).

  $ expr 2.34 \<=3D "2.34.9000"
  1
  $ expr 2.34 \<=3D ""
  0

Apologies for the confusion, and feel free to drop this patch

Carlo
