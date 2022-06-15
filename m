Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E7C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 19:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349041AbiFOTRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiFOTRY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 15:17:24 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA329344
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:17:23 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t11-20020a17090a2f8b00b001ea6a226d21so1454282pjd.8
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=zx63VrCsxKXAjQ0bdfzzwHS1qCdw8T4KYNcb4/Yfx5c=;
        b=RZMl4kKoK8X2bSTgDtO0cVyvf4ZCoWjue1Z3u37bsEHjwQM6n05Fp5cITGkE5CgPgh
         Zaq9nXOv/GtLIVHlFgckCpMXHzIZHOjijbNqVYt3ruZS4rcFqlr3To6ILPemx4bTlrP0
         qXfNdW8WPspgQdgnyNowlFOEMgrDtpuk/AF1V5uA2BFo0G7hsCCgy/UGF063I6zT2jsK
         W3IcH7hNUYuq8yrZ6vfrvyQxwulb/UPiTCLduZPkEzU9gFu4AIFT3obHO/JNZbkITEa4
         DepRk10loybATfc7DqChAtAagdzlwIhWe1AIbz0WHE1wjaQnrR0dOspvbVIknEiEg4i8
         mdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=zx63VrCsxKXAjQ0bdfzzwHS1qCdw8T4KYNcb4/Yfx5c=;
        b=7pmpJ6Bz4yO/jdlk3WAEPny3gH+n7DZNc/0b+hi1GHT5YAv9n8UzoGfFrn+4zhq3HO
         /Whu749yU7OkbgJPZ4W0se4XCokUgbZ3JfLMu3oW67o3sPofKnR/RWiVQMX7CMd6Trpc
         jjgjV1QPztPElNHmYzM2APunhyiR9s9ThHqyJn3aM7qEnp7cuEDgtyXXAFgAIU1gPXLr
         M9b+HKjlezWe5PkKSkrnKpbUVKY2AV0j8o0fmInOygsRTy7hBh5Glckd9Lf0j4skp39W
         w8Vdaw9dgCIHmtZKf+ME4QSNY23J/xJUfqy+m130vnPdLMhGAgiHsEw4hbJ+syB4t62S
         2CGA==
X-Gm-Message-State: AJIora/39BGKWzYV/vany8Bw2WZ9AYGxDK9sRBV07EMkGN0n8eP33bTa
        6nD7fGnIeDcOUaK6a3p9w+c0YOvBqApkHg==
X-Google-Smtp-Source: AGRyM1sQ8HSEwTovQGEW2BuM4B0tUJe3uhjGetIPjP2/rld0ctP2uUInfEz3JYBuK2ekasxghiM+01fNuqHg3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1da5:b0:522:cb12:549b with SMTP
 id z37-20020a056a001da500b00522cb12549bmr928667pfw.81.1655320643038; Wed, 15
 Jun 2022 12:17:23 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:17:21 -0700
In-Reply-To: <xmqq35g82f0y.fsf@gitster.g>
Message-Id: <kl6lv8t14tz2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq35g82f0y.fsf@gitster.g>
Subject: gc/submodule-update (was Re: What's cooking in git.git (Jun 2022,
 #04; Mon, 13))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/submodule-update (2022-06-10) 8 commits
>  - submodule update: remove never-used expansion
>  - submodule update: stop parsing options in .sh
>  - submodule update: remove -v, pass --quiet
>  - submodule--helper update: use one param per type
>  - submodule update: pass --require-init and --init
>  - submodule update: pass options with stuck forms
>  - submodule update: pass options containing "[no-]"
>  - submodule update: remove intermediate parsing
>
>  More work on "git submodule update".
>
>  Needs review.
>  source: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>

=C3=86var sent out a non-RFC series [1] that should supersede
gc/submodule-update :)

[1] https://lore.kernel.org/git/cover-v2-00.12-00000000000-20220613T220150Z=
-avarab@gmail.com
