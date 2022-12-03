Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B76C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 16:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLCQ7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 11:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLCQ7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 11:59:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4F20BEB
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 08:59:04 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q71so6875166pgq.8
        for <git@vger.kernel.org>; Sat, 03 Dec 2022 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6Vh+rTbHL8ux56d9rSyftsctBPCAARAl80aUVKH2VQ=;
        b=DrC94e7Q0oWMb635JYMS+2SRyRzrFvgoq9GWWv0kippZG17An5xbA9YgUGzkrgFdWk
         VGJxXAmNdeHURtIC2/re45MQa8CPkxUdKx0PwET4US17csryZctgoovItHJ2EbBpQKcE
         CzFQGcdpS7bgaRYQ8ocojVaDx5f6xyvME7lAYZTOr8lq4v1z0ZoXhQrb9eP6eT8JyO35
         IxjiYjm8AX27koRdm3LnyiNKN0Kz1ouptvWSyqLcp5cJkm6i7PtSU6zkQboWoEJUcRQs
         PN36ZckkUwoYDQQkVMw2aSRj+KpCYjRKoz+lh7Qo9w5ZRukTQbeBRAobE9tsKT6IUP3m
         fZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6Vh+rTbHL8ux56d9rSyftsctBPCAARAl80aUVKH2VQ=;
        b=730O2POU/PGtPaafR9kZqOKYG35jAsvWydXo8PxHI1pqeZHUBhUe8fGtSv3OyW65rH
         Z85cjpIzTkIEw1xy/Ii9oZayfvgEUCHR8aUId16PAxtsWUTS6f+x14rDZ2OuAC9fsi69
         Ym23BAzsUFEmntzXos60rxLMjimH69X3dGeGPxupN4HanFSlzs41Ex+at2OEkaF3Z1I5
         DZxsYAZzCwvfU7XQ1/F22J96LbVGKyhMl6q4cY4BlTDHHfjt32Mo5RcErnHTSSt2/eRm
         RsUrQ8AjXn8me70lgls8GNZGWelY7Z3+5zu+ETs4HyWF8xsPIpGv+Wup69g2HhiSUXF8
         WX9g==
X-Gm-Message-State: ANoB5plPUUw53YNEjtHKSmf8rsiA8N0o7RzlUMSscKWLqpByseOWrvKO
        n4aS3UA3livTEWEId+I3Om8UCBjgq3pYLDLaNmM=
X-Google-Smtp-Source: AA0mqf5G4ys2zbOXGIWfxsBcRn1vc8+l0EifBB3yMfAXcycfXB7FNsXfKANDifPLAZ8Gd4X3f9IHyWEMqfmE5kC/fh0=
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id
 x41-20020a056a0018a900b005726da6218emr58088303pfh.1.1670086743573; Sat, 03
 Dec 2022 08:59:03 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
 <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
 <patch-v5-11.15-a5dd4fa1d00-20221202T110947Z-avarab@gmail.com>
 <CAPig+cTQu6E4-sLac_WEMJ6NMWCVDenOj1iNdfPib_WociXhXQ@mail.gmail.com> <221203.86h6yceioj.gmgdl@evledraar.gmail.com>
In-Reply-To: <221203.86h6yceioj.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Sat, 3 Dec 2022 11:58:51 -0500
Message-ID: <CAPig+cQjEyr1yvufqX8gf-YS8RgEzZQbpQvSn9GuNDWAt8Z8Sw@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] cmake: support GIT_TEST_OPTS, abstract away
 WIN32 defaults
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

On Sat, Dec 3, 2022 at 8:11 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> On Sat, Dec 03 2022, Eric Sunshine wrote:
> > On Fri, Dec 2, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >> +       message(STATUS "Using Windowns-specific default test options: =
${GIT_TEST_OPTS}")
> >
> > s/Windowns/Windows/
>
> Thanks, the rest of this is just typos, but maybe this one's a Freudian s=
lip :)

I had the same thought and nearly said so.
