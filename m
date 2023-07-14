Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE3DEB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 14:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjGNOyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjGNOyP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 10:54:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1425830E2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 07:54:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99364ae9596so266695766b.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689346439; x=1691938439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpitlytWe5p51rsU7uIpRoIgFzEQ5KbAhtHfNa9JNUA=;
        b=Nj5mTW6REbejT9SuE3a911tdFNtr5nAo3V1ol/D1TEvgzklvXIloUGWa873NH350a6
         gtiQ+DS0uFRdYrxznV2NCAzjtb9lf01qiUDPRtJ58mG2kqDTHdeViKhH0+66NU9jvsyi
         aSbUleMGAyD4E0H3n1Ls1Ko1fkbCI0sHPWA1Sb0v1EtmuNbPcvhgQZRh1bimXTabs2op
         lbZYfRSFoTm/mWLeRdRRQNdsAo9/ItF4Vx+uwS9HVCq11M56PCUopLNCgLVmyFytw4D/
         NhblDoSEKBltS+wYoWeOgQYizB3mEsULwZgdYsKVup3SNa/F+ze1W69eg3dzvS78jHIm
         SPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689346439; x=1691938439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpitlytWe5p51rsU7uIpRoIgFzEQ5KbAhtHfNa9JNUA=;
        b=GOq00JwW3ufNtgo2J9zxhoIdhQP2FUcsoSuY/Z6n+IpICSUNnULONNVXa9LeiJqkIJ
         arr+ah9vayw/CSTfbAwLgFnotUyppxfguCZnbVjta6grKP5o91DrSJ9fKEJGb3hTh3JP
         5o6hzfVGcpZqfxOfPS0XzJVaaDSuA5n8WotvJYeC+5DBGlNBv2TTxZvcWxhMCt8uquu7
         1Za8ZzQJqvUeJpmGC8vJElI2Sv1aRcE2YNJ+f3D6otXC7Y21tZ2ywtsh502uURdwoO2I
         u4XZ/5ey5MZoYaPLhPLw0VlvytyvaHPfhly4636Ja52fum3etfw0vA8yjzVNaLb81p08
         SF+g==
X-Gm-Message-State: ABy/qLYaOocy1q7mlEzzXEHkqzaqRrJTHXFhnjF+gYETXeu/bD0HQzqB
        +LPIMO+t63kuwDn/AfjxlUgiNDUwnKOM9lt9xDs=
X-Google-Smtp-Source: APBJJlG9IZx9ojAeZwqlgRP3zi9oVLNqbdg/Qkw6egAmqaRNbJug68DCAf1nGS3w8G/p/Ly2uh34h3+Q35QRHfxDlG0=
X-Received: by 2002:a17:906:7496:b0:993:da40:fbff with SMTP id
 e22-20020a170906749600b00993da40fbffmr4642546ejl.0.1689346439412; Fri, 14 Jul
 2023 07:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com> <279beaea-d332-0d88-3cd0-b935ef6bc5eb@web.de>
In-Reply-To: <279beaea-d332-0d88-3cd0-b935ef6bc5eb@web.de>
From:   "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date:   Fri, 14 Jul 2023 10:53:48 -0400
Message-ID: <CALnO6CCOWvYLkGRJOSV5saK3g3s0+RD-aEopF6gcX3qfmU5=UQ@mail.gmail.com>
Subject: Re: [PATCH] t4002: fix "diff can read from stdin" syntax
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2023 at 10:44=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>
> Good find!  Introduced by 9cfcbcc095 (t4002-diff-basic: modernize test
> format, 2023-05-18).  Perhaps an automatic formatter would have avoided
> it?  E.g. some sed(1) scripting, or shfmt (https://github.com/mvdan/sh)?
> (Just discovered shfmt, never used it.)

I'm doubtful: it would have to know things about the test_* commands.
(I would expect context-blind formatters to leave it alone, as it is a
perfectly correct way to spell a command with spaces in the name,
though who would do such a thing, I don't know.)
