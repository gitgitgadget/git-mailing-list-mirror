Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E9C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 07:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EA260E9B
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 07:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhIOHgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhIOHgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 03:36:15 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC7C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 00:34:56 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id p24so1918273vsg.0
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yts7BsQ//RR/0HlDABl3SYHrI5NVbYEKrYyc8pYOcDI=;
        b=QGnsN9cFhprbJNXt4Ya+Ul6Xj59FY7PLK/Jk7ChHYqMZmqDlxHdf1RVO0YG09wPIqR
         zzalhLMCh14J7spgY9FnnIL0iz9AOXsuJLCL2sP90i2eermVGOFBWyn0u3g3Wxu6JfOl
         S2kmzEH8XNCUwvI9eLOCgxNt5LKlNwTNnMOnLGRgPdnrfN2rCbnt1GrdS9VAZwiH9xY8
         Pz9ni7LffcOGNU/iaayRcNHQGPycdTQR6SdAsO9rG0eSaGq2uaVl6S9tLZcQn6KvD7f5
         wjBtQTHa+5asL2r1b5SwiOX5oF/+jlh2KsvYU15zt7iz86E5K4IqurMen/q1xr7uMI2l
         tsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yts7BsQ//RR/0HlDABl3SYHrI5NVbYEKrYyc8pYOcDI=;
        b=vseqMe0peWBdjcwQL5jWX0SzCxlI6zh3P9yeXbzET6TzFrSlT21qdMJbAzqf0dnI5z
         /4YUKX0eZeWiZ6Qyq+TFuXZlLLN3ANL9icjbAjq3obYKXEokr+XlEMH+2qpFuEtHdsx0
         ww9KrhfuOoNqO7NZ5YML8bO1dYsBKIRmqD6PhclgQVLEH+NCxSRtOoFhl3Vy57+uvjXo
         JMFVRY5EO/r0YZMUfNSijENmqhxuMWhhp4x69RH05NgUV3VNRB00lw3P9656A+EIZLeh
         BLz+E14rCg8teeFay3Y2NpRM6nvA+Eof+mlCQ/bApWZHCxdXT+bE0D8R3N8pqO8rqzt5
         mcGw==
X-Gm-Message-State: AOAM531U4gt3X3+Y+ukZfge9zHagvFRRE0MaZMFG/0/InwAh0621Srrv
        d2FT2LP3PRnynax+hZZn1IbK7MOdBPkmaaPg3H4=
X-Google-Smtp-Source: ABdhPJwM9XyaKEuiBjXQkwkzOflX78OvRywBnYo58IOoB7L2n7ReLJqPlNOTNf73pVE2aoih6QdAVHevV7oiI9y9mpE=
X-Received: by 2002:a67:ee9a:: with SMTP id n26mr2228322vsp.14.1631691295742;
 Wed, 15 Sep 2021 00:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com> <e595dbc6c843fdb01c333fd20031d59716804b88.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <e595dbc6c843fdb01c333fd20031d59716804b88.1631213265.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 15 Sep 2021 00:34:44 -0700
Message-ID: <CAPUEspiY=V3y10nc-xUpv7AXwtTv1e1jyRC6FvRrcS3H_ASNnw@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] Provide zlib's uncompress2 from compat/zlib-compat.c
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 11:47 AM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/config.mak.uname b/config.mak.uname
> index 76516aaa9a5..9beacda4434 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -258,6 +258,11 @@ ifeq ($(uname_S),FreeBSD)
>         FILENO_IS_A_MACRO = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),OpenBSD)
> +       NO_UNCOMPRESS2 = YesPlease

This first line is no longer needed and is counter productive
The logic in the next 4 sets this variable correctly, otherwise

> +       # Versions < 7.0 need compatibility layer
> +       ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
> +               NO_UNCOMPRESS2 = UnfortunatelyYes
> +       endif
>         NO_STRCASESTR = YesPlease
>         NO_MEMMEM = YesPlease
>         USE_ST_TIMESPEC = YesPlease

Carlo
