Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D7EECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiIWQBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiIWQBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 12:01:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC814769D
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:01:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso537954pjm.5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LVg6Z4V9NyntoWkw1qYIh5EX8Qg7IocyjZRMafINJlc=;
        b=YievLT4BJ/7Qj8AZ5jDUZmAtMAQalQP2g9bVa3ANnOF3RyeSNrtZENm3+LGdenAYwP
         8w6s7dbZRObEv0nxcsdH6lLpgcGD5ug5xrRDqOxugp764L6FwTphd0yFR+vKxjPG8iu+
         SZ0DzNbtHjQJfNvamEL/U/K067fFr1YCDkoixDyZSxFOvzvsoY/9te8an1XSH5JtW0Vg
         6ypg3xJmOZJcFWAHJASDYYl2gIsfwTOWJdA93HRByeSPf2TXXYCzweVkWPW6D16Qsg1s
         QEbO/j0Ry20nVlN2HhEWvVLNACSC0uazCu4Y2Cranpz7O8yg0/WOMz3dmvA0h2/s7I1m
         0zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LVg6Z4V9NyntoWkw1qYIh5EX8Qg7IocyjZRMafINJlc=;
        b=b2KBBWuKY3Ckg+02PZ0QPC0MWAa1YOJSigccki0eVGY2TVNOqfp3V5G0v095aG/Av3
         t9nF4nY7JglnzBjOHaRUf2dgt71JsXegnADVL9FXt1NK5lRrsp6Y8o5/tppMByxHzLf7
         ar1lTkP1Z8k80CeHurYp+0/IrVFdCqdG+g2dNvLLKsr0j9ErsLytotFS/3t2iZ1vG0Gg
         YPvj4oP1+MSgvJvEEwHyPOXop/V8eVYZw00YU6I3wjFMYBXKrO4KD7Ode6shetSfNdJZ
         30yireWTwskIyK6FMy2lFX+4pv0CwbE4Col6QxSf6hm/aLVeuOuQD4ZYY2x/vuBaroas
         LrxA==
X-Gm-Message-State: ACrzQf1V4CzKnmu2QAXBE/1i6QylnV3fp6ooaZYuCI15+JmKh0Cq31s0
        PoZ6gRrlvkhFODUyne29qLhA
X-Google-Smtp-Source: AMsMyM6eA0ke3xGFxInMUcFr/MlsiOU8ErJhTna/9o2T6i3cpZ6KRloT9G1AwlYEhyQg2uYiEUWsuQ==
X-Received: by 2002:a17:90b:4a91:b0:202:59ed:94d5 with SMTP id lp17-20020a17090b4a9100b0020259ed94d5mr10042932pjb.213.1663948865681;
        Fri, 23 Sep 2022 09:01:05 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001715a939ac5sm6158696plc.295.2022.09.23.09.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 09:01:05 -0700 (PDT)
Message-ID: <d5c8012b-ccfe-2562-b56c-71b24de900e2@github.com>
Date:   Fri, 23 Sep 2022 09:01:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/1] grep: integrate with sparse index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        avarab@gmail.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Integrate `git-grep` with sparse-index and test the performance
> improvement.
> 
> Changes since v5
> ----------------
> 
> * Drop the `--sparse` option patch and edit corresponding tests. 
>   We can wait until a better name is decided to replace `--sparse`.
> 
> * Modify the commit message, especially get rid of the `--sparse`
>   occurences.
> 

Thanks for the update! Everything in this patch is either part of the
previous version's patch 3 or comes from the tests & sparse index enabling
of the previous patch 2. The resulting patch enables the sparse index for
all usage of '--cached', and avoids any user option changes. 

All that to say, this version looks good to me!

Thanks!
- Victoria
