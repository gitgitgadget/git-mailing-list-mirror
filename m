Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29992C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B0F2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trkudQlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBT3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBT3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:29:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB04C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:29:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so13943840ejb.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPPVmJF3001iSNLGhhZcK1xqRDz2Y+U9jZuJpUuS9LE=;
        b=trkudQlNvwTd72eKspyy0PLZlpAux/oBCfSo7HrYGlvgB758JTHjbOC4FiN6Yyt5rl
         W6gZna65vjEb/YFq7soUSGI40ubDOFF+exBjFuOq2f5EYAht4SB4bwZrheccZMTUf6Nf
         mAJXkWDX/Sxdc3nmq+P1WXmQ6VMAPFc0NYERh26uSbnEvBh8bPbogTFZNwr3s5dCJkep
         JQfwNHZM1NTDXkCIl5R+DvXGCpvgD7lIFJ99GpMNtWMOUzpWwyxU3/4XpQtLGAIIVu6K
         g9/Sdy85aG5mEa60iD0i6KPZ9S3EnJ5AggEHVpR3DIyj8FE8Mf+ueUei9yENrdUL3sOK
         k+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPPVmJF3001iSNLGhhZcK1xqRDz2Y+U9jZuJpUuS9LE=;
        b=BAdKgl8QROjP6mSvgnNveuy5V2eJkyx1mGXcNZAWFTWfymm5lMC6XYKzplH+t3dLsc
         Kze8zBWDlt7v8cDJbmB326v2yaN99QCqtG5v1fptx77f4nxlog2DYD+k84vrSFZgmfFm
         eodVyfrD0jHhP0E7DqlKqyQ/1MFjKoIoTnJwoJKIXwy6g3HpmFCF/td1FJVRs9tfRXQS
         iXwMGSQynT9yMdWm3PIRoWnnll6W5R+bAk5TmGYpSVMAGz1DLtai3ZGpI0N4BKlBMe/v
         zs9hBEBB2YRX/s+IAixZ/JYQVuA0+bqtMEyh3d+q8AlGL4uYzEfXzAsPF1bLnN4KMoEk
         0/0A==
X-Gm-Message-State: AOAM530hJe+WEPrxOSzpyPWUQF1vLpIXsU+cnwI2whSzKb2jwXgkSvu7
        4E43/x4cbH7XviW11Cnpg5NXqEGi4irZzX3ginIX6mZn
X-Google-Smtp-Source: ABdhPJy9yQCXKywS8EwtOVvP04IIR9JFZRM8XQhmjfd0gP6cGujNDWrCIt35kXDEzArW1ptKOv33ck22w/4FJFKFqB0=
X-Received: by 2002:a17:906:4406:: with SMTP id x6mr24601523ejo.160.1591126141951;
 Tue, 02 Jun 2020 12:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200602041657.7132-1-chriscool@tuxfamily.org> <20200602190521.32877-1-jonathantanmy@google.com>
In-Reply-To: <20200602190521.32877-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 2 Jun 2020 21:28:50 +0200
Message-ID: <CAP8UFD3gKCh8qkzE--M5ZiJmJmnRzbPJgg=kLW3HxJHMk9x26Q@mail.gmail.com>
Subject: Re: [PATCH] fixup! upload-pack: change multi_ack to an enum
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 2, 2020 at 9:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Thanks for the patch!

> I think enum values should be all-caps, so here is a fixup for that.

It's true that they are often all-caps, but there are a number of
places where some enum values are lower case like:

- apply.h
- dir.c
- pretty.c
...

> I also fixed a spacing issue (2 spaces between "enum" and "{").

Thanks for that.

> Also, maybe replace the first paragraph of the 1st patch:
>
>   As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
>   more thoroughly, let's actually start using some bitfields of
>   that struct, which were previously unused.
>
> with:
>
>   As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
>   more thoroughly, let's actually start using some bitfields of
>   that struct. These bitfields were introduced in 3145ea957d
>   ("upload-pack: introduce fetch server command", 2018-03-15) but were
>   never used.

Yeah, it seems better.

> Other than that, this patch set looks good to me.

Thank you for your review. I am ok to resend a V3 of the part 2 patch
series with all these changes. If having all-caps enum values is not
required though, I wonder if it's worth resending everything.
