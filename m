Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E23C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjFCBrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFCBrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:47:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4239194
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:47:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3b5881734so3754027e87.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685756838; x=1688348838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UpQJyb/2RLmBY5YUk2cWmttpp9dvPsfuflvX+M7mD4=;
        b=QZLh+RRW9nMmZE5jwubl92h8j00ZswzuExszXyms+foMsb/zynZbAyZiilpJbXt9gB
         F4siL6OU/+hl8cFYXYCPiSZavufQ/C4wnb6uuEUEbkMaLjhfBuicO7BxjGAjRO8TW8Cd
         wuwDFh/fZWcMOW4XP1Z8oY7u/PGG7JDR04vhIQvjvISJWLDarOAPc3NpwlxHkq2ku665
         cvxgcZFktsg/KjgbL6J1ZswIeS/UlocgKXiWIygHQXwNqDBDLBPLmwYgA/c83vVg4cW6
         Q/Uby9hS1r4BpeKIZCFGq3phxpTFT1V0e3JhngCUDr/2mZsPkrxZimlfms5M1J57Ykms
         hSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756838; x=1688348838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UpQJyb/2RLmBY5YUk2cWmttpp9dvPsfuflvX+M7mD4=;
        b=Zucd84WSI1TEHKZEVTFP9WgwARkbbqyQmlwCH1G8dOHF9jAT2tr9tGx34pCBt8cBKG
         73Xc2kbGnBgg7ySiixjEy7rEvLXs5RzXT1zKGGnD3JzQR768xDk4v7Gsrn4YwA5BnjQ4
         QmXu82qR6E41KFANGMPI/ZD8K+QAwekHBZbtYWygJgycLsMXJfYGe9fFUvO9oyApHfWL
         hwfGYZ+mj70pIQFu0tThKVWTSM0AGoMjWU6+hoaB5IDSLC+1V3M7PLhyv4MfT1PzZHyq
         6go8XBuxBzB1P07niUHbZOAOlR3/Ko1u42n4bSwhHfqyZJWGa+CdCGQm0OpS3TFZ5o5K
         l2qw==
X-Gm-Message-State: AC+VfDwnixjDX6tcAsk8K2TUB0V8TKP52obXCpSSYL8tSTMRccJDxpmm
        l31uVdun++4q0cvC4CVdFFaaTtDwl0835wJ4RkE=
X-Google-Smtp-Source: ACHHUZ6Ry2q5+65frsgmJaUuFSFIV17vDe6DwS8VbVCGs0vuEh+K1SHtiWY1KJK6kiIPwU+/NA/S1NnErZasTk7eOAk=
X-Received: by 2002:ac2:5dd5:0:b0:4f4:d83e:4134 with SMTP id
 x21-20020ac25dd5000000b004f4d83e4134mr2894921lfq.57.1685756837890; Fri, 02
 Jun 2023 18:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
 <20230602192700.1548636-1-asedeno@google.com>
In-Reply-To: <20230602192700.1548636-1-asedeno@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jun 2023 18:47:05 -0700
Message-ID: <CABPp-BEH46_daydTZpt0YLXLDYEOOeBobuht3hUgJvucSyUKMA@mail.gmail.com>
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
To:     =?UTF-8?Q?Alejandro_R_Sede=C3=B1o?= <asedeno@google.com>
Cc:     asedeno@mit.edu, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 12:27=E2=80=AFPM Alejandro R Sede=C3=B1o <asedeno@go=
ogle.com> wrote:
>
> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>
> These definitions are used in cache.h, which can't include dir.h
> without causing name-hash.c to have two definitions of
> `struct dir_entry`.

...are _currently_ used in cache.h (your commit message is fine, just
pointing it out for below...)

> Both dir.h and cache.h include statinfo.h, and this seems a reasonable
> place for these definitions.
>
> This change fixes a broken build issue on old SunOS.

Maintainer note for Junio: en/header-split-cache-h-part-3 moves the
inline functions in cache.h that use the DT_* defines, but that series
should both textually and semantically merge cleanly with this change.
(Just noting this for your peace of mind.)

After en/header-split-cache-h-part-3 merges down, I might opt for a
different fix (I'm still mulling it over), but that other fix isn't
possible until cache.h is split up more.  Alejandro's fix is the
cleanest interim solution I can think of.


Reviewed-by: Elijah Newren <newren@gmail.com>
