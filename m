Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B662BC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C4165001
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhCPJNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhCPJMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 05:12:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0CC061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:11:56 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so6479759otm.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GAyWAXLO2REjdLuO5ewBnkNHMkWgPMIqmlURNMNDqp8=;
        b=RA5XJ+ectFPZHqboN7MujhSJToDX7TlulLyxvLQF1vdjHaiaN804lSHkTJuw1crWvI
         tJiqpJ11QPDuLBHc1EZ7pbSzE8hcXPL+ZrVSej1t8kWI8ssl/v+k7nGm2MS3ph+eH03A
         u4eQwsXuH11dRq+6GZUXaIth4ayh8JaXbdKi6bQ4MfDhZMLLFcPXW/Ys9YYQtph1foHe
         9S3PJxRFcsy1sHJ5g6Amhw5+07AjgnaRIoNdcYSQMvpeFJwnYup/3WwPQyueVAzg74uq
         upsfdyk5OvuGlFHDq3MBiGqfbFcj9gfcucK7MJJTnIy0nRfhCPAgkdJHZZ9JcKc2gVYY
         ZEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GAyWAXLO2REjdLuO5ewBnkNHMkWgPMIqmlURNMNDqp8=;
        b=FxSIDO89bvvvfFb2ZlnTfXzG7g7z6pRqmXERtx5UM6cjQWvWOREo2K9YTbKB59Xv1r
         NkAGFILOrf9TnvdiJkw4qFr6GTSZkfZw22glB1x0GZZVdMK3aX7V/W8/s/p7etJVEKzn
         hwUDSSkuZB2r/zv9aPzbY0TYUU6fU7XYwyD0O102ms//9xMC7Mo5Y+C4x3FNQFuDUew8
         kx3G3Xn3cF5dRK+pwCKfOOxqwW6ljV6AmmtYtIpV6jEFgFCv9NfvO0wl2dUK36Rq1Wic
         w5Ye1xln5TI6QC5HyCblqSkSPOQce0ZtacgfI2FxOFem3GxseyCGNM/Ar3tPW1HOZ+aZ
         Pvjg==
X-Gm-Message-State: AOAM531j0vEbXu4u351g18n5/vrXeL5DsaSBV3va/exaJjCLt8HXbcJv
        ZVekLXziq1oQCBZLEZgw8OoI4hG4kPJZcgjYFJY=
X-Google-Smtp-Source: ABdhPJy4oNGP79OxwVQB48Fm5lhTZXnwzHkpkBE+qpL/wMV0CzdLP35kccJQPuyoxYRw8cgzBmr1SmwES9Gs2ZOLuRM=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr2873878ota.164.1615885916364;
 Tue, 16 Mar 2021 02:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
 <pull.901.v8.git.1615813658.gitgitgadget@gmail.com> <68e0bd9e2d6f0a89d60db730eb77507d6a17a5ae.1615813658.git.gitgitgadget@gmail.com>
 <CAP8UFD0tgXi6Hq42dzsAAGMOhvLxqaUuBqex0CreyRb_XD5rxQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0tgXi6Hq42dzsAAGMOhvLxqaUuBqex0CreyRb_XD5rxQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 16 Mar 2021 17:11:45 +0800
Message-ID: <CAOLTT8Ti0+QJTUahUxOJ8fmq5aNTVnaSm1GyXaOJAAk3fD=49Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] interpret_trailers: for three options parse add warning
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8816=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:53=E5=86=99=E9=81=93=
=EF=BC=9A
> I am not against this, but I just want to say that when I previously
> worked on `interpret-trailers` I think I implemented or suggested such
> warnings, but they were rejected.
>
> I think the reason they were rejected was to improve compatibility
> with future versions of Git where more options would be implemented.
>
> For example if in a few years someone implements `--where=3Dmiddle` and
> some people use it in a script like this:
>
> git interpret-trailers --where=3Dmiddle --trailer foo=3Dbar
>
> Then when such a script would be used with a recent version of Git it
> would work well, while if it would be used with an old version of Git
> it would emit warnings. And these warnings might actually be more
> annoying than the fact that the trailer is not put in the middle.
>

Well, this is indeed a situation I did not foresee. As a user, I don't see =
an
error | warning reminder which may make me a little confused.

At the same time, some sub-command like `git cat-file`, If user give a wron=
g
format:

$  git cat-file  --batch-check=3D"%(deltabases)"

git will tell us, "fatal: unknown format element: deltabases".
It's easy for user to check.

> I might be wrong and there might have been other reasons though. Also
> things might have changed since that time, as not many options if any
> have been added since then.

Thanks for your patiently explanation.
If these warnings are really unnecessary, I will drop this patch.
