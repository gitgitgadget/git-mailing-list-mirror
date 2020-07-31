Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990EC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C8A208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKcAH535"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGaT03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaT03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 15:26:29 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AEC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 12:26:28 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id x19so3916915uap.11
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvBGxZoeDuZjXA9PhXkhVjP+P9OPJs1ox5OrfZsbI1E=;
        b=JKcAH5359GZtIXSt63Y213fWwVYbGr9y3MRlzc8rgEVj41qP/GUDZVKB443uCwSPpC
         YJ03x6kwF+YKEKHwtU4H5RVaW+//YfPUgbJofYaitglAKn0PINPLw0UVIkx0jRBmJ+oa
         rgjleEPteWgoEn8bGDwZU1WTtc4lMHcCTAer5Rqqp1+7FSLNx2/A/EOoX0ayM9USh1Ix
         V6YJtWmCfPoYMkxDwIm8+U+QkOuk9aajbEYYz1/7oVYtP5ndsUr9UOGRKq7JVipWNk7h
         uKDc/OxuGQ+qdpbGXLoHkwLWzDHaY1ULdmIxCcirCgoPUzRp1+36QtN3NSw8bqcDONNy
         /YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvBGxZoeDuZjXA9PhXkhVjP+P9OPJs1ox5OrfZsbI1E=;
        b=O6fUUOAS0fZ499ECNG44wurx5C68Idfzb0huoPG839XTgf91VlTUddHhinObdprlWB
         pwe7pxCttkw0kIJRuSucgPfGnxnrtGBg/xk7T4mjK284v37QXrcX77/a1CpmdtUTCKNa
         GgXUqEF+65gM2Y0HxuVFnyWh3dHyICwvq39Oo3Hg8qPcB9bUUVpcNipRAVLsSRlzm8y9
         aT1c3b/M7lU6eHbdxhETw3v9Z1hsb15w1fjt8Mb2hELY3JGjOmdGZRKGh/X6OTkXYkRF
         NZ/uUZvq5UM71mYmeRkwtWlvRtKewZXpa6n8weWw2zAMiR9lBqzDvkXMApV0WN6B6HK7
         YUaw==
X-Gm-Message-State: AOAM5305KqhgCEuJfHYLr8l2UFM1o1FNxpiTSyYQiMIHPcVV6ihGx2xd
        5UPHPmu8wnYyBxgb1je66oilcF2+5o5Tu9Vwgok=
X-Google-Smtp-Source: ABdhPJwIMH3NUVRJJlhEpkCM38Rh37A2+PCk9UEr2DMZMyh3KILw9v+CRhXCgsWq3SqMe/Wl867o6FYsE1U2YuKp5gA=
X-Received: by 2002:ab0:130b:: with SMTP id g11mr2634232uae.119.1596223587876;
 Fri, 31 Jul 2020 12:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
 <20200731174149.GB843002@coredump.intra.peff.net>
In-Reply-To: <20200731174149.GB843002@coredump.intra.peff.net>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 31 Jul 2020 15:26:16 -0400
Message-ID: <CAOjrSZskJRj+TVV35fEp-Mhd+proVV72rh3vAcVFnNfhRy2ayA@mail.gmail.com>
Subject: Re: Diff --stat for files that differ only in whitespace
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 1:41 PM Jeff King <peff@peff.net> wrote:
>
> This seemed familiar, so I dug up some prior discussion here:
>
>   https://lore.kernel.org/git/1484704915.2096.16.camel@mattmccutchen.net/
>
> We didn't come to a resolution there, but there is a patch to play with,
> and I think nobody was opposed to the notion that with the right
> code change we could be suppressing these whitespace-only stat lines
>
> -Peff


I think for now I'm going to feed --numstat into a script like Junio suggested.
Out of curiosity what would it take to get that patch into git? Is it just a
matter of someone just verifying it and submitting it?

--
Matthew Rogers
