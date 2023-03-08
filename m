Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F3DC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCHNbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjCHNa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 08:30:29 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6D258B64
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 05:29:21 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id r16so16370575qtx.9
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678282161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8xaRXw75yaoOjgFgujEdeAxiWIyIAYnnbrJdsFFL8Y=;
        b=VJCy9Gq686EbZEem+nXV5uze8xSLUgLDjq+BnkUOeLUQIUB5qHVOlMaIk/NVdZCmJX
         3kMzmkJewWyBWLrzLhyo3MDnlSoUBvCONMtnVyu+dYU7UzWqZ/ChwsQ42qQeimx5iQhi
         s67Pk/9ko4kKPjQdpDsfA6jwBg9UohzkUGScto8/AcefA4slYFDrpiv4A7j79yCGrVjU
         mCJ6ATgyYYhwscZ/pfBl2OjpxMULFVnBXOrP3PrU5y/hx78dg3uZA+PjkdSX7tCy++67
         +gdYRLQ+b8tg1urO5iFLZLFHrTxNyKgyg/YXp/4BXL2kGJWM5zHeqS6tBLuT5P97Ba/c
         4WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8xaRXw75yaoOjgFgujEdeAxiWIyIAYnnbrJdsFFL8Y=;
        b=RctksJc85FDgkbenOEZffLncU1hQiGpr6FN2erAWJXd/9yMps7wLsa4ZeSB1EvhXeS
         ZeQgCp6lVR7wmRT1eYOEEzkHuOdsELqMA1M8qzR15mclxpQTRVES2epNMNo34lVbDP9b
         Z6sY9rz9f9FbjHrFGVptSsXn2kVpfp1N2PQGB7lpQaKncS/QZPuyEzznxf4H/apeo/YN
         vbR3TbPeJiHkrLv9HFrWHFRXP0LRhx0sNDAcSvhbWlpSEGdReeAAJMb9HYMjTXLIL252
         g+Sy54qCsDFhyUOFgzTj3eCrj4DqBBvIv51LCEwFNRJHQ8fdNm4MZL3sFPDxuTqr8JXD
         ZHsg==
X-Gm-Message-State: AO0yUKWTm1QL3inTD8lcsk/RwY0R28X302+/z4C39Xj+LoNobV9AfTK/
        kNgFP+tf20dBZFi32NAQnaiQ
X-Google-Smtp-Source: AK7set+04bP+TMCIZ65syGkUWclxJ06Wyu6mD63ErzEi7EfgSxNgEnDY1MO7KJjSMhrcPNAkRxeVDw==
X-Received: by 2002:ac8:5dcf:0:b0:3bf:db77:8d47 with SMTP id e15-20020ac85dcf000000b003bfdb778d47mr10043224qtx.55.1678282160693;
        Wed, 08 Mar 2023 05:29:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5ddb:559:95a7:8685? ([2600:1700:e72:80a0:5ddb:559:95a7:8685])
        by smtp.gmail.com with ESMTPSA id x12-20020ac84a0c000000b003b62e9c82ebsm11571858qtq.48.2023.03.08.05.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:29:20 -0800 (PST)
Message-ID: <64903e15-014f-a81e-26dc-83e16b632b2b@github.com>
Date:   Wed, 8 Mar 2023 08:29:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <230307.861qm0235d.gmgdl@evledraar.gmail.com> <xmqqttyw1ndr.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqttyw1ndr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2023 12:29 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> But in fact we've been doing the locking since 6c307626f1e (grep:
>> protect packed_git [re-]initialization, 2020-01-15). So the only thing
>> that really needs justification here is that putting the alternates
>> re-reading under the same lock
>>
>> There is a really interesting potential caveat here which you're not
>> discussing, which is...
>>> ...
>>> +void reprepare_alt_odb(struct repository *r)
>>> +{
>>> +	r->objects->loaded_alternates = 0;
>>> +	prepare_alt_odb(r);
>>> +}
>>> +
>>> ...
>> This seems reasonable, but wouldn't this do the same without introducing
>> an API function just for this one use-case?
>>
>> That's of course a nit, and you seem to have been adding this for
>> consistency with reprepare_packed_git(), but it already "owns" the
>> "approximate_object_count_valid" and "packed_git_initialized" flags in
>> "struct raw_object_store".
>>
>> So as we'll only need this from reprepare_packed_git() isn't it better
>> to declare that "loaded_alternates" is another such flag?
> 
> I am not sure I got what you want to say 100%, but if you are saying
> that this "drop the 'loaded' flag and force prepare_*() function to
> redo its thing" must not be done only in reprepare_packed_git(), and
> that inlining the code there without introducing a helper function
> that anybody can casually call without thinking its consequenced
> through, then I tend to agree in principle.  But it is just as easy
> to lift two lines of code from the rewritten/inlined code to a new
> place---to ensure people follow the obj_read_lock() rule, the
> comment before it may have to be a bit stronger, I wonder?

The fact that we do it in a lock in reprepare_packed_git() in the
only current caller does raise suspicion that someone could call it
later and not realize that the lock could be helpful. Inlining the
change within reprepare_packed_git() makes the most sense here
instead of mimicking the pattern.
 
>> Perhaps not, but as the resulting patch is much shorter it seems worth
>> considering.

The shortness of the patch is metric of quality, to me. The other
reason (we might introduce a footgun) is more interesting.

>> ...but to continue the above, the *really* important thing here (and
>> correct me if I'm wrong) is that we really need to *first* prepare the
>> alternates, and *then* do the rest, as our new alternates might point to
>> new loose objects and packs.
> 
> Yes, and as Derrick explained in another message, we only have to
> worry about new ones getting added, not existing ones going away.

I'll be sure to clarify that in my next version.

>> So with both of the above (the same could be done with your new helper)
>> something like this would IMO make that much clearer:
>>
>> 	diff --git a/packfile.c b/packfile.c
>> 	index 79e21ab18e7..50cb46ca4b7 100644
>> 	--- a/packfile.c
>> 	+++ b/packfile.c
>> 	@@ -1008,6 +1008,13 @@ void reprepare_packed_git(struct repository *r)
>> 	 	struct object_directory *odb;
>> 	 
>> 	 	obj_read_lock();
>> 	+	/*
>> 	+	 * New alternates might point to new loose & pack dirs, so we
>> 	+	 * must first read those.
>> 	+	 */
>> 	+	r->objects->loaded_alternates = 0;
>> 	+	prepare_alt_odb(r);
>> 	+
>> 	 	for (odb = r->objects->odb; odb; odb = odb->next)
>> 	 		odb_clear_loose_cache(odb);
>>
>> And, I think this is an exsiting edge case, but we're only locking the
>> ODB of the "parent" repository in this case, so if we have alternates in
>> play aren't we going to racily compute the rest here, the loose objects
>> and packs of the alternates we're about to consult aren't under the same
>> lock?

I don't understand what you are saying here. odb_read_lock() does not
specify a repository and is instead a global lock on reading from any
object database.

Here is its implementation:

extern int obj_read_use_lock;
extern pthread_mutex_t obj_read_mutex;

static inline void obj_read_lock(void)
{
	if(obj_read_use_lock)
		pthread_mutex_lock(&obj_read_mutex);
}

static inline void obj_read_unlock(void)
{
	if(obj_read_use_lock)
		pthread_mutex_unlock(&obj_read_mutex);
}

So I don't believe that your proposed edge case exists.

Thanks,
-Stolee
