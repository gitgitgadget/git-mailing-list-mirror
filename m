Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5673C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4522145D
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 18:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMGg2rCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIFS5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIFS4k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 14:56:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA47C061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 11:56:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g6so5399189pjl.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KO0p+XWQRzGBLui9c6vGuRBZiYUMu7IRoWVKBnoMeS8=;
        b=eMGg2rCB7MojI2Vc9HWb2nwpA0sPg47uOfAnWZUtbSkTrhki86neFZe4RwQJAhooFm
         KSeg5gISzMxg4Wx/ayAnJIb0vCZXPbhsIWJMh+pDKz5TcM6CIUVHd9lspEbzBkgA+zCR
         F6f4JbyVZoHiDBn5pa/b2CQaXV4wUW/pKy0OwqVHutUuTjn6RVfTEiyA/Tsr9z6A48o9
         yh1EJ3fIqvFGe/fK2v+1+7gCOEzToOndPN3/nJblRjTWijzJrqhHfZeKc3bI8Kr2+uFD
         Su9SWbUERlMp4dTG/pb2mXHfYyN8l0yb47GIxHv0ezlEJ/1PZln4aMcunyOBycZPr0xk
         A3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KO0p+XWQRzGBLui9c6vGuRBZiYUMu7IRoWVKBnoMeS8=;
        b=oK5vM/F3oFBvUOEhIBZRfX/Ny1G404tl/FcVmk+eFjbKDuXwlCVBLehysLqQhTQxGO
         G5fvgpj+1cV03Pb8pJ0AVW0pSzuK+YiFbt7aQtToBrE8B5yoSiyzty4hyduug9tUp22T
         Qxz8ctBxpXqHPhIcHlUCuFWdH7k34JIvM2Hx2LKkInXTgzwSK4db6ypvgEvJsZEjWhiD
         pY2Iv7fQvQYb3qE/BPWrVYhcyY+Yz4q/dae62sHiR5znU6+qyJBeA7wljOX1kzZkstom
         g4qUupmKphw9cyeCxc7egR1ApR4P7mjOoLbEMrqxMgIBh5tec+2crM3YTeKWH9Sy6UPz
         gA0g==
X-Gm-Message-State: AOAM530IkUfhEHar1pPM/V1fO2BVPztAYhDTqWVSJO/tYapLE5ZOOvNs
        JpNcl1W/1MbHsT5IkmROm0sBFykNPzg=
X-Google-Smtp-Source: ABdhPJwiwkQ5eVSw0mHPbPQaRJrP0csjpGPwjWEo+a4ZHbrYmzy1cCdqIfEJJPU1CSkBKjwZLSy64g==
X-Received: by 2002:a17:902:7b81:b029:d0:89f3:28ca with SMTP id w1-20020a1709027b81b02900d089f328camr15266481pll.6.1599418596549;
        Sun, 06 Sep 2020 11:56:36 -0700 (PDT)
Received: from [192.168.208.37] ([183.83.152.81])
        by smtp.gmail.com with ESMTPSA id k29sm10136898pgf.21.2020.09.06.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 11:56:36 -0700 (PDT)
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com>
Date:   Mon, 7 Sep 2020 00:26:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828065609.GA2105118@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-08-2020 12:26, Jeff King wrote:
> Are we interested in participating in the December 2020 round of
> Outreachy? The community application period is now open.
> 
> I can look into lining up funding, but we'd also need:
> 
>   - volunteers to act as mentors
>

I'm willing to co-mentor a project for this term. I don't have any
particular preference of projects, though.

> I would appreciate help to find project ideas though. Are there still
> scripts that are worth converting to C (excluding git-bisect.sh and
> git-submodule.sh that are still worked on)? 

I think Dscho's e-mail linked below gives a nice overview of the various
scripts and their likely status as of Jan2020:

https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/

I'm guessing only the status of submodule has changed as it's being
worked on now.

-- 
Sivaraam
