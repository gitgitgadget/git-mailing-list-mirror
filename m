Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F70C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 05:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiAVFBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 00:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiAVFBG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 00:01:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1624C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 21:01:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so6719236pjt.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 21:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=SWqXMXkm2W8aEajRSW+aA0K9sZPydhxLtv3qYpKpcDo=;
        b=YSX1Kto1SUj4uG29q0CuvcOYCwqyivooMBtusC8Sm4gSZ3cNEn19Zok3m3kIxcFA6Y
         qFz7cc+OhIu+tPXuE/+4dDn8LlGgdMraCf9QICFMOtbBFhC/8hAJdIebXYrRUSlfP1xu
         oK8RcA3+tfDNrVE1Vq0s4s60knus9L8Or+jFZ08EmXoHalYV9xRUJPlFKEKQRbasjmqW
         gezr9WZCNOyu+zkp602YQVbIx89vvCTvlBwFScbkZA6wJwymYVXzsIrqwM403r2orpzU
         /F83OpTy7bOlKrpYQ+lnhUJGeyjK9D36mkticOougzXBa6dmHd8rP8eRM+c4DFbxUssb
         B48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=SWqXMXkm2W8aEajRSW+aA0K9sZPydhxLtv3qYpKpcDo=;
        b=aTnAUwzY5vQOWVosckHVEks9NHNIXCwPBtJHGb3e0/Tw+hLJ7tDH4M+jR/M4F1xcdW
         K7EHQIkO4HZrtPfhzDNF7YjkDPVbT2L3eyM+EO5R6l+rsjfsex+9jyF8bBV9W5PL5Szd
         vdPbgEwxHuid3RBmwEyHWcARL4OsPrxAn/7yP/3wnTU2r+ZzAXmg1VfPqauo6wWzl/LO
         c822/uyiiqLrqGhfAG4DPezAubRdIHCEpj9ZAhZpRAdtDQTzVUVytXMPHxNUT4ri+QyC
         5jqFkJ9ZRO45oHyKkiFQDfMeRGfZ7R4zmZR9xkTVDOq+CBoiEBVWerrCAjQlMXzN7Dp8
         c07g==
X-Gm-Message-State: AOAM530Tt7EEDspgwwn921ul2hQbc4AYScZHnV7bvue0mpIXZlc++8rd
        UdmiICTmBZH6Vixtd7X9/wsaZL7W6wPIjg==
X-Google-Smtp-Source: ABdhPJyf/hV98AffkfpjGfMMTs6dJKTvvxL9iT/Y8h/se30rBeD0T2Tw9zsgZZdjOuJwkAYE6aQJLg==
X-Received: by 2002:a17:902:e54f:b0:14a:1bbf:9cf0 with SMTP id n15-20020a170902e54f00b0014a1bbf9cf0mr6995385plf.158.1642827665493;
        Fri, 21 Jan 2022 21:01:05 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id s13sm8465848pfu.0.2022.01.21.21.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 21:01:04 -0800 (PST)
Message-ID: <a1546449-376a-cdd3-c8fa-52c504663577@gmail.com>
Date:   Sat, 22 Jan 2022 10:31:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [Newcomer] Suggestions for microprojects
References: <e176d1b3-482b-899b-af24-ac03c65d103d@gmail.com>
 <nycvar.QRO.7.76.6.2201212330280.2121@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201212330280.2121@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Johannes and Christian. I will check them out.
