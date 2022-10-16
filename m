Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38580C4332F
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJPUHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJPUHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 16:07:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9532D81
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 13:07:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so20712339ejb.13
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdj8vTftR8P+JaRklmNxz5H37sQMdFoYxBN39EKBWvE=;
        b=VYPmHOlezd0vEP/pmi64HYPuqEN7KTkz9iLb5HuB+tZH1zYkSUUfTPT7RGUXrtk2Xy
         rALUamft9mRRWUgVAEpMNiLMD8EeJmwpscxvcV5exybjcv3OgdFgNrcjSK/GNyyKvsLo
         78p6s4iMiAbAICG2rpPrCVgeXfIsTm3Zi1AOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wdj8vTftR8P+JaRklmNxz5H37sQMdFoYxBN39EKBWvE=;
        b=EdgbqJc07K4Hw/kYgYiBh5/y4slIGjiF4bhD+8XSci1n8Q9dugJGf00mV6QLLsXpMq
         YLGqKfeT7NL49Lfa5o7INJ9pcE9UI2ITmJHY/OjCaTLBnrVpTgDGKtwnkAGtwutb30MQ
         yeXjypUKV8HaoQBcLB1kmUxFln3Fe4/qnIxIGN4BwYCufFR99rbmF/316TuTu18cHGUO
         IQEsGbOQSKJa9ay9kp9Z8q4ISFnD3oJXnxaeHRSZ0lFAf2ggx58BVueNDmTd95yQQ2rD
         JSHvFnBMvp92YiRsnFV+FdYRQ0ro2t3d5Tfhtd9WnjiR8Dg/W4oH9iRCLC2TngOFeiDW
         ovIA==
X-Gm-Message-State: ACrzQf0HVG675OX1+CjF4M2i2VzMZHoEEuxmb39sy+Z/OObA0nm+tiIv
        rrui40pcYagSccX1hJZeXVuEJiFYNtlevQIy7V6X4ZmMD9Z0Hi/J
X-Google-Smtp-Source: AMsMyM7YRe9RvsuqtewR6uX/aL2BQGW5CYomNbOiJiIJYrISCQ9d1lDZCrwmU5v/lVj8GuGgSUo1z5zr0oKKW9Cg/kA=
X-Received: by 2002:a17:906:7952:b0:787:a14d:65a7 with SMTP id
 l18-20020a170906795200b00787a14d65a7mr6369327ejo.108.1665950868168; Sun, 16
 Oct 2022 13:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
 <xmqqedvbcrnn.fsf@gitster.g> <CAPMMpoigKVzhXu1WqSrx13MP1jR0J+ajkwRVVtY_LwHYAoWeTg@mail.gmail.com>
 <xmqqsfjqbwil.fsf@gitster.g> <CAPMMpoiwnLyqzBBubkgSpjyJQqSeEVdoZy72FAwGDbMgg9UXxg@mail.gmail.com>
 <xmqqilkmbelx.fsf@gitster.g>
In-Reply-To: <xmqqilkmbelx.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 16 Oct 2022 22:07:38 +0200
Message-ID: <CAPMMpohBOk2eQMbMxJhjr7cezrhMxVfaS--Aq8jJ1e-LQbEjrw@mail.gmail.com>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > My understanding, from ad-hoc testing, is that using OPT_BOOL causes
> > the target variable ("use_gui_tool" in this case) to *always* be set
> > to either "1" or "0", regardless of whether the user sets the main
> > flag, the --no form of the flag, or sets nothing at all.
>
> You are saying "git gc --keep-largest-pack" is broken ;-)

Now that I look at that, that does appear to have been implied by what
I was saying, yes!

>
> OPT_BOOL() and OPT_BOOL_F() are OPT_SET_INT() in disguise and there
> is no "set to this default value if no command line option is given"
> involved.  At least I do not recall allowing such a code in.
>

I can confirm that it works the way you expected. I was sure I had
experienced such behavior during my early attempts at tristate
handling here, but in retrospect I was very much mistaken, not only
because --keep-largest-pack is not broken, but also because I just
ripped out all the arg-parsing function and enum stuff, and it all
works fine with -1, 0 and 1 as you pointed out it should. I don't know
exactly how I messed up my early testing, but I don't suppose it
matters.

Substantial simplification in the next update.

Thanks!
