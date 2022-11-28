Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0931CC4332F
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 08:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK1Ihr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiK1Iho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 03:37:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2065C3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 00:37:43 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w79so9774714pfc.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47uqb08mq7TNtGBQ3JUYBnS/n/T8GgbJA6UdQ2L4WD0=;
        b=SANHZrUG1G19NlZaf6efxV1qWcq5YcGZ4TG4kB5O+7NDUZHc0xoWgYFx3bmJAfgAEo
         wmV5M4jCaMRrLMG9NBaXQkU7TM13fZLoki/hGA8m7gmsjl+HDuU5K4hjyBGF9e5tQxFE
         Jkbo71gphnnE6Mu/3B1J0WBJZHJUnAs2typyoWSAN7IlSTi2JMFSoYgULp3iXEAiYHkE
         MsuiipOo2H3PPBVjvhqsuN3WTWnqJSNmh+phCpI7Ak5AiItk1zLQ102UnnFWfQ1lTtIP
         WRKXkqYt058pfeZ6a8Y7yCZb2FCHSDJKDt2+ZBuDm6HQUJ7rcO8H1C+9Ulh62EYKbjmX
         0sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47uqb08mq7TNtGBQ3JUYBnS/n/T8GgbJA6UdQ2L4WD0=;
        b=6PbDszYpnN35w6024V2zDRudm1GJpVh5Xe/6c4Zjzj9AVI7YCDSOvOBr0feMVk/RK6
         achHDdvrczBVfer9EFAzzoF8YcvuINFZj4E1tzTj6ccM5SJnMlAH/S14f30VaqrPGVgE
         8A0FEZLCvN2HG53hwyiGS7vGuquiOj2oLpK5uVie/opWDZw16MhDQZ0mV0Gm9oC7eqaO
         03+eW6Z5kQc7/KlaIUcgHRO7jOaDWK33+/g/QH2TXeIvc0W2XYI9P/HYRJ6x8ZKsybmH
         cZEQ55iPZnkLnotFPGrhqQ9qAHh/c+0WzDD1m+CJZcXZIa7EcfQFogzb5W56H2LAAI3o
         mabg==
X-Gm-Message-State: ANoB5pn3n5K3pNWequep6QsFGXVBuQn/r0h5M27Kt66B7BBKvJ2IgKfS
        evQJwlf6OYVubmqdcYsaWwo=
X-Google-Smtp-Source: AA0mqf5Eyu8EDdJPu1xMy4QT+jVyf2eG7xhNsX+tGCW6UMrFErKXRofbtiHHhuQFimEQmADw8kfTYw==
X-Received: by 2002:a63:cf0e:0:b0:477:b603:f754 with SMTP id j14-20020a63cf0e000000b00477b603f754mr23348403pgg.232.1669624663178;
        Mon, 28 Nov 2022 00:37:43 -0800 (PST)
Received: from [192.168.43.80] (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b0056e8eb09d58sm7658906pfh.170.2022.11.28.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:37:42 -0800 (PST)
Message-ID: <abd9d2ce-a68b-905e-4ec2-4964aef6ee6c@gmail.com>
Date:   Mon, 28 Nov 2022 15:37:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] i18n: fix command template placeholder format
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/27/22 00:24, Jean-Noël Avila via GitGitGadget wrote:
 >  static const char * const revert_usage[] = {
> -	N_("git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>..."),
> +	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
>  	N_("git revert (--continue | --skip | --abort | --quit)"),
>  	NULL
>  };
> 

Looks OK, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

