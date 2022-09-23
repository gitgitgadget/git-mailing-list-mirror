Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F0C6FA8B
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 04:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIWEVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 00:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiIWEVh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 00:21:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE3311D60E
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 21:21:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b23so7700279qtr.13
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 21:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wHRYPDGIpaoZhH7V+08oiXtSCQrDelbQRoGAkMvkhD0=;
        b=O9xvnZXk4IBCrxz8lJ/Lmr7L1Umelgks9oVO0IohG/PGlvvKEwYiz2cVyXYu5aKvq4
         HhEQBGKMt8fJU6/nn1S1kcmCqY9CRWXcaQCr+mDXzQb6p+CqLp5IDC1jdtM/TjObw3HQ
         tUjgREXiOp5JA+MksCIos06ulxJSGGhvU4RkBxvRHjkhfcEqr7o1JfZY0WZVal93Xn+H
         Ney7eW+hmYQgMXskPvBKJMXasUOnnrtwUhKtn+492F7tT51em2oLED6h2QLcLKG60ynk
         et3uU2YQf3CYyzz11Cphwq9exhL2L4RcYMPNU23KteF+6a8QUc7YV3Y5w+2Jk0ogR4tn
         TFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wHRYPDGIpaoZhH7V+08oiXtSCQrDelbQRoGAkMvkhD0=;
        b=x/uQwpYWfwg8jslHnfEq0ZNi+NVrelgd4mVphHagEOWnyrvAtMRNU6mSoRXfO6BOV5
         aTOD1q8F9FWqUdf38nV4MPrQKGioq0lo2VxGX32+mQJUz7GiGmFOur2UvO6Yx5lOO6g6
         DfaO04qQJmVbkvf3vdijq3bYcuZ6zTWkAC6rG3azI+baSZCQLUOATLeo6Uhv6W6/C2FN
         xyezbYDi4clBy5vIEan6JLEETvWuTG7HI94HKXkUbDQp4sb/gId5AckFvDhVsQduMa5p
         OnphkbDw+Pl1fjwBGCif+8I44DNuLtmCGdEDs4KgpuvPTajyLZaYw1AM6I2Haw5RL+Ax
         qbaQ==
X-Gm-Message-State: ACrzQf1sVQ09J+l9989YTEhQ5/hmIqWDm8nS2ZrkHlVShdx10wRd+neS
        3AZlUiLhvn/lfJOwDDVvoUcZ193J+/w=
X-Google-Smtp-Source: AMsMyM5nAdPeNt89DoCCZ2IEevtt/s2jH1EJmS2QdNlahs5ctT9YVCCxdMkNyTIjY4ubzlq0lLPEJQ==
X-Received: by 2002:ac8:4e81:0:b0:35d:a8d:25a4 with SMTP id 1-20020ac84e81000000b0035d0a8d25a4mr5708511qtp.101.1663906895816;
        Thu, 22 Sep 2022 21:21:35 -0700 (PDT)
Received: from [192.168.1.69] (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id x20-20020a05622a001400b0033aac3da27dsm4986059qtw.19.2022.09.22.21.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 21:21:35 -0700 (PDT)
Message-ID: <ec27fcee-2ad5-ba50-b891-444e7c97f50f@gmail.com>
Date:   Thu, 22 Sep 2022 21:21:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/1] grep: integrate with sparse index
Content-Language: en-US
To:     git@vger.kernel.org, newren@gmail.com, avarab@gmail.com
Cc:     derrickstolee@github.com, gitster@pobox.com, vdye@github.com
References: <20220923041551.27790-1-shaoxuan.yuan02@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220923041551.27790-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, shoot...

Sorry that I forgot to "--in-reply-to", please ignore this thread :(

Thanks,
Shaoxuan
