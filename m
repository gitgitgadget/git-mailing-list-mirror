Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22B1C6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiI0NzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiI0NzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:55:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DECC8559A
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:55:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z97so13274454ede.8
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=t7MfLvQyxW8JKkJvgHO5xeNBVPWsaM4Q2vY58SNL34w=;
        b=nBUUG7Vz7H0GwYJt/6kthL7Dap+8CUhxKWx03SHPvELBt6W8tPL6hV4RVqnrghZX84
         VUibxlKOHaZwjmE5oAD9VORs/qBs0F3X0L01Y36siNUMeBTLQe1BsHQvvMC/4qNqlbIV
         rFj9ps9yNc3YFscBeFhiCZpa6A2mE5Id8IkqTxDnSwmQFhfNwC9dIAIrzzDG5LpS9fZa
         gCxwzcppe9EVCEBAhX++EVrSErO4MVU5zKVXRuYZ3DyRIVW5NpHH6VHzwSATKDf8RpwR
         S/CpRORm0Ysh781hmSTdovtfKMAVnRrSOYYsoLtM2mxzSLuHSXj+X/bujKk7ITzgwK7B
         vpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=t7MfLvQyxW8JKkJvgHO5xeNBVPWsaM4Q2vY58SNL34w=;
        b=6PMF6DJ3zr/UHR+eZFV2+gEQD/ePM3ObM6pgs1cFFm+2ZuMNoqgY3cwA+uSWS1nwuk
         63k2Tm5nx9AGqIWW9l4L0+p390KIk4DGShYZy6QcP5o7VS4mRjLW2YNIWMEuGqan3nUL
         NOwO/Ody2Jhs6PWFKY1SV55VpuUvdUvrg4dqp6h0FK8M1a1VNNf6NlPeFtOFpTm7YTJu
         rcM7x6XoCSvIwXnD6zrV3jn8vZhX/ud3BpALLbrFcT4WDR/+f1+YZtc2RbxttRTZ8m5H
         71C4r0PCoqOndQr7SccgTSOEUrOS0YbKC0D0RZo98WlmZS3w3msZGxvZP5FjXwi3vIqU
         omQQ==
X-Gm-Message-State: ACrzQf0QtUVCPMt4pRupLM/NegSB3m0PNPV048jnGPp4im3+ZZi/UDiC
        /6Do1s0QZEejIJih/dsgego=
X-Google-Smtp-Source: AMsMyM5keu6x2yYGLDUjVXAP+Il4ZjxnPMjHAm7LWrdzNfdA9fGttzJTsDxz4m/yuwEiVR6YkPfY4g==
X-Received: by 2002:aa7:c1d8:0:b0:457:d582:2105 with SMTP id d24-20020aa7c1d8000000b00457d5822105mr148078edp.379.1664286903920;
        Tue, 27 Sep 2022 06:55:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b00781d411a63csm812701eje.151.2022.09.27.06.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:55:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odB38-000O7J-0p;
        Tue, 27 Sep 2022 15:55:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
Date:   Tue, 27 Sep 2022 15:50:29 +0200
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
 <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
Message-ID: <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Phillip Wood wrote:

> On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
>> From: Stefan Xenos <sxenos@google.com>
>> A change table stores a list of changes, and supports efficient
>> lookup
>> from a commit hash to the list of changes that reference that commit
>> directly.
>> It can be used to look up content commits or metacommits at the head
>> of a change, but does not support lookup of commits referenced as part
>> of the commit history.
>> Signed-off-by: Stefan Xenos <sxenos@google.com>
>> Signed-off-by: Chris Poucet <poucet@google.com>
>
>> diff --git a/change-table.h b/change-table.h
>> new file mode 100644
>> index 00000000000..166b5ed8073
>> --- /dev/null
>> +++ b/change-table.h
>> @@ -0,0 +1,132 @@
>> +#ifndef CHANGE_TABLE_H
>> +#define CHANGE_TABLE_H
>> +
>> +#include "oidmap.h"
>> +
>> +struct commit;
>> +struct ref_filter;
>> +
>> +/**
>
> We tend to just use '/*' rather than '/**'

No, we use both, and /** is correct here. It's an API-doc syntax, see
e.g. strbuf.h.

It's explicitly meant for this sort of thing, i.e. comments on public
structs in a header & the functions in a header (and struct members,
etc.).

>> + * This struct holds a list of change refs. The first element is
>   stored inline,
>> + * to optimize for small lists.
>> + */
>> +struct change_list {
>> +	/**
>> +	 * Ref name for the first change in the list, or null if none.
>> +	 *
>> +	 * This field is private. Use for_each_change_in to read.
>> +	 */
>> +	const char* first_refname;
>> +	/**

While we're on nits we tend to add an extra \n before the next API
comment...
