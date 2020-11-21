Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB2C63777
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89FB221EB
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdaAGcqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgKUUwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUws (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 15:52:48 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF90C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 12:52:48 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y73so7020192vsc.5
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 12:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kJOILQ2546MQYt1uxxMLolDOlYjbPAoQSF+WGqodusA=;
        b=bdaAGcqmbIxaR4IvRH8CiwYt6slGyOkYlRORnHiArPDA6rrPEF7wW0Fjpa//ec8MOp
         G5Z96pwNEKHttKZB5oo2TZ0c3knKmD65aNekUwHgZ9Ia8xW8xiEZuKmzGTVgaz73B3n2
         tdIPQ0GoNQ0SdcsV9/4l/JlL3xoStP28lWvJtI2dVzC2vgzV01gy916YoC0vk3fRSlNQ
         UzrCZro/9Q2WM7o1QBwNHR02AMxi5nrVKLybrFWnjJdX/58OURaObiwRA9/AgSS1uh0i
         gzzrl6rJPCyi8JLMug0YlZ5rsu9ZVo49lCxWhRkgVs+/YxpGMF6KndaoE7nlpXP7Jz9N
         bekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJOILQ2546MQYt1uxxMLolDOlYjbPAoQSF+WGqodusA=;
        b=Ls7FTGUCWTZurCJQxqFqUlRBQ5DvCFh7KxuxKEEgDLThEqfMJEr7oIllBB8QiEft/T
         FyobsD/pVrBD5W7rLjVq/uWEUX+s/rJ/sxcE8T3elMxHz7t66fuERU1UrDpRy7WJzSwE
         C9dco7Vp+2e4P2dMLASiWc3/F2dow5QpLqVz7CKoUuRjTsteuWottoB3aEhdralLNubG
         VOqxHAjoedx1xBDzFm2tUmOuSbq/XstoADyeQqLXsQyxQ5tNaYzrJw3Qt9YNc9+GVlsq
         QdRkifLpP9MSwbMBD75IeCIsF3afeQb2DZLaLmdgZWB3n4Hn+iyXViDTj7cVIl6jJWaK
         xJEw==
X-Gm-Message-State: AOAM533Lu92rzYKdqqm+TY4A4HjvM13Mfv6+4csqSNv7qoFwsub6h+rQ
        pWRY/yzUwvhFArkbIkzCXd1AWE2BdQWFdemoAcvh/vU6yA0oJQ==
X-Google-Smtp-Source: ABdhPJywc8q1bHHJfRLMFiFbuX+j1hgBMXCdy6tRt9A5rWx2eSdk5Dxl40eG0x9TqsyluVcAbHg6aZ5Lhg77Hqt5r54=
X-Received: by 2002:a05:6102:22fb:: with SMTP id b27mr17073804vsh.49.1605991966335;
 Sat, 21 Nov 2020 12:52:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605972564.git.martin.agren@gmail.com> <d6e43bc540bc682bb46d54e579a7101d0d2c462d.1605972564.git.martin.agren@gmail.com>
 <20201121202310.GA972561@coredump.intra.peff.net>
In-Reply-To: <20201121202310.GA972561@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 21 Nov 2020 21:52:33 +0100
Message-ID: <CAN0heSpNYpCGqgaa9LABG1T1LRa9jbGxvUucSSvrJG9ztHpXOg@mail.gmail.com>
Subject: Re: [PATCH 3/4] grep: simplify color setup
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Nov 2020 at 21:23, Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 21, 2020 at 07:31:09PM +0100, Martin =C3=85gren wrote:
>> >  Cc-ing Peff, who initially introduced this helper. After having inlin=
ed
> >  the function into the for loop, it seemed better to just copy the whol=
e
> >  array. Happy to hear arguments against.
>
> No, this is way better than the existing code. I introduced it to get
> away from strcpy(), but this is better still. But...
>
> >  Come to think of it, I suppose we could copy the whole struct and not
> >  just the color array. Hmmm...
>
> Yes, this seems even better. If our goal is just to start our new
> grep_opt the same as grep_defaults, then a single-line struct copy
> (whether through assignment or memcpy) is even clearer and more
> maintainable.

Ok, thanks for the encouraging words. I couldn't keep myself from
thinking that we're doing this for some weird ... performance reason?
Thanks for taking me out of that thought.

I'll hold off for a while in case there's more feedback, then look into
replacing this patch with a more aggressive copy of the whole struct.

Martin
