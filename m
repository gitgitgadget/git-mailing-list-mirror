Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617D7C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4013B60F24
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhJKPIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhJKPIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 11:08:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D3C06161C
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 08:06:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y10so27814qkp.9
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kLjd6sH11ODaUNypptA0GuxeAgQuEFexS5xHqbDP/0s=;
        b=GR92wt5KXmX0axTquWGKvYLqaQdlKNmMPKF3BVDYsEe6sI1IRxvT0POk1zsPqTtjqR
         xZDSKwR/XtjAhr6wOVlzhS12sXdMKlY1Z3ZQig8PofyRkQf1X/Sccu8lWGUR+FLOQ5cf
         q8Vtb24T/6B+qknF/97Hlt9IQ/vvmTkPN/gzuSsqxqsBBhnwymy//uf81jHWGUZirb/x
         YgqNgsKTn9iPJKd0ccspUzZmMPFrk0Ff+juIuJujV5157Vtw24a6+B5f4KfePXv0oldD
         gIDlG/8JO2Foc4oBaK+LnyAHTKLZ/CjF3yLVLJi9tuHROKWEAFHUTq+yE7V5OB5ZHSOL
         ac3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kLjd6sH11ODaUNypptA0GuxeAgQuEFexS5xHqbDP/0s=;
        b=MQIReLxKnUIKKXmLSYjWKxkH3xsyTjSERgdcehp1T7K7WAKDiitUnrhsIRI/OCG460
         uIv0ZqLNVQj7+uKWVP6IuqXc92nslQNUpwVbWrabn6d/xo6iEma9snhmhr1yruVwhCzP
         wy+w5E2DNRllcnUbfa30Y2oinaU+goHey8/7N2tAV+fKcSKmNawFMW0P6LCV+XuztEOB
         yy0vMVqdjaRXmKBwQ6V4ooGC4zVOqXtQ4CIyZAnpUwsok5rTI8cWYdWt6Fq+Kzy9oET2
         Jrwm3LZK+dWD1/Egs02dEFBgllU82bwXe3b69J6AmPkL807t7vsovJGk8rlKqU4YR5kU
         YuDw==
X-Gm-Message-State: AOAM532bdrFj3Rns3H3Ni7wH4lHn3I2+r4mJd+DkfDvxx4j7LFCiONDK
        lLIB/zMx61at9tIEv+p95Pju
X-Google-Smtp-Source: ABdhPJyyfhn10li8YDu2U6no4MyEizUGW3SAa8eCTw3rdse/PzZLXu/RPlemigh9faB0QCnk2ydUjg==
X-Received: by 2002:a37:bb07:: with SMTP id l7mr15645230qkf.123.1633964760561;
        Mon, 11 Oct 2021 08:06:00 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id bm27sm4446962qkb.6.2021.10.11.08.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 08:06:00 -0700 (PDT)
Message-ID: <b7227617-0c99-3899-a234-037fe9c23558@github.com>
Date:   Mon, 11 Oct 2021 11:05:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
Content-Language: en-US
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
 <xmqq35pcm6m9.fsf@gitster.g>
 <72f4df1e-54ef-6bdb-ef71-1f115e92c9a5@github.com>
 <xmqqily7l9i5.fsf@gitster.g> <cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 10/8/21 1:19 PM, Junio C Hamano wrote:
>> Victoria Dye <vdye@github.com> writes:
>>
>>> I tried coming up with a user-facing name that wasn't too focused on the
>>> internal implementation, but it ends up being misleading. The intention was
>>> to have this be a variation of `git update-index` that uses the default
>>> setting for `command_requires_full_index` but then proceeds to read and
>>> write the index as `update-index` normally would. Something like
>>> `--use-default-index-sparsity` might have been more accurate?
>>
>> The option name in the reviewed patch does imply "we force expanding
>> to full" and not "use the default", so it probably needs renaming,
>> if we want the "use the default" semantics.  But is that useful in
>> the context of the test you are using it in place of "reset" or "mv"?
>> Even if the default is somehow flipped to use sparse always, wouldn't
>> the particular test want the index expanded?  I dunno.
>>
>>> In the test's use-case, `active_cache_changed` ends up set to
>>> `CACHE_TREE_CHANGED`, which forces writing the index. It is still
>>> effectively a no-op, but it serves the needs of the test.
>>
>> Ah, cache-tree is updated, then it's OK.
>>
>> As to test-tool vs end-user-accessible-command, I do not have a
>> strong opinion, but use your imagination and ask Derrick or somebody
>> else for their imagination to see if such a "force expand" feature
>> may be something the end-users might need an access to in order to
>> dig themselves out of a hole (in which case, it may be better to
>> make it end-user-accessible) or not (in which case, test-tool is
>> more appropriate).
> 
> I think there is something to be said about the name being confusing,
> because the current implementation focuses on "expand a sparse index
> upon read" but it also allows the index to be written as sparse.
> 

This helps clarify what I was misinterpreting in the test. It isn't looking
for "default" behavior, it's verifying whether trace2 logs capture index
expansion and collapse when those operations are expected to happen,
regardless of whether that's because `command_requires_full_index` is 1 or
because the command needs to use entries inside of sparse directories. With
that interpretation, I can replace the command with `git reset
update-folder1 -- folder1/a` and get the same result (without needing to
change the test in the future *or* add a new `git` command option /
`test-tool` subcommand).

> Conversely, if the user runs
> 
>   git -c index.sparse=false update-index ...
> 
> then the index.sparse config setting forbids conversion from full to
> sparse, but does not say anything about expanding to full.
> 
> Perhaps this should be corrected: the index.sparse=false setting
> should expand a sparse index to a full one, then prevent it from
> being converted to a sparse one on write.
> 
> This diff should do it:
> 
> diff --git a/read-cache.c b/read-cache.c
> index 564283c7e7e..04df1051e18 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2376,7 +2376,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	if (!istate->repo)
>  		istate->repo = the_repository;
>  	prepare_repo_settings(istate->repo);
> -	if (istate->repo->settings.command_requires_full_index)
> +	if (!istate->repo->settings.sparse_index ||
> +	    istate->repo->settings.command_requires_full_index)
>  		ensure_full_index(istate);
>  
>  	return istate->cache_nr;
> 
> Victoria, what are your thoughts about including such a change?
> 

I think this is a worthwhile change, but I'd prefer submitting it separately
(either in an upcoming sparse index integration or on its own). It's not
directly needed by anything in this series, and I'd like to avoid adding
features to the scope if possible.
