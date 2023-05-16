Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D22C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjEPTAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEPTAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 15:00:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB19CC
        for <git@vger.kernel.org>; Tue, 16 May 2023 12:00:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510a5a5cf79so9a12.1
        for <git@vger.kernel.org>; Tue, 16 May 2023 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684263651; x=1686855651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6RbwDQV3n9AMO7oG+T+9TR6eQOzzeSHFbXl0Me5rHE=;
        b=IN1ieLkvF1gOH8yebExuOoKZ3dfMoJEk3ksklHs5Xk+SXu9/jWu8Jz1BWe87QXpail
         93lbVugM/x1RMFs2i17IW6tcqY9dKFBvGvGLB0+iOXITSyR66qqxe0JsbioqYF8WRYyu
         1JTtS2JOf7AZPm75UfG1fZwRMNV8GZPnv81iog1FUQ4Ms/FkGXI2VWKSjqnAVvKzLQp+
         NM+hhwmxLSzXku1HjGS54PnzGKe8B5PwHW30N/qSlLYAKM5y7BWtpGM8oQ6pU6HOUPTP
         LeHD5DBEcnrdYiaXy/0VvkVZnZxp9jj6UF2ZJLJPrQAFTt5MiM61IO0FrbnyGhbFisG4
         wO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263651; x=1686855651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6RbwDQV3n9AMO7oG+T+9TR6eQOzzeSHFbXl0Me5rHE=;
        b=BYTjnQr3/qykDudyCeZ5IQSOwyoesL+XA6XnzzXTVc+Eed6flieWISiGCgJimhLkIm
         ofCBTp0gw15HD/cqqyKCXB4gG1aXyagkAWi7pPBoi0XC2vUM8vjcLN0AFAl8XUr0OfrY
         6bRLmpgb0s//yEYJiCRZR4sl72tS94jC61qT5c8RH5US5EonpaSJwLs32hzPYWbec6jW
         N9rHvr3DOuvwnunOugfLWjS7foHU3IUDbm2w5kkm6Y3+OSW9CdKZ6+WLdBZwK4vpWN0R
         plgeWOcifClb/XPgfBLiz8Okxx8cz31p4RTd7FQqSM02jIvl7IHwd6Dbq7zIr5j4EjZo
         UtuQ==
X-Gm-Message-State: AC+VfDym5VDbTAkf5Tqucg5wJT8hXr2Q8x1im+mi+97fjU1w4Km1i4xI
        aUqm6D1swIcUVRzHZZmNk3Nn1gd4WUXmVqFionMf9g==
X-Google-Smtp-Source: ACHHUZ5DujX8pAHDb9gtTrDA8cJXmmmyKS3gMXYLkb42f76V8BjMnjXoKx/FV7nYul3rJ1dzFoalx/PAnNvUSD/w1cc=
X-Received: by 2002:a50:aadd:0:b0:50b:f6ce:2f3d with SMTP id
 r29-20020a50aadd000000b0050bf6ce2f3dmr23315edc.0.1684263650876; Tue, 16 May
 2023 12:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com> <xmqqbkikuppz.fsf@gitster.g>
In-Reply-To: <xmqqbkikuppz.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 16 May 2023 12:00:39 -0700
Message-ID: <CAFySSZDn7vNgXmhO6EzvkX_6_uw-pdGZUjmFmwk=Qst-P2HN2g@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-compat-util cleanups
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 10:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:

> This seems to have been based on 'master' around Apr 25th of this
> year, like 0807e578 (Merge branch 'en/header-split-cache-h',
> 2023-04-25).  If this were written some time ago and have been
> tested internally at $WORK or something, *not* rebasing on a later
> tip of 'master' (which you did) is good, but at the same time, it
> would be nice to hear on which commit the series is designed to be
> applied.  To prepare for the start of the next cycle, however, it
> may be even better to rebase it on the tip of more recent 'master'
> and test it internally (again), and sending the result out as v2
> would very much be appreciated ;-)

ok I'll go ahead and do that
