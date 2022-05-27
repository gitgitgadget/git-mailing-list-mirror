Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9D8C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 22:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiE0Wiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiE0Wiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 18:38:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952B162A13
        for <git@vger.kernel.org>; Fri, 27 May 2022 15:38:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c14so5500398pfn.2
        for <git@vger.kernel.org>; Fri, 27 May 2022 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uxDJ6qEyoaYikHKJAlrxaYbU+JnrGSNj3B+UzzhoMhc=;
        b=c6CZOEEAoKVKQegi3hpREtL4QxhYL4WA0uT8fMzSOb7Sq6GEGAKrWT18wG6xkZsyzG
         1Q23bGQEe8hcKgz7oVUSGBKJmZAbvDHz3RhGD8J4ouFVlE9I5lJiyDFgOcpvR6lFKLSJ
         PXbQ+8Xc0hS6mXzwkbOuKBEa6/v/EiwwOdBz9U5lKeZk0BZzT4unYIlTL07xjFBjKuGd
         tUFsi+g2K0Vmny4pNBxyavfOwvkr3SLZ7UeAA9UpERAePJfuuFX7+Ixn6q2Qy/y9vGLu
         Fg4EkXcWAyiYbzQ6XbTUqPbCRJscoE2/vLHCS5w15cmaytRmS4uRFZvLA+tNEuNAxRms
         x0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uxDJ6qEyoaYikHKJAlrxaYbU+JnrGSNj3B+UzzhoMhc=;
        b=tNePh49PwzUDwvkqqBoT2j9MYyH0xe9jr+d8st3A55kDufo5ThGvoCzNowbGRpn22l
         4Kg19SAliDF8Fxz4u5K1QOe/vNFcRRY4/U5F3ITSpY+MuRviW6rT+iK5AltH7/kpBeXd
         2egmnsCH8Xrookn6x/oNJ/l3g+fq5tqL7UOyJllw27hRYrniIMHgjQlyerdguG6YYvhU
         ixazA5s7MIswqnSc8m8vib6+MUPtc91ZnLm+hnFw8ob521fUfx7Vahe/ACEz44cyKHae
         9pyPIIT4+e/XxcHxYvFXE/yGwqM7RFxEEdZTgkCM1awmMGS+6QAisUvQcdmXYicQXvpW
         Uo8g==
X-Gm-Message-State: AOAM530jSFCV1EonvG2ZehA3UdVhtoYB+F+/WpdK3qsyHjZTYD5Dps8L
        fzgaXmU3hQRQ9udYWpykRXAC
X-Google-Smtp-Source: ABdhPJwgyHMA2o5SG2kfKjfvGbARxuybTguCvEmkOgPqrRjIoVCPpyKwP1JwuE1ARhp0VLpWmw8WpA==
X-Received: by 2002:a63:5d21:0:b0:3fa:387b:7b44 with SMTP id r33-20020a635d21000000b003fa387b7b44mr25109333pgb.48.1653691127998;
        Fri, 27 May 2022 15:38:47 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001635dc81415sm4144266pld.289.2022.05.27.15.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 15:38:47 -0700 (PDT)
Message-ID: <b4c94cd9-4afe-cb0b-f60b-48a359f06ae8@github.com>
Date:   Fri, 27 May 2022 15:38:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [WIP v2 2/5] mv: check if out-of-cone file exists in index with
 SKIP_WORKTREE bit
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-3-shaoxuan.yuan02@gmail.com>
 <0884b97b-0745-5cad-3034-a679be5d6c3a@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <0884b97b-0745-5cad-3034-a679be5d6c3a@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> 
