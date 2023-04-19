Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE533C77B76
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 03:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjDSDQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSDQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 23:16:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC277297
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 20:16:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c3so9368174ljf.7
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681874198; x=1684466198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfqAizCrU5/yTi6oydsbfk72Fum6a3jm0ZwHqi1JNuo=;
        b=QFMKeUEkIt64XTfPIwUOGWMGTjNVEcqks3CmFvFY3CT6AUubFcUUqNERJPyhJm+PXw
         c5PE8WZaYPjFdv9ZAwRhaZRwsS9adD3NR6PS3xs13oftzHOidkEq8Gu/UuP4iS6GEWTv
         Xnxqeg0qtKf7CAm7Fi+oqq5g5Ib3NP/lbkDDlyk4+JegioOVhI/dVKDZzeLjUd/+wAo9
         Ahv7Rq9MM6V8Ina0CaT69zW08LclPIdpW/f0vxyckQuA+hilphiqnQSv0+X4Jt5zhYNc
         pMj5T6WjjzNukN5cMzhBhVL0weri4K8qmGXlcdEN9ZDePwFv1DRvN9zMT+AxHmKjiFs4
         CtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681874198; x=1684466198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfqAizCrU5/yTi6oydsbfk72Fum6a3jm0ZwHqi1JNuo=;
        b=N5gBsJlEN4/a0dXDA7sBelH087qqFBNoJ8Ys36/7LfFF16P20D95BpXDI2g6YGIhKF
         NqU5FmUYmwHa3sbrX/sSM6lOtDsyxJs9mangG3Spcxx5bx8czhs6ubVibjzLbt3hya97
         afj+d9BFK1euiT+JA4l6GsLXuiJYFCU0vmC6E8iwch6dKqDy6iZuKwjrGRidQK8CvtC4
         hM1dSVn5QG/XLY0fFA+Q3xPF/FuQA3W86OZWQuEoAIzwal+hwyW27hZCgnQFrIUPuluX
         K5wDhOYBPooAZa9UKiGZCzy2Nb9dfYT5HJ5rY7TGCVylPCQe8/Z4Ok4IHWCFb1c8h9go
         wlYQ==
X-Gm-Message-State: AAQBX9fbTkWcyXYseVpVCtQLpXmdhClL6oxXYLFVxlJKkvq6PszUN62l
        CMwLxIqACD07AQQ+gWWpQtluDAa0aoMGCGmHQqleQ7ly
X-Google-Smtp-Source: AKy350bAHX8fgTNyd5+HJxc243ywltVM3oXlpX+MO35nUtFnpjpgyi63GzAORzTmsPy8D8/TBA1eUBcClMsR6RawKL8=
X-Received: by 2002:a05:651c:218:b0:29b:ebfa:765d with SMTP id
 y24-20020a05651c021800b0029bebfa765dmr1499852ljn.1.1681874198241; Tue, 18 Apr
 2023 20:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com> <xmqq5y9uo4kj.fsf@gitster.g>
 <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com> <xmqqwn28c3dh.fsf@gitster.g>
In-Reply-To: <xmqqwn28c3dh.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Apr 2023 20:15:00 -0700
Message-ID: <CABPp-BFtFuvU_XSUA-kDt_4WhZxdgF615h+hnH_tPwUhnWg05w@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 2:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I didn't know it was a fix for anything when I wrote it; it was in the
> > 24-patch series just as a further refactoring.  Then I found out after
> > this report and doing a little digging I found it might be considered
> > a good fix for the issue so I included it here too.
>
> Yup, let's queue it at the tip of (and as a part of) the base series
> with a bit of explanation.  How does this look?
>
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> From: Elijah Newren <newren@gmail.com>
> Date: Sun, 16 Apr 2023 03:03:05 +0000
> Subject: [PATCH] protocol.h: move definition of DEFAULT_GIT_PORT from cac=
he.h
>
> Michael J Gruber noticed that connection via the git:// protocol no
> longer worked after a recent header clean-up.  This was caused by
> funny interaction of few gotchas.  First, a necessary definition
>
>         #define DEFAULT_GIT_PORT 9418
>
> was made invisible to a place where
>
>         const char *port =3D STR(DEFAULT_GIT_PORT);
>
> was expecting to turn the integer into "9418" with a clever STR()
> macro, and ended up stringifying it to
>
>         const char *port =3D "DEFAULT_GIT_PORT";
>
> without giving any chance to compilers to notice such a mistake.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks great!

> ---
>  cache.h    | 21 ---------------------
>  daemon.c   |  1 +
>  protocol.h | 21 +++++++++++++++++++++
>  3 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 2f21704da9..71e2fe74c4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -39,27 +39,6 @@
>  #define S_DIFFTREE_IFXMIN_NEQ  0x80000000
>
>
> -/*
> - * Intensive research over the course of many years has shown that
> - * port 9418 is totally unused by anything else. Or
> - *
> - *     Your search - "port 9418" - did not match any documents.
> - *
> - * as www.google.com puts it.
> - *
> - * This port has been properly assigned for git use by IANA:
> - * git (Assigned-9418) [I06-050728-0001].
> - *
> - *     git  9418/tcp   git pack transfer service
> - *     git  9418/udp   git pack transfer service
> - *
> - * with Linus Torvalds <torvalds@osdl.org> as the point of
> - * contact. September 2005.
> - *
> - * See http://www.iana.org/assignments/port-numbers
> - */
> -#define DEFAULT_GIT_PORT 9418
> -
>  /*
>   * Basic data structures for the directory cache
>   */
> diff --git a/daemon.c b/daemon.c
> index db8a31a6ea..75c3c06457 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -4,6 +4,7 @@
>  #include "config.h"
>  #include "environment.h"
>  #include "pkt-line.h"
> +#include "protocol.h"
>  #include "run-command.h"
>  #include "setup.h"
>  #include "strbuf.h"
> diff --git a/protocol.h b/protocol.h
> index cef1a4a01c..de66bf80f8 100644
> --- a/protocol.h
> +++ b/protocol.h
> @@ -1,6 +1,27 @@
>  #ifndef PROTOCOL_H
>  #define PROTOCOL_H
>
> +/*
> + * Intensive research over the course of many years has shown that
> + * port 9418 is totally unused by anything else. Or
> + *
> + *     Your search - "port 9418" - did not match any documents.
> + *
> + * as www.google.com puts it.
> + *
> + * This port has been properly assigned for git use by IANA:
> + * git (Assigned-9418) [I06-050728-0001].
> + *
> + *     git  9418/tcp   git pack transfer service
> + *     git  9418/udp   git pack transfer service
> + *
> + * with Linus Torvalds <torvalds@osdl.org> as the point of
> + * contact. September 2005.
> + *
> + * See http://www.iana.org/assignments/port-numbers
> + */
> +#define DEFAULT_GIT_PORT 9418
> +
>  enum protocol_version {
>         protocol_unknown_version =3D -1,
>         protocol_v0 =3D 0,
> --
> 2.40.0-352-g667fcf4e15
>
>
>
