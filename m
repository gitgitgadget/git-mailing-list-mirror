Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCCBC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjHIRnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjHIRnI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:43:08 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D7410D2
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:43:07 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a74d759bfcso34654b6e.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691602987; x=1692207787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CexSVwFX48Di/R6KoQ38tqyoQ6G0GJYcDiElEIkyYe8=;
        b=qaq6FSjxytD1MT+pruLEWFf3RMjXtKduX/XofuWKfPaEa0XrEQxCEzS3AL/Y76RrsX
         6kBbJp/5mHV4fSAQwD1tyvjSr8HY9uUAt3JS5BllgyveZ82oqX4V81qgEeyiqbYkSt4g
         bii2fFKQ/bESjrc6CboNYf+E8kU78sJgv8AqWMMzSlx0GJir7tcYOr4hwesqpZsA2c0f
         I3lND+fn1SZBCG1fbL8IJ4Y3Xl5u5/L8W9EXQiPCNCMKKCXIB3j/d7JzUrd9NsvbckNm
         L/7TjxO5UyZEuoHnShSKqZ+4adyJAXrCa9bQL4Bn+EpCxeCMO4bFOl6XxPRVfS8kruu6
         /EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602987; x=1692207787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CexSVwFX48Di/R6KoQ38tqyoQ6G0GJYcDiElEIkyYe8=;
        b=Ha5IBWAFpRJFN9fh3WxWPInSU361RPojozMR/trfCSzuJlk5uw8fnZiiiiuNpXGqjx
         +v6dl05igP5ljuMqgK88VH6598bH9Ziuy6tdYfLGzNqjFfPcJu3VZ1qvPDQFpmYTBoHv
         XHu/9+/R4Y7CtAFQvpBrYN1r/iBHULe5qOWSUHP7m2porfvdXQHmb+DCSNSu0Vfhc/rL
         Y6olsHH5r76GeBle4EKRkXRtRCY+trjRt4KkABvZLMk1ci0vW0S/d/9ED/ioiCJHYdcD
         J3YTQv5Luxzop5lndOohfwM450y7p1yZd2rfSyR3JkQHB8j2Y3SLhd6MqeLKfmZEzNBa
         OByQ==
X-Gm-Message-State: AOJu0YwdSV5kt7eIMdJrL2dJR7Xunwl6ebQZC9ZlvDz7/UFKhR8XFD4y
        Tm+K0Sgx+MGzmAygw/Bw/emAi3Vd8AM2pHlt1s+Atl+BGY8=
X-Google-Smtp-Source: AGHT+IHR8sP6voY5+enMyu04v1qHS3KnCVhV590dtOVY3a8bttAf9Z5UfxaUg9wDCgJWQtid7T2UA4rJedXcVaYoQtI=
X-Received: by 2002:a54:418c:0:b0:3a7:2456:6af6 with SMTP id
 12-20020a54418c000000b003a724566af6mr14630oiy.31.1691602986844; Wed, 09 Aug
 2023 10:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230809170028.GKZNPGLM93GYB+7Ej9@fat_crate.local>
In-Reply-To: <20230809170028.GKZNPGLM93GYB+7Ej9@fat_crate.local>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 9 Aug 2023 10:42:54 -0700
Message-ID: <CA+P7+xrGBNO-JNfHvbVUV9AgY_Q8PgYSr5EVycGzC5+ZB7Cv3A@mail.gmail.com>
Subject: Re: git send-email -v
To:     Borislav Petkov <bp@alien8.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2023 at 10:29=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> Hi,
>
> when I do
>
> $ git send-email -v --dry-run --to=3Dme  -1
> /tmp/UdA2hemFfD/v-dry-run-0001-x86-microcode-Include-vendor-headers-into-=
.patch
> (body) Adding cc: Borislav Petkov (AMD) <bp@alien8.de> from line 'Suggest=
ed-by: Borislav Petkov (AMD) <bp@alien8.de>'
>
> From: Borislav Petkov <bp@alien8.de>
> To: Borislav Petkov <bp@alien8.de>
> Subject: [PATCH v--dry-run] x86/microcode: Include vendor headers into mi=
crocode.h
> Date: Wed,  9 Aug 2023 18:34:39 +0200
> Message-ID: <20230809163439.26391-1-bp@alien8.de>
> X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
>
> Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll):
> ---
>
> The -v and --dry-run are glued together and stuck as text after "[PATCH"
> in the subject.
>
> Without -v, it works as expected, see below.
>
> Shouldn't the option parsing error out with "-v is unrecognized option"
> or so?

-v is a valid option to git format-patch:

      -v <n>, --reroll-count=3D<n>
           Mark the series as the <n>-th iteration of the topic. The
output filenames have v<n> prepended to them, and the subject prefix
("PATCH" by
           default, but configurable via the --subject-prefix option)
has ` v<n>` appended to it. E.g.  --reroll-count=3D4 may produce
           v4-0001-add-makefile.patch file that has "Subject: [PATCH
v4 1/20] Add makefile" in it.  <n> does not have to be an integer
(e.g.
           "--reroll-count=3D4.4", or "--reroll-count=3D4rev2" are
allowed), but the downside of using such a reroll-count is that the
range-diff/interdiff with
           the previous version does not state exactly which version
the new interation is compared against.

it takes a required argument, and inserts "v<argument>" into the
[PATCH] block to describe the version.

Typically the argument should be a number, but you happened to provide
it "--dry-run". Presumably assuming that the -v means "verbose" as it
might in most other applications.

In short: this is working as intended, but it is somewhat confusing
that it doesn't validate the argument at all. It is intentional to
allow non-numeric strings, but maybe we ought to validate that it
doesn't start with -- to avoid such confusion here.

In short: -v doesn't mean verbose, it is a valid option, and while its
a bit non-intuitive in this case, I think it is working as designed
now.

Thanks,
Jake
