Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E875AC4361B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 08:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE26B230FB
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 08:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLFIyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 03:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFIyg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 03:54:36 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04CC0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 00:53:55 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so10394712edx.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzo8aYa9GkW4tj7fHmTomD/4cFd8V7m9K3TKd141TYg=;
        b=g4HVFe16la8k7CD3vxyr3NENpER/5V9Hf5106WU9hZCm06/ryXnMmk3QFQTcGS1vpS
         QdHW9/hFNLLj/igLiBmM1Sh9VuwRFhrXwfKkmoH/ogi2h6ImhnFa0S3funZeHiYJRW13
         5LEVgnf5K1yjlmKpE05VBZmU/0kHhV2kMQM5lPZzLr7vpfmXZqiCO/ytQNUmqy0ZJGS+
         xNtw+rrKykMY9GMB9n7AbGmjoXIiqOUEjdrJILOQbU0wOgjR4BodWqTOxEJ2OkhFryvC
         qu0K3SLWLNya4TwPJhORqXwmvRkMliNGXNPihZ0ffXPc3Gzt04zervCQxmng4nT/jJLZ
         z8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzo8aYa9GkW4tj7fHmTomD/4cFd8V7m9K3TKd141TYg=;
        b=WniRI0gSC2hw9XgQuhr9dVDLoZZLsH0oxA1SMotOrq9TUiup4QcoQdaUWAvgeSCX4y
         YDo7TJ7Ha3Dc1aeHmQe2BbAQqb+8IUJ7iYY1Wrfv3RI7ShM7VtbmS0Ryd+5cZnobMaUc
         iw/KIcTpTreg9HJUX7rF6cEt3FCZkLoqyxRzTn950qXqyOYi7JXav9OvIRqH7D8ZuXCd
         v5TfQ4vJaCGA7zXwBPdpXp1woW2fpunnJj+OkKWt2s6lgoTY6tKJlQ2UQvwoCT6x8nyc
         KdzWveDoIVoR46qKKZNIvPb1jjNzwfpRbPdoHwBEwzxMQ1Dno1Cf4sfnz8khY6rcYYeY
         L9Tw==
X-Gm-Message-State: AOAM532U6I79iZTM9g3Nzcpu9rfE+uU6AdGhfWeV9Hp309iF2VjXZq5f
        y7EFJIz17t90JDDZKENZaMnAwmdJsukqWGO30Bk=
X-Google-Smtp-Source: ABdhPJw5Uym2gkKHQ0hRAY8bSixiPEKxDmQM/TqEzQGUrCttC30LvViGQMlTPKQvqoidJKJaqTaNWCRjdQq+MRYvEM4=
X-Received: by 2002:a50:af65:: with SMTP id g92mr15030797edd.273.1607244834264;
 Sun, 06 Dec 2020 00:53:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <a0479d02ffedccb65a167463228445a6d62c9f96.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <a0479d02ffedccb65a167463228445a6d62c9f96.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 6 Dec 2020 09:53:42 +0100
Message-ID: <CAP8UFD1w7Sgh5KYApHy034mRA7Ls47Wb9kcecyeQM6vYcH-acA@mail.gmail.com>
Subject: Re: [PATCH v4 07/19] entry: extract cache_entry update from write_entry()
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This code will be used by the parallel checkout functions, outside
> entry.c, so extract it to a public function.

Maybe the title could be a bit more explicit like: "entry: extract
update_ce_after_write() from write_entry()"

And: s/This code/This new function/

> @@ -371,15 +383,10 @@ static int write_entry(struct cache_entry *ce,
>
>  finish:
>         if (state->refresh_cache) {

Here we check state->refresh_cache ...

> -               assert(state->istate);
> -               if (!fstat_done)
> -                       if (lstat(ce->name, &st) < 0)
> -                               return error_errno("unable to stat just-written file %s",
> -                                                  ce->name);
> -               fill_stat_cache_info(state->istate, ce, &st);
> -               ce->ce_flags |= CE_UPDATE_IN_BASE;
> -               mark_fsmonitor_invalid(state->istate, ce);
> -               state->istate->cache_changed |= CE_ENTRY_CHANGED;
> +               if (!fstat_done && lstat(ce->name, &st) < 0)
> +                       return error_errno("unable to stat just-written file %s",
> +                                          ce->name);
> +               update_ce_after_write(state, ce , &st);

... and inside update_ce_after_write() we check state->refresh_cache
again. So the check is now done twice.

Not a big issue though.
