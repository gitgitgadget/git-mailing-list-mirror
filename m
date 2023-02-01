Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2F3C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBASTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjBASTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 13:19:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9E7BE6F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 10:19:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w20so4267237pfn.4
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 10:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+UDyFHff1R0L1jHLlpZkUr0pSvxJsWXesRz/EPVcw0=;
        b=Pwcc5duGeuSoCpLZhLQGS11dMDZbqk0hfqUa5kb+CiVPzqdzyGbkKm61v8ssrNxfwc
         dlmhNoAnhh19mokgmCm3x0zxlGAFyUscwaFeEopQhlz9IOlGgkOG5VRdlj6v50/EP5Ys
         Z7tqhKFxUoBtscN4fryyU89ygu5d6p4NML7v/HxpE8fGgFzXtxOb0p2gt/K8/YQOq58H
         d5MiL7RmGEzNUEdnoKUGLCH2iqkIbAyo9XS5/rpTgnlbUkuKfTWg+S9aQdocoXnn0AAJ
         Fq7A7wrHIrqqJOlXPKWhecWrMf1dw1oOmsCu0rmBG9nsg661FAjo1OOlzYBI4AHyscdl
         goWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+UDyFHff1R0L1jHLlpZkUr0pSvxJsWXesRz/EPVcw0=;
        b=a0w6Ga1bD+vfPXicVULpWuZRCt8BMMvhGxXJi6XL7N/DDxn9zzBo1UMt2SYVDZ+ord
         aO2Gx1ltp4K0dQxGC9/KF/aEQvgNgDuGEWFFinDC2w5fpw/V9yOu1Seu8ufOYv8LQbCx
         dK3E/TpD3/1Q0SY2t5ibBwxKFUMMPMd0HGtKVFFvxdb4jdzssG58315RES5ohiVjmNDB
         763iMII2cprOFeN9JPdTlP3O1DUKRNR6o1xt141sUZI80OwZ0ZvWuOWWJtVFxlZdV09o
         +LKSWfwWXk9cWrsKVrG8nWDZhmbUs9OzI8rD3zXGGdiGodT64t6CqndpDRSh3ZbN/k8K
         QoFg==
X-Gm-Message-State: AO0yUKUQ+f9QgLji09FVw/KGaveZpd7xfjUgGnk+p7SMUxm1d9yQpXxj
        DbxOtnf/i45TWyo+JJwzuxE=
X-Google-Smtp-Source: AK7set+zKTnlEAluuzNxRXBf7mEJDqEgR9KIWekGpqTExIVMQ9OkXKzP1+PAKkzJIQ2wwl4i5wlAUQ==
X-Received: by 2002:a05:6a00:b8c:b0:592:5885:8634 with SMTP id g12-20020a056a000b8c00b0059258858634mr3118913pfj.14.1675275542759;
        Wed, 01 Feb 2023 10:19:02 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x124-20020a626382000000b0057fec210d33sm11727293pfb.152.2023.02.01.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:19:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Dulfer <rafael@dulfer.be>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
Date:   Wed, 01 Feb 2023 10:19:02 -0800
In-Reply-To: <20230201155712.86577-1-rafael@dulfer.be> (Rafael Dulfer's
        message of "Wed, 1 Feb 2023 16:57:12 +0100")
Message-ID: <xmqq5ycl1c6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Dulfer <rafael@dulfer.be> writes:

> From: Rafael Dulfer <rafael.dulfer@gmail.com>
>
> Currently, the documentation is slightly incomplete, not explaining all the differences the default format has with rfc2822. Leading to confusion for people trying to parse the date format outputted by git log
>
> This patch adds 2 more exceptions when compared to rfc2822. Also adds an example of what the format looks like (I originally wanted to specify this in strftime notation, but because of the way day-of-month is formatted this is impossible)

Overly long lines.

>
> Signed-off-by: Rafael Dulfer <rafael.dulfer@gmail.com>
> ---
>  Documentation/rev-list-options.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index ff68e48406..8bc8475f3e 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -1103,9 +1103,15 @@ format placeholders. When using `-local`, the correct syntax is
>  `--date=default` is the default format, and is similar to
>  `--date=rfc2822`, with a few exceptions:
>  --
> -	- there is no comma after the day-of-week
> +	- There is no comma after the day-of-week
>  
> -	- the time zone is omitted when the local time zone is used
> +	- The time zone is omitted when the local time zone is used
> +
> +	- Day-of-month and month are switched around
> +
> +	- Time-of-day and the year are switched around
> +
> +As a result, the format looks as follows: `Thu Jan 1 00:00:00 1970 +0000` with `+0000` being omitted when the local time zone is used.

All of the above may technically be correct, but I wonder if it
makes it easier to follow to simply stop saying "is similar to".
That is

    The default format `--date=default` shows a single line with
    three-letter day of the week, three-letter month, day-of-month,
    hour-minute-second in the "HH:MM:SS" format, followed by 4-digit
    year, plus timezone information unless the local time zone is
    used (e.g. "Thu Jan 1 00:00:00 1970 +0000").

or something like that.
