Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E7BC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9252207D3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6lJ1Nef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgESSks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 14:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgESSks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 14:40:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E01C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:40:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x13so296070pfn.11
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3UIUkFK5UG0bOogX1POZ1UAX7jc+YvXTKYkYLUvZsoE=;
        b=r6lJ1NefMXg6Xd+KOUKQutzPNiXhXUrpPh+oBpRAHAS0moxFKnsBwjJ/pHX+BkRo+G
         TSpOzwEDbYWy7EDvsxl7+107TACcWNWFSuaqYagA9h+RTYXUpQ6mp6I7UiOIuKuqMzl/
         4vxEu44p5DfztIs8UP4UO5EpBnVYVNzPElLWQHvWT19gNwEIobRl0Lb8htHNOc9TN8ei
         RAOJ+60Sr3xStvDobh5UXrJlD+6IDri+dQGx4k1ro+xy9e6VSHx5aTDy/3IiqUSdtLrC
         VliW0oK2SIFh4Aaz7/afvJJxaJavYrFGATL66HJ0xkTSoO23YucDCgRoIZZ+HQCgiK3h
         TLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3UIUkFK5UG0bOogX1POZ1UAX7jc+YvXTKYkYLUvZsoE=;
        b=SwiTApGCAu/UCx4/RkRxOWoXLm93JW5DfD1rNVfGuhsrQao9ErvuHwm/T01BYAb0Cb
         O55CmRUhKXyeFAJemkHArqWwiW8sRVP/A7BWTfiThNUKwx3QiJDUtmvroFPA/b+E4Gjt
         5o7VwbEQwUwZ8pvpbOczIR+EJulA8c21bxWR8Z/N+AVPu3HMo8yAw19C3BbJO+wCDUqM
         FAGEsLmCbbTxPkoZGhNPl7AE2TMhhT8VRKh4qjKGfB+/n5dQB8KDGdgu8AAq4OYoy/Y8
         FquEO5ry6TaHSj+mz+StXIL1rzq1UAKj0c2AiA/PcI+4ocAj2xKJ9pzYFLa/yPY/+4FD
         yTxQ==
X-Gm-Message-State: AOAM531wHSEokUz0BnsYnO7nPfkNKPZVlhQDWrh/v6waPuSQtQFyCzJ2
        bHYBNNPsW0W8QCA0S/hmhLjF
X-Google-Smtp-Source: ABdhPJxkDSB+fxjW089mDp2VCOfTNmW912VNwSPfP3ZXJhGPrB8l+kv3nZ4vDDqJZ9Qy77A8zmYx6g==
X-Received: by 2002:a62:1e84:: with SMTP id e126mr453204pfe.67.1589913646276;
        Tue, 19 May 2020 11:40:46 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:908:98af:f00e:87b6:e4b4:50f0])
        by smtp.gmail.com with ESMTPSA id gg8sm229239pjb.39.2020.05.19.11.40.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 11:40:45 -0700 (PDT)
Date:   Wed, 20 May 2020 00:10:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gitster@pobox.com
Cc:     joe@perches.com, git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: git-send-email: Ability to populate CC using more tags
Message-ID: <20200519184041.GB4397@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Currently 'git-send-email' lacks the ability to CC people described using
tags such as Acked-by and Reported-by etc...

While doing a bit of googling, I found a patch from Joe [1] but that doesn't
look like made its way. And in that discussion I didn't see any real objections
for the patch intention apart from the usage of the term 'trailers'.

So I'm just curious if Joe or anyone has plan to resubmit it! If not I may
do that.

PS: 'bylines' as mentioned by Joe seems reasonable to me.

Thanks,
Mani

[1] https://lkml.org/lkml/2016/8/30/650
