Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF5C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 13:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBMN6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 08:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMN6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 08:58:49 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9370D1969D
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:58:48 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bh15so10228420oib.4
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFb6fccy+z6lClyVskGaW1cpLUQoqlUf5hvDW9Ou7QQ=;
        b=gL9NjIug2xbMGhTL51bd1PaDnjsT8tZ1mVDE5kNq+ChR5nWQT18rm1tksE2Q68oBJK
         trYUXaczgs2opBxR4vZhXgIU4QdjFmCYZpzw2+/bwa2OjFV7Fx5GpVVKwsmePuvexTbf
         miBV86Kl3zHQRKzFNOjZv6KyJSb53omI7fVNa1mv4fPThgYipN3+58hMyObiFOq6Y5jW
         eDoKyMRaOJbUOguDhT0Up7uGkBafGbk3LhzsFWPF3v1MSRCE5xoXByqnlGuVkmnfbZkc
         7DpVAe+P+XQkqVW2n93t8udg//bkaOVmHieXKBEl2whDEOTdyb9ykYVBHTxZJvjuDu2N
         dhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFb6fccy+z6lClyVskGaW1cpLUQoqlUf5hvDW9Ou7QQ=;
        b=E5XMAugVwXPMwXaRlh1nJ1MsmhyGSqHa4jBfaLrveiz/ZUsz2S3qou56boF0UqWufH
         bHZKJQVozb9daPOYK7xn1FB8N3nTktMCzJ57cJ6w8xiIal1oZKuaEbqCbkZcQ9waGUtB
         XLDwnp75IM+WygPvfqzGV1haty/bBFSeWPnfyrvtbWxpF5rlP+32Pd8hK6Frx3pORVi1
         NlwNNTMfkuMGT2yeuDRL3Tw8Fd7GjNmkhkxgmLPv3NLs+tc3JoEdglYD+sKC987fj9ge
         xK8NLGbdfykGhCg1iiQUve53Omk0vAr0FYGG7w7yHfCO4ez+XEzuIQIv2HBYP6bFN2LJ
         2c+w==
X-Gm-Message-State: AO0yUKX5s88lpNzY705cPYT5qhU3qtjdDirIQ4YrMzk4AZWI2l0HQVeZ
        qZHilKRl4Deya1KOw8iM1HiIHo4wJHfPcpk=
X-Google-Smtp-Source: AK7set+n92cV1awikv/QFS/w1muMfmqc3NR6h0ANCkoJkjw6aJ1ic7Ia/MdzJ8/7TRtBXndwh21wIQ==
X-Received: by 2002:aca:2117:0:b0:37b:7cc3:b229 with SMTP id 23-20020aca2117000000b0037b7cc3b229mr9151202oiz.15.1676296727824;
        Mon, 13 Feb 2023 05:58:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:71cb:950b:48ab:5f9? ([2600:1700:e72:80a0:71cb:950b:48ab:5f9])
        by smtp.gmail.com with ESMTPSA id x133-20020acae08b000000b0037868f9e657sm5104266oig.37.2023.02.13.05.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:58:47 -0800 (PST)
Message-ID: <876cf920-113a-90cf-f49e-6e1b7b146acf@github.com>
Date:   Mon, 13 Feb 2023 08:58:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] commit-reach: avoid NULL dereference
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
References: <20230211111526.2028178-1-e@80x24.org>
 <xmqqcz6fesca.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqcz6fesca.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/11/2023 5:43 PM, Junio C Hamano wrote:
> Eric Wong <e@80x24.org> writes:

>> -	for (i = 0; i < from->nr; i++)
>> -		from->objects[i].item->flags &= ~assign_flag;
>> +	for (i = 0; i < from->nr; i++) {
>> +		struct object *from_one = from->objects[i].item;
>> +
>> +		if (from_one)
>> +			from_one->flags &= ~assign_flag;
>> +	}

This looks like a completely safe change to make, so this
patch is good to go.

