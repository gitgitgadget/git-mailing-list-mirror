Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB3C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjBURHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjBURHw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:07:52 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E355B1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:07:51 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1720433ba75so6412285fac.5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKofp5GaNV4gKAfeJ0Zy/jtszMfnxNTwxC37kfXMyzw=;
        b=WsXCgSKqTmKMTwabyPklTCaT6OV6Do20BIm0rpmR8ODwKyDKv697GdN4ODoyWjyOkG
         K4KhqQNmsd1KVxTjFga2glb7E0WlXKgIgpmNNUeX6RHElKGkCzy3KZzRQJiD931eupWd
         BVQHlSdU1uk5sE9DSeT2FEaHUKBQwuWNDP6xr1dNX1zTkgw9OfeqTXPMVYcI1kI/0a1g
         Q6+yh9RQs20+14o2dMNFtQnbo42+yf5qYm16jinoWpjkiTzT5rkg5hY5iA5UBQ/aHN54
         B4wBjE6EpJVC0ux7GGAE1u5+zPjpDH8gVj3D5vhoDHxJoBaKfVlW+ci3tpsOEccldXIM
         0ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKofp5GaNV4gKAfeJ0Zy/jtszMfnxNTwxC37kfXMyzw=;
        b=ujRYvqGL6IQKmo0neg5LkCT+ttgBPhzMrkLNyzXjjK4/6pBi4/jah9Rp96kIza6T3I
         nKu9fSOwvLNdsFXmLYpw52sDJFKHzcZq5sc+PBm2EHJ3HiZuIJemfkEMbd/YDyZwQMlW
         qKW1+jACf4NjL7L4Ljo86F0oP0llpTV/j4AZM0SnSaeNx5lJLx/AxSmpHTvJ0fh8HPj5
         AqCZRFZ+WckYtAuNPu7xOnrKouhsj04lAVSXmKqdrJxAgYkj7cBrt3fTKfHut/ba+MAA
         ObOefjCTeO/yGkyIpCLChAwG5igqJFq3mpQTVBbrN+PAyse66GWykCUd1gxkY1HSsXFQ
         42nw==
X-Gm-Message-State: AO0yUKUtyeBawsMjAvimI0ACzcUcCLfDhBJClCp0pWfWcZ3Lf0T+2WS5
        cX/Tn0RLBBxfpa9E6P615NVTGgKrDzCsBps=
X-Google-Smtp-Source: AK7set85fdsmqaYPYtSvPEdFav9SLjS6FWpSEMg373sSwaa8WnEk3jiYnfGXRFN0nL7KIDwiEc+NWA==
X-Received: by 2002:a05:6871:1c5:b0:16e:676:bfea with SMTP id q5-20020a05687101c500b0016e0676bfeamr6822319oad.9.1676999270838;
        Tue, 21 Feb 2023 09:07:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f4bf:9183:9c31:c1de? ([2600:1700:e72:80a0:f4bf:9183:9c31:c1de])
        by smtp.gmail.com with ESMTPSA id zj16-20020a0568716c9000b001724742cfcesm52387oab.38.2023.02.21.09.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:07:50 -0800 (PST)
Message-ID: <44bb24fb-ab5b-f4a2-f9ae-90439e9c33a8@github.com>
Date:   Tue, 21 Feb 2023 12:07:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] rebase -i: check labels and refs when parsing todo
 list
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
 <pull.1482.v3.git.1676999137195.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1482.v3.git.1676999137195.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2023 12:05 PM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>     Changes from V2:
>     
>      * Fix some whitespace issues pointed out by Stolee.

Thanks for the quick update. LGTM.

-Stolee
