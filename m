Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA953C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 16:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F412070A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 16:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Da4/HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgEYQnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbgEYQnK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 12:43:10 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A5C061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 09:43:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id t4so8354891vsq.0
        for <git@vger.kernel.org>; Mon, 25 May 2020 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5QdMtcYEMJ0LVNBtZZCn1/AtqWbcG5Ymw+rvp9/NJg=;
        b=d7Da4/HF2ChBtpLV1Ltmo0LfDfrQA8EgUHzdFQ2Gy/RU8oWI9bHsl6o0RikAd3MMJH
         3NiRaf0zZJc/kukefdSrNAo++z1bvtArhXx8duvkmicoIYhgFk27CkFhD7Dff78jMpbb
         oeJW+ePpZ/lVJOSGDzvYa9S1g9k7K7zNRzAetsJRTXRlIEpGxtG0Dh7j0jsTQtmvzmd0
         XIEtg3jseRNBmEzEbdJswMVvpX9iQJsqef2tVO7hwKfyGMKNUKHaLhJtHA8CO1UceNcG
         ALo/tuDdbWoL+cLYVr6rgn3AOqm/mGdGs4kOKanPiGbq2ta2KE2v0NpgoNZVLBnrPmTE
         GfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5QdMtcYEMJ0LVNBtZZCn1/AtqWbcG5Ymw+rvp9/NJg=;
        b=NvBBeDlz8nkKY3Q5MyFn8sGVBOJ3C9kIcx4dFXvruYBIS0qTQ0XiLCddboLaooCSru
         zV40Xlpikbflpo7vxLQIVi6MxSTOyONZWdgl4fL7fBkHMiZcnVOtfEYU/dF5xMk+XAhW
         AgC5UwME7QV3zeb9OCY3nkzEljIUKXlXL47kYn2pLtTvFpRGx7mEHjncm0YjgdLBFf56
         cIJkL8rxyK2tOqWv6FB9yhPRooqvD6Vy7Xdu/wtXYauGnYbWqEUxqyUaQhj8eU2y/hw8
         U9nAKN0odTwtqxmkELxILMZENlTkk/3Vi3x0iG939cplPdjPGyla2mVAGA8/6eolZylP
         j3Vw==
X-Gm-Message-State: AOAM532E8eATM+NM8MKwurQdfezD7nmJD4BWRifvPFOLX6Zd9dHimZBD
        e2rfVRCOWjxkQxqw3P9gPB8Pw59r6SOOzZY/RCZ/ERI1
X-Google-Smtp-Source: ABdhPJwOKS2IxjSL1NfqccvYrEtb6x1dZSMtIQstqMkWsu0WIT8Mx+oQwDrlteii47fQgKOd64XG56I06XDUrdy5R3c=
X-Received: by 2002:a67:2f95:: with SMTP id v143mr9178903vsv.79.1590424988053;
 Mon, 25 May 2020 09:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200525144138.1624272-1-toon@iotcl.com> <20200525144138.1624272-2-toon@iotcl.com>
In-Reply-To: <20200525144138.1624272-2-toon@iotcl.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 25 May 2020 18:42:57 +0200
Message-ID: <CAN0heSoyxvTTaJaRmnQADTaMrWa4QBbGnXi8MUZp7ksibejc8g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: correct hash environment variable
To:     Toon Claes <toon@iotcl.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 25 May 2020 at 16:52, Toon Claes <toon@iotcl.com> wrote:
>
> To set the default hash algorithm you can set the `GIT_DEFAULT_HASH` environment
> variable. In the documentation this variable was named
> `GIT_DEFAULT_HASH_ALGORITHM`, which was incorrect.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>

I would replace both instances of "was" with "is", since you're
describing the state immediately before applying your patch, not after.

Changing that and wrapping at 72 characters yields something like

  To set the default hash algorithm you can set the `GIT_DEFAULT_HASH`
  environment variable. In the documentation this variable is named
  `GIT_DEFAULT_HASH_ALGORITHM`, which is incorrect.

Nits aside...

> -`GIT_DEFAULT_HASH_ALGORITHM`::
> +`GIT_DEFAULT_HASH`::
>         If this variable is set, the default hash algorithm for new
>         repositories will be set to this value. This value is currently
>         ignored when cloning; the setting of the remote repository

Indeed. This discrepancy is visible in the commit which added both the
documentation and the implementation, 3c9331a129 ("builtin/init-db: add
environment variable for new repo hash", 2020-02-22). As
developers-only as this variable is, that commit was not in v2.26.0, so
this might be worth fixing before cutting v2.27.0.

Martin
