Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B04C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88AB6109F
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhDPXRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhDPXRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 19:17:40 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50526C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:17:14 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id y23-20020a4ade170000b02901e6250b3be6so3993142oot.5
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l699PfPdm78ue8xz67S+wiveYF6/QDa1dju/DwQaiGs=;
        b=G3XRQmUoJsR+rOkPMbWq8zcAST+7nPgmpKToxAMCRZmSjelpwg7msK/6wWHXU4JigI
         wkMCrO/G8U8oZxUw0sa3KgiXLWh2aSkdJaS3Q2EBW+7v8BqDbXvhMqH4Zq3zU7rLEFd+
         /bYQFG7rs5cpi46rbYPsX7dBingCFqp0etZsRTnif1+0Mt2xzulcR5/hcjwcvRDWAw2R
         DUamOcYqnNX1MjfRCET7C6oZ3JzLFZRCOHAQDbTU8dyIaFoCN/zZV2bvl4MIhPilWX7a
         4HgXpJFyebbnP/fzsyIK2PHy4HPosAghRQqQovNCVfujoTsXa/jYxE2rylVtLGlSzjw2
         /EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l699PfPdm78ue8xz67S+wiveYF6/QDa1dju/DwQaiGs=;
        b=KtGH6F8JRz45VUYEJ3s6HREQkhlqI/ssJf0dm97gojlQ4BPCBKZZFd/+FWPXodiwdL
         ge10owOQxwGiTQ3rMfiC3BFzJbcr9CHJcDY+wGw8fsllrqc7lWXXiInd0Q/syreRnVFh
         rG+rL6UcqYPCgwBsJGEh68c80+KLNgxVixk0vXM7VFAS3rkqOzs01lR+Qwz3YHSpU84u
         u8TA3M18GIK+Mt07TT1JPNl7HBoWsrWsD61tv1esxmPHuhaihTm5e9JMEiQT9LmelTjh
         si5JnxfZrg9JlO6gopwLdiwl+hyI68K96u60UxGvFNzlx9CLAe9yzpK8Pv6qzVcWgbSG
         F+VQ==
X-Gm-Message-State: AOAM533Vds9QCLPu7XNJlU2oKh5AMmXwl/NlwB9E0fyIxuC/wAyoY46Y
        Sm1kZciR6yG01ZyWBQ7YwmBuw0IM1/Fuk3ah6QPRsCVi
X-Google-Smtp-Source: ABdhPJw59mMUHnY8NtFBQuRO1V9+yJTZUC2btSITT1QOMYDOVrMnZAzxC/x/qLe10T4UpAX2gbc5Dyhq8YfDxQdFFzY=
X-Received: by 2002:a4a:d685:: with SMTP id i5mr5033629oot.32.1618615033727;
 Fri, 16 Apr 2021 16:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <cover.1617914011.git.matheus.bernardino@usp.br> <xmqqzgxxkj8v.fsf@gitster.g>
In-Reply-To: <xmqqzgxxkj8v.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Apr 2021 16:17:02 -0700
Message-ID: <CABPp-BE=KfQTj0ad3uBS90MA1EDkHFV8kXi7xbEMDcnoi-MiOg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] add/rm: honor sparse checkout and warn on sparse paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 2:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
> > when asked to update sparse entries.
>
> OK, has the back-and-forth concluded and this is now ready to be
> merged down to 'next'?

Yes, let's merge it.
