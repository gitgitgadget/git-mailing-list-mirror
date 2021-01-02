Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EFAC433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F4920798
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 21:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbhABVyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 16:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbhABVyC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 16:54:02 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE9C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 13:53:22 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id y25so7858674uaq.7
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqzeC3o0gYpPO4V0sTBqbQ+ARENAA1RAtEce27ekQGE=;
        b=UDdhaHmlYXXUxwYYTqhAAPa+bci1QKfVnZ5rntm46RCqTthqCxaK7hGK9xxxsIotta
         Zy7zlJNNbCvS1WhtDZvTNXxnEWCHlw8J/rJ2NRQ6YD7NB2Qdj9Xki3N1vkOZNdI72asF
         r+TBf3asvnQfVKHrSg9EEkgs/9n9ZYexrleRronYzxHpL/3EcQcKZLU131tpG+mzyA7H
         KcEhc8s2pdGBku59lNF4Gb15eAKID6Ze8q15jpiI3D37Bhq4TxocRwSkBu8kqSh1tWNO
         DI4aYAYHMIqtYJiLVwOGZiv2D++SYfO68w09U0I1hQMQ9dSpBkw6q9UNar+l0ELTptlg
         ykBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqzeC3o0gYpPO4V0sTBqbQ+ARENAA1RAtEce27ekQGE=;
        b=pz5rlHJeqaUFxr3krplmv/6fhGSUKUqqsN1lBcYw+NX1XoGmtIdq/u02pqVGO0ZRYb
         GzCGCEos8xdvh06PaB16ss2YpjkqstOJe4XAn2VBVJ+x8mC+WoPV+hETdxvS5LTNIceQ
         d6VaTkBq6OfwLW5L2l9DtFJqUNB2r9aXbQKsyX8faKOzB2BG4VyTj7+UXkmwYW6sr6Zp
         Qk0NPDrdMDJoqME9JN5yR1+aEhWDsa92Ni7qa522Gf4RE+yZty3aGIm2x4YaJDogpYGq
         Xx4rX67yAcBaU0sCsZZgllewhg4nq4DDBtdrm23EmrRrdyqgT1QhGA5nKmCjmV48Jzdv
         gLdg==
X-Gm-Message-State: AOAM533Z9t9YdGyRy9XxLN1R9TXKezfIsuBL5LjsSP7gxPzNK/XgauqB
        PGGzeJo1uS/EObfBFoEapMV5VaLZVITYwK/r+AU=
X-Google-Smtp-Source: ABdhPJwrohr4/+RFPXtkgWNqtvB7dVY1gA/Y3EOSjIwacQkb6fGF2IeiFtx2RUYsPnxkOjw0FKcHe5j55dJDurpiL/I=
X-Received: by 2002:ab0:7504:: with SMTP id m4mr40543025uap.34.1609624401220;
 Sat, 02 Jan 2021 13:53:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 2 Jan 2021 22:53:09 +0100
Message-ID: <CAN0heSojPyr=g5PBVmT4VTfxxKxzYcFXJ1jynM1tGuZSyQMykg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix some typos
To:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2 Jan 2021 at 18:43, Thomas Ackermann via GitGitGadget
<gitgitgadget@gmail.com> wrote:

[Snip several typo fixes in Documentation/, all of which I agree with.]

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index c151dd7257f..8f77baa678f 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt

Hmm... This does not match the "doc:" prefix of the patch.

> @@ -442,7 +442,7 @@ endif()
>  check_c_source_compiles("
>  #include <regex.h>
>  #ifndef REG_STARTEND
> -#error oops we dont have it
> +#error oops we don't have it
>  #endif

I don't think this is correct. This omission of the single quote somehow
looks like it's done on purpose. I don't build using this system, but I
tried making some silly code like this in another file, which I actually
do use:

#if 0
#error might or mightn't work
#endif

My compiler refused to compile: "error: missing terminating ' character
[-Werror]". So I fear this change to CMakeLists.txt would make us
needlessly fail to autodetect whatever it is we're looking for here.

If this change to CMakeLists.txt is dropped, this patch looks good
to me.

Martin
