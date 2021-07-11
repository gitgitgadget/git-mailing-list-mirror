Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF8C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82659611BF
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhGKIAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGKIAo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 04:00:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D76C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 00:57:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h19so6228946ljl.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 00:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YA3OsPXtuCleOYn6eSPQWzfUinzScGy58lCNcz0vByM=;
        b=URN5HSNBvn9cUBRV7GyyJn8o0NzW4bhmVfpqdM+D7abj3UuIM1T0QTSxa/uM0N2J2E
         2QFZTzNRxE9buk9sSIieVbZk3QYUDz7uBQSFGRGOvi0xuYIF/aiQz32hbKHMS1ifKvSf
         nLXYX7IYOcrWbURrFJYZ6xhxN8wQGElF237yFnkAK74YwN7RqtP+h4We4QzvtptRZJTm
         RxBtmFiml/1dOGB+pW7apYaDU2CthsuNPog2WSpUxGGwAwYDrKuhpNiCkNCaYhzL5XBn
         StOngs2edj4AZ0gJ8Mc83h6TzLF1/hVN2PqGuZjDDG0VaWIkgsg91xs7mL1UG8ooN2c4
         JNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=YA3OsPXtuCleOYn6eSPQWzfUinzScGy58lCNcz0vByM=;
        b=HoQ9TJswect9u2UnIVCWOAj0PFRgbXOiGnUh7tLMfaH/uUWoJ5emErpv55AqtjVlkM
         ecOlm0vcaOtv/WuSVrL1/SyOosLSjWelDBP/ZU7KsGGKpsagaAISX49VvTo3f2H2Gq+m
         rGG8EnrcPBMuIbAG4uROA4VNT8NVhYp1isYBeb4nI/6KFxCRhdr1c3vCTm4xHhCrMpn/
         /uF/hx9AWaUTq2L8TT9EBbNnHx54MBFL1MyDftmoC6iGbsBLzxf9Gr4DGHD8NqLa6JwR
         c5MRORM4HZbpDjeUNv9GQXUz2V2lK3PhYaWcZIOEJV1rLzRNmT2uzNnkivntEKzja1Cw
         7hZg==
X-Gm-Message-State: AOAM530GEXh3+OMPdh9dGvKev2mmV2fPGSkmxcZL24D7H5L217FkQLnw
        P3LTCxuC7Cba9FubpeKyNUSMrRJ6Sbk=
X-Google-Smtp-Source: ABdhPJwi/t789PzA5gISdytZpVrR/8ltBWu4j1M103/YYy32MjNezzCzKOZ+LhJFBQhuJeKpxIE4pw==
X-Received: by 2002:a2e:7f0c:: with SMTP id a12mr10515730ljd.378.1625990275728;
        Sun, 11 Jul 2021 00:57:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f1sm296735ljj.39.2021.07.11.00.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 00:57:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <60e88a4b8592f_16bcb2082b@natae.notmuch>
        <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
        <60e9f8d462bd9_7ef20898@natae.notmuch>
        <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
        <60ea07e3495e8_7ef2081d@natae.notmuch>
        <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
Date:   Sun, 11 Jul 2021 10:57:54 +0300
In-Reply-To: <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de> (Martin's
        message of "Sun, 11 Jul 2021 00:13:38 +0200")
Message-ID: <878s2dgu4d.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:


[...]

> Currently only the branch is mentioned.
> Currently nothing does explicitly say that *commits* can be affected.

Commits cannot be immediately affected. One of the most essential
features of Git is that commits could only be affected (deleted) by
garbage collection. That's what makes Git so nicely safe in operation.

It'd be unfortunate to have statements in the manual pages that
contradict this.

Thanks,
-- 
Sergey Organov
