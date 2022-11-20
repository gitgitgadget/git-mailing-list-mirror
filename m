Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F79FC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKTM3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 07:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTM3V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 07:29:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFC1DF1D
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 04:29:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mv18so581969pjb.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+lxg7OyfbouWd9R0/0i7Ct3LLLXfZkViLV+5UW1PAM=;
        b=nrbk2/h8xLZ7A+ik/2W9LS58P81D/NvCZvh4VCW8XL6g5L1THKnYrq6JnPqUBuK/0C
         nzl/G0qD5WKthQ5UZfhMisn2UrY5ZirXg3hriRayhxmzn2bhWy+JmUBTweDVdczJ4snN
         8qSOR2O824lsfcjTGsLYdkiV/1ra1VvoxnafA0e9cLdm3T+QVXwKb4BDOQlSLIpiYyAM
         LaoRbGPx5QO61m5/Bho+JVXzpaSfdohK4HBojge6dfnmlfiuppf2QLK1NKKNDBKOWH4b
         ag3JDcsZMc/XO8c0kn0LRv+6AHFxwndeb7QOgwTr7E9nGg+p19mQ5roxm5HeRhomR16j
         afug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+lxg7OyfbouWd9R0/0i7Ct3LLLXfZkViLV+5UW1PAM=;
        b=a6+C0o1UzzVtW3KJfp+26v14pBXSBZAxx+hiRFfzbwW4bvnkSHZoOMlVAU3pAqZzl0
         LCj5ISP3dPk7QyIZ2gXxMWcpP00NOQc6tf+jFr3z3D/nwhOYNOx4+M+/0wDL7eBIP0QI
         sah+pEOF5xBbB3e6TjGPshdi6aJUbm6XZdtZoxxbJZASitIy/fvI3qaCtSu4VWC7PGZ1
         bO1y8ra9mOHk5ze7v1CzkhmskNlGn59wacyb0L5BHcUpmEC1aLL/MaEH9RCdK0y5+Mus
         p0cde523svRZtI1+tHOTVWu3Rvo08ca0XIi6Fu/tQQv7kO7KTvDkdl3ejjVF+nAejYKE
         DLHg==
X-Gm-Message-State: ANoB5plhpb6QHfd2sleWDRD8w2PiKHvJBK6tZr0cVbpXJ6ankrVEcLvI
        K6jbA6UEfrH01eSuAl3su1o=
X-Google-Smtp-Source: AA0mqf4OKkG3sc0dOTKkzL9xcendCJqqw3d0ic4eDo+XmuxCu6/oexYz3/aFsds9tlhVrvseKJUKLw==
X-Received: by 2002:a17:902:9683:b0:17d:c0e3:fde with SMTP id n3-20020a170902968300b0017dc0e30fdemr7454822plp.29.1668947359731;
        Sun, 20 Nov 2022 04:29:19 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id w184-20020a627bc1000000b0056bb99db338sm6783329pfc.175.2022.11.20.04.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 04:29:19 -0800 (PST)
Message-ID: <4e0ecd76-8bd3-c1c4-69ca-a2de4886f491@gmail.com>
Date:   Sun, 20 Nov 2022 19:29:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Makefile: suppress macOS deprecation warning
To:     Stefan Sundin <git@stefansundin.com>, git@vger.kernel.org
Cc:     Stefan Sundin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1422.git.1668888407433.gitgitgadget@gmail.com>
 <a3cfe081-1e68-edda-b797-e68356988046@gmail.com>
 <CAMDaVWGFi6CD+MMbWG=N57yyb8=k6AouB5h33NkKvs2q4UxRmQ@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAMDaVWGFi6CD+MMbWG=N57yyb8=k6AouB5h33NkKvs2q4UxRmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/22 09:14, Stefan Sundin wrote:
> You are right, Bagas. I assumed, without actually looking it up, that
> the new function had a higher-than-acceptable minimum macOS version
> requirement. It turns out that the new function was added in 10.6
> which is far better than requiring 10.13.
> 
> Please disregard this patch and I will attempt to update the code to
> use the new function instead.

OK. But unfortunately, I don't have any macOS machines handy, so I can't
test your future patch.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

