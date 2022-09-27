Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734DCC6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiI0OOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiI0OOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:14:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EF1BA3A5
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:13:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so5551415wmb.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=llBc7do0okpZSpty2Bix9sK+RVUtRkc8OEzaXsVslxk=;
        b=AY+NnOjPy2v5SK+f8xvJcHyoc3mwfFFWsbyHp9UhkcemsMqKrGi5EDR/BIGJfHeBRB
         Api6v5KBNC+gdyKddS+34GEykxWzYsPcwAu45y4/IeE3M+E6lYKrKWUj7oHqBOkcgFrE
         pkaPkPodNx2+N7Ha8Ci99PaoWF0i8M2twdfb4biLGdxiRssmjbtPceMpx3yuVyV/zuU2
         QdUqnAZJrECzriXY+a9CskEk+uKX8iMCzWu7pRZDb/e5FtXsmLHp0HXMKcYS6n2I3EL0
         t/hZ35Thvh07Lo5QgaZA6V4/vfQGeSJcdQuhX+2RodBI8LgojjLJWVxfAklxqiqBeGDt
         jLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=llBc7do0okpZSpty2Bix9sK+RVUtRkc8OEzaXsVslxk=;
        b=2WIDgxhcT6/r3iRMzlO/7fPDPU+5/Cvr3jycQaC+zVBtejdtp5ZPnxfuekJYUszPaW
         d/GkHiMugqBojvLe0kwotYF4aqztuFBCpHGIw5rDM6cZ8YRekoX/t8IjimJqAzVvtg6u
         dDoYfCH0hNo7T8wo1Gk0OJgACUO9Flbcp8Ff8ymksefcCuAC8ElbJErNhDbAaXZKCmcr
         llD/phhT751QmIsuzto0KY19bg3gOkjz4uDUx3Xt11agaStTFVjMlvsDHES23CeeuXrD
         GjKRx0u0aGBoxYhAL/ke/rDHIohy73ygix2z4NSQt3Vhk8I5TxJ1HxEAmA8dj+iv3as9
         +Zxg==
X-Gm-Message-State: ACrzQf2hy5z1wmpzADc8GFllzc4H0F7ko4j1JTuX9qqAJrr4sK1bCVq/
        iXn4H7QD49LDk08Jyh7JF5jH8A99aQIz2Q==
X-Google-Smtp-Source: AMsMyM7kT9RbUG84+DahHYG++4sZlkNE5sUB4/0jZlhiz6bQGZ+tUuud+0R48Gwzpw3Gef9w6pGcRg==
X-Received: by 2002:a05:600c:348c:b0:3b4:85b6:e7c5 with SMTP id a12-20020a05600c348c00b003b485b6e7c5mr2940571wmq.45.1664288037775;
        Tue, 27 Sep 2022 07:13:57 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003b4931eb435sm15903167wmc.26.2022.09.27.07.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:13:57 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <ae031714-ba51-fe39-6351-ebd638840c32@dunelm.org.uk>
Date:   Tue, 27 Sep 2022 15:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
 <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
In-Reply-To: <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/09/2022 14:50, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 27 2022, Phillip Wood wrote:
> 
>> On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
>>> From: Stefan Xenos <sxenos@google.com>
>>> A change table stores a list of changes, and supports efficient
>>> lookup
>>> from a commit hash to the list of changes that reference that commit
>>> directly.
>>> It can be used to look up content commits or metacommits at the head
>>> of a change, but does not support lookup of commits referenced as part
>>> of the commit history.
>>> Signed-off-by: Stefan Xenos <sxenos@google.com>
>>> Signed-off-by: Chris Poucet <poucet@google.com>
>>
>>> diff --git a/change-table.h b/change-table.h
>>> new file mode 100644
>>> index 00000000000..166b5ed8073
>>> --- /dev/null
>>> +++ b/change-table.h
>>> @@ -0,0 +1,132 @@
>>> +#ifndef CHANGE_TABLE_H
>>> +#define CHANGE_TABLE_H
>>> +
>>> +#include "oidmap.h"
>>> +
>>> +struct commit;
>>> +struct ref_filter;
>>> +
>>> +/**
>>
>> We tend to just use '/*' rather than '/**'
> 
> No, we use both, and /** is correct here. It's an API-doc syntax, see
> e.g. strbuf.h.
> 
> It's explicitly meant for this sort of thing, i.e. comments on public
> structs in a header & the functions in a header (and struct members,
> etc.).

We don't do that consistently, we don't mention them in CodingGuidelines 
and we don't use anything that processes API-doc comments. It would be a 
lot simpler and it would be consistent with our coding guidelines just 
to use the same style everywhere. That would avoid problems where this 
series uses API-doc comments for in-code comments in .c files and where 
single line comments in header files do not use the API-doc syntax.

Best Wishes

Phillip

>>> + * This struct holds a list of change refs. The first element is
>>    stored inline,
>>> + * to optimize for small lists.
>>> + */
>>> +struct change_list {
>>> +	/**
>>> +	 * Ref name for the first change in the list, or null if none.
>>> +	 *
>>> +	 * This field is private. Use for_each_change_in to read.
>>> +	 */
>>> +	const char* first_refname;
>>> +	/**
> 
> While we're on nits we tend to add an extra \n before the next API
> comment...
