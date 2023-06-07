Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD08C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 17:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjFGRVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 13:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjFGRV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 13:21:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6C1FE2
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 10:21:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-650bacd6250so4223718b3a.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686158484; x=1688750484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO3ARyIO29tHtBxBbYKFzZy3Sv7b/xG9KO5x5+/duPI=;
        b=dFUkaRZKulMt/L/GVn9EoxmHHyZ2H9YWUE2zdYIGsG6KQfzklikz76GQVe/4DTcM6D
         IQUU40nvdBGaau70H3rVZ0CslJgkc4GKKVGPQKnV8HVZ0PF9cwOCmIAGwdXRP8Czo0YT
         uyyEy2oJjTCp7+kx0m9slXiUhIimNJc5V1innK5efs5wdicgutbAL7RmHRB8eZyGbhsK
         hu8jWvanofrRB3Uj6OrF2xY9+Xixy1mZMuWGzZ3Y6WToGcgaciHEjt/P4ec1wlkrq5/a
         hNvit8S53l1MRHCarCcwjTznUpLMyxd7Wu9wA/D8k6yol91IyUb0JUWh+iI1MtZynW7T
         3m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158484; x=1688750484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO3ARyIO29tHtBxBbYKFzZy3Sv7b/xG9KO5x5+/duPI=;
        b=IGT9xf5bYti1VbqG08DGyxkDQ70xb/xNiEwdBDLOEBFpIgllDYHQZiH6EUxsTMDPs4
         cx0WCv2+NnRzEEZBS+9sicQibVCQNiXmLyDN0fHKVOx9M2uQarCv3cvhGuuS2mETj9gM
         RJQgjXF//fx3REnbj1O2zCtnAzCFzxzLn6giURegl7JHv0tc4R75WCYPHEEbTQzkXC6V
         5scx855/bwaX+t795gxzzLjwTU+etEloVIMDXYzaXbYD3LEYAfIWo/tKfK9HZNLJr73P
         xzw99zE1jlizafIvYeJHsQ22nxdaR3gR0Vt9o0lIm3V/nic3jzNFoV48QGBP3+S8drpR
         bPEQ==
X-Gm-Message-State: AC+VfDzZI2WbF5qPzlNqybuP6dZMaVmbv58Oph1OTl7kaiB5qmMz4dxr
        lMXlgRFYA8i0l1Bvav0CftLzA/9GZ3Z5vbB2vw==
X-Google-Smtp-Source: ACHHUZ7h/LYfhd4FW76CGGEyV5I0WQ9klWdFXcxLOfltmHr7BJO7FLRf3adRazMQqyt7r++BumRxQQ==
X-Received: by 2002:a05:6a20:2d20:b0:10b:56bd:b00e with SMTP id g32-20020a056a202d2000b0010b56bdb00emr1759697pzl.40.1686158484061;
        Wed, 07 Jun 2023 10:21:24 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x5-20020a636305000000b0053051d50a48sm9436810pgb.79.2023.06.07.10.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 10:21:23 -0700 (PDT)
Message-ID: <4225a82c-83cc-d81a-628d-a9a01d02acf2@github.com>
Date:   Wed, 7 Jun 2023 10:21:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2] worktree: integrate with sparse-index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230605161644.491424-1-cheskaqiqi@gmail.com>
 <20230606172633.669916-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230606172633.669916-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Range-diff against v1:
> 
> * Fix did't to didn't.
> 
> * Add ensure_not_expanded for "git worktree add".
> 
> * Add a section that compares each test repo's default worktree to
> a new worktree.

Thanks for these updates! Everything looks good to me (especially the checks
you've added to the 'worktree' test).

