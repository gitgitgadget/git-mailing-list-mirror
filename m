Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626D8C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E164E2A
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhBJAL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbhBJABk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 19:01:40 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B8C061788
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 16:00:04 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b16so452433lji.13
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCrYx6VRVgxVSpml3iVm4ZJGbIyYMBLgXC3S0K4lV28=;
        b=YU7kftDz99EvKq5uSPuAUBmIChB+G84B+GSPvYzWB0GY2AUZ3UbWUP8lIBN9RS4yHU
         nVZYhNT1Bx7r+FgxxrQcBBJGIKm2tARh63Z2ijKqtGnbAMq/h2dVe40bIE1gPyRmo8X7
         eTDLmFeLNDj+Cv8Bm4y4QEYnwlcoV738t41tKfmkt3RsSlmLrna74mfq1MGv+zvL3JOa
         ZmgeUaRkhGusxKdlLbMjw3PsXSIE7mUhftPyVs1VVw3omgiamrcbiP5jQ9ELzhYzGDGc
         ISBBSpAJvOQIgFoIv1uJ58bq4gsmnWydyrzo3Op6KniTC/2zTEiqmgbNQzg19bTN9KAT
         AtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCrYx6VRVgxVSpml3iVm4ZJGbIyYMBLgXC3S0K4lV28=;
        b=hhh7Z6xtVYSS+jf5JGk79scr7w8abpdy/lkWN57okxmPRRYXVnEXs8HpBHgAhQzhQG
         Nf9CF9F+3wCf0B9dn7ce/faphrXUN3mV2CxRvsZgkfTGs485UUjNQvqj5H8fB/j4Uc+q
         pbK7KtO6hsGy9s9vYSSLPgPGG5BVR7Woe6+kHo/civcIPMNwdtl5p4+ggGYbX/OPlmZL
         pegdlnnDcgLqyMawirog806m8u7r3+HeCFD3RRT0Z2F7Z2t5q+EiFCn66gpn+ITuMEli
         ydE9YzaA5ENTFJLoW59ialo2NvsPrKUGUV4pO9JEUTbl1x8B6oXgCdZAhXAA4NAfTrRO
         BXbg==
X-Gm-Message-State: AOAM533Ux7m5Chhw3yr6zRTgD78n+O2Fp5482ZEQX6UQMv3aj1g3S9vM
        y82HWQbEoEga/AVdj0HghDR4cVqZ4PJXbBKMrH7e+IDZnp8=
X-Google-Smtp-Source: ABdhPJxmgTknBjK4VJgibHsGDegkAqDrUEY79ly7J06OOzMsl6WLz5r0aCV5VHD9S07N936RCU1V2T+dUfptjtZdLsU=
X-Received: by 2002:a2e:6816:: with SMTP id c22mr215871lja.248.1612915203059;
 Tue, 09 Feb 2021 16:00:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612812581.git.matheus.bernardino@usp.br>
 <d52bcad326ece6be2fcf87ca6b72e4ce8212e31f.1612812581.git.matheus.bernardino@usp.br>
 <xmqqr1lpyls8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1lpyls8.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 9 Feb 2021 20:59:51 -0300
Message-ID: <CAHd-oW6CopkLyJTCErx9AYMw5YuhpUYhc7N4BH4sJKvy-7rvdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] write_entry(): fix misuses of `path` in error messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > The variables `path` and `ce->name`, at write_entry(), usually have the
> > same contents, but that's not the case when using a checkout prefix or
> > writing to a tempfile. (In fact, `path` will be either empty or dirty
> > when writing to a tempfile.) Therefore, these variables cannot be used
> > interchangeably. In this sense, fix wrong uses of `path` in error
> > messages where it should really be `ce->name`. (There doesn't seem to be
> > any misuse in the other way around.)
>
> Sounds reasonable.  Don't we want to protect this fix with tests?

Yeah, good idea. I will add a couple tests to check the error message
on missing blobs and when trying to write a submodule to a tempfile.
This should cover 3 out of the 4 error() calls changed in this patch.
(The last one would be when ce->mode is unknown. I'm not sure if/how I
can trigger that case.)
