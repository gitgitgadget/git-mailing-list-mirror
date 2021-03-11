Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182BDC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2DE64FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 13:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhCKNNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 08:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhCKNNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 08:13:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC8C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 05:13:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ha17so2687471pjb.2
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g0EgguUV+if6iAW/X6lmqRfh963GqtYZa5vyXfzyVJc=;
        b=Hqns9CfoE/4ukN4hp6Nc3jbr7LSkn9syvZyFbnJjU92vmt0LQ3sow1EDwd4gtlj0hs
         gTe2HAIKNmwuDoo4BBTKMC8ExtsgdfmECVotZ4TUpvbxblfI40Tw+PLopE4cYkXubjYA
         mEZ1qzep1aZuDguPyALOPhE9njeOj3y2J7Guyx7gjvihHSot5YnnUvRSoPp8pGxUdHDz
         DodQX3hj1tK3O1oH037MYyxylA9fE1OPdJAbxYihVfefkKvN/R/ZVh1oHEyx7mp/Q3Vl
         N63uLoTFhN1IbwtFg0xscyWvkVsZC0wKCm8B+Lsrnh+mcON0k8VvNi8dCA4pn1GLB1y9
         eB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0EgguUV+if6iAW/X6lmqRfh963GqtYZa5vyXfzyVJc=;
        b=tAbUvdIIQ6WoEHebjKGX5n9nNvczwh1KcxYeZ2KSznZ3Fqb4Bj24T0H0UWtNSNThw3
         r/FtZislG68AUXGNYET9N2CXuHTklB6tECKpX1MBrOJ5SirDBflOZW2Ztu9UBDO5CCpT
         eRzmcbAg+drYITSwVNEKt1p6JHIxQrYUvkuIHcbzgySSAMtCm24r5MvLjwn4VUGUA9oR
         X5XA4WxMzOYAyy+0qgA0shNxXrwgRqJnqJM8+GOXlvhmpZPvHkOz9B3bo6jHP9+V3sKi
         XRhN6JyOMXqkrSXTM9SwXKTvHCUOnu9mbuQtrGIo1nZLI0rm7S55ZUd6Hq3b9R3rmcH8
         etpQ==
X-Gm-Message-State: AOAM530NmgKIz91CEtMmB44YhLGeLEsmqTqdFtaRD91D9obWk6wwFu/X
        OSB0XRwFFDaktnJhTcgBGKWHU/btRqAetA==
X-Google-Smtp-Source: ABdhPJwdJmXzmrShuABY03P1rGVWCbM81a7brfwfDByKyRlbu2RN/+P+se78WPlqzfpuHE5I1qD0Ag==
X-Received: by 2002:a17:902:fe0d:b029:e5:ffb8:1c28 with SMTP id g13-20020a170902fe0db02900e5ffb81c28mr7857393plj.62.1615468383620;
        Thu, 11 Mar 2021 05:13:03 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id b186sm2449500pfb.170.2021.03.11.05.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 05:13:03 -0800 (PST)
Subject: Re: [PATCH 3/3] po/README: document l10n conventions
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20210311125511.51152-1-bagasdotme@gmail.com>
 <20210311125511.51152-4-bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <9b50b5e1-33c2-2562-4b3a-f25db3f6ac1c@gmail.com>
Date:   Thu, 11 Mar 2021 20:13:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210311125511.51152-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03/21 19.55, Bagas Sanjaya wrote:
> Document things that l10n contributors must folow.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   po/README | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Oh oh oh, typo there. folow -> follow.

> diff --git a/po/README b/po/README
> index eda7edf4e6..e1a0494b17 100644
> --- a/po/README
> +++ b/po/README
> @@ -344,3 +344,24 @@ Below are the usage examples:
>           po-helper.sh check XX.po
>   
>   Run po-helper.sh without arguments for usage help.
> +
> +
> +Conventions
> +-----------
> +
> +There are some conventions that l10n contributors must follow:
> +
> +   1. The subject of each commit should be prefixed with `l10n: `.
> +   2. The length of commit log title (subject) should be less than 50
> +      characters, and the length of other lines (commit log body)
> +      should be no more than 72 characters.
> +   3. Add "Signed-off-by" trailer to your commit log, like other
> +      commits in Git. You can automatically add the trailer by
> +      committing with `git commit -s`.
> +   4. Check syntax with `msgfmt` or `po-helper.sh check` before
> +      committing.
> +   5. Squash trivial commits to make history clear.
> +   6. Do NOT edit files outside po/ directory.
> +   7. Other subsystems ("git-gui", "gitk", and Git itself) have their
> +      own workflow. See Documentation/SubmittingPatches if you want
> +      to make contributions to these subsystems.
> 

-- 
An old man doll... just what I always wanted! - Clara
