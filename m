Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041CC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340A760EFE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhHPPOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhHPPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 11:14:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231CEC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:14:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h17so27681365ljh.13
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57YLf08l922zK9QfkykyasxzmAmv+OKAfHzQzrkpB+s=;
        b=hseXcLv2SX4EnZOiaAi61GLLppV9p2hxq4vb8LFQmn2EME9TZoOK4bdcuCEckXYer+
         nJDH4FKqEwap7Z2uueaggSg2h9byHtCPEKJHkIdg8/ZV5Xqo3CnI5WJwqq8fpHyljXeg
         /NrWDptfPdztw/jaxJ3zkvDS/mCXIRE2UgONsN98C3GUN4vAsMnbn8ktzvSDq5XbHoCF
         AnSX2e31H1IW3UAyzJDb/cuSpVjjZU13Ypc/66L0CyCdBqWqfgRfSIc/pxm2OgWDFOM6
         d2uDgPPb0tpK8UfecdI1/QYEgPxCM4bOmeevJwx7b6WpPDUBiqU6G5s2xU4L2KVx/GAy
         I0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57YLf08l922zK9QfkykyasxzmAmv+OKAfHzQzrkpB+s=;
        b=gEghG1B4yj5H0k5uRAyo/LLvwSuj/z4tCAOVaDzrayFt05AqGoKZeHC1/r1q22d020
         uZD58yXuy6f6qFBZ+HifFaONokKDwy0kk6gknbbzuyQ/+oKsZ53ZDG4M4fwsA/HRs8VW
         8T3PajdWF9dN2IxtawXfHzfRequCwv2oUPZRqWV5GUaOj04Jibo+7Zu9BfIN/iMg9Ipj
         2aoG03j/szofycZWNeyHbSUnSAdIotEaX+l/q3J1iSAeGavmWKH4gBbXSeJum+T92WY7
         Yafomi9K7ZiJni6H1OFZXSnt1JizhQUtkA+FogAV/RX7bOC1q6bZnpAF5tSoESswho5k
         /cAw==
X-Gm-Message-State: AOAM531/0Yr7lw731eVeOpPv63bB9lX139dExV726EQ3E8Do+T/3xDhM
        ljrQ8ZOQGplgt4XktW3rYpi452ZjegnTMwcmHY3/Nw==
X-Google-Smtp-Source: ABdhPJx+g835+/LnnMc6So4KKZRGCW/LVW5Y51hnDEgdjmYZnZ4EcgCaDDMcMy+OHkM3Jij3ySnrUSaGn7OKQesd4jo=
X-Received: by 2002:a05:651c:211c:: with SMTP id a28mr4286970ljq.8.1629126860518;
 Mon, 16 Aug 2021 08:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Aug 2021 12:14:09 -0300
Message-ID: <CAHd-oW52gv7_bYHnay12+fPTdCgxsgRDT0yLAxpBH6SjMbwPSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] In grep, no adding submodule ODB as alternates
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks everyone for your reviews. I believe I've addressed all of them.
>
> The main change is that I've also made a change in submodule-config to
> avoid registering submodule ODBs as alternates (thanks, Matheus, for
> noticing this).

Thanks for working on this! I reviewed the entire series and left a
few comments on some small things, but overall it looks good to me.

Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
