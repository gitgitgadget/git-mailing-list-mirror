Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB3CC48BC2
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 06:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2795A611C0
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 06:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGGpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 02:45:55 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43888 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFGGpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 02:45:54 -0400
Received: by mail-pf1-f177.google.com with SMTP id t28so12346932pfg.10
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ncjAV/o5oJX9q+uuBYtxte1BsoSKdaii/Fe60r8BFfI=;
        b=jS1x5HKPwAPBrhPlw4s5H6ibwBoS4ufBsK9e9gRdTGUM/W1S5MUrIlUfU+SAyHSnMs
         mx2tqJIdB3DgENhz+APpcrNGZp7IsYfeeFFOPAniRD7UQwpjY4h9L4rgdRrZNtNAjt5B
         fMWLE1stDaxl0hA6q7iZ925r6/Y7gfFWSXTHq+37YJssbZgW3woN2Heg0AjK8GNUe8Db
         aWGjLbCoaY7lqA8eWtE5/AmV7lgckFoqSYOGtu9DwrgGI6f3BrQjxzQt2C/gpOiSQv9S
         w3h80BLZZXTXvDACdOBG+EwgSEFGTqXPIattnHxzMmyyVBeT4DU3ddPMjt4cebwtrBYX
         oBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ncjAV/o5oJX9q+uuBYtxte1BsoSKdaii/Fe60r8BFfI=;
        b=TTeNkq85/dzLUjFgsaLkiLHpycdMxB3cbXUAewjKJg1sdLjB1RzWZQoW2Q8T80svdl
         myJMH6vQVi0MZZQneicpvuGqfJqmSNXHVmdN/sCFwGDxp4rAaExFkDR2dl7aT7oTGXS+
         UIJ2UjKgNQPzHlJW6J8Mdy1e+s6nFes/hfD87O7yZ01xZAI2rr1DDTXpvzXFhh/JyuyI
         dAW08Dc7Z0jH9U7Hm2T0FJMHF/y4nWKeS8h4av7oKckjYppMmQvhiro5GIXTcDQjQU7Y
         hENnUh2Q+48wl4u0uEBuo43b6OEOUiMD5BhJxtmom6JUSo5sGKQzSYlw/3mATapZ+DOB
         nqWw==
X-Gm-Message-State: AOAM531pBWf6r/F0wfvO1dTyqhfmCj5+XeM0Q+Svwe5ldn2Quanycyw9
        QBZtsIY8yI6eJKgyEuBoQyMop5Wz5Ymzog==
X-Google-Smtp-Source: ABdhPJxAKjLPT0o0aGafoO2PsHEA72Scv5eGYfVFx96pzRXUIn278fzR1jcPKRRA87leKenROxhq3g==
X-Received: by 2002:a62:2e04:0:b029:2db:4c99:614f with SMTP id u4-20020a622e040000b02902db4c99614fmr15720102pfu.47.1623048170383;
        Sun, 06 Jun 2021 23:42:50 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-19.three.co.id. [116.206.28.19])
        by smtp.gmail.com with ESMTPSA id o9sm11012582pjp.51.2021.06.06.23.42.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 23:42:50 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [suggestion] support non-negative float number in git-repack
 --max-pack-size
Message-ID: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
Date:   Mon, 7 Jun 2021 13:42:47 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to create packfiles with charm-numbered size (that is for 
example use 49.99M instead of 50M) with git-repack:

$ git repack --max-pack-size=49.99M -a -d

But Git didn't support it:

> error: option `max-pack-size' expects a non-negative integer value with an optional k/m/g suffix

The workaround was scaling down to kibibytes:

$ git repack --max-pack-size=52418K -a -d

But the workaround is a rather convoluted to me, because I must convert 
mebibytes (MiB) to kibibytes (KiB). I had to multiply the desired 
packfile size by 1024, as opposed to by 1000 in familiar size notation 
(kilobytes [KB] and megabytes [MB]).

It would be nice if non-negative floating-point number can be allowed in 
--max-pack-size option, so that many users don't have to scale down size 
notation like above.

PS: charm numbers are most often used in pricing, because it's almost 
used everywhere (part of psychological pricing).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
