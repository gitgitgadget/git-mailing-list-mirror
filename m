Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1687C433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 01:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6759D225A9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 01:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL1BDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 20:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgL1BDE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 20:03:04 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3EEC061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 17:02:24 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i6so8028394otr.2
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ArvO5NdqnOEBxahkY9ujew/WZt7s/ujoZBU+8Yl8aKI=;
        b=Nd4mfRpInT9D2UDMnSn9plwBD9OY5LFWFpNux4MWXWuz40aJOlT4lfw5ONLw6iQ/ZS
         3QzcpeyAQPpH5CQn+8kP0ZgpOWg4mtqXxeDAsza6lienKJ4tEPVtOo/lNHb5duLsOrvK
         Cuu5MOlpZf35lpOmrrqg4zWgxdj15ZEX2O+wZHn0UbORtin5/Hq4XNrKWME79scBQD6m
         +ZmUyvvX2ikVpBQ6hbvVxKCQ7XcXDQIir2mJAfEom/YQ7hzdPAqxH7maR0vy9qPBNF/N
         GdMQAwtoNpdclJhksQVKKKp0IE967B4Vcv1i81vbTbiz/8Y7W0l+jqaKPWa1hIlp+S7F
         kdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ArvO5NdqnOEBxahkY9ujew/WZt7s/ujoZBU+8Yl8aKI=;
        b=POBbzt03JzccY+/9XIR7QWUF+/Znd4qxACy1zvoteAZaDygiuiVprY2YfyOtwzyqH/
         iKBJ0cnyltI1ZqLzcXvO39FAEYEs+MaGpA7nqCkyWLGPeEuUgFYMJnpm9CZnonXCvFOT
         BRewR3oqJpBvVuvdo4+dKe0t5qy+dE7JlLQ5NYUdVdXiZBF65/xXi8czZc2QAwPHmUZ5
         XhHeHdVtIYPOb4FUDffYM0/outnVYqMLalQFSi+wrsDO9tBdH7od00mZ90x7XBCbWxX7
         RSH6fwwPKaF+GTmnGAc+lfuTxER77jK5eTvdUKZGXBYc2kfdqL29qyspF3Ql6R5xgbkN
         Z/sA==
X-Gm-Message-State: AOAM530+aawdYOS4j9rOQZ6WMj9rhB+JNAzki13JC3MF7BRxQj8WiADJ
        vn+nAkSLkmNVgWGP70zbdxs=
X-Google-Smtp-Source: ABdhPJyUCyyjzd3TxtM86xKBt+1t8O8STqQWjRqFQyBpPaVTM0LMW5H66KdiD7wzcsL+SByTXCbQew==
X-Received: by 2002:a9d:5f9a:: with SMTP id g26mr32006267oti.241.1609117344014;
        Sun, 27 Dec 2020 17:02:24 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id x1sm4631631ota.32.2020.12.27.17.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 17:02:23 -0800 (PST)
Date:   Sun, 27 Dec 2020 19:02:21 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>, git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <5fe92e9dec09e_10e65208de@natae.notmuch>
In-Reply-To: <20201227205835.502556-1-seth@eseth.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201227205835.502556-1-seth@eseth.com>
Subject: RE: [PATCH v6 0/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> Sorry for the slow turnaround on this. I haven't used Git via email
> patches before now so it took me quite a few hours to read through
> tutorials, configure git-send-email and fight missing Perl libs.

What distribution are you using?

> Changes since v5:

This is not v6 of my patch series; it's v1 of yours, which I think
should have a different title.

What happens when I want to do v6?

Other than that (and the fact that you initially used the wrong version
as a baseline), I'm fine with your approach of doing a patch on top of
mine.

Cheers.

-- 
Felipe Contreras
