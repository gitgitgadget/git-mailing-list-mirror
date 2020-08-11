Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70066C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 14:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F94820756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 14:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="UL8yvcPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHKO1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHKO1U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 10:27:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0CC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 07:27:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i80so6750576lfi.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlOSpVshPgRreZT561BVJcNqWMiu62S1SwGjACVin5c=;
        b=UL8yvcPFEuZzqBAufPt9mxewCQyPNkuJNaY98v+9keqJsPlXn7hbdRl3Iy1f2iWfx4
         JWN7F3sxoh9QL4LzeXQ2/PCKy3kBb65DNhnBRJJQVaSjfmIYPW2bEc/rCRIypzK8JDRg
         BTa7xLfcWQzcDpApM7G6C7W8iBdvFrVJtB/Lau81EtB4NbRpr/NvCwNsAhFkArtrHg/y
         y9zuLyz5Hy7qVYCbq3tMDCBM+7TwAU/dXUrmWGU9DRvLulKTA5dCHVhdASgg7QoYqGNy
         odah0RkOO+8jDNrxJQVr4Ihny3rqLU0rm9rDfh/pj3ZdVU1RdVbf7WHjOhRb6z7vzgpn
         WUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlOSpVshPgRreZT561BVJcNqWMiu62S1SwGjACVin5c=;
        b=FhdYmYpbyXvOWPqe6TPcKF5Qup3FhaKHfDHb88lEr8jOzhzFgBqgFiDTweEGuG4mbI
         emVQIpJQ/1B/2hFzwSaBtuXhUKu150eM4nzuZlK0DUoTRQsZ46+Zo2mzPPrNKYrNRYLI
         GtGCrpVE1t/GpDJRu65P3XlHTCwfJ7BuMhILy8KMGWFsNE1LdkGvgG2AueG6ecunA+OT
         C/RTmLGnDvINjfl5uMUrp3pAxTJ+KtFt2eHUWGk2lVuAmn5ciu2n7Imk/XdsfxwJH7m8
         xpMP2omS64t5eRRjVUEbJzez54rqBcuh3CEas8fqbOOQ6KuFHWSY0Mnsj3mGNqA/Kg62
         Zx6g==
X-Gm-Message-State: AOAM533ADYblojk7ifO6Nx13d1kTZtIkTQb72U/3Kr8COHze13uhrv8P
        vzh2gcGQxgdS69vp8KdUJyS55nOAFlgR3U7yZA1ZhA==
X-Google-Smtp-Source: ABdhPJxFWuvTnHySy2ddm1OLaGcECKz8joOO+hY1yhA8O4fjY452Iy66TECqsTxHD4h7hqJby9wIoKnDGiwCkHbZqWo=
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr3378992lfo.125.1597156036607;
 Tue, 11 Aug 2020 07:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgcub811.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 11 Aug 2020 11:27:04 -0300
Message-ID: <CAHd-oW7Wd8oSaMhPFeRcEeKTJ-k_hC7b6e28efhXT5LFu1E_Uw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Mon, Aug 10, 2020 at 4:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
>  - hex: make hash_to_hex_algop() and friends thread-safe
>  - compat/win32/pthread: add pthread_once()
>
>  hash_to_hex() used a set of rotating static buffers, which was not
>  safe to use in a threaded environment.  This has been made safer by
>  using thread-local storage.
>
>  Expecting a reroll.
>  cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>

I think we can drop this one. Dscho suggested using a different
approach for this conversion, with Coccinelle [1]. I won't be able to
look at it right now, but if someone wants to give it a try, [2] would
be a good starting point.

[1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet/
[2]: https://lore.kernel.org/git/a35a9334-6db2-d8e3-8ce5-15f15a9005e1@web.de/
