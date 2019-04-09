Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827EB20248
	for <e@80x24.org>; Tue,  9 Apr 2019 11:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDILpb (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 07:45:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDILpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 07:45:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so20514714wrp.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XpjoNDzBHLr97kqmU6Q8aPtNeM40b0gc0EmTLUy17cA=;
        b=SqvhKFXlwTSQj/NZ/iIXIJ3TEQACmUm9QVTaLV4qprd/mip1JTP/B/RR3Lr9a+vl31
         dUFwCrwqoN9qCgXd3BPwlsPS1ZJ+S86TPbKPHyv/aAxrkiWM++R1FrjjCFu3tZcwTsEo
         9hsx6FGkq759ZKoGj+u/S8vUgzjwLpewYVIfuRQUPVx+rYfnNNSwi7cZglrNgcLrBQQ6
         uY4lFtsZBK3pRHUWqeEXwFzITdtOBwkwdE97SUoUCDjy3hgqLf9crzvH+kGv624N9lj8
         xbEhrb9RH+TtCe18XvAH3xJMawYEnpwE+fOueTCXCY8FHNx6AFU/ixedVjtIeTqTzRkg
         HVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XpjoNDzBHLr97kqmU6Q8aPtNeM40b0gc0EmTLUy17cA=;
        b=tMVtpty83GphWTlYPfPNhSlXRhPMnWhAxZrTjQfF9n9Qcru5zGwiHM5tGnkxGJd5nv
         UoXsNQsA8HrDvUAcM02biKntpV9rsw27KNXXZ+bs7Ru4Oob74mh+BZgfszmykaXCr7EF
         XoL26vg2O91uEuy6tv+FQDo/GU2rmQeS1FVARiLLN3aV6OYf2KdVVl8SGKJ5CrrAYbfn
         FJWvxh3oAnSYyNZalKlxT5ieeR/IMJk9mtY2QilA9UnNoeMSUYIyYezTnp+c3g/9YBc7
         TEHG4pPi55pGoAYzT4MoLQQT/ppC9EFselG3JrQqTbVirAVIoZLGuPWJVXOJ+pMl+/my
         368g==
X-Gm-Message-State: APjAAAWgxdMNnlvLRaF5rNDm5uml9nFOBH9eQzI1wdPfrLNOpnGDYAlQ
        d27nLx1k9HXmqZGVxW/P0CU=
X-Google-Smtp-Source: APXvYqw/Y7CsSklEk0sdCJ/bk8RpHv+3IhSuOwPtdRvSVWASnAQMra3tut30dSPnocXR+BMBrKRFJg==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr21799789wrp.31.1554810329218;
        Tue, 09 Apr 2019 04:45:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e9sm48881134wrp.35.2019.04.09.04.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 04:45:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, peff@peff.net, johannes.schindelin@gmx.de
Subject: Re: [PATCH v2] MSVC: Unbreak real_path for Windows paths
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
        <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
        <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
        <31485f76-13a9-ec3b-16b9-78864490164d@cs-ware.de>
Date:   Tue, 09 Apr 2019 20:45:28 +0900
In-Reply-To: <31485f76-13a9-ec3b-16b9-78864490164d@cs-ware.de> (Sven
        Strickroth's message of "Mon, 8 Apr 2019 13:26:16 +0200")
Message-ID: <xmqqzhoz4d2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sven Strickroth <email@cs-ware.de> writes:

> A path such as 'c:/somepath/submodule/../.git/modules/submodule' wasn't
> resolved correctly any more, because the *nix variant of offset_1st_component
> is used instead of the Win32 specific version.
>
> Regression was introduced in commit 1cadad6f6 when mingw_offset_1st_component
> was moved from mingw.c which is included by msvc.c to a separate file. Then,
> the new file "compat/win32/path-utils.h" was only included for the __CYGWIN__
> and __MINGW32__ cases in git-compat-util.h, the case for _MSC_VER was missing.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  config.mak.uname  | 1 +
>  git-compat-util.h | 1 +
>  2 files changed, 2 insertions(+)

Some context lines in config.mak.uname did not match tips of any of
the well-known branches I tried, and the blob object name recorded
on the "index" line was not useful, either, so I ended up applying
the patch by hand.  I do not think I screwed up a simple two-liner
patch like this too badly ;-), but please keep an eye on what will
appear on 'pu' and holler if I did, so we can correct it before it
hits 'master'.

Thanks.

>
> diff --git a/config.mak.uname b/config.mak.uname
> index 32381f5fd1..eb1428858c 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -426,6 +426,7 @@ ifeq ($(uname_S),Windows)
>  	CFLAGS =
>  	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE

