Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A2C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39D222245
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="OKGGw/GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgJ3WjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 18:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJ3WjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 18:39:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ECFC0613D5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 15:39:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j24so10685208ejc.11
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfBgvMBOfHOrnYtKy9FJhnIWlTAUi714cTXXVKuu5KQ=;
        b=OKGGw/GTg3rRw/mdz1QvOfU7chTFFkXiG090xhfueCtzeUw1SKecAaX5a+tszo2hb4
         YVnQRoNzLpn+L8TC7kKVsNR7Dnunvxgp8F36jQcrCQo8YG7qZZWmMvEQnb7aKaY3XY27
         ecQzxcBO9aekFfVeclkRAZq+PnQkx9Kf89W5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfBgvMBOfHOrnYtKy9FJhnIWlTAUi714cTXXVKuu5KQ=;
        b=HdubafkZ++Ha6QpOi/BmYAaK4rJAWg7nWLXS2hfJqT0HAKKkwDX4X55K+M1LmN0PHN
         gEiCE4+c6dSBecXH7uDkK7t9X9hwlqrQrG4FGfYXm4gOw3HtYYmmaNOuj8bWAgJ795qZ
         YFX/Lpf4/FEImRltVAou/k834EDTSRNl6kcALVHyYGjJGT94ITgDktPq4L4DV/KklWYg
         xfLWYXWfnmDRvHbXXMgzn3SdeNzivVN2SKXfRopr/GgeVUPlZNjTg4MRTrszpsQuNWWK
         lUObLlIspchzdsC5IWtE7dCSUqKP4w7p+Qr56EIXmT6L6NP2MWuUcjd6Rcz7SOxEkK2R
         Pv5Q==
X-Gm-Message-State: AOAM532gTS5OZm5M96GYy0NnbggnxN1AWFz4JvqqOFRjfG/C3H6f+PBk
        IqxdnnXgYhN20A8lL12oCwc88Nb57OKTdY6oJDUsdFL+JNQJ7Q==
X-Google-Smtp-Source: ABdhPJwkoaERD+U0VlaY2Tf3tYSdrtg0U0HpRZ4LpvuAUAg3HcAUGeDvpvwyhjNxEmvGS7HFa9fdgTZm7sK5/eO4XRY=
X-Received: by 2002:a17:906:804:: with SMTP id e4mr4592436ejd.420.1604097541657;
 Fri, 30 Oct 2020 15:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
 <1604029402-19593-1-git-send-email-dan@mutual.io> <xmqq7dr7369a.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dr7369a.fsf@gitster.c.googlers.com>
From:   Daniel Duvall <dan@mutual.io>
Date:   Fri, 30 Oct 2020 15:38:50 -0700
Message-ID: <CANo+1gsquxyCSGhkjmtN2AazyuBN8ht_msxyVq4aFVFse-y1CQ@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to haves
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 11:42 AM Junio C Hamano <gitster@pobox.com> wrote:
> I am a bit puzzled why it is sensible to
>
>   (1) unconditionally
>   (2) toggle
>
> the GENTLE bit.

That was pure carelessness on my part in flipping it instead of using
`&= ~`. Fixed in v2
