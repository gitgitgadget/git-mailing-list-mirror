Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C18C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiKHA0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiKHA0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:26:38 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B951FF82
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:26:38 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n191so10290502iod.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpX5mUi5bskq/2rBWNiHlwMV+PUZgJbvNVFms8w/Ffc=;
        b=0TtPuvSng19nxWDP0zZc7kFen7wuokRnYZRrfMbWwWNdzPWAaN1ci6Z29PUa5Pw19t
         WArLOgr5Ts/OoK4Z07gqw43STeVo0FDzADpCXhKefPrPT1HotK5hm+3Qghz0oQIJpGa3
         3ihMJw8rcKsQox3eLJ3GfGRQ/r8SuYSNLItYM/lshedRH/VZ7TYLP6DRFpk0fMqETfrR
         MOIhjVdNOChklnkG4QQZbGkerGiFEUuFpGqe68O/iZWVp/XwxRZkpUArodNxn90FhHZm
         z+h5wwr9/J+DjNkLFfLv0EZiUirQ9ORPq/IU4r8ngBSkk0+0/uTfC3MZhE6NffLHrJXP
         5Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpX5mUi5bskq/2rBWNiHlwMV+PUZgJbvNVFms8w/Ffc=;
        b=G05Ezh4evKK2LewTdMxdaGyC2XtMWv6Wc+GHyKePGpUeykFSY+umMCwfPYU8OVDrr+
         ythEjgpngLgu+SZ22eJ7fL7upMRScdE8b2e9cZuFHWs3Kedd0racvfev7gCGBZeyK3bx
         AHD3Nriy7zfG4eZsGdwxrek8ICU4gAN32P1EbSzzKV7QTRtOy3oWYdz10YDK6e76Isnh
         LwvayOjJKfNI/0+PSP0pVjQPDSJ2hyI1IXq5hbJ+llSkPFVgP5HZb6OclpaO1wK7WMuh
         ogMLvEfcPUEGD+g1CdixcRp6KI9AQ6z3StojGw0Gj6PB5Ch29rF7Xf7DP9hqJ8C3xZHv
         8++Q==
X-Gm-Message-State: ACrzQf38nbQQ/7driqha680J0gMQSdOfrUpwIYu4J0UI0gWHSI2fzzY2
        p3qBDKA/65zXEszRMOLtoAOZGJEDdPUBowiF
X-Google-Smtp-Source: AMsMyM6Gx4dJMqS58Pizt9rds/thhDLbzLnVMWwRVdfXxB99+SeCAg+kFzGjXVCw/koXKBSpj4ksUA==
X-Received: by 2002:a02:2a04:0:b0:374:fe6c:2a96 with SMTP id w4-20020a022a04000000b00374fe6c2a96mr29892667jaw.109.1667867197339;
        Mon, 07 Nov 2022 16:26:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t10-20020a056602140a00b006bb7764890dsm3731235iov.45.2022.11.07.16.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:26:37 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:26:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     andrey a <gvozdila@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug while cloning http repo
Message-ID: <Y2miO01QqsL/mvIm@nand.local>
References: <CAOvKmB_qjAm66fAuDBmgGQG7J=+=VW6Fayxfp1zPs5qJfdd=-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOvKmB_qjAm66fAuDBmgGQG7J=+=VW6Fayxfp1zPs5qJfdd=-Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 07:58:03PM +0300, andrey a wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> git clone http://git.altlinux.org/gears/r/rust.git
>
>
> What did you expect to happen? (Expected behavior)
>
> Normal cloned repo appears.
>
> What happened instead? (Actual behavior)
>
> git clone http://git.altlinux.org/gears/r/rust.git
> Cloning into 'rust'...
> error: Unable to get pack file
> http://git.altlinux.org/gears/r/rust.git/objects/pack/pack-42e36950f8cd6e0d242719691491d16dd2e270e6.pack
> transfer closed with 7043414950 bytes remaining to read

It looks like something (e.g., firewall, anti-virus software) between
your workstation and git.altlinux.org is terminating the connection
earlier than it should be.

So your client is only getting part of the pack that it asked for, and
some of the objects appear missing.

> Looks like versions before 2.33.4 works fine. And after 2.33.5 (and
> 2.34.1 2.35.1) reproduce bug.

If there is a bisection which conclusively points to a single commit,
that would be interesting to know. That might not necessarily indicate a
bug in Git, but instead a behavior change which tickles whatever
mechanism is sitting on either side of the connection.

Thanks,
Taylor
