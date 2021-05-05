Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FEC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE756121F
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhEESFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhEESEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:04:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB93AC061350
        for <git@vger.kernel.org>; Wed,  5 May 2021 11:01:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n2so2842264wrm.0
        for <git@vger.kernel.org>; Wed, 05 May 2021 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hXHEua9KbnQgbeqPWZnag12/6c6UYGJQZyRIb4CzkJw=;
        b=Oq9mjgLf5lzyil+G+9ZRKPxHsyuLHCfwxfWNXIDOvowp93KCKp+32KdaOtY+F7FrkL
         oT3MfBNGNQBGZSaz8nMruZH23/jMMg93KHYb4DwQ/ynRSpJPdfjU4fPtlR18XhXjbHMR
         yWiEqd8WYXDgLSeYJSFixg7Fhyu1Z180ZNeLA6v7c6eB6U1De82egctCbACJKIz+XcHT
         THRY8RXQ2g+TGc8+K4y3Ir+UJCiPzB4Qf6Atlh3NvBaLYoDntzPM3FAGYstewjSdfwhX
         axci5Q4qupvrIE6ShM/KvhpNCx6ZE5kRWBvGmMfIWman/lan0DkbIlIzfMgf2nJLAK3Z
         Qqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hXHEua9KbnQgbeqPWZnag12/6c6UYGJQZyRIb4CzkJw=;
        b=Uhiejw7qjKTCFs5a7xGPVvMxB6KYISli1PZKF8R7pNdRRitfXlufPSvwk/6pEF6tAg
         IpKL0J6hylIVQAibll9u6LN2h/AnNa8KzSkNd7rG8w6piaHs/ksLxff0fqzjLigGnqA6
         snWnjvX5a9ZLq+FjZtLeksjhgQDZ+pXIQygAyQqxeEeZfIdlFU1j8bZ8HRpweip+Qmpu
         ITz7OsP1I0yTuQCbRXpDR4btn0nyFhG9YqXcYrtzlitYYVCXAtRpnx23a1am4RtUTSHa
         YLVcwCyJDx2o5DYUK2288I3eCskUgD1jdMYpcdRL+6JHY19bOgDhkeMB/mtZ0Lz8iWWV
         BTRQ==
X-Gm-Message-State: AOAM532ETN8wARK106bzgAZIswSH6B/c5dNPtPqj78AT5Gj4PwZPUkTR
        tlJlfVERQlGZdwMFvTL37hk=
X-Google-Smtp-Source: ABdhPJz9rmKIy5IB+Dt9PqulvmBNi+9wOmnstZzqTum4G4sFyKIzOEighvtFLdGx4cgULNtLigii4A==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr297802wrr.324.1620237659446;
        Wed, 05 May 2021 11:00:59 -0700 (PDT)
Received: from [192.168.1.201] (61.22.198.146.dyn.plus.net. [146.198.22.61])
        by smtp.googlemail.com with ESMTPSA id p17sm16832wru.1.2021.05.05.11.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:00:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] patience diff: remove unnecessary string comparisons
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.948.git.1620120345.gitgitgadget@gmail.com>
 <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com>
 <xmqqpmy658e1.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105051649280.50@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <67b46d8c-6a84-d2f7-dadf-e63050149e93@gmail.com>
Date:   Wed, 5 May 2021 19:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2105051649280.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 05/05/2021 15:58, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Wed, 5 May 2021, Junio C Hamano wrote:
> 
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> xdl_prepare_env() calls xdl_classify_record() which arranges for the
>>> hashes of non-matching lines to be different so lines can be tested
>>> for equality by comparing just their hashes.
>>
>> Hmph, that is a bit different from what I read from the comment in
>> the post context of the first hunk, though.
>>
>> 	/*
>> 	 * After xdl_prepare_env() (or more precisely, due to
>> 	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
>> 	 * is _not_ the hash anymore, but a linearized version of it.  In
>> 	 * other words, the "ha" member is guaranteed to start with 0 and
>> 	 * the second record's ha can only be 0 or 1, etc.
>> 	 *
>> 	 * So we multiply ha by 2 in the hope that the hashing was
>> 	 * "unique enough".
>> 	 */
>>
>> The words "home" and "enough" hints to me that the "ha" member is
>> not hash, but "lineralized version of it" (whatever it means) does
>> not guarantee that two records with the same "ha" are identical, or
>> does it?
>>
>> Well, I should just go read xdl_classify_record() to see what it
>> really does, but if it eliminates collisions, then the patch is a
>> clear and obvious improvement.
> 
> Right. I had the same concern. But it does look as if
> `xdl_classify_record()` replaced the possibly non-unique hash values to
> unique sequential identifiers.
> 
> I have to admit that the code is unnecessarily hard to read for me:
> https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L110-L157
> 
> But I do gather that the loop at
> https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L119-L123
> is called for every line, that it does compare it to every seen line with
> the same hash, and that it exits the loop early if the contents disagree:
> 
> 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
> 		if (rcrec->ha == rec->ha &&
> 				xdl_recmatch(rcrec->line, rcrec->size,
> 					rec->ptr, rec->size, cf->flags))
> 			break;
> 
> Since naming is hard (and you can easily err on saving space at the
> expense of costing readers' time, as libxdiff proves), and since I am
> running out of review time, I'll have to assume that
> https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L150-L154 means
> that indeed, the `ha` field is set to a counter that uniquely identifies
> the line contents:
> 
> 	rec->ha = (unsigned long) rcrec->idx;
> 
> 
> 	hi = (long) XDL_HASHLONG(rec->ha, hbits);
> 	rec->next = rhash[hi];
> 	rhash[hi] = rec;
> 
> So I am fairly confident that the patch is good, and the performance win
> is nice.

Thanks for taking the time to review this patch, I agree with your 
analysis. The output of `git log -p --diff-algorithm=patience 
origin/master` for the whole history of git.git is unchanged by this patch.

Best Wishes

Phillip

> 
> Thanks!
> Dscho
> 
>>
>> Thanks.
>>
>>> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
>>> index 20699a6f6054..db2d53e89cb0 100644
>>> --- a/xdiff/xpatience.c
>>> +++ b/xdiff/xpatience.c
>>> @@ -90,7 +90,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>>>   {
>>>   	xrecord_t **records = pass == 1 ?
>>>   		map->env->xdf1.recs : map->env->xdf2.recs;
>>> -	xrecord_t *record = records[line - 1], *other;
>>> +	xrecord_t *record = records[line - 1];
>>>   	/*
>>>   	 * After xdl_prepare_env() (or more precisely, due to
>>>   	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
>>> @@ -104,11 +104,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>>>   	int index = (int)((record->ha << 1) % map->alloc);
>>>
>>>   	while (map->entries[index].line1) {
>>> -		other = map->env->xdf1.recs[map->entries[index].line1 - 1];
>>> -		if (map->entries[index].hash != record->ha ||
>>> -				!xdl_recmatch(record->ptr, record->size,
>>> -					other->ptr, other->size,
>>> -					map->xpp->flags)) {
>>> +		if (map->entries[index].hash != record->ha) {
>>>   			if (++index >= map->alloc)
>>>   				index = 0;
>>>   			continue;
>>> @@ -253,8 +249,7 @@ static int match(struct hashmap *map, int line1, int line2)
>>>   {
>>>   	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
>>>   	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
>>> -	return xdl_recmatch(record1->ptr, record1->size,
>>> -		record2->ptr, record2->size, map->xpp->flags);
>>> +	return record1->ha == record2->ha;
>>>   }
>>>
>>>   static int patience_diff(mmfile_t *file1, mmfile_t *file2,
>>

