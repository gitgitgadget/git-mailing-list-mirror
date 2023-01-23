Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F311CC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 04:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjAWEH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 23:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAWEH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 23:07:57 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A25F3588
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 20:07:55 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g16so6794298qtu.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 20:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHejVunqXyhWDMb0JGq13OPpuSesPlW1gKtEAIlsfog=;
        b=D3kd0kYqYGf7GTc98SrXM3+/u/t//yuqV4C943sMUOnOrlw8mJsXc8+fT5dULjBeVJ
         CQ8abqVOE4F7wH8KYkueNc7WLz3lsp+ZW/cQndvyvCs6ST7UbEOif3QwenHOUT0BYhWm
         WJdxexTWg5Kxt7xwowBTeLcWgRy8l5mGtxLc4sFmr9bxNDS7w8ZcIlagYhqvMAQGwe6x
         lezNfPcT7ytAFwSagQJKX2eDoaMVniXe8gFZ8RDOXJDJfktrhSfisqEkQe8NYkUfHv76
         VNVv3FJVuhkn/lD1KzPIoLiosKSt7uwMXvOKOIWelRDgEyqzdZadvT2O5MwRmF6TGxFP
         LEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHejVunqXyhWDMb0JGq13OPpuSesPlW1gKtEAIlsfog=;
        b=wbpmjzPFgBhhorBPpX3De8VLLBsmr8B2+upq7bBm8kH9KtnJa1UldoeirM6cFaw5ID
         T7TIyp8jG5g9HAhRg8mpG43uTx3/+syPL1PPsB3YOUU6pqfQ1ezSreSo+ytbBbiQSQ/v
         L2FrGigmJRM9elYSi3f+/l+yoriWtHBTCLFy1SPcEBrWHd4vDzIEF0tmeQ8v6DkyZMTF
         YKtrgan32yIswrL3VNQSnLA9huuVqC9LUNJqDLGS7ex8JKTsx0HUa4m09qJX3FadRZ0F
         wsR6MxEcbvQLPNGKCXoF+ZlZV/uwhyabZ3DH1GBZOsw8uBpf4I7n9R3tHOJP0WAmK7Sn
         NA1Q==
X-Gm-Message-State: AFqh2kq+1+E5VgqD3dWTNZG/mttFxd5eNr/gdoWrjLB/QjOB6iZ5b/H/
        EZSVhD3BuUVfGI5KEoOiy00=
X-Google-Smtp-Source: AMrXdXsLLCa1p4rK5/5LMrGzDEls9c0IvaAWLQTV2SgZu1bmd1OLqWW1CVi/HMBxy5UvzScvu1bUsw==
X-Received: by 2002:ac8:4c90:0:b0:3ad:202f:8797 with SMTP id j16-20020ac84c90000000b003ad202f8797mr32339302qtv.9.1674446874354;
        Sun, 22 Jan 2023 20:07:54 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:1de8:866f:b711:7175])
        by smtp.gmail.com with ESMTPSA id hj4-20020a05622a620400b003995f6513b9sm23939149qtb.95.2023.01.22.20.07.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jan 2023 20:07:53 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] attr: fix instructions on how to check attrs
Date:   Sun, 22 Jan 2023 23:07:53 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <FBC71853-6FC7-4D6A-83D5-3EDA2250F4DE@gmail.com>
In-Reply-To: <xmqq8rhuturw.fsf@gitster.g>
References: <pull.1441.git.git.1674356774172.gitgitgadget@gmail.com>
 <xmqq8rhuturw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 22 Jan 2023, at 11:10, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> The instructions in attr.h describing what functions to call to check
>> attributes is missing the index as the first argument to git_check_attr.
>>
>> Fix this to make it consistent with the actual function signature.
>
> Sounds quite sensible.  It would have been very good to explain some
> research in the above, like
>
>     When 7a400a2c (attr: remove an implicit dependency on the_index,
>     2018-08-13) started passing an index_state instance to
>     git_check_attr(), it forgot to update the API documentation that
>     was in Documentation/technical/api-gitattributes.txt.  Later,
>     3a1b3415 (attr: move doc to attr.h, 2019-11-17) moved the API
>     documentation to attr.h and made it to a comment, without
>     realizing the earlier mistake.
>
> or something like that.

good tip about including some history. I'll include that in the re-roll

thanks!

>
> Thanks.
>
>> diff --git a/attr.h b/attr.h
>> index 2f22dffadb3..47f1111f391 100644
>> --- a/attr.h
>> +++ b/attr.h
>> @@ -45,7 +45,7 @@
>>   * const char *path;
>>   *
>>   * setup_check();
>> - * git_check_attr(path, check);
>> + * git_check_attr(&the_index, path, check);
>>   * ------------
>>   *
>>   * - Act on `.value` member of the result, left in `check->items[]`:
>>
>> base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
