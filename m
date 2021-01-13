Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF60C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75ED62339F
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhAMPKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbhAMPKV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 10:10:21 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0044C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:09:40 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id b19so2228935ioa.9
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1FBw/MdT1MXY8MYhF5c+QrPUDyCd0gEgzUoA/Dttoo=;
        b=VjmIJ4xi6rd83LgKmvx3Yam1qsd8cQkQaJb2a2wJqcpW2Q7JZE6QY0Jzanw5qKI9sH
         J3WOZoT4kdQ473SEy3vofVY4sZrwQdDrAaS2tow4iQgWs1j+frUHZ4/XFgIQXI5doD2a
         mgRMeZ24/r90vsWEIWbYmAzj10cA0pMkOr3cZD2/IigmB/z11DSBqDhiLBAwKt4OWD8q
         vYa16xpgEkWR4D1zGUz5BMM0vdwplnzJWC3JS5sw8BBTiKktsGbUic8cUWuWt0wbHP/7
         NqImC86FGkhaLv+dcbRmqGaGc29pkUoQMM7IeFQBBObr4n07cWwCZGNvV0Xhu48M1rnD
         TJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1FBw/MdT1MXY8MYhF5c+QrPUDyCd0gEgzUoA/Dttoo=;
        b=rVY4aa5ZhUzxlYtOcMwIltMjbmHh5y4sOyBth48ZVkS371MgAI6MM0KRj0VIGVqZ5+
         gGhRHYf78qIpQdWBU020y2UWIamP8pzncgRy/v4PaVu7TZKXW2Ml8D6t1CK8MVW95hRi
         Z0sQu3JGCsc+gLCwP0DWGewD+lTVQdsHTgRGR+rXoA7YJWuSja8g4uw+uA54WQ+6rfO0
         LfQ5fq7ZcFr+7Jm19sITBdJKAXKPycp23EKfYSQ6T3WjaPV2NjBKLYU5U7kVz2X2Uhqt
         EMQCQafDg8UazGBo4YI9uCUlguBuc9rPKBkRw13RgKNFDOFK+WXLEUyPSXXXccZi/oyg
         SJ6A==
X-Gm-Message-State: AOAM5333RrhSZbgsufBoy74SHiqxvNBlQBAJeaisCHlYKU8qlg4BIQD1
        4T1Fe/aj4BR/NRLS8usDhEAXF5bihjenrg==
X-Google-Smtp-Source: ABdhPJxMdPEvdbbM/4IkPxtPP3U5fghAfACu60LLfhMqgiJlV2GxnDqS+SwWvxLMoEtXl/vH5lJDLQ==
X-Received: by 2002:a92:da0f:: with SMTP id z15mr2600259ilm.287.1610550580279;
        Wed, 13 Jan 2021 07:09:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id f20sm1678954ilr.85.2021.01.13.07.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:09:39 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:09:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH] refs: Always pass old object name to reftx hook
Message-ID: <X/8NMPiE8SrrcRGU@nand.local>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
 <X8n1Qf7TJyqIOE/l@ncase>
 <X/4Pin4Zdf58n1jc@nand.local>
 <X/7X5ku3wvMr2hw6@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/7X5ku3wvMr2hw6@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:22:14PM +0100, Patrick Steinhardt wrote:
> > Would you consider resubmitting this patch if you are still interested
> > in pushing it forwards?
>
> I can, but does it help to resubmit the same patch? Your response bumped
> the thread up to the top anyway.

Let's see if Junio picks it up in the next cycle. If he doesn't, it may
help to re-submit the thread.

> Patrick

Thanks,
Taylor
