Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F672C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiA0Vz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiA0Vz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:55:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E42C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:55:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i25-20020a635859000000b003486e456e52so2179182pgm.8
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=zWQyU4rCQLu35Ss6taV2YqbIqfXXnz/VSNuStOyqV9c=;
        b=cscM7IOQQbqLVesFC6i0GJgalme1ZUkFQX6P4a/RGNaODZxQm4MzX04d+32jy39uGY
         SobQJE9vDhieOitRVxevoI46AO99fWWlsQpNJq5gXG2Wz+YgUD7yGz47BiisZv3NSOVt
         nbwNfkEFDvtgpQTKF3vsfgV4HAmX4wd24meEpE9Ohay+P+M9sjJFloQCG/699ycZcWi5
         Qw0Zd4rsl0da4P6iQAJJLXPY8TqIuKhqA4Th7Tqa0NOCLiOiLI7XTNWJDwSUu597ak53
         rygy4WDz0es36sDKRhJgWvp0OfTQhl1n+vGldXCrsFdeRbq4anNN/8uyeqmjPPUPGuO3
         VQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=zWQyU4rCQLu35Ss6taV2YqbIqfXXnz/VSNuStOyqV9c=;
        b=UACbx7ADsY6jBAe4tVWgaTKFXbTxAIWVhRo8bAF3ibgHH3EnynDyOHauDc6tV1dXyu
         nW60X0fOb/U6+1q6+5d+0JoaMQLjwpE+en+34nBVRHVNSohCfuVUlFtrfS8PyWbp7BxT
         EYzFjJv4aehkixUOCfADgxcHTIZbc1Eu7WSQ+JFjVRU+G7fthYHh+Q15fZn7n6jIjzxT
         u4Ti6Z3h2anBXHyL6k47zvGyd6AFbEcqlTiDWuvOEDwkAyIhie7y7a/zCcTZbIogvINX
         ddfRl4dIoliXSZfkBvm6j5YpwMWNbRH3MaIYLRSWZvtZSb+vhXD8DASM21JJXFkPj7OA
         U9BA==
X-Gm-Message-State: AOAM533kGceh9sjUdF0vwkhgUtgDKVoPf8Qjlz3qfVZdfYwFmoZM+6+u
        0VsiAraPNlDuY8lFMsy/Pl2YfokunOPQ5g==
X-Google-Smtp-Source: ABdhPJx4VUkWpLeCBL+jVXPcjokleRQoHiZQEJz1uvKAgnVRIA1/7ElDpZgjaKl0CwasPLVRxbL72jbECs6iFQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4d82:: with SMTP id
 oj2mr1806246pjb.1.1643320555702; Thu, 27 Jan 2022 13:55:55 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:55:54 -0800
In-Reply-To: <patch-v4-7.7-02954603763-20220127T143552Z-avarab@gmail.com>
Message-Id: <kl6lo83wzvv9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
 <patch-v4-7.7-02954603763-20220127T143552Z-avarab@gmail.com>
Subject: Re: [PATCH v4 7/7] submodule: move core cmd_update() logic to C
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> From: Atharva Raykar <raykar.ath@gmail.com>
>
> This patch completes the conversion past the flag parsing of
> `submodule update` by introducing a helper subcommand called
> `submodule--helper update`. The behaviour of `submodule update` should
> remain the same after this patch.
>
> We add more fields to the `struct update_data` that are required by
> `struct submodule_update_clone` to be able to perform a clone, when that
> is needed to be done.
>
> Recursing on a submodule is done by calling a subprocess that launches
> `submodule--helper update`, with a modified `--recursive-prefix` and
> `--prefix` parameter.
>
> We also introduce `update_submodules2()` and `update_submodule2()`
> which will supersede `update_submodules()` and `update_submodule()`.
>
> When the `--init` flag is passed to the subcommand, we do not spawn a
> new subprocess and call `submodule--helper init` on the submodule paths,
> because the Git machinery is not able to pick up the configuration
> changes introduced by that init call[1]. So we instead run the
> `init_submodule_cb()` callback over each submodule in the same process.
>
> While we are at it, we also remove the fetch_in_submodule() shell
> function since it is no longer used anywhere.
>
> [1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VH=
PGREmDVObA@mail.gmail.com/
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---

I've read through all of the patches besides this one - I hope to get
through this one soon.

The diff is quite large, but I can't think of any way to shrink it down
at the moment.
