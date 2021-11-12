Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212CC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A3661054
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 23:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhKLXLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 18:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKLXLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 18:11:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D50C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 15:08:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so43782608edd.10
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xoOPoNWDE15o6cfWOlfsSKJPl0zvZHCeSR9MKIzQWoQ=;
        b=Oo2Lgzqf+Qw1qf/gClWQqkHvgDU9MpVOdIdI7AQhdU3896J8RQy/6ZSthnxcJnvpFo
         tTjJaM5UR8HLHiYa0ef6kWPs79yoDjq2uHwRIhj/Sz/6dJIrW7WnL1l6IYzpfl030QNl
         YYPNyiPEup7rYYKls/X3CYUPtHX8UtDd9cwWDM5M/M/n8LTef/nVF/ZCiN4qWGqaPvaA
         5mb7oA5z+2XtBfhJsUjLQZIQbZ5DRzknbnwxmUB3GGZkD+sPAvEjpnivRCpoCmmB9pv0
         cmH15YVuOFMDll590PsSHqMVgJDIbHwpfvf1z6pdAq4d4nhQwzxFyiEzX5tLrAxPB/M4
         fpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xoOPoNWDE15o6cfWOlfsSKJPl0zvZHCeSR9MKIzQWoQ=;
        b=VqjwmMEvxfEbI+/CxJRZjRLqwOTKK+Xseff6g8iFVIILoZ1vczVxbNzuQbtIFc3PPg
         pCbb9OHBGbWo5NjgEBTs1u8fAJi9jQ/e36O0IR1Ls6KL8mjdaAbTAqnlm3DzOMk2xf34
         K82OJW44Q8TUOL2DQ51GU5S3qkbxPq/ep8hGgS8Wid4K3LVqAFMuJjOora10zmmWbZmH
         R0q2AWBFLK7MkBup4REN+Mz32dNxgsw5OQuKBOI1CO7vjjhtv0DhACOs6ov5LWwl1N2D
         5umdMbH4ZzPAzkl7UnXcW93Kf+aoH0F5Y2Sfap2RY4lvJE4tFko2KLGI8veR/blixrzE
         dtYQ==
X-Gm-Message-State: AOAM531n9Lub+IEUaHXIFzIOHvBv6H+be8w5mllm0bFRZ0HQDkXBtBbv
        bdPDGRtsMPd64TmZxrRS0uNhDe0oeCfl3w==
X-Google-Smtp-Source: ABdhPJxcnbAO45juURxEXRgvS29Gw2mNC3/eDrAUcexmkMkvzzZpBmUj2NI7e3xETgt9+W9Qq9iJFA==
X-Received: by 2002:a50:da0a:: with SMTP id z10mr25884898edj.95.1636758496510;
        Fri, 12 Nov 2021 15:08:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j12sm3988695edw.14.2021.11.12.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 15:08:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlfeZ-000Z1B-64;
        Sat, 13 Nov 2021 00:08:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile, git-sh-setup.sh, t/: do not use `egrep` or
 `fgrep`
Date:   Sat, 13 Nov 2021 00:02:41 +0100
References: <20211112225334.1862016-1-ville.skytta@iki.fi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211112225334.1862016-1-ville.skytta@iki.fi>
Message-ID: <211113.8635o1ug4g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 13 2021, Ville Skytt=C3=A4 wrote:

> `egrep` and `fgrep` have been deprecated in GNU grep since 2007, and in
> current post 3.7 Git they have been made to emit obsolescence warnings.
>
> `grep -E` and `grep -F` on the other hand have been in POSIX and its
> predecessors for decades; use them instead, and use basic regular
> expressions instead of extended ones where applicable.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  Makefile                             | 2 +-
>  git-sh-setup.sh                      | 2 +-
>  t/perf/run                           | 4 ++--
>  t/t1304-default-acl.sh               | 4 ++--
>  t/t3700-add.sh                       | 2 +-
>  t/t3702-add-edit.sh                  | 2 +-
>  t/t4014-format-patch.sh              | 8 ++++----
>  t/t5320-delta-islands.sh             | 2 +-
>  t/t7003-filter-branch.sh             | 4 ++--
>  t/t7701-repack-unpack-unreachable.sh | 4 ++--
>  t/t9001-send-email.sh                | 8 ++++----
>  t/t9133-git-svn-nested-git-repo.sh   | 6 +++---
>  t/t9134-git-svn-ignore-paths.sh      | 8 ++++----
>  t/t9140-git-svn-reset.sh             | 4 ++--
>  t/t9147-git-svn-include-paths.sh     | 8 ++++----
>  t/t9814-git-p4-rename.sh             | 2 +-
>  t/t9815-git-p4-submit-fail.sh        | 4 ++--
>  t/test-lib-functions.sh              | 2 +-
>  18 files changed, 38 insertions(+), 38 deletions(-)

Sounds sensible, but as far as sane_egrep goes this branch would be
better built on top of my ab/sh-retire-helper-functions, i.e. the
sane_egrep you're changing here will be gone entirely once that merges
down (post-upcoming release, presumably).

On the other hand that conflict is rather minor.

> [...]
>  # If move can be disabled, turn it off and test p4 move handling
> diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
> index 9779dc0d11..ce75d4debe 100755
> --- a/t/t9815-git-p4-submit-fail.sh
> +++ b/t/t9815-git-p4-submit-fail.sh
> @@ -417,8 +417,8 @@ test_expect_success 'cleanup chmod after submit cance=
l' '
>  		! p4 fstat -T action text &&
>  		test_path_is_file text+x &&
>  		! p4 fstat -T action text+x &&
> -		ls -l text | egrep ^-r-- &&
> -		ls -l text+x | egrep ^-r-x
> +		ls -l text | grep ^-r-- &&
> +		ls -l text+x | grep ^-r-x
>  	)
>  '
>=20=20
> diff=20

This looks completely fine since this use is trivial, i.e. let's just
use BRE here.

But just a note that on some implementations BRE & ERE aren't just a
syntax difference, but they dispatch to entirely different regex
engines. I've seen very different performance characteristics with BRE
v.s. ERE, and even cases on some GNU software (can't recall the
specifics now, sorry, I think on glibc) where some things that are
pathological and have runaway memory use on BRE would be just fine on
ERE.

So again, it doesn't matter here, but just since you're poking in this
area a note that -E isn't just "I'm using ERE features". I think it's
probably a good idea to always use it, unles there's a good reason not
to.
