Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC8C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiGSRag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiGSRaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:30:35 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9652FC6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:30:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i5so642660ila.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UAsTZHgwgali7Cyhu6BLw7hIkoOhbv9V0n1/CW5yT6c=;
        b=TTJke7ZD8zxUpajiRL2pHIFLSDve5nMQjfJTyrlzMbOgK27Awzdlprb73tMhpziv0Y
         MsmZHhuR6uExhlqstkCxMKCk1uF1u+dy00rYCRAvKObUbTFdJhcailmeXl65UohQ/zRi
         JYBAWq8YQooaVFXnB+zWq+8Eu+4xOgZgpMsXs0ONEYnrQlOEjfGTG1ykP0fRXGxer4hk
         L9IumRlZAINhFbcgDQ8QGIbmE4DwSI9yMpZ/wuDZFJRSAUPqfLVEgbi6oiVH26hrsv80
         QKYcg3HDjI/Dymamk5ZbOJpnSY4qo1QT7zzZAlD7Gc1AuL6BUOGtqoOj/KWiGbHYbFMi
         GMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UAsTZHgwgali7Cyhu6BLw7hIkoOhbv9V0n1/CW5yT6c=;
        b=fwEgGRD4sHoHVaVbqd493TrgFm6vCOa1iOEgRDNyHVPiMW/kdOaGg/QsZ5OaMs+h1k
         lCtMkBg6ZXnmkFH6xIPoZrbFdP/wCR5w6sdfar48B8w7AnOoBFcB4X4phHA84pREDfxB
         kLBVbTvOgJpuZHPWq9O1yjJBywXlE7p4DkHtWi9vjWpvAZGMERuExiIz1fn9HLc4Hc9+
         2NTdCfpVFGAnh2QcaHZ4mZhevwYzF9GW8IaiPqteZ4O0RhO2mre7aJK/Ey92kEnLOPSc
         vgQ4OAHXi9dq1Z2u1kw3MusoT/Jbcp4PRC+B2xf/vPqDDtCS9ziVNLmUxZRpobqd2yEe
         NgOw==
X-Gm-Message-State: AJIora+HgUdBIHLEfvRxV/GMPqXAuy6Bw50MOVxisX6/ysIBhNqx4ygT
        lcyXplptZhGU8oAtkZoWoVP0
X-Google-Smtp-Source: AGRyM1v5CyqW30N2Vvg3TuLNvhA9pSQcOBPGrIHOqNpo3JhXQiyv4ksM9LaSbUsBvxq1xEB1qU9z0Q==
X-Received: by 2002:a05:6e02:174d:b0:2dc:5fe0:eae1 with SMTP id y13-20020a056e02174d00b002dc5fe0eae1mr15701308ill.235.1658251834011;
        Tue, 19 Jul 2022 10:30:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id s4-20020a056e021a0400b002d3ad9791dcsm5966332ild.27.2022.07.19.10.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:30:33 -0700 (PDT)
Message-ID: <19ab5c2b-6506-18c1-b8c1-b96074442edf@github.com>
Date:   Tue, 19 Jul 2022 13:30:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] osx-keychain: fix compiler warning
Content-Language: en-US
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1293.git.1658251503775.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1293.git.1658251503775.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 1:25 PM, Lessley Dennington via GitGitGadget wrote:
> From: Lessley Dennington <lessleydennington@gmail.com>
> 
> Update git-credential-osxkeychain.c to remove 'format string is not a string
> literal (potentially insecure)' compiler warning by treating the string as
> an argument.

>  	if (!argv[1])
> -		die(usage);
> +		die("%s", usage);

Thanks for preparing this for upstream. I reviewed this change as we
were doing related things in the microsoft/git fork. LGTM here, too.

Thanks,
-Stolee
