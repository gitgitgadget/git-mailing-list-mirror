Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B0DC433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 04:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiDEEFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiDEEFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 00:05:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E55B15714
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 21:03:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so13373731edu.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B5VD/08KZTK5TK4Zj45fyxWMfFvh87B42pg6stbPTs=;
        b=vjvW72rdHQFzzfQva/ceWYIG0vuvw+c7Z93LIX27XaaM3B7Sjnc5l1IISutWN7vU9w
         QVdcopyShbLve5CudFtQwabsQfqwma2OhdBp43w7vCka8HrGHbzPWhftNGUeMBws9Td7
         BZH8iF+3O3okALmhjbjryFgYqrarigywgVrjqTc8uzfiWGbiYjy0J3u3Nxo69PJDzt5o
         PMUuy5DQQ66KZ4kNjS1BmFssOzHBxe72jzc6fsPgBztu2yZg0AJhIP0BTilTkEWCiT23
         AVPx0faU0BcdIqtQ7qKS6d1UCRmho0o9+HK2nqzSjwDI9+CQaPFFZ7CTxY1LASiVSs5g
         zROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B5VD/08KZTK5TK4Zj45fyxWMfFvh87B42pg6stbPTs=;
        b=15y2wWCrq3Um2DTWmO5GSGD4ZfC9gvTmrWWzgCYKos60K06ilWModG6k0QpLHS09Je
         mfzYTzr0LPVRsAwOhnLBMCMyarm1qX1kffFm/nbV+xaHgBhm3v8LutYHLbWXpkNjbmHK
         /+ZlFEHHUJ37e1vfJmJlL8zkiHKuUOuCRC5odsRl1kG9JeJMa1yu/Oer9s05Xi194um7
         L07cq/idM+BkGpVmjRucn9LVo7VFGOK09W8gsBvAASuMh8Ddmenz8Xg55urpO6HGhBA0
         FbhyvPvluC05JOxxxqCyYpw3FQ9EsFDrNhSDr0Vya4X8a6evP2x5axGEBvMHIPqLt5wP
         BE3g==
X-Gm-Message-State: AOAM533Ev4ZMugBn8tamibMHlUd2ByM949GyMRVxLGDRedoJ4wgmWEmH
        wWx1RqBoujT6kIpU0kBUYRxRSjuKVC7l2KTieRPuVw==
X-Google-Smtp-Source: ABdhPJym/YFbObNcJ5YSMMFyFPPfABWWpmkv7Ji5fpBA7Vc958pRA5G6hXOOMq7VNyjk5o1xllMJMHa5G0nZdA0SXyc=
X-Received: by 2002:a05:6402:358c:b0:419:809b:93cd with SMTP id
 y12-20020a056402358c00b00419809b93cdmr1471103edc.387.1649131398026; Mon, 04
 Apr 2022 21:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220404055151.160184-1-alexhenrie24@gmail.com>
 <CAPMMpohXLG2BsO2N1He9aBxm_VuQGCtf32AC67jVkuHQnwVw8A@mail.gmail.com> <CAMMLpeRQm=PwvmvEWy387oFsjQXNgPnbgqSnre8Hz7iLJxPM_g@mail.gmail.com>
In-Reply-To: <CAMMLpeRQm=PwvmvEWy387oFsjQXNgPnbgqSnre8Hz7iLJxPM_g@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Apr 2022 06:03:05 +0200
Message-ID: <CAPMMpojFg7x7O3YRSDkKa31eM4U-fbKSPA9he6XXG+TQngwtVg@mail.gmail.com>
Subject: Re: [PATCH] convert: clarify line ending conversion warning
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 7:23 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Mon, Apr 4, 2022 at 9:22 AM Tao Klerks <tao@klerks.biz> wrote:
> >
> > I think we could do slightly better than "the next time you check it
> > out", however, in terms of clarity.
>
> I would prefer a short message to a long-winded one. How about "the
> next time Git touches it"?
>
> -Alex

Works for me!
