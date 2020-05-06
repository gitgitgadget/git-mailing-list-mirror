Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CDCC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A22C206DB
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnuwbmIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgEFQUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729486AbgEFQUO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 12:20:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89729C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 09:20:14 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r66so2251883oie.5
        for <git@vger.kernel.org>; Wed, 06 May 2020 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1SSmCMNBH5Xk5XlUPn4uDZAwhUPlrUlVY1iYTibTfA=;
        b=fnuwbmIG+KNPtOgqotVRNptYHH5Qz84vsFTjEEDXb9WZMchvPEy0nKWhujktVDxEq4
         o3gFT+uVmxRmLddhOG5++MGa/7r06ZynsfWu+vXA0D4JwzNKGoVRqeFEyOUt4BvzOzoC
         3cYjVqHyrUjnHf/d4Ndm+dW4v2I2/iB1lFr6HXvuFPapOs6qC35+rdZv5CMeI0gErbkc
         if9uNYDhhmOvuAR9wPkATvUhDYcqhgtdhIQ8qh8QT8MqMRGMhD/nA21hkTPI6OeU7pQM
         OxQACZTQVyedy9PfjX+kJcC6c+PO4ZVeNogIjZ8xj/+LCdYOI3EtgUslaSKEAPpojMhx
         7/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1SSmCMNBH5Xk5XlUPn4uDZAwhUPlrUlVY1iYTibTfA=;
        b=oLZqITADixeEAVq8cAm7RfZlv39Pbf6v6SOEJgJvuWehtBsi0UKNV6WiNU/gvQXVMJ
         8C+WkbevD6qgMVRJPCkiH12c+Kk5hF4R8W293VqXE980KGEqoVe4+nUZzASpzHZN0hfu
         cBJvqosN5Vx7cBXtf6JG1nwnowRbWKw6RdRfaG6/RzIzWycwNBapKpZpywlmMlf20YMB
         rDDz4R00RVV9BlZcmbORB++wfIHZ0Oi/WrOjk/bR9cvFxhf2LuVkmSMfO0PV6k2ec5n7
         2W4lXihetWmNAKxHwm8+jjk4LdTJlmBbV8jfnEoa83l/HXuBw/80zMFKw2ysfX0HK18R
         nkew==
X-Gm-Message-State: AGi0PuYJhEti/iYZPHUmMBWPhrGffLlgGZVJ/CZw+gF2+6WKNEBGIigd
        agfRfQD6OfLYtC7Cuk2WvswdqdcnsQskpiQW1bcW0lFQ72A=
X-Google-Smtp-Source: APiQypJsR8pjnMA5UQn1ktAOuAa1/uHLRVbDT5Q5U5FL/E0k9g8CbvdmSYSAFoxB+T/oDoeJxGY0PBxN9r9KirENTKE=
X-Received: by 2002:aca:5513:: with SMTP id j19mr3131740oib.31.1588782013829;
 Wed, 06 May 2020 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com> <20200506080023.12521-4-shouryashukla.oo@gmail.com>
In-Reply-To: <20200506080023.12521-4-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 May 2020 09:20:02 -0700
Message-ID: <CABPp-BHurMUPM=NVr7N4Fvx9UccNqi-nQrFH0_vM9a96MjFzog@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] gitfaq: fetching and pulling a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Wed, May 6, 2020 at 1:00 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add an issue in 'Common Issues' section which addresses the confusion
> between performing a 'fetch' and a 'pull'.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 5dfbb32089..53e3844374 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -255,6 +255,14 @@ way of cloning it in lesser space?::
>         presumes that the user has an always-on network connection to the
>         original repository).  See linkgit:partial-clone[1].
>
> +[[fetching-and-pulling]]
> +How do I know if I want to do a fetch or a pull?::
> +       A fetch stores a copy of the latest changes from the remote
> +       repository, without modifying the working tree or current branch.
> +       You can then at your leisure inspect, merge, rebase on top of, or
> +       ignore the upstream changes.  A pull consists of a fetch followed
> +       immediately     by either a merge or rebase.  See linkgit:git-pull[1].

Looks like you have a tab instead of a space between 'immediately' and 'by'.

>  Hooks
>  -----
>
> --
> 2.26.2

Other than the two small spacing issues, the series looks good to me.
