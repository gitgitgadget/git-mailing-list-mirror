Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768E4C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiKNXjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKNXjY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:39:24 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A0101F1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:39:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e12-20020a62aa0c000000b0056c12c0aadeso6857534pff.21
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSwdia4Ksf15ceVewCKK5/fh1o2zFzkDvF+0Udocg2E=;
        b=EwWa8cog57YGBBdhzTu50sqV4EZZZTttr6v1QZqHLNARhXamG6zeYT39JBW53itEEK
         lNmanDIEX0C+fylWlszcGlXhEonfR/5dL3EukPTRuCIZs4U28rICoy7B6ED7tbUPXNer
         E+c8Gv3rWtsHI79lCqXRTIyWSiASgtv1kV5elNv2z0/Jc5rClWrq4Ptd8f9GHuqDZuDk
         8nsg3X5cygp5lgYYF/maBr6fiSraTex7nkhisg10GMags7FtIaF1SKGJfcuWwnOpADDI
         3/POFFHCaVplum6w2PuZnkxKrd/lvbIHTFn41u0BKePPe3VxEyF7WVEWs53+OrniP3Zg
         56fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dSwdia4Ksf15ceVewCKK5/fh1o2zFzkDvF+0Udocg2E=;
        b=UOtrESwCxA02cQlZof7pO5za/fmSpu5Hcsx35NDAaK+q/RCvHeiegdwmYO/FT+1KCD
         wyRDxJ0O5TJDyiG2iFPVH4AGTwbWJVjx9XN/evPYI2qN1wKMGq7GZyaxhro6wycPNJ1R
         9ug+L5tcQNXPin+X1N7IUO7YCmQU7vEF2WBedB9Ob6WYLHbMUyBTgmC8id/BDuuMeDas
         zXfsKouP8TB3N3JyK4IP7zEj9vxaT3bwx8DsgZEPG1ko9drtG6tHx25+qNNA7T6bRSzp
         wPS9klOA70CJ96mycq+xHEUh6iE0vas3Hx/XbF/w6bu7pdDrK4VW9oTOfWMgK0gqPGO8
         vr6Q==
X-Gm-Message-State: ANoB5pnfqF8jeCEIXXnj4LlMLalg0uw7K1rOx+IwJ1lTiDh7anRXwSEQ
        sk8Gl0rjVNApXUgKfNlUaIdg5Lt8EpIYiw==
X-Google-Smtp-Source: AA0mqf6ML3KdlczirJOLM4GE1W9fl56AGIVcIa2/la5A5u8JukJ40Pt1f6S9PG/cvVU4IWEFGlJ0h9knmddHyg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:d34e:b0:20b:1f6:3fe0 with SMTP id
 i14-20020a17090ad34e00b0020b01f63fe0mr15930227pjx.125.1668469163503; Mon, 14
 Nov 2022 15:39:23 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:39:22 -0800
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6lk03xnm1h.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/10] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Cc:     Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It's also proposing to replace Glen's one-patch[6], which is working
> around the problem shown in the test added in 1/10 here. Per
> downthread of [7] I think Glen was aiming for getting a more narrow
> fix in case we split off 9/10 here into some later fix.
>
> As we're fixing an edge case in something that's always been broken
> (and thus wouldn't backport) I think it's better to just fix the
> problem directly, rather than introducing new "--super-prefix" use,
> just to take it away later.

I still prefer that we take the one-patch to unbreak new releases,
because partial clone + submodules is absolutely broken (e.g. it's
already causing quite a lot of headaches at $DAYJOB) and the patch is
obviously harmless.

And more importantly, it lets us take our time with this series and get
it right without time pressure. It's not as pressing as, e.g. a
regression fix, but it does render certain Git setups unusable.

With regards to urgency and when to choose "small and harmless fixes vs
bigger and better fixes", I think Junio has generally made those calls
in the past. @Taylor if you have an opinion, I'd love to hear it.

> 6. https://lore.kernel.org/git/pull.1378.git.git.1668210935360.gitgitgadg=
et@gmail.com/
> 7. https://lore.kernel.org/git/221111.86fsepmbhe.gmgdl@evledraar.gmail.co=
m/
