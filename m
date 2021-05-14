Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EE2C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AB8613F2
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhENJKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhENJKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 05:10:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C0C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:09:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s20so15884235plr.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyEEAP9KehWXnO2HnqQXQzp183ebigP3AdCFVCTsG5M=;
        b=lsdZhoEDs1IvuzflEfUtwrh72kIU+fOvkObpdevdhK/fP2rHAqj5QHwkDYddR5ZTth
         Dd2BpAMEsFAad5Kk/4N2e2tMRmCjmjBiPIUCMjHPP0jepOr9MSe9rXEnNCcgnWloqwMH
         p8LnIx//t1ohmy8GAClbYUk3nZlZaqNoPY4BoMYR77QmYkQkAC0M1t6bfWxDJekT/Dx8
         9cR2JV04MVwToygKzVEiWro9JDXEQM7SP+XO82LSRav8FNjT2CyqDIQ5XE+HpYBYpm1n
         /9bI0qi+945Fm3o8SU2WKblh73uR8dEyC+QdHmpSsOinCN07RhXyExRK99YbmsuNIBfj
         80nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyEEAP9KehWXnO2HnqQXQzp183ebigP3AdCFVCTsG5M=;
        b=OnMuW0n1CvmvqLr4rcD/YLurFrkUR0CJig2UwDkzuMx3aDSbdILSWnztPfUMdN7mVP
         pb9p3c1eWYxL2Wy7qgmPP0iAoC/kHs/zX4MoESZhJdWuC7TcYPaB8umTM3hfouhD/gYU
         75CSDIcrHnRL5K4FITTIdw8dmvCj3rqhIM+wFpCpRADEZZGi//SXeTHrILD0g2xZE08S
         ugBQQnjp2dJblLAcYMI3D42QZZMIQrpd+BsfA8uPYnWWEC0lENBbnczQuPVGkHnasHhm
         vFlj7Y2UEI3cZ40QwOPiDC3pP7rJ9Ka2jCsrIAgH4vPN/zs8fTHLn60/kaJ5mmGIM0pl
         HA3g==
X-Gm-Message-State: AOAM5305b/tvUu8wSdykC0EtphF1UQZMicwxH/wEiqfNFvQ8H8gx3oxU
        trL0ZzzB9DVGHxJ30mGB+lpfqkuVNVlI/RcgnY+etasbn2o=
X-Google-Smtp-Source: ABdhPJxYeqS0ME66QBjhiy2iXqQXxWEnc/omxRlioWaSkS6KsFJdAL6MWH80RV9BnZpgjzhfV33BF+C0S0Ge6PCYMlA=
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr10080789pjo.171.1620983345040;
 Fri, 14 May 2021 02:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
 <YJ4K4UXh6sva5I4H@coredump.intra.peff.net>
In-Reply-To: <YJ4K4UXh6sva5I4H@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 11:08:53 +0200
Message-ID: <CAN0heSp13ZStRU7Gv0HwuRM4xvMV+EDhUZd_wbs+nVv0u0a4ew@mail.gmail.com>
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 07:30, Jeff King <peff@peff.net> wrote:
>
> That said, I think in this case "value of `srcref`" is actually an
> improvement to the text (but I wouldn't say the same of the earlier
> patches, which feel like they are making things clunkier).

Ok, if it's an improvement on its own, that's good. Thanks for calling
out that the others are not.

Martin
