Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C226C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKJCaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKJCaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:30:00 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887EB1F5
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:29:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m15so406442ilq.2
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eF13bjFJy0oVou0IJpyOoWjsU2AuXF5CDirCxi3MepE=;
        b=sdKQTcG5d9Q1qoIM+XaIZaO17T0eUKmBQXsDYknu1+f//blkg7Y82w9QiojEXM0oa7
         ZweDCuawSZNhBCelwHWhqpA914h9DpXlsxtbHFduPoId9cAKzolld01iP1hYTblCfIjJ
         AZCTJH9f63hshFsgYVEatf4dQnPHZ1kIZIhC+WEKz9s1WEkQlCxBdiIRu8cmawTvx0+8
         Y5aIYkZVPTPsqDXq+nvSkPaYxAdyfQ1mQurr5Cat4cR++aNtwFZ1v8QCVyyPj3zGn7qd
         e0KORRxlbpPYaSq7cHH0EEKXjuyPfgBbP3dOJpDXAtytIJ2GeI5sykFc7tflP0uoFOvL
         ENCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF13bjFJy0oVou0IJpyOoWjsU2AuXF5CDirCxi3MepE=;
        b=k8SrekS7BZCaEdMIpYtmC3RleE86+ZNdJWi6ziEWCvdm1pht5vMOTdY3su16rymXQP
         t65+M5FgsR0xMfnjPQuLIig/YV5tViAVgxSKvrr/yFD5Cs5nI9Gjf+jj4rH1ioRDJDKp
         wJhiuPmbikYQKlAXy5aBYKxb3koh6HMEq04PYrMNLhqXgijC5PwzNPA5MxupgpWpQxua
         p6azRMrh8cRfsv9eUd/fi/cR/RsNUa/bR2t8A/MtfwsYYfyZmLSOJkkxWYzdkmZx7DVg
         ZEPxcefkxEbD2ges+OXsWS1pHxowPc5Rg0C1UVOzORzrikZR7+Hr1kwC79S99dYpNK/j
         fKnw==
X-Gm-Message-State: ACrzQf3NV4xwBRv6q/oFJLxt4u/+hr5eZ7uFTxssOfekOQHLfxM8P1PW
        nk8fu+mfn4ISLRSZMZKn7TNbbdGqTV8AGw==
X-Google-Smtp-Source: AMsMyM6uVoU2s9KNBxlgncfWilJadv2poieHaTbf6bz5dMSKrLERjqJYBe53gQHmGUfqHCv4swBN7g==
X-Received: by 2002:a92:d210:0:b0:300:c813:116b with SMTP id y16-20020a92d210000000b00300c813116bmr23587033ily.79.1668047398223;
        Wed, 09 Nov 2022 18:29:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z26-20020a05663822ba00b003640f27d82esm5498766jas.21.2022.11.09.18.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:29:57 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:29:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation: increase example cache timeout to 1 hour
Message-ID: <Y2xiJEhmcf3KDK1p@nand.local>
References: <pull.1412.git.1667989181611.gitgitgadget@gmail.com>
 <Y2uoko+ho9c5sfKf@coredump.intra.peff.net>
 <CAGJzqsn3-_qM8K8_+5=z7-u-n1Oe-CfgjrSLF84RaFXUDMOChg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsn3-_qM8K8_+5=z7-u-n1Oe-CfgjrSLF84RaFXUDMOChg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 04:09:14PM +0000, M Hickford wrote:
> > The patch itself is obviously correct.
>
> Thanks for the review

Thanks, both. I picked up the updated round.

Thanks,
Taylor
