Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63860C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiISQM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiISQM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:12:28 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6D28E0A
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:12:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j8so15864qvt.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hYAtXBpZ68xCWe1Nl8JCJBJphz/OWhxpPgb9Aqumxlg=;
        b=XrLfMuV23Dd0TxpOjmi+lujQN6HSxhezyZ3MA9BPXUdRVrgEaygMV1Y6FvdfPy8que
         a9aCTpS5TgFtfTjoSDc0e0L/iC9GXRxsOny7bGY5ElhUsmG7yQI9zwz+cOevYrO8NRJ3
         ELexxmCz+D4vYs761C54lnZh9+6xhyNmJI1phwt6qvjkw3svpdcaENzqnssGNZnRhsEj
         iqzDQmGPaQtLmoeK9IR3tbUsuzuL4a/aAPwMHnuJnu6VWN/8GLUrTWP8Lq8Y5OCnPuAR
         hcfHn45ikGLKeYzUHnA5WEYWN0imQyM15Q/zyjz3rG9ImI8a8MSHyNqgp3mXnU6jSLql
         kOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hYAtXBpZ68xCWe1Nl8JCJBJphz/OWhxpPgb9Aqumxlg=;
        b=c2U3EdKetyL0xDhpT4XAQa3CTrq8oSFo4mVfEDvCf4oXmlo58xQST9+6iuGr6/NDIK
         tDSPP1zzS5DQj47UOV2C8rfmeuIl9kjIjjmEFlcMQQJBj4PZCdxIzRFcK2bcCOroOQJj
         CC5A7GrzYamC2cQ6qCUKetgwdPYD2/Ukf2ypOLil608jF5zDsC2dZp611OQ5pv2XEW4+
         2oycwxMS8a4355ju5Wp+hAdYYzH2ZuKPubuMTtlM2Fg5tW77WGn4JJ6sSGNxg/KdoiGD
         YovYzclMjnTKvqlsyqQpZleXV+uDE25Y3+k0ZLK6GC01Ry67BP63QwJjV6vEAOGCC6rR
         GAbw==
X-Gm-Message-State: ACrzQf23aiMptElCOXBF/DS6tAWAuF3KWNbznp39ssoavp8gP6K2Fn/E
        +Z1Zcoe0x0C+EwKQxnN+c8Bp
X-Google-Smtp-Source: AMsMyM6nvROYJ6lnapGG3+B67HzTpFKHDcz9E7CIAV6jTY1pwzQhh/VJ3QPR2Sd1HeNLqiCHq5aaWQ==
X-Received: by 2002:a0c:b2de:0:b0:499:363f:222f with SMTP id d30-20020a0cb2de000000b00499363f222fmr15579028qvf.73.1663603946883;
        Mon, 19 Sep 2022 09:12:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id i19-20020ac85e53000000b0035badb499c7sm11338103qtx.21.2022.09.19.09.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:12:26 -0700 (PDT)
Message-ID: <ead6293c-8906-04c9-6566-e47efb624385@github.com>
Date:   Mon, 19 Sep 2022 12:12:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/8] osxkeychain: clarify that we ignore unknown lines
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <2ece562a5952b5752de5040b17ec36076164c72f.1663097156.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <2ece562a5952b5752de5040b17ec36076164c72f.1663097156.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Like in all the other credential helpers, the osxkeychain helper
> ignores unknown credential lines.
> 
> Add a comment (a la the other helpers) to make it clear and explicit
> that this is the desired behaviour.

I recommend that these first three patches be submitted for full
review and merging, since they seem important independent of this
RFC.

Thanks,
-Stolee
