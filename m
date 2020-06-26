Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C886C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 05:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F8020768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 05:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsarKUoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgFZFpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgFZFpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 01:45:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE62C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 22:45:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so5981753edb.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 22:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANuYEozebU3SPsA8DoPu197MpkSMRw/u69C4GISz0Hg=;
        b=RsarKUoDKFa1DmlfK2asBxrIyf5eybu+yQiJUxSRY5q9kKXKT98Hq+SzzQPxgN8co7
         tvzSDrA59hLHe0uWT/EbE8SjrOEG1tvZuO+915JiHNeQAq8PBJLhqJQbrlRMXIYSnWAi
         TzYeOkRC89J9cK2xNM1uckMArFWsbs0SyBk1X8GA51cTKHVU019bTO/vHJ46cPijZeZN
         IbtJ5RoI3EjDYyLiJ+g2EeYYrDMkoeVQ6r+rEson3E8268BfYppxYLUud1lLZCXPsQ0h
         6nBhH3JnCVGwvCJQ9xVXiCyhjmGEGZkh5nJ3uYMc6O+BTrV/Lc1t86QEAbJzNSESLSUi
         sDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANuYEozebU3SPsA8DoPu197MpkSMRw/u69C4GISz0Hg=;
        b=T3nUw/5C3X8SZo3mAiqoSy2X9WDSyxmE4+9WxxCoGBc32GPam0WE6tsba0atyhhp2/
         rcHMoF6cbib0BoWqZjsgLPN37Q+En3DLVfCw8U0bQVN32dLtFFvGIdC6uAuUX+X8kdo1
         vxSyI15iYSnCSTTIz9BX8xk4w3wtyrJyf2NrYADGrdnhOlg2L75B5+avr6DF9TkyT9mF
         OFX+tAbalKZPVVQFspdOvzHDuSV4C558XZQ7Px3WBYypOmHWM7en1lrI6capKAS/yPZr
         J9CIVVXgai/AQgq25UBW8PFGXdEmOYhUhnBsC/9FuH8JvbpDsQkeM9En2JNZVtkJfcrt
         xTwg==
X-Gm-Message-State: AOAM530vNllDzPY/ML0LxRZWP1t7/pepXMiln47vtCRJ5A/nHztbIOAE
        g418B+8z27keFG00M1jJPszuIDjFAo9gUqz3Hyy0kiqa1iQ=
X-Google-Smtp-Source: ABdhPJy2pq7OpRxmyb1iOPyZV3DGRkmjHBB2YKwjYlw+Nh6FfcOwXseMZaq/4PZAIBz4VFP97Kl1ZzrskMbMNEGNFjg=
X-Received: by 2002:a05:6402:1250:: with SMTP id l16mr1743777edw.362.1593150315142;
 Thu, 25 Jun 2020 22:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593115455.git.matheus.bernardino@usp.br> <e5a10d3f2152859b75bd815c37511975057d0ab0.1593115455.git.matheus.bernardino@usp.br>
In-Reply-To: <e5a10d3f2152859b75bd815c37511975057d0ab0.1593115455.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 26 Jun 2020 07:45:03 +0200
Message-ID: <CAP8UFD3NwKtWYL_H5fWjT-HQVd3W8ZJ49p+faDyMQ+==ttCWjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] compat/win32/pthread: add pthread_once()
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 3:00 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

The commit message might want to explain a bit the purpose of adding
these features.

> Note: the pthread_once() function is adapted from:
> https://git.libav.org/?p=libav.git;a=commitdiff;h=b22693b06d1e5d73454a65c203b4d31c1ca5b69a
>
> Which is LGPLv2.1. Should I add any notice/acknowledgment somewhere,
> besides the comment I added above the function?

Yeah, I think you should also tell in the commit message where the
code comes from (along with the hash of the commit) and that libav is
LGPLv2.1 which is compatible with GPLv2 as explained in section 3 of
the LGPLv2.1.

>  compat/win32/pthread.c | 22 ++++++++++++++++++++++
>  compat/win32/pthread.h |  5 +++++
>  thread-utils.c         | 11 +++++++++++
>  thread-utils.h         |  6 ++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 2e7eead42c..5a7ecbd999 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -56,3 +56,25 @@ pthread_t pthread_self(void)
>         t.tid = GetCurrentThreadId();
>         return t;
>  }
> +
> +/* Adapted from libav's compat/w32pthreads.h. */
> +int pthread_once(pthread_once_t *once_control, void (*init_routine)(void))
> +{
> +       BOOL pending = FALSE;
> +       int ret = 0;
> +
> +       if(!InitOnceBeginInitialize(once_control, 0, &pending, NULL)) {

We put a space between "if" and the following "(". It might also be
interesting to know perhaps in the commit message how much you adapted
the code.

For example perhaps a good strategy would be in the commit that
imports the code to do the minimal amount of change so that it builds
and passes the test, and then to have another commit that adapts the
style of the code.

> +               ret = err_win_to_posix(GetLastError());
> +               goto out;
> +       }
> +
> +       if (pending)
> +               init_routine();
> +
> +       if(!InitOnceComplete(once_control, 0, NULL))

Space missing between "if" and the following "(".

> +               ret = err_win_to_posix(GetLastError());
> +
> +out:
> +       /* POSIX doesn't allow pthread_once() to return EINTR */
> +       return ret == EINTR ? EIO : ret;
> +}
