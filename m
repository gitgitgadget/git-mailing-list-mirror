Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7AFC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiDZMwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiDZMwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 08:52:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4517B988
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 05:49:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z26so1210777iot.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=osiYS41i6hWajpFuntOu2N6SE0h/HVFiguDpmFGxOrg=;
        b=bU70UBAQwyhgHRzrMp5XmAJXzIEhWyrgWQHBFoM+oihqTVZA24GmSkgR+eo9P6K/hm
         MuWaqpf7BIGK22oY1Jq00In6P8Cl7fC1ij7sKr/rzuZZN9xYFryd+yjyLiwAdM0ISqqS
         Z7ZTqk3dltsX6Mf07l8SdMvmvV/5lBu7kOdurMPQYRxG0QZX1A3vOk10vPlaVnEmaeSh
         aylENrOH+dJeooYd3ymqioDuylkd0MUUFmLBF9w87MiRWxsXhtd6+I4z4LBjhlH3EEtO
         HYu1y4td4BNM2Q6+aqsVNEku9RP5oNa2fN/4ZndWDRq0ttKjhSd1jBDBtwJzrN5s9keR
         wFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=osiYS41i6hWajpFuntOu2N6SE0h/HVFiguDpmFGxOrg=;
        b=kfeqVbmORJEit3J6zFpdjxI81UcC1yEowxbHxYjHXKh6/oPvgKKJIXB/8RS+tBkOf5
         acn80YPZO79XrF8qNCk88wImMEGJ2dVew7tyzCxB+3/Km7ah/FP1194uVeVn79WOpkj+
         1VitO5TnOLvlIpOktYt/77IN/19/0pObOSNULaQ+ISbTR+3RvpZEhKwebPIyS90cOYGX
         p0WuIO2+aMkogFK6hZRPDTR4fO3GFG3q0PVa442AOXpmrteUsKZ4i78XFXyWIzrTVli3
         /+GeJzujD/ci8gaJ7z/XFkhvaEETHz8qxcXuj+LBCH69a9szAznUiIAnCMG0mwF3TJFy
         zQMg==
X-Gm-Message-State: AOAM530chTQ3h2W4aCWTljOGCPmYxmPSMM/ymniaEweBouvjSH+XHWPY
        b/DErO0+62nXT+PMMeCFNyfc
X-Google-Smtp-Source: ABdhPJybUJHE+s/MzuEaoDhefXF8pDMcYTTqvCO80KD8YWZ0c+qEbt/r0cf/33X94ZxWXkFwy2P9wQ==
X-Received: by 2002:a05:6602:1211:b0:654:94db:fa48 with SMTP id y17-20020a056602121100b0065494dbfa48mr9365319iot.48.1650977370450;
        Tue, 26 Apr 2022 05:49:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a3:141e:f20d:6edf? ([2600:1700:e72:80a0:a3:141e:f20d:6edf])
        by smtp.gmail.com with ESMTPSA id w2-20020a92c882000000b002c81bffee08sm7798773ilo.55.2022.04.26.05.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 05:49:30 -0700 (PDT)
Message-ID: <9ff9f199-baec-80f5-41c2-17034744e527@github.com>
Date:   Tue, 26 Apr 2022 08:49:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/7] Sparse index: integrate with 'git stash'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2022 1:49 PM, Victoria Dye via GitGitGadget wrote:
> This series, in combination with the sparse index integrations of reset [1],
> update-index [2], checkout-index [2], clean [2], and read-tree [3], allows
> most subcommands of 'git stash' to use the sparse index end-to-end without
> index expansion.

I'm really excited to see this culmination of your work in this area!

> Performance results (from the 'p2000' tests):
> 
> (git stash &&
>  git stash pop)              master            this series
> ---------------------------------------------------------------------
> full-v3                      4.07(2.42+1.34)   3.98(2.42+1.32) -2.2%
> full-v4                      4.05(2.46+1.31)   4.00(2.49+1.29) -1.2%
> sparse-v3                    7.48(4.81+2.57)   1.53(0.26+1.61) -79.5%
> sparse-v4                    7.35(4.74+2.54)   1.59(0.27+1.63) -78.4%
> 
> (echo >>new &&
>  git stash -u &&
>  git stash pop)              master            this series
> ---------------------------------------------------------------------
> full-v3                      4.21(2.62+1.45)   4.11(2.55+1.44) -2.4%
> full-v4                      4.11(2.51+1.41)   4.02(2.49+1.41) -2.2%
> sparse-v3                    7.35(4.64+2.66)   1.70(0.32+1.64) -76.9%
> sparse-v4                    7.74(4.87+2.83)   1.70(0.32+1.66) -78.0%

I wanted to add some performance results from real-world users of
an internal monorepo. These are numbers for all runs of "git stash",
so it is not broken down by subcommand:

Index Type         P50     P80     P99
---------------------------------------
Full Index       13.3s   26.3s   47.5s
Sparse Index      2.1s    5.8s    9.4s

Thanks,
-Stolee
