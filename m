Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF0C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 19:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKCThh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCThe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 15:37:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2E1CFF4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 12:37:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b62so2590413pgc.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/QVcp0xIYb0jZnKMXGLv7ceB3NvYhjP9/olJYyjk8A=;
        b=fxPv70OkYf5A3qeIE25Ss9GolEl/m2eTJKIw3ySCtrUW7AR3HnTvC+TLhMXp7aPI+0
         bXqcUUawLgd8GuTXVXVAgxadA4w6kbN5dU10VtMHLQDXin76+CxN2ox5rTW4t/FopRgV
         m3lljlilAQgcmuo6k0S8tFGH5NpJik5rESSGCPJP4gyXeB5PuwEQz0pRjG0ibbTN53Wn
         eAFXhJIa3qazs/rtrjMH6mMNspIqz+sdbEO53R5zZrsuCd4UWza36uyxeDZ8KI0znhmk
         nXxBbdT362yTbtP5EOYCsSnKjBEHJxxSZS8zgq8jw9UW37N6TJXeo/H216L8ubcvh/51
         GHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/QVcp0xIYb0jZnKMXGLv7ceB3NvYhjP9/olJYyjk8A=;
        b=Tb/bXoc7VNA/Wy/fYdkLhg2skwKzPUjvTSeMKfeSXjyOs/2QhWjJFg9emIUzN6M42E
         PKXd6ZKo1SekxWFijRxEcBML3fDgCathZEv8buCiEZx5oCgg+6D4YXOSwcwVa15bbjfY
         G9lDbwAdDA4jjqevlBXjdrjNl+ZU6B0RnBybtSxF803p9Xy5iu4oUtujcCs5YOqYRPDy
         X3SaoklVZbfs4wC0uEggltQ465dkHmFn9xQ/zkBldjiERA239ydiqUBTmTNeJ7c4HPMM
         UJmzA9SGGK0pDJQCGfOjTqV+EIJVnqiC1QihpGYpwlbR0s0lrD5doH7GVa9pt0/PI3xB
         29ew==
X-Gm-Message-State: ACrzQf0Vis5RC5xSxyK6xRiYjs2KSKxbGUus3EYgmi3irRUTTJDa6xEJ
        JU0rvc7PIL4RNi1Az3ubhcrnlbJ/+7dFzyb6Ljo=
X-Google-Smtp-Source: AMsMyM7eHU2OxlKz3J653oEA4499nQVtH4HQa7zgvgIPE2pC76Q99NfGwClkdHJfjJQn9K+SyhZnp+enk8fkkA+Hj9I=
X-Received: by 2002:a63:2a55:0:b0:46f:8fcd:a853 with SMTP id
 q82-20020a632a55000000b0046f8fcda853mr24340078pgq.145.1667504253835; Thu, 03
 Nov 2022 12:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com> <pull.1372.v2.git.git.1667500788132.gitgitgadget@gmail.com>
In-Reply-To: <pull.1372.v2.git.git.1667500788132.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 3 Nov 2022 20:37:21 +0100
Message-ID: <CAN0heSohT_zDYequyv9-cCALrbpR0yQnSoPA3+YGMhgKxE5K3g@mail.gmail.com>
Subject: Re: [PATCH v2] t7001-mv.sh: modernizing test script using functions
To:     Debra Obondo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Debra Obondo <debraobondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 3 Nov 2022 at 19:39, Debra Obondo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Debra Obondo <debraobondo@gmail.com>
>
> Test script to verify the presence/absence of files, paths, directories,
> symlinks and other features in 'git mv' command are using the command
> format:
>
> 'test (-e|f|d|h|...)'
>
> Replace them with helper functions of format:
>
> 'test_path_is_*'

Ok.

> Changes since v1
>
> Replacing idiomatic helper functions
>
> '! test_path_is_*'
>
> with
>
> 'test_path_is_missing'
>

The above "Changes since v1" and what I've quoted here should probably
be dropped. We prefer our patches to look as if they've appeared out of
the blue in perfect shape. :-)

> This uses values of 'test_path_bar' in place of '! test_path_foo' to
> bring in the helpful factor of indicating the failure of tests after the
> mv command has been used, that is, it echoes if the feature/test_path
> exists.

This paragraph is excellent. It describes why you've done the patch this
way. This looks much better than version 1 of the patch!

> Signed-off-by: Debra Obondo <debraobondo@gmail.com>

After removing the lines about changes since v1, this patch is

Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>

> ---
>     [PATCH v2] [OUTREACHY] t7001-mv.sh : Use test_path_is_* functions in
>     test script
>
>     Changes since v1:
>
>     Replacing idiomatic helper functions
>
>     '! test_path_is_*'
>
>     with
>
>     'test_path_is_missing'

This place after the "---" line is an excellent place for including such
"here's what has changed since v1" comments. Good. They will not appear
in the final commit message.

Thanks for contributing!

Martin
