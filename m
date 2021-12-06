Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500F4C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 13:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbhLFOCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhLFOCj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 09:02:39 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09038C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 05:59:11 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 193so11120874qkh.10
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q9+FYNYL4SuTDwKyTKh16bAfMXQ+Rj9C0GWtot/K3W4=;
        b=IdBqJuocOXr+MjlACCK0DbBPHkHI7yscLswWwGWBcNYWYL7iUEPpEdXtHcOnorh50w
         xx/pCfGTVBiT6sMwJkcGuXdjNYSTII3+kSZ8cqraEI8aymAjDCEEyfX19G1hIMjJ4TE1
         nkfntCprtPM7Kju0nfXg7ydIury+YGbyX8hqP7pCBk4vJUvQXXinN/UHO/fJIrtdVP4z
         8SREORpg3QhmC7CSO8aMIBZhPLknmPjg4loxNmY8W5bWl7LFNwzerrIJYxXEKq+LxMj2
         7ExfF5C32k9nqToAb1GiHI66jH8W4p8SNV2WAb3uoCgqw/DmFAhTgAagt4QKkQ+qPtyr
         TJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q9+FYNYL4SuTDwKyTKh16bAfMXQ+Rj9C0GWtot/K3W4=;
        b=AzK2Gtscr2BawCGcNRJ33pJRHBhH1iTw0YCzQ+XrTKcIrI1hIcCCFd9qQJUsz/TaPB
         ZoOOMiBLt/+72KqAspbbJ8ra0V2Nr0eSCpvpMplpqFArGWanygfjlTQbHpGGW2xM5RhD
         qdZ8sm4VnWW9KuIlnYR8kq0b6RGof685BxOejIC+14L/QFpcVFN3FPjySDqrYzXaHhRf
         CmQ54U99FFVU7lWBLbdDp0Kzf/meMVes/yPQ0BvFhCT9CRjr+Z4ve3fmJalYQdF5W1gz
         MOYDDrrV0Oq1rft81WxuIAvDMMycOvMToZnd16GNbZRGFJzjLRNTrlCvBUuN8zzUfN+v
         lyDw==
X-Gm-Message-State: AOAM5316kjBeWNcuy6WxueeZf2rTMLNDgqkGsq973WyBzKZIAFCY8nO4
        YffhlJ4QBK/dp0lUCgg1yjc=
X-Google-Smtp-Source: ABdhPJxhzO+4yULdQUYJls/nfC5998g5F2MUHjK8b0eqhHNjNJJQt39aEK8a6SWpKQlWhCoyjdKJvg==
X-Received: by 2002:a37:4554:: with SMTP id s81mr32231248qka.762.1638799149961;
        Mon, 06 Dec 2021 05:59:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a127:30a:f299:4fac? ([2600:1700:e72:80a0:a127:30a:f299:4fac])
        by smtp.gmail.com with ESMTPSA id y12sm6294327qko.36.2021.12.06.05.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 05:59:08 -0800 (PST)
Message-ID: <166c107e-1884-ca53-fa46-12b39e6af13f@gmail.com>
Date:   Mon, 6 Dec 2021 08:59:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] unpack-trees: use traverse_path instead of name
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
 <c91421996562ecedab18f8af4ed8a02896584540.1638586534.git.gitgitgadget@gmail.com>
 <CABPp-BEs8_F7SKsxDMd8p03oMn9M3H47=hrPP=AzxsacUkGg_A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEs8_F7SKsxDMd8p03oMn9M3H47=hrPP=AzxsacUkGg_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2021 12:42 AM, Elijah Newren wrote:
> On Fri, Dec 3, 2021 at 6:55 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

>> @@ -1243,11 +1243,11 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
>>         assert(S_ISSPARSEDIR(ce->ce_mode));
>>         assert(ce->name[ce->ce_namelen - 1] == '/');
>>
>> -       if (info->namelen)
>> -               return ce->ce_namelen == info->namelen + p->pathlen + 2 &&
>> -                      ce->name[info->namelen] == '/' &&
>> -                      !strncmp(ce->name, info->name, info->namelen) &&
>> -                      !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen);
>> +       if (info->pathlen)
>> +               return ce->ce_namelen == info->pathlen + p->pathlen + 1 &&
>> +                      ce->name[info->pathlen - 1] == '/' &&
>> +                      !strncmp(ce->name, info->traverse_path, info->pathlen) &&
>> +                      !strncmp(ce->name + info->pathlen, p->path, p->pathlen);
>>         return ce->ce_namelen == p->pathlen + 1 &&
>>                !strncmp(ce->name, p->path, p->pathlen);
>>  }
>> --
> 
> The comment at the beginning of this function (not shown in this
> patch) is now stale and misleading; it should be corrected too.
 
Will do! Thanks for catching that.

Thanks,
-Stolee
