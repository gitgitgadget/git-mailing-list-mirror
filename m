Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4EC433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 06:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AC3613ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 06:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhEAGk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhEAGk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 02:40:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF0C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 23:40:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so365039ejc.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLRzjl6YenvmtWBWFOZJJEKRN0h2uDDAJ16rmFsymoQ=;
        b=guLHsuEJKTuivBX//ribc38MXczzDDMRJgu5WVM35uuWTe7m5AS6+J13eD4wixa4gF
         hsDFa+oftx5Eju4XXeAgIvulZEYB4VsEbespQR2o8un+18FPJEeLcsfX2Xa1JCItIhc8
         7UfKY+5CREvm788dnj34XwTOKzC6DRs9N+xXwPPRpLmG4pECICAKvbnneVEgretiRjIP
         Y7WfviI/sEJzgWi1OULOsN6Vc7TyjK0U8S2o0UoTZv+NTWqhf7Lguw60RP6URf0LfNYA
         wcTeAH1t8LffNOMhInUgKoAW+kJ9MAZNEHc7XcthYCUFhaur3rkGa5rW/Rngyd7O/pxe
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLRzjl6YenvmtWBWFOZJJEKRN0h2uDDAJ16rmFsymoQ=;
        b=S/DZMwW0QlwTYURDwDrTq25s/ds+QsQsZOKOTBxd/jF5JFosirq73D9JP8iNEMyb3c
         1B9BAkwb7FtxQme/LNrK69+V1wrIpKR0iY7uGKuBvnn7pEoMcnEemZzOkDV2HiK14cle
         JoIRkKV8TFyZydJRFuC/iORFFO6JlvtgC61k2oN31ogMDvfe90GazZeXdl4kI9+9BxMy
         2JuLgfXYQBMXK+bWhvbiYErHycgHjSl/G9DmY7/s51L21Sn5n721ySthw6CBZEiDxMEI
         LLHHfzus238n/3v81eFeL1aDxgxEbVEPXl8xaQE0eE2jznmOhdZubquN6Yn25zhe4h2n
         41Fg==
X-Gm-Message-State: AOAM530mkYY+dvmzLd4EvrPg516eNgb9I4bNHM0CTL471b7hmwE3nKKf
        Y6biEkgBKA5RCZaAMmGpQGAnmXJg8J5RE1ELyA8=
X-Google-Smtp-Source: ABdhPJwWvsvSUE++8GX+iHF94RO+3osT6/JgSVIO8OMpQ0aoUWWZe/5ez3LztwrH1LecPeeN5NlyHDIOaZs59XLwVM8=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr7752884ejf.341.1619851204605;
 Fri, 30 Apr 2021 23:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
In-Reply-To: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 May 2021 08:39:53 +0200
Message-ID: <CAP8UFD1Wm2e7Q3XY346-fFWMhdGHV_1Kp=wo8cqsx71j7Sg-dQ@mail.gmail.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 8:37 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Git allows URLs of the following pattern:
>
>   https://username:password@domain/route

[...]

> Some Git hosting providers are working to completely drop
> username/password credential strategies, which will make URLs of this
> form stop working. However, that requires certain changes to credential
> managers that need to be released and sufficiently adopted before making
> such a server-side change.
>
> In the meantime, it might be helpful to alert users that they are doing
> something insecure with these URLs.

Another helpful thing to do might be to add --user and maybe
--password options to some commands like 'clone', 'fetch', 'remote
add', etc.

I think historically we considered that authentication wasn't Git's
responsibility. If we now think it should be concerned about this,
then --user and --password options might be a good way to start taking
responsibility.

For example `git clone --user XXX --password YYY
https://git.example.com/git/git.git` could use an HTTP header to send
the credentials, and then after the clone maybe (if a terminal is
used) ask if the user would like to save the credentials using a
credential manager.

I think this could be both as easy, or even easier, to use than an URL
with credentials and more secure. We could also make things more
secure over time by suggesting better credential managers as they
improve.

Also I wonder if on Linux a credential manager could encrypt HTTP
credentials and store them locally using the user's private ssh key if
there is one.

Thanks,
Christian.
