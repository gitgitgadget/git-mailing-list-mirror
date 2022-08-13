Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B484DC19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 09:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiHMJOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 05:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJON (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 05:14:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D37415FF6
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 02:14:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q30so3465441wra.11
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=Qf/ZKQqeSpMP+pUM6p10r/tB6+85FOQf9Qj6X8F9rFs=;
        b=I+1ljb8X5H7jRi/CZSlOGAI9K5m124A7gq8evnhV+bgTu2v9zMh+YKM51XBbvfybbZ
         3qUBcBd2wsivQwET9SxEYZOfJucn0Z0cvHKKDF0ljkRwqGiXFKnoLbU3Pm+ZeOfHnIsx
         cJ7aZKh6FjFHvgmbgxmGK242g6/VMFcn6Jjhd76vm1vfhknNOmU0eumVfQZBq/zAYPp8
         bue/oRpWE1jCDJmV33cXaELW6/F+4bXu2LI3r18A3kmIkfvVVVeZF6K0xeWyg2Ahsm+n
         6VqukTAbHLrpQV2QnqHp56dBJPzuovL6qbD5IJmgjj9OkiKb2HWlvB/5fyLhQg1A1nsU
         YiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=Qf/ZKQqeSpMP+pUM6p10r/tB6+85FOQf9Qj6X8F9rFs=;
        b=BrPaJJBKAJiPvRhjdviD5dXvgUhRdEMOCEZBfPj5QVvV/f5jU+NgBqfSl97QCxFAoV
         Bf5FxriFqsW0AiZ3+zgcvvz68U/nIvBO6jWsqfnaFFRo/jyI0SRs1uoiUADBQsD0O47v
         K70zW38qUW/RrVA67NyAnGJnbkTn4Vp4R6qKQzHWhGV8YS75jlTBlvHYWud+Qa+aFlUn
         K7J2PUB1JNp6wJT8SWxzLWffrSvkgNiAs4aCZMD1S5K1g8rmCwgpZHiSVoh9T58pX/yj
         JY/jvqOog7EeFGDqQ8AYRngzNEX8rC7mkYLSVJNg03StEzXLk+P9jCdrRwIXGmoCIwev
         rnJw==
X-Gm-Message-State: ACgBeo2JfYZ/w3FAGswjBJDG2/HXqdZi07ADfVz4VPVR0UR33+ltaHoq
        d77R+ckOdrs1dRllAQ7LwN6Hu/t9EzmmpScA
X-Google-Smtp-Source: AA6agR5x9MQV00kWA606tjPZ8X3+L8n5W7zkhZJMWAIaP9++4KxHK6tsvJfFDo5ej6Blte3Q6U85WA==
X-Received: by 2002:a05:6000:118b:b0:21f:110d:99a9 with SMTP id g11-20020a056000118b00b0021f110d99a9mr3797942wrx.505.1660382051142;
        Sat, 13 Aug 2022 02:14:11 -0700 (PDT)
Received: from [192.168.2.52] (68.83-213-117.dynamic.clientes.euskaltel.es. [83.213.117.68])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c478600b003a30fbde91dsm2141252wmo.20.2022.08.13.02.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 02:14:10 -0700 (PDT)
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <xmqq4jymvllq.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <9693b83f-551e-e579-b267-af1d633dc381@gmail.com>
Date:   Sat, 13 Aug 2022 11:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4jymvllq.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 4:47 PM Junio C Hamano<gitster@pobox.com>  wrote:

> The "-d" and "-D" options being the more detructive ones among other
> operation modes of the command, I am not sure if this change is even
> desirable.  Even if it were, the implementation to special case a
> single argument case like this ...
>
>> +     if ((argc == 1) && !strcmp(argv[0], "-")) {
>> +             argv[0] = "@{-1}";
>> +     }
> ... (by the way, we don't write braces around a single statement
> block) would invite cries from confused users why none of these ...
>
>   $ git branch -m - new-name
>   $ git branch new-branch -
>   $ git branch --set-upstream-to=<upstream> -
>
> work and "-" works only for deletion.

Agree. But the approach is to ease the deletion of previous branch,
aligned with merge:

$ git merge - -
merge: - - not something we can merge
$ git merge - old-branch
merge: - - not something we can merge

In fact, I think it is a bit confuse to allow use it that way, and
probably induces to error.

Haven't think about -m, -c. If you think it is a good addition, I can do it.

I can fix the braces around that single statement block, sorry.

