Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE92C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1181B20775
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 08:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iknwgo9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgFZIWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFZIWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 04:22:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5FC08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 01:22:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so6241032edr.9
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9HnItG0olWvRbX5HSYHw5ALVAjl43NQ2m47xloLLIk=;
        b=iknwgo9BxjcSe589xrACQLCGYKgM8ZUzePzgq9dZ3a+W8jSg1TY1orwMqGV+HxJxZC
         pVaaAMANjCvwyk6ev44CheV8x69HXopVZvVcVfCDwngW/8Sn13UAS0Tpih6dtORLfLEN
         /bdFVUD+O7Fdl8AbTmIU352A+lnlswKE7016Tc15rokQJoBOU2jA7qThbDFe5OzDEHrH
         vS0QTMUyDlh6+yfPAHI+CK0X8QjvjiG+p6ddAauc/xzuLceMtd/U6FVlB9+ZbTIqQd8p
         +woyZ6WKs02rIcF/cwvXS+F6oI6li7Y9lyUoAC+AMiKM+Fehw5i+z/ZPc9IAQPg/V8Jq
         8F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9HnItG0olWvRbX5HSYHw5ALVAjl43NQ2m47xloLLIk=;
        b=ogYde3ZYzr5LAAV3EgRGzyAtDBuXTvEI2dTRXrVkFzABh2l/C8M9aoIPzwqOL+dPgl
         lRrwttXgLM4KpbnouQPN880wcOBuhnZn+S8odwx05S7A6ROpFBZ/ZMaqlfvenczskdV2
         6a6M3OqxolsVxBYyyMGBHH59UXXi2MEdJqzS8h0UbppdAfCjZy3Sk1sHT6g5RRwUqXu1
         AA6nNFXC/tQ+gqnko8z5DMWytayfwCJwHIAfXp7GRvP+xnNC4qQRDgivvXA3OaquHxgR
         KdUIJuq3CjcMF4Az6/0mMkiwqXHmFf6oNqdyarbp1pmnNiZVCpF1UQESFGgOuFJweIJV
         /dRg==
X-Gm-Message-State: AOAM533/i1intdive0rhJMaWaEp0mwBZ0cX+5BPSLUwtDRBxee7YkV0P
        enMZFlaANNd/VXQ0wAEnDc1EQZW20SAlMOfBjUA=
X-Google-Smtp-Source: ABdhPJzSZxRl6ccHVn7sfKuWV8aim1paiK4Il2tpF91U72PB0KKu1JmfZhz4ngxAgXNFiIBvYVeUSrI0PtMZyfFz4YQ=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr2119593edw.127.1593159772662;
 Fri, 26 Jun 2020 01:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200625013851.GA9782@camp.crustytoothpaste.net> <cover.1593115455.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1593115455.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 26 Jun 2020 10:22:41 +0200
Message-ID: <CAP8UFD0oWuoYLwgYLbkSvDjV1Ymedd_E2j8iv3QGGitgRVq6=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make oid_to_hex() thread-safe
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

On Fri, Jun 26, 2020 at 1:35 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Some thread-unsafe functions of our codebase appear very down in the
> call stack, which can be hard to notice (or avoid). Thus they are
> sometimes used in threaded code unsafely. In this series we add
> pthread_once() to compat/win32/ and use it in conjunction with
> pthread_key to make a subset of the said functions thread-safe.

Great!

> As a next step, I would love to make [warning|error|die]_errno()
> thread-safe as well. strerror() is not safe on *nix, and there are some
> thread functions today that call these (although the actual risk of a
> race condition must be very small...)
>
> My idea was to implement a xstrerror() wrapper which calls the
> appropriate thread-safe function (dependant on the OS),

Yeah, that works if there are appropriate thread-safe functions for
all the OS we are interested in, or if we can fallback to strerror()
or calling it holding a lock.

> or even call
> strerror() itself but holding a lock to copy the result for a local
> buffer (which should be OK as we don't expect contention in strerror).

I agree that it should be ok.

> We could also set a thread local buffer array, as in the second patch of
> this series, to excuse callers from allocating/freeing memory.

I don't think caller allocating/freeing memory for error strings is a
performance or code simplification issue.

> One concern with this idea is the risk of an infinite recursion if
> xstrerror() or any of its childs call [warning|error|die]_errno().
> However, if we are only using strerror() and pthread_*() within the
> wrapper, there should be no problem, right?

Yeah, I agree.

> Has anyone thought of
> other problems with this approach?
>
> Finally, should such change also come with a coccinelle patch to replace
> usages of strerror() with xstrerror()? Or better not, as the change
> would be too big?

I would agree that it's better to avoid too big changes. I am not sure
how much we want to automate and check that though.

Thanks,
Christian.
