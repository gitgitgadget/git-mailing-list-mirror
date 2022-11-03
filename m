Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 22:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKCWx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCWxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 18:53:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933551164
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:53:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so31109467b3.21
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4hdTqQL2e6HYhJzuHFEW5SIqGCq/CJo3bRvmnkDmfQ=;
        b=N6r1dDcsKhTHUXS91rsOL0YCCd8sjQYI3EVuzF8fFlgNT4gjV3bmmZ8doumQ9ivfNE
         2DOgdeGdXL41fbWBYSWgYE/kme4B+V9qRHuQnrrn4LGGOTNzAbYfG0ssuL3i3KMIzygN
         H/P+tp4B6FSE0RDwfxGt1dJR3YkqejOrk+M9VqEw9ldqSSd0DSAnFLhkLDhI2mE9Ktor
         9DHQj7lhs0b9jEcpOMVND0uvGFTVxaOv8BTOHPnrWC+EnLTa76Robn3wHpdLY32lpegI
         vh5XPLkP31k0YbTSl7TQXUDDuKVNOg6KXf3UJcxAZeFWCnUQlq3Q1aIjXViDbG6/HAvX
         llvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b4hdTqQL2e6HYhJzuHFEW5SIqGCq/CJo3bRvmnkDmfQ=;
        b=zKF4KG1FV/z+yioskwt2W+yzXKyNK/bKZvuaUQQzLxIrjDyvyZM4f1DuoUF1vlkBQ6
         0wQT7Ts19x+WJx1h1bQ/r2j1V/vofrO2S+Y0isnUSpAFEvKqRNrI6tnTQvQpJhunkq9i
         PMDbbdEmOGi/DLav9BXWFseuoZZfxxOvlVmhnlMV8tN8UqkdkXrKidrwPj0zc4wEB5LB
         i5OtJFgHWElEc252M9e270P3B9N/UqsHknhDFkPFA9r5FxfYQtUrMANYo4zAILZ2kXqY
         rjJfsfeZftZr3lrYA0cmxjUbLpG4lQ8P2Javr2wpkSusPcmjkT/rNLYKAB4kyu59jN/5
         Aexg==
X-Gm-Message-State: ACrzQf2U+rf40y/mcPBzGAuP2to76cYBTYR3lLra+MFrFN3i3+6dWZq7
        i3WxEfKpcQUqrOONNg6yzPR0trS78TxF6w==
X-Google-Smtp-Source: AMsMyM4N8uOOvFL3hI4wBxWi5isQ3s2D4bOfbc/OFmFQ+DE8xqXj+CybQJUIRTd/FqiAn8X3dUCI62HWPX5kdw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:54c3:0:b0:360:f63:7503 with SMTP id
 i186-20020a8154c3000000b003600f637503mr201537ywb.420.1667516002529; Thu, 03
 Nov 2022 15:53:22 -0700 (PDT)
Date:   Thu, 03 Nov 2022 15:53:20 -0700
In-Reply-To: <patch-5.8-2b8afd73b9b-20221102T074148Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <patch-5.8-2b8afd73b9b-20221102T074148Z-avarab@gmail.com>
Message-ID: <kl6la657odjz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 5/8] submodule API & "absorbgitdirs": remove
 "----recursive" option
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Remove the "----recursive" option to "git submodule--helper
> absorbgitdirs" (yes, with 4 dashes, not 2).

o.O

At least this makes it pretty easy to grep for usage, and it makes sense
that we've never used it (otherwise this would've been caught).

> diff --git a/submodule.c b/submodule.c
> index fe1e3f03905..8fa2ad457b2 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2332,8 +2331,7 @@ static void absorb_git_dir_into_superproject_recurs=
e(const char *path)
>   * having its git directory within the working tree to the git dir neste=
d
>   * in its superprojects git dir under modules/.
>   */
> -void absorb_git_dir_into_superproject(const char *path,
> -				      unsigned flags)
> +void absorb_git_dir_into_superproject(const char *path)
>  {
>  	int err_code;
>  	const char *sub_git_dir;
> @@ -2382,12 +2380,7 @@ void absorb_git_dir_into_superproject(const char *=
path,
>  	}
>  	strbuf_release(&gitdir);
> =20
> -	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
> -		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
> -			BUG("we don't know how to pass the flags down?");
> -
> -		absorb_git_dir_into_superproject_recurse(path);
> -	}
> +	absorb_git_dir_into_superproject_recurse(path);
>  }

Maybe I'm misreading, but I don't follow this change.

Before, we recursed into the submodule only if the
ABSORB_GITDIR_RECURSE_SUBMODULES flag is set (which we now know is
never), but now we unconditionally recurse into the submodule.

Wouldn't it be more accurate to get rid of this recursing behavior
altogether? i.e. drop the previous patch and delete that code when we
delete this conditional.
