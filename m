Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E548C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA888611CA
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhFAJoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 05:44:15 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0057C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 02:42:32 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b9so12399448ybg.10
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vOAuHbt39dbJTZTQZ5BImB3GSxx6bTjKiWLeHMrW7vo=;
        b=aQJEf3ds4g5ZT7KSYsMczT/NQYFRb4cPFFrrS0ybktgVB19Bq2kd5/YBCdwNUvLPhF
         aSQBK65Di8sA//kcBYjimGJvOiibaM2JqQKseo+70WvoGT8fMZ8A9iU9QE0cEPbeRnEl
         NVflq4OEN05Xrkufk5QhmArkaNg1v4C/zMGDcChs8JbzhaXYquEL8HA/ZIA6InsDAROI
         FL8K29dOkQmPH9NWN9jegbcNHrEPMGQXYEcuDTi6k/Tj7aAGp7RkIER8O8yvbG+BQnJd
         3AU+pW+owrele6p5P38QObu703oAmS7/0OPO0+tjAtv6rNrAmtEweSK7l90Qgv0kDUaG
         hwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vOAuHbt39dbJTZTQZ5BImB3GSxx6bTjKiWLeHMrW7vo=;
        b=qXUt2Lm7mGkVHbkBPlDlcKws/UTZPL59zHF7DGIAlHxdwMrBTowcryM3mdjs9FKgL6
         nTCrSW/JIBUq5cV16gGyatjgxdAHXvs1cXFvcAzFX3jpo7H6ok48WmwxjxOGEsYqQzgl
         bdCjOY0M9RhSNru95wEXe+WVnqNJZJXcRZiobkI/THc5LUFd+JLYqGTqCcZI94rQXzG2
         vnYuBPuaziZVnieupENhcPVx+sn6SjVF5OqSUdUnzNzrOveyx0qTYA+X06P9n7Aylj5r
         cmWo/Iql+7JX7e4tLwkzCvBkKrbrrg44y3CK+riIz0RD/Ngvf24Cc6Uu+qSMDNh0Ra0b
         tf3g==
X-Gm-Message-State: AOAM533iZ8Pjtj3MNXqJL8cHW31O/ePTjRUs6m17y3756+wlUQlAqkS5
        BmdOTEWbsxBHbA/ZrGRnqJwlfSuPHyaA7FKIOk8=
X-Google-Smtp-Source: ABdhPJypMu4zoeO035a7GZbhtLGxFOhV0tBbWBCcUByZ5HUv2sXQAY3BtkxPgxFK9j7y69ip/8lDbvMsJxDa3FcuUxk=
X-Received: by 2002:a25:41d8:: with SMTP id o207mr29426969yba.478.1622540551050;
 Tue, 01 Jun 2021 02:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <87bl8xmipo.fsf@evledraar.gmail.com> <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
 <87tumol4tg.fsf@evledraar.gmail.com>
In-Reply-To: <87tumol4tg.fsf@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 1 Jun 2021 17:42:19 +0800
Message-ID: <CANYiYbG1vVqN-De0n2Ukexh0Jn8e_b2G1CPv24T1fbYgyhKjfg@mail.gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B45=E6=9C=8827=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=86=
=99=E9=81=93=EF=BC=9A
>
> But no, the issue as it turns out is not Perl v.s. Sed, it's that
> there's some bug in the shellscript / tooling version (happens with both
> dash 0.5.7-4 and bash 4.3-11+deb8u2 on that box) where those expansions
> like ${A%${A#??????0?}} resolve to nothing.

That's the root cause.  It can be reproduced by running the following
test script:

```
#!/bin/sh
# test script: test.sh

test_commit_setvar () {
        var=3D$1 &&
        oid=3D1234567890123456789012345678901234567890 &&
        eval $var=3D$oid
}

test_commit_setvar A
echo "A: $A"
echo "Abbrev of A: ${A%${A#???????}}"
```

By running different version of dash, we can see that dash 0.5.7 fail the t=
est:

```
$ /opt/dash/0.5.11/bin/dash test.sh
A: 1234567890123456789012345678901234567890
Abbrev of A: 1234567

$ /opt/dash/0.5.7/bin/dash test.sh
A: 1234567890123456789012345678901234567890
Abbrev of A:
```

This issue can be fixed using the following example:

```
#!/bin/sh

test_commit_setvar () {
        var=3D$1 &&
        oid=3D1234567890123456789012345678901234567890 &&
        suffix=3D${oid#???????} &&
        oid=3D${oid%$suffix} &&
        eval $var=3D$oid
}

test_commit_setvar A
echo "Abbrev of A: $A"
```

> Anyway, looking at this whole test file with fresh eyes this pattern
> seems very strange. You duplicated most of test_commit with this
> test_commit_setvar. It's a bit more verbosity but why not just use:
>
>     test_commit ...
>     A=3D$(git rev-parse HEAD)

The function "test_commit()" in "test-lib-function.sh" always creates
tags and it cannot make merge commit. So I rewrite a new function
which reuse the scaffold of "test_commit".

BTW, sorry for the late reply, will send patch later.

--
Jiang Xin
