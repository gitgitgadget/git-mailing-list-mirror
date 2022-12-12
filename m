Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84C6C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 14:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiLLOSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLLOSp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 09:18:45 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D2EE09
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:18:43 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3b5d9050e48so147728547b3.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTM/krvmmiDIife9+b4IV9dUOdQdG5CF/AEIlEQXVIA=;
        b=HHGaKWEX9ZI9XEQ+WBrClfWwR7wV+vhzy8HqzaxvElLaAAZGgENP/1ZEhzKGUj0Adw
         Oc6Afrt+w6OLgWMeqHO9Zx9PBcUMc86GCrWNqhMFnWawbBKIjupGjX7DsReUiJTatDqh
         Ji0yduvzwupqo1LrxkIq1eCuCyiOWrLsT8TzzFil4bX7zOQo6qQnqnoN1ozhrG05q915
         +ZOid0NXMzoWEpT095iuPM1wbJ/m13w6jj3stG/Q0/foeAX3oKPgw0rJkMqiQ9jQJ8vh
         e9trxIl61LMwe3Po1zfscxjyxD78ZYEFXRj91JXBD1PcKjglEeGvR6F0hZzzkQPUgZuZ
         DM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTM/krvmmiDIife9+b4IV9dUOdQdG5CF/AEIlEQXVIA=;
        b=ICeEeJt8zLo+Xx9Ex6KHkP+ejZMrnMSpCPxPmU41OO3lnDbEGlfj94f5KYK1Ainy2s
         yuFHyci6A5ESajj3iFP2spWLgD8Lwm6rRbES/DamFIDl5gjwVKw3ovMVjfuQvSb3zY4t
         jZj5q2359OGxN9veA5ZFCSe41S72OGHS8QNE+G4SbvG54frWd9M2vCHv6oIM1KMUhojb
         9v06hBz3XCIIuKWgxMH85BM8pGspbTpl5VQu+/91l/n+FiPQVBDSJY/gkf5njb4DiOqa
         W2jp9eYhAnvIPR0591VcYxgPBEa/+wiyh3TXn0CP/ZSbSgB/3aH0yhQEl/Zzzi38vJvQ
         cZsw==
X-Gm-Message-State: ANoB5pme+mHbaD6lypaSJr/k8HfmCyA0esvskMckY6+FSGmdtvBMnbLO
        wgD8G2eOUGlF5wBY9kfBLht6
X-Google-Smtp-Source: AA0mqf65gSwOPmTRv0q9KCnbQ9AIakFQm5iqLer4toec4BKEhmhpim4f/Y/2neMfD3SrGm9/deaxow==
X-Received: by 2002:a05:7500:2b94:b0:ea:28fd:6e1c with SMTP id dr20-20020a0575002b9400b000ea28fd6e1cmr1216341gab.39.1670854722131;
        Mon, 12 Dec 2022 06:18:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:84c8:9ef9:1297:e16e? ([2600:1700:e72:80a0:84c8:9ef9:1297:e16e])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006fa22f0494bsm5892619qkp.117.2022.12.12.06.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 06:18:41 -0800 (PST)
Message-ID: <1b2aa60c-633f-0a7f-e8e3-5d0f01ff94b6@github.com>
Date:   Mon, 12 Dec 2022 09:18:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] features: feature.manyFiles implies fast index writes
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <77bf5d5ff27729a39ac00d52af3c09610d733b14.1670433958.git.gitgitgadget@gmail.com>
 <221207.86v8mm972z.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221207.86v8mm972z.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 5:30 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> diff --git a/read-cache.c b/read-cache.c
>> index fb4d6fb6387..1844953fba7 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2923,12 +2923,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>  	int ieot_entries = 1;
>>  	struct index_entry_offset_table *ieot = NULL;
>>  	int nr, nr_threads;
>> -	int skip_hash;
>>  
>>  	f = hashfd(tempfile->fd, tempfile->filename.buf);
>>  
>> -	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
>> -		f->skip_hash = skip_hash;
>> +	if (istate->repo) {
>> +		prepare_repo_settings(istate->repo);
>> +		f->skip_hash = istate->repo->settings.index_skip_hash;
>> +	}
> 
> Urm, are we ever going to find ourselves in a situation where:
> 
>  * We have read the settings for the_repository
>  * We have an index we're about to write out as our "main index", but
>    the istate->repo *isn't* the_repository.
>  * Even then, wouldn't the two copies of the repos have read the same
>    repo settings?
> 
> But maybe there's a really obvious submodule / worktree / whatever edge
> case I'm missing.
> 
> But if not, shouldn't we just always read/write this from
> the_repository?

I don't understand your concern. We call prepare_repo_settings(istate->repo)
just before using these settings, so we are using whatever repository-local
config we have available to us.

If you're thinking that we could be writing an index but istate->repo is
somehow the "wrong" repo, then that is a larger problem. This patch is
doing the best thing it can with the information it is given.

>> +		rm -f .git/index &&
>> +		git -c feature.manyFiles=true \
>> +		    -c index.skipHash=false add a &&
>> +		test_trailing_hash .git/index >hash &&
>> +		! test_cmp expect hash
> 
> We had a parallel thread where we discussed "! test_cmp" being an
> anti-pattern, i.e. you want them not to be the same, but you want it to
> still show a diff, Maybe just "! cmp" ?

I couldn't tell from this sentence whether test_cmp or cmp would show
the diff, but from testing I see that test_cmp shows the diff (for
debugging purposes, I'm sure) while cmp shows the position of the first
difference.

"! cmp" would work here, since we don't care about what the real hash is.
 
> I.e. either the diff will be meaningless, or we really should be
> asserting the actual value we want, not what it shouldn't be.
> 
> so in this case, shouldn't we assert that it's the 0000... value, or the
> actual hash (depending on which way around we're testing this)?

When it should be the null hash, we assert that it is that value.

When it isn't, we do not assert the exact hash because we do not want
other modifications to the index (or surrounding tests) to cause that
hash to change, causing toil for future contributors. "! cmp" suffices
for this case to show that the config inheritance is working correctly.

Thanks,
-Stolee
