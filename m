Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD07C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 09:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11E420756
	for <git@archiver.kernel.org>; Tue, 19 May 2020 09:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR90seVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgESJtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgESJtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 05:49:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF40C061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 02:49:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e10so11180764edq.0
        for <git@vger.kernel.org>; Tue, 19 May 2020 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DpC/ADyKjuUl2/dVXTYATf7CLxy5PEHcX6bjRYwfEs=;
        b=fR90seVtRd+Z6rINkWzEwoB4U9QyVxZfips+2G9pMk0c5AYSh6LoQH6tZgrhJ/pC17
         6FhNhDz/wsYr5K9gpKLHQgK/9xNZwKk2rdNNNtxXlyrbKqYFVQem7ohYqQZmYqpewcc/
         YaS3YD3pFi2zhW+gjjTDO7cKI3DsxfYLwjFp9bkSK6coxVNoXIDVQ0+fLNEB1tFikazA
         xkV3qWSCBvbbJx4jTWRcEfzkrJ+aX9qrQwEw24u7ApcyGinSw/1IeowY55Hxfm6g2SM0
         0ds8ZzrPjH0+TvKUfEFFgzRPWxjXw8v8gwJ/vHiZmNHLSSuI1cdHwkxJQ6WdzTrTD/WT
         x9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DpC/ADyKjuUl2/dVXTYATf7CLxy5PEHcX6bjRYwfEs=;
        b=D0eLqPD2yUYKyGUZ36UAvhImhAKbHNuXGMTqOTTki6aHSXPJoJGWuERfoFmAqUATaf
         I71urHanM7V66NUwgbMsoYk47NqEDGfijfC7YjxK2ERMeeo3TTD59KLqS4ogUwJoUmF0
         6f3GIxiDxYCUwZDD4790KFxZVF0KFpVeQwL7kaSGozReyKtZwARrlSLAyUv7r085FwRz
         6R5wmD9HcgkclfwDZzigcJnoPlvePpEbLW/352qxpKjqT1lV/N4rOsCn/vcW7do4wqUf
         hnberlu11AODJkLtlxCxT2ctKjrlUFsV+xrE44p8acNKhSXMPPAo74Hd9sM1rT2lG9DM
         EWpQ==
X-Gm-Message-State: AOAM533sTuzFqC7LH48M0J8fSEa+Ae96kAGc6ecTxd6rLr+gqZnp0hsC
        BGkGE1+uCaZANgVWUUo620d/mKQraWZGvhXducY=
X-Google-Smtp-Source: ABdhPJwS/3pF3QhC8JRew3AupvEMemkKCMDYEJ2dbJef6cmJcn+3tkKAP+IAkZMopde87eHWVBz4PZkKyAE38CR8Cy4=
X-Received: by 2002:aa7:db57:: with SMTP id n23mr13679826edt.237.1589881760776;
 Tue, 19 May 2020 02:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200515100454.14486-1-chriscool@tuxfamily.org> <2860708f-2719-50b1-f1ae-7fd9c0538c52@gmail.com>
In-Reply-To: <2860708f-2719-50b1-f1ae-7fd9c0538c52@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 May 2020 11:49:09 +0200
Message-ID: <CAP8UFD36xWw152YyGQtskZESndC-=TEUYC1S5ckqvgMp7wd6Ww@mail.gmail.com>
Subject: Re: [PATCH 00/13] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 1
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:43 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/15/2020 6:04 AM, Christian Couder wrote:

> > While there are still a lot of static variables at the top of
> > 'upload-pack.c' after this patch series, it does a lot of ground work
> > and a number of cleanups.
>
> The patches here are carefully organized to make review easy. Thanks!
>
> I was surprised to see how many local or static variables you were able
> to remove using members that already existed in 'struct upload_pack_data'.
> That made the changes here particularly easy to trust.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks for your review and kind words! I would very much like to add
your "Reviewed-by:" to this patch series, but as no suggestion has
been made to improve it, I am a bit reluctant to resend with only your
"Reviewed-by:" added.

Junio, what would you prefer?

Thanks,
Christian.
