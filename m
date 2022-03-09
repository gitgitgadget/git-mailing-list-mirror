Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A054DC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 14:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiCIOg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCIOgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 09:36:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5811942E
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 06:35:54 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id gm1so2085916qvb.7
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 06:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ow51RjsCldTc6/T9KCRXeV+bkTN+E/Wf8L7T2gX/d3Y=;
        b=hhY8li63+O4Z7+zLbqMiux1cHqKfyFpzTHUikK9eRGndaCpXq/jrgWm+9ZKf0lYX9b
         KBjbUrYPuRPqu3gzsJ1tj0gkoE8B+kn5RIjadwxj/Yl+HYFXoaqwWdZokSssRdG1srbK
         sWtsZ1uQhC2gi1gy79OCygmjWpdtf42NBqLPBoG7g+UfZqZlrpXLCgsjFUjtZIk2I6F4
         WTKnDC+404AyAo0//9QsC16ZEEp6GHpPHFrZmY8krtuC2szQqTxL77woZUqrGpiTWdP+
         oNnw2rxUi+tBEwX+l/Tjc/9cUiOFHHoBf1//Zig+GcZMk5J8QJFOSKeiTzN+euiOzicr
         Vhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ow51RjsCldTc6/T9KCRXeV+bkTN+E/Wf8L7T2gX/d3Y=;
        b=gnMaZMVRR7k1SfCZ1UaHll+hCjKJ8h2O/xd71DMn/2gHsGoPGZVe+fxOo0w9y/stz2
         /fWu2zhzKH7qJ9rvy4dCLlI/K/Qt2hIxi8owpGb5hGxIAbARbqUus20OiHP01xJAsFJs
         t/OWLUXcDlK4irQUF3vYIyuddW+xB6wuNZPASVep536u4Sf9LASJCu2eDnHyYWrTBS3v
         oAdEQL4cdwv/kFwjTfyNAvjTfIykntksaBeF+SWdHaMpHwv466Zu9WT9wfiUpWloy+3D
         uMwCa+iLvu1ZBN823TXZ/RRdBpBYu8kh7ELJVe3856M9sG953RrQy3OEpG8Pg5rkgxbR
         L1Jg==
X-Gm-Message-State: AOAM532O9eEq/PiiWxyUW0MBKIA2BJZ1ysFCYQb1fFjBtOh6YsfQ02vL
        eSBcTXLJE8qM2ilfXBHw+g6B
X-Google-Smtp-Source: ABdhPJxLTSkrlonOkHyzKBgqDGTJnK0ekV3UK7Xx3w4uv1I3MC2bHsOvOQTdYQPtpBkxrEe7YYXE1w==
X-Received: by 2002:a05:6214:20a1:b0:42d:6f51:46e2 with SMTP id 1-20020a05621420a100b0042d6f5146e2mr16262103qvd.67.1646836553649;
        Wed, 09 Mar 2022 06:35:53 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002dd2647f223sm1337510qtv.42.2022.03.09.06.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 06:35:53 -0800 (PST)
Message-ID: <98fac88f-71cc-4214-cdb0-4a081a6702f9@github.com>
Date:   Wed, 9 Mar 2022 09:35:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 08/12] bundle: parse filter capability
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <025f38290f5a705c80854a42e1abcaba9a9f336d.1646750359.git.gitgitgadget@gmail.com>
 <xmqq4k48nyjn.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq4k48nyjn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 12:29 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/bundle.h b/bundle.h
>> index 06009fe6b1f..7fef2108f43 100644
>> --- a/bundle.h
>> +++ b/bundle.h
>> @@ -4,12 +4,14 @@
>>  #include "strvec.h"
>>  #include "cache.h"
>>  #include "string-list.h"
>> +#include "list-objects-filter-options.h"
>>  
>>  struct bundle_header {
>>  	unsigned version;
>>  	struct string_list prerequisites;
>>  	struct string_list references;
>>  	const struct git_hash_algo *hash_algo;
>> +	struct list_objects_filter_options filter;
>>  };
> 
> This used to be a pointer to the struct, with "NULL means do not
> filter" semantics, with .nr==0 as BUG().  Which was the same
> justification used when an earlier step added a pointer to the
> filter struct to rev_info.
> 
> Should the same logic applies there to make it into an embedded
> struct in rev_info as well?

You're absolutely right. Making the change will make the
range-diff look absolutely horrid, but the change isn't
terribly hard for the most part.

Thanks,
-Stolee
