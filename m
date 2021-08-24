Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B5C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9226101C
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhHXHb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhHXHbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 03:31:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE7C061575
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:31:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y11so17565182pfl.13
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endorphin.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GtFXj1kXGoQgS90pPWw2jrss4Ni5ThkshnKRzE2Lpes=;
        b=V7XMmTujaebJJcON2nzQeldeu9bqNdtJ8OnTGKbKZGZ38vY93iHjomOB5V9oQ9sE0g
         FbhRbDmRMFVEzZChmLpOj8t4Jp2HMTROtSL4mWzluJUXrfhoGPPb3+7mpSWa9kZKilm3
         cP/nG77mvqcrhe8C9WYg+d3PsrIsHSKuIGeGRnCmtaAjRUL24eK6ugwhr6/HtGq8DJUd
         thkfQkX/VYPHMLhFBYD7G2MUMuC3DAma53eHg0GFpUetVNt/5tICvjrHRYveqKMBA+hT
         fHpA3i4drFfTfXQ27ZGpB4Vm0lQk0o/ZeXQbEui3f3+sMHOCdQ3W+nafiq5j/m19WarX
         2t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GtFXj1kXGoQgS90pPWw2jrss4Ni5ThkshnKRzE2Lpes=;
        b=cnr/ZMKAVX4Ip3sesWjUq8u2R9/ScO91kCCmOqQOYXB+Xg33uHs0d/TtnhrvFEZvAU
         KAR/j6OYe5jalOUbze5tr6BKV6zYRbneja6HTV0u5K4tgxYWLlX6nOZ27OvpNmzyeXVq
         w674MGpwkY6M/6pdWhtycUXP3IUhj8lAhaQRg9itRX013eHRUwVu+5Sr1m1NtAH8hi8j
         hyAav3qp/9DRbxT03VcNVb5qQEeO/3AxoqsFv0q1sTs+U+kfkvD8+Wag5RTv+5BPIOJW
         pO3dd2qhln6DVAhDeCrNxSwtKhqwCSfNYkFlSgEQd7mlamYQAEKzA7M/QGjNo4KX2wrV
         h00g==
X-Gm-Message-State: AOAM533vw4rkdWJDZZXoj3A5UnXClR69LCM8x7QiRisZxKLL9dfvBQQK
        ZN97FnmKmz51r+9yFRcqWoa/QfO+19IVNEGdL3JV/g==
X-Google-Smtp-Source: ABdhPJycQkQ5HiqORkOFqzSwZ2rToryfw44kEqNdIkPdUzZXWqgu/KgfgxTGXyebXeWGZdM2IH4Xnw7iRhB7w9bQI/s=
X-Received: by 2002:a05:6a00:16d5:b0:3e0:f6ce:f2f7 with SMTP id
 l21-20020a056a0016d500b003e0f6cef2f7mr37058373pfc.78.1629790270601; Tue, 24
 Aug 2021 00:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com> <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
From:   Clemens Fruhwirth <clemens@endorphin.org>
Date:   Tue, 24 Aug 2021 09:30:59 +0200
Message-ID: <CAG6gW_s6FHG6muJ6Hai-Sb2ntmygLymQZr8YrN212_SV1VhBAw@mail.gmail.com>
Subject: Re: [PATCH v2] pull, fetch: fix segfault in --set-upstream option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?SmFuIFBva29ybsO9?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Aug 2021 at 14:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
> A proposed replacement of cf/fetch-set-upstream-while-detached which
> as noted in What's Cooking has been languishing for a while. I changed
> the die() in my version to a warning() as suggested by Junio & updated
> the test and commit message accordingly.

Thank you =C3=86var, for taking care of that and adding tests and my
apologizes for not responding in a timely manner.

>  builtin/fetch.c         | 11 +++++++++++
>  t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 25740c13df1..ca487edd805 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1623,6 +1623,17 @@ static int do_fetch(struct transport *transport,
>                         }
>                 }
>                 if (source_ref) {
> +                       if (!branch) {
> +                               const char *shortname =3D NULL;
> +                               if (!skip_prefix(source_ref->name,
> +                                                "refs/heads/", &shortnam=
e))
> +                                       shortname =3D source_ref->name;

Is skip_prefix ever able to fail?

- If yes, then shortname will be left pointing to NULL when we print
the warning below. Warning probably won't die because of NULL, but it
still will print something weird.
- If no, then an assert(!skip_prefix(source_ref->name, "refs/heads/",
&shortname)) might be more idiomatic.

> diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
> index b1d614ce18c..7d12ceff702 100755
> --- a/t/t5553-set-upstream.sh
> +++ b/t/t5553-set-upstream.sh

Thank for you adding tests. LGTM.

Regards,
--=20
Fruhwirth Clemens http://clemens.endorphin.org
