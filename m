Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A2C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 14:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiAJOKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 09:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiAJOKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 09:10:21 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A5C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 06:10:21 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id q3so14559314qvc.7
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 06:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xNROi5+EtsVyCPVZPz+UeGrc3RGXTEDLmGV8H8cFVZc=;
        b=DUIh/gHVyVYh/io6ebDQmjrmlFQPDvjwXkNyt3Hp35oPqbjuDltmGQjyp8UBvaxSDH
         z96kqICVnmdLUw4DELbX+e6jqjMVbqkgJP9dq9O4h6iWmsZn6pcP2ipnSB1WegAqaW5l
         dLCHqOPD1sgY+S4Qmclq3EIaW6t3q+ah6ucyMprp/7buFs5WJmDOtGlEQxRhnM6K5+BW
         Upj2We+pZGIvgo0YGiSL3W0Zb4wzXc+MV2wRyC+A72BYZxhiQNHgrbBNFdcK28PJ1S10
         TXYiMdOg5SakBuXA1aeJqZxUrISJniTo14je9yuW7d8P4L+QhC3Ly4MwW7WxRyERtAmp
         oG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xNROi5+EtsVyCPVZPz+UeGrc3RGXTEDLmGV8H8cFVZc=;
        b=hnBKG66gX60u5f2jDmfVpeCx9Xbct7OdqLELictvKZ5Vo+oK5RssAiCoamwkpvfGYE
         +csKn4gHy5aSov1bQK2e3VYgQo2Gfr0d2u2WVrxgXsHfRSrnX/Lpy+bQ8L3Y7YaS+msT
         lxSnsPcU5ut1qBrj5Re8VKVdT3qi5/HdGaYy1IplEeabqbIQYzPXxGr7OmU6RCjxeCxB
         /+jnDicmnCWHukw+hhjKiJfOaYN10CNZzAY0Zm9k7DrDbjowkRMbbcaqybrUmiCmFqDC
         uWgBk26iY5QtpIUZE/vg+4xHOkRscaxYgeBLPQ3T45ucV61QWkKjf2vhXfALpgE1DTUb
         6fvw==
X-Gm-Message-State: AOAM532wFbBLbYtgS1beVuagoSylCQNHcQYYaxLEZ0eHtEtIa4Eyecib
        wbch0QcgCMUP3f0nnBmQ0GYS
X-Google-Smtp-Source: ABdhPJxdCcarreQyKnHrw1SbUqu2LjQg7pwciZrB3LlJyHT9qFEXMIF6w/5yecIs3Hsn8LU2W8PxCA==
X-Received: by 2002:ad4:5bc1:: with SMTP id t1mr69427341qvt.87.1641823820766;
        Mon, 10 Jan 2022 06:10:20 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id v10sm4119336qkp.105.2022.01.10.06.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 06:10:20 -0800 (PST)
Message-ID: <556f6266-a79f-1d5c-6bd7-79d65223b403@github.com>
Date:   Mon, 10 Jan 2022 09:10:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 8/9] update-index: integrate with sparse index
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <c5b98e36516b8f832576816c202be7581f261909.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BGmaKsvrO1Qxwuj+WgcvuE_NA4agY_HLQ8=csvddRafqw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BGmaKsvrO1Qxwuj+WgcvuE_NA4agY_HLQ8=csvddRafqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Enable usage of the sparse index with `update-index`. Most variations of
>> `update-index` work without explicitly expanding the index or making any
>> other updates in or outside of `update-index.c`.
>>
>> The one usage requiring additional changes is `--cacheinfo`; if a file
>> inside a sparse directory was specified, the index would not be expanded
>> until after the cache tree is invalidated, leading to a mismatch between the
>> index and cache tree. This scenario is handled by rearranging
>> `add_index_entry_with_check`, allowing `index_name_stage_pos` to expand the
>> index *before* attempting to invalidate the relevant cache tree path,
>> avoiding cache tree/index corruption.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/update-index.c                   |  3 +++
>>  read-cache.c                             | 10 +++++++---
>>  t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++++
>>  3 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 187203e8bb5..605cc693bbd 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1077,6 +1077,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>
>>         git_config(git_default_config, NULL);
>>
>> +       prepare_repo_settings(r);
>> +       the_repository->settings.command_requires_full_index = 0;
>> +
>>         /* we will diagnose later if it turns out that we need to update it */
>>         newfd = hold_locked_index(&lock_file, 0);
>>         if (newfd < 0)
>> diff --git a/read-cache.c b/read-cache.c
>> index cbe73f14e5e..b4600e954b6 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1339,9 +1339,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>>         int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
>>         int new_only = option & ADD_CACHE_NEW_ONLY;
>>
>> -       if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
>> -               cache_tree_invalidate_path(istate, ce->name);
>> -
>>         /*
>>          * If this entry's path sorts after the last entry in the index,
>>          * we can avoid searching for it.
>> @@ -1352,6 +1349,13 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>>         else
>>                 pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
>>
>> +       /*
>> +        * Cache tree path should be invalidated only after index_name_stage_pos,
>> +        * in case it expands a sparse index.
>> +        */
>> +       if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
>> +               cache_tree_invalidate_path(istate, ce->name);
>> +
>>         /* existing match? Just replace it. */
>>         if (pos >= 0) {
>>                 if (!new_only)
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 6804ab23a27..bc0741c970d 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -1216,6 +1216,18 @@ test_expect_success 'sparse index is not expanded: blame' '
>>         done
>>  '
>>
>> +test_expect_success 'sparse index is not expanded: update-index' '
>> +       init_repos &&
>> +
>> +       echo "test" >sparse-index/README.md &&
>> +       echo "test2" >sparse-index/a &&
>> +       rm -f sparse-index/deep/a &&
>> +
>> +       ensure_not_expanded update-index --add README.md &&
>> +       ensure_not_expanded update-index a &&
>> +       ensure_not_expanded update-index --remove deep/a
>> +'
> 
> The commit message said this change was about --cacheinfo, but this
> test doesn't use that option.  I'm confused; was this a bad patch
> splitting by chance?
> 

It was not - the commit message title is "update-index: integrate with
sparse index" and the message starts by saying that this patch enables use
of the sparse index for *all* of `update-index` (where "[m]ost variations of
`update-index` work without...making any other updates in or outside of
`update-index.c`").

It goes on to say that the `--cache-info` option is an exception to the
above statement (that most variations work without updates outside
`update-index.c`) because it requires a slight change to
`add_index_entry_with_check(...)` to avoid index corruption. That change is
also in this patch, but it's not the main "focus".

The test added here is intended to broadly test `update-index` with a sparse
index. I'll add a case for `--cacheinfo` in my next re-roll but, for
context, the reason I didn't originally is because I focused on the (as far
as I could tell) most commonly-used variations of `update-index`.

>> +
>>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>>  # in this scenario, but it shouldn't.
>>  test_expect_success 'reset mixed and checkout orphan' '
>> --
>> gitgitgadget
>>