> 
> On 5/27/2022 6:08 AM, Shaoxuan Yuan wrote:
>> Originally, moving a <source> file which is not on-disk but exists in
>> index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
>> out with "bad source".
>>
>> Change the checking logic, so that such <source>
>> file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
>> instead of "bad source"; also user now can supply a "--sparse" flag so
>> this operation can be carried out successfully.
>>
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>  builtin/mv.c                  | 26 +++++++++++++++++++++++++-
>>  t/t7002-mv-sparse-checkout.sh |  4 ++--
>>  2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 83a465ba83..32ad4d5682 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -185,8 +185,32 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>  
>>  		length = strlen(src);
>>  		if (lstat(src, &st) < 0) {
>> +			/*
>> +			 * TODO: for now, when you try to overwrite a <destination>
>> +			 * with your <source> as a sparse file, if you supply a "--sparse"
>> +			 * flag, then the action will be done without providing "--force"
>> +			 * and no warning.
>> +			 *
>> +			 * This is mainly because the sparse <source>
>> +			 * is not on-disk, and this if-else chain will be cut off early in
>> +			 * this check, thus the "--force" check is ignored. Need fix.
>> +			 */
> 
> I wonder if this is worth the comment here, or if we'd rather see
> the mention in the commit message. You have documented tests that
> fail in this case, so we already have something that marks this
> as "TODO" in a more discoverable place.
> 
>> +			int pos = cache_name_pos(src, length);
>> +			if (pos >= 0) {
>> +				const struct cache_entry *ce = active_cache[pos];
>> +
>> +				if (ce_skip_worktree(ce)) {
>> +					if (!ignore_sparse)
>> +						string_list_append(&only_match_skip_worktree, src);
>> +					else
>> +						modes[i] = SPARSE;
> 
> 
>> +				}
>> +				else
>> +					bad = _("bad source");
> 
> style nit:
> 
> 	} else {
> 		bad = _("bad source");
> 	}
> 

In case this advice seems contradictory with past style suggestions, from 'Documentation/CodingGuidelines':

	- When there are multiple arms to a conditional and some of them
	  require braces, enclose even a single line block in braces for
	  consistency. E.g.:

		if (foo) {
			doit();
		} else {
			one();
			two();
			three();
		}

>> +			}
>>  			/* only error if existence is expected. */
>> -			if (modes[i] != SPARSE)
>> +			else if (modes[i] != SPARSE)
>>  				bad = _("bad source");
> 
> For this one, the comment makes it difficult to connect the 'else
> if' to its corresponding 'if'. Perhaps:
> 
> 	} else if (modes[i] != SPARSE) {
> 		/* only error if existence is expected. */
> 		bad = _("bad source");
> 	}
> 
>>  		} else if (!strncmp(src, dst, length) &&
>>  				(dst[length] == 0 || dst[length] == '/')) {
> 
> In general, I found this if/else-if chain hard to grok, and
> a lot of it is because we have "simple" cases at the end
> and the complicated parts have ever-increasing nesting. This
> is mostly due to the existing if/else-if chain in this method.
> 

Agreed that the if/else-if chains make 'cmd_mv' complicated. The most
frustrating thing about its current state (unrelated to this patch) is how
unclear it is whether any given conditions are mutually-exclusive vs.
dependent vs. one taking precedence over another. On that note... 

> Here is a diff that replaces that if/else-if chain with a
> 'goto' trick to jump ahead, allowing some code to decrease in
> tabbing:
> 

...while I'm usually hesitant to add more 'goto' labels to the code if it
can be avoided, I think that model fits this use case well.

> ---- >8 ----

[cutting the proposed refactor for space]

> ---- >8 ---
> 
> To me, this is a bit easier to parse, since we find the error
> cases and jump to the action before continuing on the "happy
> path". It does involve that first big refactor first, so I'd
> like to hear opinions of other contributors before you jump to
> taking this suggestion.
> 

I like how the refactored version simplifies 'cmd_mv', and how it
correspondingly simplifies the new checks in this (Shaoxuan's) patch. It
does still leave us with one big, monolithic 'cmd_mv', so in an ideal world
I'd probably lean towards pulling the innards of the main for-loop(s) into a
few dedicated functions (like 'validate_move_candidate', 'move_entry').
However, I'm happy with any improvement, and this refactor would certainly
give us that!

> Thanks,
> -Stolee

