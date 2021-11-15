Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E5C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6B063215
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhKOQ3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhKOQ27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 11:28:59 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E2C061570
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 08:25:59 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso14865556otr.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lGciaamOZVNnZ9BXCUzXkeJGaO3h3NNk1Ldb73nFBbo=;
        b=HcdhPfKTa+shM9s9vEcLUpyqkD38NW9OpRRmP7vpEh0A8cJTrFmsEfO0jroRvmmBR6
         ftEYJEKTM1JsTdIO7LfozoUihMAkvU0h+Z+rqChx0XnlgMsrQ930F043Jcr8J+eKlXWJ
         T3vfQd2vjVtBwIPOYxn5whs+mJFbIUggpb7MgGV9MJpGjw82gSe/X9/rJsA8Gg1UJcff
         1a8AowYmabl6WkGy0EeN14xq7BpFG/1BKhIc6FPx5wYVsvQaJSQk2XjV0LERY1hDuTer
         3oC7p5B/7OoSuOt7GhgAqXeA3Z5mIoguUgUFHAkqmTKTypVW7XX2YnKF0gI8/6vAjnp6
         wUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lGciaamOZVNnZ9BXCUzXkeJGaO3h3NNk1Ldb73nFBbo=;
        b=0OONei8KbZ4MiMC4k11wENFIkKulyrb5zh11Ei5GVno0czaK3h81OgGsvSnZiT74s6
         xy5ydMGTzcdSVYU1K9oyYu2cVX6ugAd7IjkaqhUiFtcN9Rnoob97NKCxcfWR328naLfO
         jmTKp7EeeYMR/GHoVoGkFz97Q4S6zn4ShtJg3rJjDt9Fy4pZTwHF4jecjoB95yaNLp3l
         0k4f5z5CFASNAATje2V82/3KvefD9uXeVIl40ZxJ159tIFKVcko3mBYXKpK6yMTjux9J
         IfleioVHF8rwOHKs4p/hfwFV0qncFiEJ/FZcuPSPvmngmn9Qbtol6btkvqWt6tytP9Pf
         kXHA==
X-Gm-Message-State: AOAM532lDpCkbrWpgN1PieY+b3vxxG8/oPXuxWm9efarxIfBxVLA4CYI
        r8GuLmy5lxq2AOU47aFwQzLwszY9fEM=
X-Google-Smtp-Source: ABdhPJz+tsKIZy15pzDUk2UNY/GM+dHgZjyZjCLJZG4pBUy0qU+PCGqS0EwGfxjANB2mwYRyttF4tg==
X-Received: by 2002:a05:6830:4392:: with SMTP id s18mr242486otv.168.1636993558442;
        Mon, 15 Nov 2021 08:25:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a026:e8ce:df21:8431? ([2600:1700:e72:80a0:a026:e8ce:df21:8431])
        by smtp.gmail.com with ESMTPSA id w5sm1342559otk.70.2021.11.15.08.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:25:58 -0800 (PST)
Message-ID: <4ad06bc6-4f11-d6ef-ec95-ab0e9db9c2c7@gmail.com>
Date:   Mon, 15 Nov 2021 11:25:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] midx: fix a formatting issue in "multi-pack-index.txt"
Content-Language: en-US
To:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com
References: <20211115063318.14426-1-dyroneteng@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211115063318.14426-1-dyroneteng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2021 1:33 AM, Teng Long wrote:
> Signed-off-by: Teng Long <dyroneteng@gmail.com>

Hi Teng,

Could you spend some time in your commit message explaining what
is wrong about the characters used for bullet points here?

> -  - A value j referring to the jth packfile.
> -  - An offset within the jth packfile for the object.
> +  * A value j referring to the jth packfile.
> +  * An offset within the jth packfile for the object.
>  - If large offsets are required, we use another list of large
>    offsets similar to version 2 pack-indexes.

Is it that the indentation isn't enough to show a sublist? I see
that the HTML rendering on git-scm.com [1] does fail to show this
sublist, and I could believe that this change would fix it (but I
am not sure).

[1] https://www.git-scm.com/docs/multi-pack-index

Thanks,
-Stolee
