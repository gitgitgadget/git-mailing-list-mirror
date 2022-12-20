Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A0C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 17:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiLTRau (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 12:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTRar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 12:30:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E72624
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 09:30:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i9so18519910edj.4
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wra6fGr6joPufpSupkdfguUKHjo6SXwEPpsKnlDFQMg=;
        b=Ozj7mqeCyGcXyyIrU6FkloEwxwq7vytDrRNrKOMoA0Qx19TvB8Qjyhqxp2vj69n361
         j/QUdPd8qyWoImSoJcVYF59EHbmJ+aFHovMMCLAHSA2Qi1cSs7jVafmAuHMDRMGlgGdh
         sQ+hojoccIsMNrx1i5FUQ2ilyR1CYYEI5OwCbMiJ+Ys59JNXa2nrlvS7FfMk3u3061ro
         tE9jm2V0t0cIz9zrzY0lH9qECODt9WYSKaCOFY+veq8qKn5QCJY9bjoemAYz4h4ofa/I
         NpEBPYHJWH4SGXm4ZrmmnFRXZU34GooAQSn+Naf3nGa7oiV2IYHIQaacGMJtFARNDi2F
         uL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wra6fGr6joPufpSupkdfguUKHjo6SXwEPpsKnlDFQMg=;
        b=JBKWjjYWhVZu4lB6PMHDjyKd4ECvS0kGAfJseSKuZ+TsHZh1I/uF+a1DRZLuNnY4Mw
         BCEw+28OAnFmjKbUsh41mFnF1zqH2kJZiZ1ihDbRfyplmws7VPyXhjc6pm+DvDJL2dDq
         dz+HFkEirQbh2vvt8c8COh6yJs3ZiNSl+gagR+N++7JiCscTEW1/TLmno7zJBdqkPs+C
         HGB8zEUR2CnupO8J3mOVnhqFzpr6pyJzgLiUDP324JR5rKZg5wfgNYHcJbt2Zh8+TUKv
         hhU9GxiB5B5fCMHsRsiLvA9gvAK6gyfGGsnONl14C7cSyRTvfZrb5nWCOn3DLoYkB44o
         k8kA==
X-Gm-Message-State: ANoB5pmphbeOaOi8aTVft/echMZ30eHtg2222oN+uBW2XqzOFIl8gE4u
        SwOqQz763IcBcOcB2B6b/3PpmC2pZ4A=
X-Google-Smtp-Source: AA0mqf62EahgWq/95fTuFoI05Y/Nqct8eDsI7UqmzH1q2+Zcq0x/zVehw+Z2odxL9G88zuCxYSob4w==
X-Received: by 2002:aa7:d4cb:0:b0:46d:35f6:5a9b with SMTP id t11-20020aa7d4cb000000b0046d35f65a9bmr35964385edr.24.1671557443792;
        Tue, 20 Dec 2022 09:30:43 -0800 (PST)
Received: from ?IPV6:2a02:810a:8c80:15d0:5471:5cf5:3620:10b? ([2a02:810a:8c80:15d0:5471:5cf5:3620:10b])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7db4e000000b0047466e46662sm5913197edt.39.2022.12.20.09.30.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 09:30:43 -0800 (PST)
Message-ID: <d891cfa7-1592-198a-606c-3fb4f9c51007@gmail.com>
Date:   Tue, 20 Dec 2022 18:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Andreas_Mei=c3=9fner?= <real08121985@gmail.com>
Subject: Question about figure 5-15 in Pro Git Second Edition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm reading the book Pro Git Second Edition to learn Git. I wanted to 
ask if there is some mistake in the picture. Can it be that the names of 
John and Josie need to be swapped in figure 5-15? Cause John is working 
on featureA and Josie has created the featureBee.

https://git-scm.com/book/ms/v2/Distributed-Git-Contributing-to-a-Project

Kind regards,
Andreas Meissner

