Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18C7C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EB522CA1
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLUVyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLUVyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:54:50 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCEBC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:54:10 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id j8so2548917oon.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h7aJbLSmwZScmg7fm9Bk1xYq5BRXtj7hNHgAUdrE1KM=;
        b=WmHAOb4VxG1xuWZn4RDnuY0zpIS5ZxxXxdD7TqhMIT5ig50d0t2QLI3LbyLRUxkr5m
         pYH7dJ3PH87837xFT6ir/x/53w4GXm1lRbfluHbJdbZoeM7KfkNsVD/ppFaRqU1BBwfP
         NhqBF8LoXejx9qWX5KbkqHl/GnF+D/hDTsiHg0zz0E+OKRFEWEam8vyYgPFD69wivB6v
         5hDCOgWRIO5wrT4OrJNZyavksRcBCbwhesRrLUC1UkSzEJmutk3kgSfW0CnRpLweXdVJ
         nR0E3flxI/8//NgcMCcQbF9ewMK/K+hPC/kUbqimPWTgtASvd324N4AVIHO0q7CqPydi
         H9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h7aJbLSmwZScmg7fm9Bk1xYq5BRXtj7hNHgAUdrE1KM=;
        b=HT90Qz4p8NiqJVCYmdSWU8t6mgLGDsAAKqnPkrIVQvA7h8P6MtivrAJlJGE76Xv+C9
         1SFeKvd/363NzaEA4+HNc0hk9i/hwFZ4niLLplQT+i9+146ekzIOqlg0GowRUJd6oPQE
         K6rgGxcQacStdXMVdqXKpGMtAbZx+7nKpys0KpazxEKx4uz+sCpsH4fzjPxeNP3R/spA
         F//5TKqVXqLpSGvEX13e53tWRBNTNKfji0szaiTtn6zsCe5vLYqNolZWw3wGDmP0ZQRB
         Tjvm2tqPs37JRmTwM142JwVxAjAboPdq5tcmY05VhHthabhXF54xJgXJKGop6SlIMnpR
         LoYA==
X-Gm-Message-State: AOAM530sZbc98zobpqKPEo+yuKfUfSEvP7VuGrn4kvvS3mYjMKEk0WdF
        pCbe/7CPpHJNoxn4AXebO/RrDp5xskCHVw==
X-Google-Smtp-Source: ABdhPJw3OWJxBfQNzt9nstH/M/7aBAQu5IgWCZzJ47Rjr1BlsPT39vhiClGHXVscB6IyNIBFLJ+DHw==
X-Received: by 2002:a4a:da44:: with SMTP id f4mr12854077oou.84.1608587649352;
        Mon, 21 Dec 2020 13:54:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id o63sm4047516ooa.10.2020.12.21.13.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 13:54:08 -0800 (PST)
Message-ID: <8ee65ef1-a68b-e881-70af-cb2a492331ca@gmail.com>
Date:   Mon, 21 Dec 2020 16:54:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
Subject: Re: [PATCH 0/3] gc: fix handling of crontab magic markers
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <cover.1608585497.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1608585497.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2020 4:26 PM, Martin Ågren wrote:
> This is a fix for a new bug in the v2.30 cycle:
> 
> `git maintenance [start|stop]` add and/or remove entries to/from the
> user's cron table. When inserting entries, we add magic "BEGIN" and
> "END" markers. When we later removes these entries, we remove everything
> from "BEGIN" to ... the end of file. A realistic scenario for hitting
> this bug is
> 
>   $ git maintenance start
>   $ crontab -e # add stuff at the end of the file
>   $ git maintenance stop
>   $ crontab -l # stuff from above is gone
> 
> The second patch is the actual fix. The first patch is just a very minor
> fix to the documentation. The third patch future-proofs the magic
> markers, so that we can be reasonably sure that all future versions of
> Git stick to these strings.

Thank you for the attention to detail here. I think this series
is succinct and completely correct. Apologies for missing the
obvious "test after the region, too!"

Thanks,
-Stolee
