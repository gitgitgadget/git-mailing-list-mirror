Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D81C433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 01:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiCZBZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCZBZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 21:25:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D735577F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:23:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so6548983pgn.8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m2AdpUvmt+rqk3+xMAKflG2IJYQv+7mFOzf0mGyplzI=;
        b=PssT8d8agMwFCWjp+d2QU6gFJu8yidcb4baIYecKy910LO6vyU78O5ANE39gq9XuWX
         5P8wVyCEmb99BZv7/uvz3+t3GeULwHTjrb3rXVFjfacyu3jsmXu+Zz/Gl7LXwA3KR3/d
         LMR9/W2uW7q9vBHmkVkuioBbwUEjksK7Junj8HHlB5eURg0e+6zQwWMmgImKyNYQFHYm
         0P8Pg2y8R0gh03zVzYw2L74Q/Eo1YjeAmhBSl6yRAxL+T+JsObi+niwCP7jsVAv6do4J
         shpuAbbNCyCZ0S/kHowZTMk+PonCwMQ0pOi/x2YBqSgjtWm3+5lC8UYaD23BZfX2QOCI
         kYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m2AdpUvmt+rqk3+xMAKflG2IJYQv+7mFOzf0mGyplzI=;
        b=Ja2HLhSugx+KCvQzbGSmMSSVQMWqVeQS24ep72DF8miVBHYenSTdttaFd3OoEp5uVM
         dN0zBt5SH7I9xMggDqsmBAbJ0jI1qhXE1y772Gyvnv2b3QGxhwjDZ2SSJaExIsZl6ck+
         t4cMe5t1mRh+7u3LEzva/kkLRNveOhGZhqPq5V4QY9Y6SwRQHnAqWPezu6s8wm6O/b+c
         qn+H1QVVHda6KiriaYcozPSv8ABdy2iPJ+VgnnEM+PO3ed9fiIe0m+Bll0VE/e1XGM39
         gecYh6zUCkFTmfITTcwINtt81V9U2sZCJAsC/tbkZVA1L2Of5yB9MdYVaU6pvsdjbiV7
         fHQQ==
X-Gm-Message-State: AOAM530COkehGHNqV7kaI6QH474nE8QVR6h3Qicw4EFj/zloSBWvFQtU
        eOn1aWJWN7ym1pDdZ/bijbXe
X-Google-Smtp-Source: ABdhPJylk/Dve8l19RcpdxIS4KKmIX1LqJ/WLMnGLZLpQziJVgGiW+QXFHguMaIJfn7CuzK053Z3pQ==
X-Received: by 2002:a63:4e5d:0:b0:381:f11:59f6 with SMTP id o29-20020a634e5d000000b003810f1159f6mr1732744pgl.565.1648257837361;
        Fri, 25 Mar 2022 18:23:57 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id kb13-20020a17090ae7cd00b001c7de069bacsm3753848pjb.42.2022.03.25.18.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 18:23:57 -0700 (PDT)
Message-ID: <703439d9-bf4e-4e71-754b-60dabc07301a@github.com>
Date:   Fri, 25 Mar 2022 18:23:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] mv: refresh stat info for moved entry
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, reichemn@icloud.com
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
 <xmqqk0ch8vc3.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqk0ch8vc3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/read-cache.c b/read-cache.c
>> index 1ad56d02e1d..2c5ccc48d6c 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -148,6 +148,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>>  	untracked_cache_remove_from_index(istate, old_entry->name);
>>  	remove_index_entry_at(istate, nr);
>>  	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
>> +	refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
>>  }
> 
> This is a bit unforunate.
> 
> If we are renaming "foo" to "bar", I wonder if we can grab the
> cached stat info before calling remove_index_entry_at() for "foo"
> and copy it to the new entry we create for "bar".  After all, we
> would be making a corresponding change to rename from "foo" to "bar"
> at the filesystem level, too, no?
> 
> Well, we are already doing that by calling copy_cache_entry().  So
> why do we further need to refresh the cache entry in the first
> place?  There is something fishy going on, isn't it?
> 

After some more debugging, I found that the exact trigger for the "not
uptodate" error is a mismatch between the 'ctime' logged in the index entry
and the 'ctime' found on disk. Because we're copying stat information over
directly from the original index entry in 'git mv', the 'ctime' does *not*
reflect the time of file renaming, leading to the error later.

I think this explains all of the behavior we've seen so far:

1. Any index-refreshing operation run after 'git mv' would prevent the 'git
   reset --merge' error, since the ctime would be updated.
2. The error doesn't happen when the file is created within ~1 second of the
   'git mv' (noticed in the test earlier today [1]), since the 'ctime' would
   be seen as "matching" between the index and on-disk.
3. Adding 'refresh_cache_entry()' (and assigning the return value properly,
   unlike in V1 of this patch) avoids the error for the same reason as #1.

So, based on that, I think a "refresh" at the end of
'rename_index_entry_at()' is still needed, but only the stat info needs to
be updated. If that sounds reasonable, I'll send V2 with that change and
update the test to more appropriately test this scenario. 

Thanks!

[1] https://lore.kernel.org/git/d03a34e6-d6a7-6ddb-5784-57078e32ab89@github.com/

> Puzzling...
> 
> In any case, refresh_cache_entry() either returns ce or create a
> newly allocated entry, so you'd want to first refresh and then the
> add the cache entry returned from the function to the index, I
> think.
> 
> Thanks.

