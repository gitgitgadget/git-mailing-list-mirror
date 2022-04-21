Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C860C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392164AbiDUUFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392160AbiDUUE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:04:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFDB4A3C7
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:02:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t11so12129791eju.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YvqadXN5yxMd+hEjtacTFDZwnUYm+166zfq/IN1+p4g=;
        b=WOxSRuUew2AYWPvZU3DIYmTJuwYbyZsrNHd0JQIbcakR8MbbEfCjQkUAKi3vHcyUcJ
         YK6mK1DuFWoq6FDt63oxw0p1dwJdq/u+1Lp9GolkajfzQMOq5GiDuESZq2de56i6CJ+S
         YoYsXSs5KL7gErB/cgidETmNXLp8RRCUgZ4MYz/u50e9/xlgyeONR3QBsX7Fj7O8MF/b
         I/RV/BglpHWAXit3ebgfL2p3UBpQWi5ijZLg3TQf0unIPUpHqUT1bf7YB/fCzbLlUfgW
         7nh+jv3tKu7aeNqFVWQpiokldS6UtlwD1OjkGDvuhj/nndPOMujhqCRhUr3rYpLPlCu7
         Ycqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YvqadXN5yxMd+hEjtacTFDZwnUYm+166zfq/IN1+p4g=;
        b=zF9DggBbvFl2VqEjX9j3TNiICONoLFx6KwcwlAslZ9zO2Lwc1u5dRdKm+75d8DsKSR
         ga7cWbD4jo/coBs4ncdNdTf7xa+p84jPtv1dap+QkpGfp0e69Lpv4lDG3sTh3F3G3qqW
         fR/7bhOv3GtKZmEqZhEm83achtq/vA+KFHoAtDn4f1y6WnT5nlq5T8en+3cIV/V6VDvK
         XbZ3wXxkncxI4OuzHUX6Nh3if0+7xP11tQ4mlqSteu4yc5N4LNIJQ0wyABRz54tWPD6D
         d2QrDvWmKkh6TpZqX+yJTaGcUkHVDgnYL9NlZlG/hu+nXuEQK6IhtLMYW/c6zcrgQNQC
         3twA==
X-Gm-Message-State: AOAM533F3/2jqMhJgP0eW+UD7kkhZdfbM805gmWdsX9C0Se+at/Y1SoK
        C0R+PL/G2odxhkjwSf4FPzrbRL0olyA5bw==
X-Google-Smtp-Source: ABdhPJydrXHSoi7quVpqXvL42Ts/WwkrXf+A8RZESnEifwg3w0OLSxjrL/9wE8oevSmLfKKrB2UH6A==
X-Received: by 2002:a17:907:7da3:b0:6f0:d63:69bd with SMTP id oz35-20020a1709077da300b006f00d6369bdmr1017466ejc.289.1650571326652;
        Thu, 21 Apr 2022 13:02:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k22-20020a508ad6000000b00425b0825265sm298edk.38.2022.04.21.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:02:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhd09-008BcN-QQ;
        Thu, 21 Apr 2022 22:02:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org
Subject: Re: Should sendemail.confirm default to always?
Date:   Thu, 21 Apr 2022 21:58:06 +0200
References: <20220421194832.lshqkl3bogy2f2hy@eve>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220421194832.lshqkl3bogy2f2hy@eve>
Message-ID: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Alyssa Ross wrote:

> [[PGP Signed Part:Undecided]]
> I was recently having a conversation with some people used to the
> GitHub-style Pull Request workflow, who told me that they feel scared of
> using git send-email in case they make a mistake and e.g. get the
> recipients wrong, since they can't correct it after sending.  They can
> resend, but if they do that they'll feel like they're bothering some
> very busy people by having sent them the same message twice (regardless
> of whether those people are actually bothered by it, it's scary).
>
> This made me remember feeling that same sense of fear when I used
> git send-email the first few times.  At some point I discovered that I
> could set sendemail.confirm to always, and then git would always prompt
> me before sending a message, and I could review the recipients list,
> edit the message if I wanted to, etc.  After that, I was happy, and
> completely forgot that that wasn't the default behaviour until having
> this conversation.
>
> So I thought it was worth asking, might it be a good idea to change the
> default, and have git always prompt before sending mail unless it's told
> otherwise?  Expert users will be able to figure out how to change this
> default if they don't like it, but novice users won't have bad first
> experiences where they accidentally send out an email before they were
> ready any more.
>
> I don't think this change would cause too much hassle for people
> expecting the current default, because the current default is for git to
> prompt *sometimes*.  So anybody who doesn't like being prompted is
> likely to have already disabled it.
>
> These git users (who are probably in the majority!) are used to having
> edit and delete buttons, so for them the idea of having to get things
> right the first time is scary enough with a preview, let alone without
> one.  I hope you can empathize.

As a regular user of it, I have it set to sendemail.confirm=always. I
can see that (goes and looks) a bit over 10% of it git blame's to me,
and I'd find it too scary to operate without that mode :)

Now, I'd honestly forgotten that wasn't the default mode (I set it many
years ago), but I for one think that setting makes sense.

I think a patch to do that would be worth having/reviewing (hint
hint!). As always the real work is updating docs, running the tests
etc., digging up ML discussions to see if there's been any past
arguments for/against it etc.

In this case the code change itself should be trivial (I honestly didn't
look this time, but really, it's a config default...). So this seems
like a perfect task for someone not too familiar with Git's codebase,
but still interested in contributing :)
