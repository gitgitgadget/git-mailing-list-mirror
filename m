Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9184C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942F064DA8
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBSS1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBSS1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 13:27:35 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DF3C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:26:55 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y21so1452896oou.13
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIxwvWo1JWjjEDsjyPoDlmL1UfUl+vIr+24bTpa2eoM=;
        b=GVSyjz5mph4ogAzaWnvTuFEymQ52/Lz1JtvORh1eGEiMSgMR3kIe+gMEjhuohVRvO3
         VH8jVDH6FNZaI4TGMCVcY1xfXTX/ARmgQIUrV2NXTLENvFL7NrgKGjXjGutxAWb/Bjnf
         MfLu1dWM6OmG6dumzu2Qtd82M0jt+W49i20Q0WFmBacg8Mhf+fmXBTfo38r2XtPi2YzB
         mcJ1ULLGyMNm5/zYWKdO8c5Nf2aiofN7qO1SM5QPAJbIbR6KK8lx73TJBkA31AtEtBaW
         jdYghSsPQfL71sMPkOOGYU1RPYfFhYubqEZnbzko8n5PSUg2GyUBPASO0wJ1gfnbpTwr
         49fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIxwvWo1JWjjEDsjyPoDlmL1UfUl+vIr+24bTpa2eoM=;
        b=BF90SNhIEs/8SSznyhm5TF3ljM+rdgmYE14XSd04G63STkUoETa/z2oT2s3a5iZJlm
         E/SUks13RNYVEib1KaXQQq6HJ5tEVHsqQquIuGLD0YFq33ExKs+Bx00NlbvJAlFsohJb
         8yqsudnjomqiV2+LWS1lALljEg51ppK96STfHzSzEhHUry9nc2lQNzC3TnBKFLc+5v5M
         veGbFWa9da77t76q4+5FEVQTMQWxygwpNNjrRylA4OEi2F1BgrHoOc6v9ebIc4SvMDS6
         V5uj2SwZJnQaj1n5IkBwHm+g6xlxGpLdXCX8iIIILgUm4B3t+pbElMfvRwSLaEdy6cDC
         tMsw==
X-Gm-Message-State: AOAM5315KP+pjTNxmp0sOPS2dZnldqNUvWiTB4MbTXDzmiE+u6pdmZUX
        A395lTvr8UNcudAMbNiRmbnxlKe0/fQEN+UCIYE=
X-Google-Smtp-Source: ABdhPJz5gYQw2e0FGZ/SK2Myjz3l0VXDY7yACKBjjnYCDo0Bx+NfcfEg/AvM4VKdbHdHRg3ATuEBTCUC478UUQDt9FY=
X-Received: by 2002:a4a:424c:: with SMTP id i12mr8021335ooj.85.1613759214316;
 Fri, 19 Feb 2021 10:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
 <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com> <CAOLTT8RAuS5-PgTj4YdvakFV8uA1mfKa-gxBOxnWPcL5Sv0VHg@mail.gmail.com>
In-Reply-To: <CAOLTT8RAuS5-PgTj4YdvakFV8uA1mfKa-gxBOxnWPcL5Sv0VHg@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 19 Feb 2021 23:56:43 +0530
Message-ID: <CA+CkUQ9nK3KyrXTTQifs1eFM-mWiR39Yt_FAbxwfjoiN5CghLg@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Feb 19, 2021 at 10:39 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hi,Hariom verma,
> I am very glad that you can serve as a possible mentor for GSOC this year!

Yeah, possible co-mentor. Thanks :)

> I am very interested in this "Use ref-filter formats in `git cat-file`".
> Where should I start learning? :)

That's great. Maybe you can start by learning:
- What is cat-file?
- How cat-file works?
- What is ref-filter?
- How ref-filter works?
- What logic previous students came up with to unify these?
- How much work has been done?

Note: here at Git, we usually prefer inline replies. So, please avoid
top posting.

Regards,
Hariom.
