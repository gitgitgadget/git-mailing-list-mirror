Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62715CCA485
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiGSQEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiGSQEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:04:08 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7B651422
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:04:07 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so32402242fac.13
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f2sV3LD5cmsMPyv6rL3UOEcIfzvqv9VY11LUoaaJJR4=;
        b=S/RjEM4mtl88ywJzv59/mrjz0VD3Xi6gRU/mrchEHUi9qLCr/YMviynh40s3DNw7uA
         GnWIeYlHwuKVrszah76fffRHXytMBbmN/0itpz+jo6K4dI9t6QohY4A5csnOZLXwKPBn
         IRfxC7QO/R/H3oe2TPqJC9OwatT7ridJIRwBh7gMMeY0MKuHXH0bMLVUpIoW0e5RLu+4
         d4+NFNwcS5R4g3urKYzjV1oqVdtxUJlQOj90U6m24iHklGe+2xID+2yFM9bOteflCABj
         ElAxsafA+f8HHAuqf+2V2N6eH1g9HRAVSUs+CNDx6VibFEnC+tpyen6U/kmFaUTo25QG
         aF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f2sV3LD5cmsMPyv6rL3UOEcIfzvqv9VY11LUoaaJJR4=;
        b=J4aJwpcwcstNtBmQfZpuLr+Zl13tSCV8xVG6LW1sKyw3MUBtFla1KtpwV+h+D60q4O
         LHgMml/21d35GlMTE3jLlfNKAjp+a6vyUtRWUCq7lbO/ApoQiEdHuYw+3V48VN45gwke
         shaMgb0HSa8W0EXyy/B7Jw8YIAJ5zW7LXOIu61krYxt2nmB4olFpzb+29bgk/vYTcZ3Q
         USrm/4QmglxSsYfo7mPrjnlYb8UMEo3KxWFlK/rrsjxfQP1VwDz7S4yFi3HvCH/WJJst
         1RfvcwypttI7X6FDOHVp1HxK7IXH4g3zWggN3SxD9lpsYlRkl9fJyKr52tMz6c7Yr7r8
         FoMw==
X-Gm-Message-State: AJIora/8b4ce2HOtV3CgJDk5a+bRtxFzeehpzYICeSXMBTbzI+uPkKUU
        UhqgZITemggU1g3F5bGkwaag
X-Google-Smtp-Source: AGRyM1sOqJGc6AnIfMyGXi+vQ3mDkl1lSOSo8VXIlD6eIKkRTtE+cJPvG4Gi6UY04STXr3vTrxnL/g==
X-Received: by 2002:a05:6870:4687:b0:10c:8322:62d9 with SMTP id a7-20020a056870468700b0010c832262d9mr8402oap.257.1658246647224;
        Tue, 19 Jul 2022 09:04:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id n45-20020a4a9570000000b0042313f42b26sm6139396ooi.39.2022.07.19.09.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:04:06 -0700 (PDT)
Message-ID: <91c9b9d1-ae9d-658a-fca6-8bb2e75607e3@github.com>
Date:   Tue, 19 Jul 2022 12:04:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 08/12] rebase: update refs from 'update-ref' commands
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <fb5f64c52010e01ce0b5a886e9611fa2a6ea7833.1657631226.git.gitgitgadget@gmail.com>
 <e40df260-6ca7-10f8-c4bf-82c42585dd12@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <e40df260-6ca7-10f8-c4bf-82c42585dd12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2022 9:25 AM, Phillip Wood wrote:
>> Now that the 'git rebase --update-refs' command is implemented to write
>> to the update-refs file, we can remove the fake construction of the
>> update-refs file from a test in t2407-worktree-heads.sh.
> 
> This is looking good. I've left a few comments, mostly about error propagation. It's nice to see us recording the initial value of the ref when the todo list is created. It's also good to see this using a lock file. We could perhaps lock the file (with a timeout) when we read it in sequencer_get_update_refs_state() to avoid a race where a process is checking out a new branch in one worktree and another is preparing to rebase that branch in another worktree.

>> +static int do_update_ref(struct repository *r, const char *refname)
>> +{
>> +    struct string_list_item *item;
>> +    struct string_list list = STRING_LIST_INIT_DUP;
>> +
>> +    sequencer_get_update_refs_state(r->gitdir, &list);
> 
> We're ignoring any errors here and always returning 0 from this function.

Thanks. Will fix.
 
>> +
>> +    for_each_string_list_item(item, &list) {
>> +        if (!strcmp(item->string, refname)) {
>> +            struct update_ref_record *rec = item->util;
>> +            read_ref("HEAD", &rec->after);

This is the other place where we could have a failure.

>>   +static int do_update_refs(struct repository *r)
>> +{
>> +    int res = 0;
>> +    struct string_list_item *item;
>> +    struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
>> +    struct ref_store *refs = get_main_ref_store(r);
>> +
>> +    sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);

We need to check for failure here, too.

>> +    for_each_string_list_item(item, &refs_to_oids) {
>> +        struct update_ref_record *rec = item->util;
>> +
>> +        if (oideq(&rec->after, the_hash_algo->null_oid)) {
>> +            /*
>> +             * Ref was not updated. User may have deleted the
>> +             * 'update-ref' step.
>> +             */
> 
> Unless we want to support users editing the todo list without using "git rebase --edit-todo" then by the end of the series it is a bug if we leave an entry in the update-refs file that has been removed from the todo list so I wander if we should remove this if().

I think this is leftover from the previous version and will
never happen. If rec->after is null, then it would be removed
earlier when parsing the todo list.

>>   +    do_update_refs(r);
> 
> Should this be inside the "if (is_rebase_i(opts))" that is closed just above it? We're also ignoring the return value.

Couldn't hurt. Should be a no-op if not in interactive mode.

>>   +    write_update_refs_state(&ctx.refs_to_oids);
> 
> We're ignoring the return value. Also I think todo_list_add_update_ref_commands() only ever returns 0.

Thanks for your attention to detail here.

-Stolee
