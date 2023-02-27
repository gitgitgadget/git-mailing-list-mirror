Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D4C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjB0Nv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 08:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjB0Nv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 08:51:57 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC6D335
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 05:51:56 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1720433ba75so7430129fac.5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXKW+Vb8jN/3246ctl4FS0GK+ZRaB7kSDa5qnAQ9e8s=;
        b=M1307S1pv+1lGq2SL8VigvDRBHK/4/6BSHoLRWIeZGCmZJ3KRERLilqXNhGGQfEljB
         CCtl5d5CihBILx5TtPwAUOhYhdDwvxC8kdQHYBZabR/ejfQnfBIA+vlOIVe5M6flQ4dm
         B2ZY6Tg2LXmW1xQOHganjnURQB6SZabChmhFdJ6VIu6MkNjmR24iUFofFQVixX/XnKvK
         sScTgWNtwoY8gavR2rTcxVDeQ0Vk9gPPsw4PWT5pkgdQR/h9IohfW7KkzACirudW6rDp
         LhyBQsfb+1PPhHNBFch6PIyQDcGYkxWRb0RWv/bMxvBFEcwI1i7G9t1uCSgUnOc1jqcd
         cHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXKW+Vb8jN/3246ctl4FS0GK+ZRaB7kSDa5qnAQ9e8s=;
        b=lnhLjhCWXMQAx8t5d95BVPkVdy3jpjw1EmboY8fopzgbHru6NseiIxqJMldIkwgMGp
         aN4NR9O78L74jDlrc698HvoBqQ0+QhktigwyY1bv3lRIruzEMFRydOQP/rRlzE/CNsQc
         PiMlAJ4CbEKEmtUCAqcfEJJ8TQcUsA2B3lgwRta9NTaeffUhJ1IrQB9L/hsOkP+2phN3
         t1wmVvH/sj8g+twpXdu6G0xbuelQYMq7HRV7MVZabJAkdQYXf4WPxXrQJS+CSOB/vdXz
         proZ3cuw3nL35J3TsldfO9nV1mCa0anz+LACdO95hB4JdXhNUCLz32GnuoRPrXH394Q5
         pq1A==
X-Gm-Message-State: AO0yUKUN6SFIEZjsbQ3OCdK4AErl42aoM9obmDgzbAwgf7mC3WSy/73A
        AkWhKUq1QkWjYIhdyZayZWYN
X-Google-Smtp-Source: AK7set9jM4PH04T7M7gYVVZ6mqLC5IqvXJYQPU9kAcBCoJaaq815uy4npiAqm5IvdKkQqm2e7CGChw==
X-Received: by 2002:a05:6870:73d4:b0:16d:fa4b:f66e with SMTP id a20-20020a05687073d400b0016dfa4bf66emr19598773oan.33.1677505915957;
        Mon, 27 Feb 2023 05:51:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c838:390d:932c:3ee6? ([2600:1700:e72:80a0:c838:390d:932c:3ee6])
        by smtp.gmail.com with ESMTPSA id a4-20020a056870b30400b001728669a604sm2304555oao.5.2023.02.27.05.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:51:55 -0800 (PST)
Message-ID: <d130d7df-313f-bb6f-524c-d1204c0ce627@github.com>
Date:   Mon, 27 Feb 2023 08:51:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/17] Header cleanups
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 7:09 PM, Elijah Newren via GitGitGadget wrote:

> Changes since v1:
> 
>  * Fixed a bad squash; moved the changes to the right commit
>  * More thorough justification in the commit message for the 2nd commit
>  * Removed an accidental added include of gettext.h (the file was used, but
>    it makes it harder to review that patch)
>  * Add some explanation of surprising changes to commit messages
>  * Add a new commit which removes the include of hex.h from cache.h, and
>    instead makes C files include it directly, as suggested by Stolee

I'm happy with these updates. Thanks for the series!

-Stolee
