Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF172C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 01:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjECB6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 21:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECB56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 21:57:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A482D44
        for <git@vger.kernel.org>; Tue,  2 May 2023 18:57:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec8149907aso5567417e87.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683079075; x=1685671075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6HH19FU4uUKDWrlt9j/lezPo1oLtZ2rA5PnVe9b7ek=;
        b=fKRDAfN6c8ydFQkQmooNw6lYK0HJHSD7FtR55rbzQwQ2T4BZsbAAcjK1Cm6O0bvwC3
         GUZKa7WVwzZqTCGeayKEDZNdRDjYa4v9KYIPOH+7E2dE9YbKbwn/0VzEOyssX0uFYEjO
         ZSd90QB0hmd4ihKI5X3s3h4WiOgfqwWtXAd01Vbc8O7b7ISH9YropLatjMLECv4ArWCX
         5YP1edY1MncCNPxAHLbIT+kugy4dtT2rc/Jm0lOoE60cTvXCTuSYBSwXJ1KL1wHEr5ve
         aJznoE0HuQK30M/1EnMHJ6vMUTUtwnX3p6HMVPb6N3SPrKWpOL1Qtivief7+eZ2tGV1D
         IAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683079075; x=1685671075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6HH19FU4uUKDWrlt9j/lezPo1oLtZ2rA5PnVe9b7ek=;
        b=lX/uiYwTDhnK0HqKN/xSvzApneRzGauUIlRCCxuh+rJLJMMCJ7fZ/xpemrt8ibSy7C
         rHBY223gFBvO710qKgFswQyuJuInob4OhUHqXkoEx4bjmhN/LrcsJL/JL01Xlf8d+8uz
         cIpO1gq1HSXVdqfk49FCUZLl/oJXv6LrK8s/cIIQMtatbau3GwVyov85219K0paohjAX
         2tJbt722bsWhjUBmQRtP2A1NbxPCMSeKaQLR78LeH72bdfKmu0wv296GtCLF3w7IsfBT
         c8hM81TL14FGt70fJajCy2ley+frS78o3Tqf3SNE7v0IexlFFFf93sFtsccs6beuK8XM
         vW5Q==
X-Gm-Message-State: AC+VfDyeXEgy50q38gedZe10pafcy0Bc44tA2ErNpG5gMiZmiLk0bcEl
        hy8vAygsfhwU5tTyeKY+F2rkFs7iOBigBky7mN+vBfZc/aQ=
X-Google-Smtp-Source: ACHHUZ75qlJSMRXAPQd4FOlTv60+x6RZp0LCcV9XND5APA/uXkfu1XN/3iGkHBxRlI+Ofcufyk83Ho26YCoQCH+025M=
X-Received: by 2002:ac2:548f:0:b0:4d8:75f8:6963 with SMTP id
 t15-20020ac2548f000000b004d875f86963mr446696lfk.38.1683079074801; Tue, 02 May
 2023 18:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com> <20230502211454.1673000-6-calvinwan@google.com>
In-Reply-To: <20230502211454.1673000-6-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 18:56:00 -0700
Message-ID: <CABPp-BGLcUnqZvYNG_5pNOXSHCtryVyXoMJHdX5eXdkgYAS24Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] strbuf: clarify dependency
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 2:15=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 178d75f250..d5978fee4e 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -3,7 +3,7 @@
>  #include "environment.h"
>  #include "gettext.h"
>  #include "hex.h"
> -#include "refs.h"
> +#include "strbuf.h"
>  #include "string-list.h"
>  #include "utf8.h"
>  #include "date.h"
> --
> 2.40.1.495.gc816e09b53d-goog

The commit message feels misleading.  A little digging shows that
refs.h was once upon a time needed, but no longer was as of
6bab74e7fb8 ("strbuf: move strbuf_branchname to sha1_name.c",
2010-11-06).  So, you're removing an unnecessary include, but adding
one back that was missing.  I guess that might count as "clarifying",
but maybe some of that extra context in the commit message would be
useful?
