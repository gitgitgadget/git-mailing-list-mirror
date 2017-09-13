Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36581209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdIMHNP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 03:13:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36634 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdIMHNO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 03:13:14 -0400
Received: by mail-io0-f195.google.com with SMTP id n69so7008200ioi.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0Z0As99w7WnFgRbFfe3gHOgP8/BCFfE+nx3KDMmy/Hw=;
        b=CDJy56yNsiQWpPNqUOx+AuanR/ME+Tm9tYTZSE867GFNzmpZmU6kMEmjk0sR0+7QKv
         q3baIpfoGZ1RwcnK/6ENXXAMjQQeo+eIcYY5VUswSbC5l9T+wx0gKbWxFtoC2Rfjpc49
         xphpUziT3iEx7GxzwGtn9eBshefx98lQ0TVBEgMPric3TcnVZ/u4RRdiC5qqS4cIkX8B
         bsI3Wj/SFgN21imm7yUYpMyyq/NspzJrVE6ePU5pZRKqW16IVJCeulprXgbowAMxPVyL
         ubYtGQy2Mc4nBRGlqOFeFOaMeDRt96LsZ9T31hEzG5mWBNBr18HqX2ZXKHWQcL8gOttZ
         BHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0Z0As99w7WnFgRbFfe3gHOgP8/BCFfE+nx3KDMmy/Hw=;
        b=boneLfts2nHpi4+A/K81C8hEHDJ+iTe8eWIhhPWfsX0cbdj51iwNxdirtSWAImxuMM
         U76GjRdR/MALn7tcfMSNuJCL0TA6wYuJWNXzmG3FfuaA2bI7YdMGm4P3enUGmN580MGM
         r82ed+a32WI6gsB6hS1RFe3CHYUp5NKrxpU/rjxSbcPMUD2S0i1Mrsl6lQaKNLuDTxf6
         0Dfbbt6wSDIXX4heBBakFuf3Cc248Hod5S9JG4Yrsx2ir7bNYvtlryH4JsqEWTQ2xt2I
         GWUax6bmEz6iX1SmpC8G2zh8jF1dwaX6qoEvboIZyxkuj1e6DggNMabJxjFz0e3kXfpY
         TQ6g==
X-Gm-Message-State: AHPjjUjL2eF2Qhha/Yo6v9H+8d1tDIuZ/cyKD3tMVyd/HU2vpuB/YtJW
        aKWwQoU/069LM6AM5w4=
X-Google-Smtp-Source: ADKCNb7PUOgIuxisUCLdF0ThRzZwRZ/y8SSgx1b5yEH2V+fct2kRCS4mfKZg0xuaRbZfGQOj1GiaIA==
X-Received: by 10.107.195.67 with SMTP id t64mr24739571iof.71.1505286793234;
        Wed, 13 Sep 2017 00:13:13 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id s66sm388008itd.25.2017.09.13.00.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 00:13:12 -0700 (PDT)
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
 <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
 <1505226892.27800.37.camel@gmail.com>
 <20170912150541.fkgnxddv6z223h3d@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <2320e1ea-4a8a-543c-7b9e-c40d6c07288a@gmail.com>
Date:   Wed, 13 Sep 2017 12:43:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170912150541.fkgnxddv6z223h3d@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 12 September 2017 08:35 PM, Jeff King wrote:
> But theta-well isn't a pun. :P 

:)

> It is true that prepending to a linked list is also Θ(1), but I'm not
> sure if it's carelessness that causes many programmers to use big-O.
> It's that what we care about is worst-case performance. So knowing that
> we have a lower bound isn't usually that interesting. What we want to
> know is whether it will blow up in our face as "n" gets large.

This seems quite acceptable.

> Plus typing non-ascii characters is annoying. :)

I expected this to be a reason. :)

---
Kaartic