> The flag clearing rule of this function smells somewhat iffy.  There
> are three primary callers of the function:
> 
>  * commit-reach.c::can_all_from_reach() calls the function, but it
>    has its own loop to clear the flag it asked the function to add.
>    If the function uses the flag as a temporary mark and is designed
>    to clear it from all the objects, as 4067a646 (commit-reach: fix
>    memory and flag leaks, 2018-09-21) states, why should the caller
>    have a separate loop to clear them?

...

> The above seems to indicate that the expectation by callers is a bit
> uneven.  Shouldn't the first onetrust the callee to clear the flag?

Yes, that makes sense. (But there's more!)
 
> Even before 4067a646 (commit-reach: fix memory and flag leaks,
> 2018-09-21), the function had a call to clear_commit_marks() to
> clear two bits it used temporarily.  The reason why 4067a646 needed
> to add this additional flag clearing, whose NULL-dereference bug is
> being fixed with the patch in this thread, is because it marks any
> incoming object that peels to a non-commit (e.g. a blob, a tree, or
> a tag that points at a non-commit) with the flag bit, but such a
> non-commit object is not added to the list[] of commits to be
> processed, before the main processing of this function.
> 
> 		from_one = deref_tag(the_repository, from_one,
> 				     "a from object", 0);
> 		if (!from_one || from_one->type != OBJ_COMMIT) {
> 			/*
> 			 * no way to tell if this is reachable by
> 			 * looking at the ancestry chain alone, so
> 			 * leave a note to ourselves not to worry about
> 			 * this object anymore.
> 			 */
> 			from->objects[i].item->flags |= assign_flag;
> 			continue;
> 		}
> 
> 		list[nr_commits] = (struct commit *)from_one;
> 
> But I am not sure if it is even necessary to smudge the flag for the
> object that was a non-commit (or the tag that peeled down to a
> non-commit).  The main process of this function is a history
> traversal that stops when the "assign_flag" bit is already set on
> the found object, but the object that was part of the incoming
> objects (i.e. in from->objects[] array) that turned out not to be a
> non-commit would not be discovered during this history walk, would
> it?  In other words, if we walk from list[] that is an array or
> commits to the parents (but not its trees and blobs), we won't
> encounter anything but commit.  What does it help to smudge an
> object that peeled down to a non-commit in the incoming set of
> objects, if it would not appear in the walk from list[]?  It would
> not stop the traversal by having the flag.
> 
> So I wonder if we can just stop smudging the assign_flag bit for
> these objects in from->objects[] that do not make it into list[]
> as a simpler fix?  Wouldn't that make the follow-up cleaning loop
> added by 4067a646 (commit-reach: fix memory and flag leaks,
> 2018-09-21) unneeded?

Thanks for digging into the details here. I agree that this extra
assignment of the flag to these non-commit objects is unnecessary
since we intend to clear them by the end of the method and don't
do anything with the flags otherwise.

What you seem to be suggesting is this diff:

diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..8c387911228 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -740,10 +740,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 			/*
 			 * no way to tell if this is reachable by
 			 * looking at the ancestry chain alone, so
-			 * leave a note to ourselves not to worry about
-			 * this object anymore.
+			 * skip it.
 			 */
-			from->objects[i].item->flags |= assign_flag;
 			continue;
 		}
 
@@ -856,17 +854,6 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 
 	result = can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
 					      min_commit_date, min_generation);
-
-	while (from) {
-		clear_commit_marks(from->item, PARENT1);
-		from = from->next;
-	}
-
-	while (to) {
-		clear_commit_marks(to->item, PARENT2);
-		to = to->next;
-	}
-
 	object_array_clear(&from_objs);
 	return result;
 }

And instead of the current patch, this should allow the
following diff hunk instead:

@@ -807,9 +805,6 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
 	free(list);
 
-	for (i = 0; i < from->nr; i++)
-		from->objects[i].item->flags &= ~assign_flag;
-
 	return result;
 }

This avoids the need for the NULL check, since we are skipping the
entire loop. The clear_commit_marks_many() is sufficient. 

Thanks,
-Stolee
