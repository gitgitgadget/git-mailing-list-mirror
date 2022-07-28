Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D647C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiG1VJ5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Jul 2022 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiG1VJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 17:09:51 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EB7821F
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:09:50 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3238de26fb1so13921937b3.8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1xwhdI5q97OM0uyjs1vogfgz1+/UZp7CRGhGU9PBIPY=;
        b=lgELB1gQHJ+3AcVAgnjRA4eXvIaW++T63UoKnbFO75u+V28RTXDlaWQEe2mDvSvTWs
         Ia+a48qSnrWMINFIVdtGw7Esfz+OOSI2ZNQ1p54eUw857curHRxSq+0THz62riEtenCr
         m+H1dYexc4727ESt7qBQ/VmYYbQgN8aTpjEH1fkQK1pHQUbNszDAZhdK4/MsZQAf2Hw6
         tbX6T1TcGLyRz8jL5kZqeAJE3Df7/FUDf9Pk0gn6efMb1AVF0ndl+LwNPEEV7PTZL5Wq
         o3kyNeFjHzdDN4eGrB6YTMK6c6HJSuX5bEOT6JI9Y+DX6H6oYx7ykEV1/gaFxRQ2KL1+
         bx8A==
X-Gm-Message-State: ACgBeo1xYwMKFOxzZ2MJGXzhhncZfUQXbqeynHCGlKFrbfa4L8L+0hL9
        5YYIw6ytY1AStXHztghoY7DykRrXcQhKr5v4y/rCXv/+6mwMJg==
X-Google-Smtp-Source: AA6agR4EQpTQFypZ8JNPpTJ4BlB/eFwlrhvZNOQzIxWfC1eztSEVlo7F4LyEaCyrIoKT7KcakiW4vtXgQv00cSwCsn8=
X-Received: by 2002:a0d:e853:0:b0:321:c297:c9b2 with SMTP id
 r80-20020a0de853000000b00321c297c9b2mr551773ywe.493.1659042589568; Thu, 28
 Jul 2022 14:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7x9ch7n.fsf_-_@gitster.g> <20220728174953.66964-1-sunshine@sunshineco.com>
 <220728.867d3xj6s0.gmgdl@evledraar.gmail.com> <xmqqv8rh9co5.fsf@gitster.g>
In-Reply-To: <xmqqv8rh9co5.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Jul 2022 17:09:38 -0400
Message-ID: <CAPig+cTxM2vr11XRU-zrNAJRwveP0W9d0x8Euvr6HKmQicKgPQ@mail.gmail.com>
Subject: Re: [PATCH] format-patch: clarify --creation-factor=<factor>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 4:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> >> @@ -27,7 +27,7 @@ SYNOPSIS
> >> -               [--range-diff=<previous> [--creation-factor=<percent>]]
> >> +               [--range-diff=<previous> [--creation-factor=<factor>]]
> >> @@ -321,7 +321,7 @@ product of `format-patch` is generated, and they are not passed to
> >> ---creation-factor=<percent>::
> >> +--creation-factor=<factor>::
> >
> > Looks good as far as it goes, looks like both of your patches need to
> > also tweak this bit though:
> >
> >       $ git -P grep 'percentage.*creation' -- '*.c'
> >       builtin/log.c:                      N_("percentage by which creation is weighted")),
> >       builtin/range-diff.c:                       N_("percentage by which creation is weighted")),
> >
> > Probably just s/percentage/factor/ in for those -h strings?
>
> Thanks for being extra careful.
>
> Eric, I am not sure if the other patch for the range-diff command as
> a standalone patch is worth it.  Perhaps you can help me by
> submitting a single combined patch to cover the above as well as
> what we wrote in the two patches, with you marked as the primary
> author and with Helped-by: that credits Ævar?

Will do.

(Slightly chagrined that I forgot to check the usage-string in the C
files. Thanks, Ævar.)
