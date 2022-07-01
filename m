Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66FEC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 19:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiGATnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiGATn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 15:43:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11262983E
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 12:43:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b125so2546315qkg.11
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0fgF0OwusJ9qP9coDZrI1rqEseeBFt8fepwfCZKT2CY=;
        b=GgoN9RixTxgXGcJCDD0aTjNyXK60tBLvKbMIRoW9zkSQu1QhgxnNJzYn5n2ObhMKLl
         5fOfOPuk71LnaNtcTie+z3c39JrwrOvnq/yKKESV4SGfYU2N+h3JE351eo6252WXHw9Q
         BgN7BwAv5GjLyzOMPC4ALPaA2EyUyuGP9Zpe/8T9CjQ8EaoMWgFN16aGtASCiBOFOS6Z
         nAjgcBm0tsTygmM0edv+iv0lsTMd9AmA4qDYXUAaXBkM8l+cdx0Ypy8ACpXiWI5Qhd0Z
         xX07QdOiix+65Of60gk0gqdJ4fGnlutRQGe9i0ulI0L4ia0Mbybn4RajX3cXoKLEkGw3
         mBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0fgF0OwusJ9qP9coDZrI1rqEseeBFt8fepwfCZKT2CY=;
        b=ZM3Ezu1aVVOyXWw+VEaBnwThP7dzP5ZYb2GBxGLZeOGDfH5xbEiX4SsAdgrLsdzs6T
         cqolN53XwBVrS+WTSSVEwpZINB+WiH8LGZwRCalNjwf0gkkEZZzg9/gBZGYNQEYDvpZn
         5/KDQTwxQynBG5iZQIQBHD5c/XvkUIMrNsiSh1A8W/cokCfAf672xJKL22MQY4LOb+P/
         2ir5GFeuyLshlKd+qoVlru4IGEGXlr9f0lUUkLPni62zxOFzhBzRa9tban1Ei46i4GB2
         lYAHhkXEOKdNe4VAaN7jH4W+pPC5ZfprQSP8QkJjdzdo5qVz14QwfrIGTInAViHQvBi0
         6cJQ==
X-Gm-Message-State: AJIora+RFoiJGqXBuuHsgrn0/PufUTBVrh9dsCbMHy1wMNm7/oZcrrQN
        TCbwA8FNdKNElzRyojT/PDxzfo3zvxi9
X-Google-Smtp-Source: AGRyM1tB40FAzoC6Fw4LZHzAnqV5CJPMdNBOZLHo2LE0P97U89qhyB9MNPjznkPyV5RzqRnI7BoBKg==
X-Received: by 2002:a37:48b:0:b0:6af:2c49:1598 with SMTP id 133-20020a37048b000000b006af2c491598mr11714432qke.121.1656704607903;
        Fri, 01 Jul 2022 12:43:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7520:df4:69fa:89ff? ([2600:1700:e72:80a0:7520:df4:69fa:89ff])
        by smtp.gmail.com with ESMTPSA id z3-20020a05622a124300b00316a384447fsm15368032qtx.16.2022.07.01.12.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 12:43:27 -0700 (PDT)
Message-ID: <b06e2765-940e-0157-4eab-4faf8aefa2f4@github.com>
Date:   Fri, 1 Jul 2022 15:43:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/8] mv: fix out-of-cone file/directory move logic
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2022 10:37 PM, Shaoxuan Yuan wrote:
> ## Changes since PATCH v4 ##
> 
> 1. Fix style-nits.
> 
> 2. Add t1092 tests (2/8) for "mv: add check_dir_in_index() and solve 
>    general dir check issue" (8/8).

Thank you for these updates. I just took a quick
re-read and I'm happy with this version.

Thanks,
-Stolee
