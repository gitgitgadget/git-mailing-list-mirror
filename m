Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA9C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A9B2072E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXsHfo/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKFTxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 14:53:18 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20EAC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 11:53:17 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so1620347wmg.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7kBCfBJQkK7Q0hWfwxjdSwwYeTUDJjxkiCH3KsWcO2g=;
        b=HXsHfo/VtX4C+3PfErOX2bu3mCLcM2KoVkFL1dAUI7H3IafNYg8/biyWvixcMX2yja
         ksUAIQWKABH86njq3pA9qrb7MiuzV/7uam/nLW50h40g/fp5E/fJRIQFnXjDB3HALiXH
         uM+S5xFqENLnAoW+HzG0Cs6BCjcGAOY6ZQQEsrtN3MD4YN/bXVM47brb6cOhy3t4tXnK
         CZXDkS+fCY6GapX3aQ5ko07fY3FCpENrJer2HoKusmzosE+GFBDuZU2J7qfpC/ihyCv/
         QxidZyATJc+9Otcvcxo+eaVWdf8hcHvpODy7zQN3qPzLN+2QAVOVlFM2mEiu3akAuUaa
         syaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kBCfBJQkK7Q0hWfwxjdSwwYeTUDJjxkiCH3KsWcO2g=;
        b=BUN80iWnEvuj9+cTemG+CQXXEuTSU12JhXn8CraasJ45H3F5FmCfxp2DKZHvSrV8GJ
         2ddoSdspFeb0BpBPwLm+XTv3+1jkaRcEuYCNoOi7ZTM+CAlVfTiB1pDv2t00T1xSyrlo
         wS5q2Dvf0FTIdlXmh+cdjfaaVN6jWMNSkCQKW0s+PDaCFeCilGFv5MtikFCtc6oT0vFI
         vFgLGa/nx6uROk67bkxiikgtPgzexZtSOpXjd6nUQKg1Ngpj1bX/kYfOxLM+rR5Ggq+s
         ixVMwy/dni5NxHggxPTOjzZcRPmB2KJ/UjayD7cYGNX8F1fEiyjYQGWo1pmwIUY+n7Hk
         qHlA==
X-Gm-Message-State: AOAM530iwHkAYGEZ6tpFFfRgCQMQ1GUPlKpoCVxL8vb/mcnNGxpGUzuS
        TLCGpCF1J/74hvzROVkx1CNv7o7LWpM=
X-Google-Smtp-Source: ABdhPJzSDiEj0OFSwRFxIWzfk76ok4sx2yBeccSV3dyV3yKN6mGplzjSdY0M5rK9+6Te/k5zG4da7g==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr1188736wmz.87.1604692396365;
        Fri, 06 Nov 2020 11:53:16 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-325-232.w86-199.abo.wanadoo.fr. [86.199.212.232])
        by smtp.gmail.com with ESMTPSA id 89sm4036009wrp.58.2020.11.06.11.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 11:53:15 -0800 (PST)
Subject: Re: [PATCH v3 03/11] merge-index: libify merge_one_path() and
 merge_all()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201005122646.27994-4-alban.gruin@gmail.com>
 <xmqqh7r4uhrn.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <d6598312-00ba-9ec0-1f67-2b3977d7e308@gmail.com>
Date:   Fri, 6 Nov 2020 20:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7r4uhrn.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 09/10/2020 à 06:48, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> diff --git a/merge-strategies.c b/merge-strategies.c
>> index bbe6f48698..f0e30f5624 100644
>> --- a/merge-strategies.c
>> +++ b/merge-strategies.c
>> @@ -2,6 +2,7 @@
>>  #include "dir.h"
>>  #include "ll-merge.h"
>>  #include "merge-strategies.h"
>> +#include "run-command.h"
>>  #include "xdiff-interface.h"
>>  
>>  static int add_to_index_cacheinfo(struct index_state *istate,
>> @@ -212,3 +213,101 @@ int merge_strategies_one_file(struct repository *r,
>>  
>>  	return 0;
>>  }
>> +
>> +int merge_program_cb(const struct object_id *orig_blob,
>> +		     const struct object_id *our_blob,
>> +		     const struct object_id *their_blob, const char *path,
>> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
>> +		     void *data)
>> +{
>> +	char ownbuf[3][GIT_MAX_HEXSZ] = {{0}};
>> +	const char *arguments[] = { (char *)data, "", "", "", path,
>> +				    ownbuf[0], ownbuf[1], ownbuf[2],
>> +				    NULL };
>> +
>> +	if (orig_blob)
>> +		arguments[1] = oid_to_hex(orig_blob);
>> +	if (our_blob)
>> +		arguments[2] = oid_to_hex(our_blob);
>> +	if (their_blob)
>> +		arguments[3] = oid_to_hex(their_blob);
> 
> oid_to_hex() uses 4-slot rotating buffer, no?  Relying on the fact
> that three would be available here without getting reused (or,
> rather, our caller didn't make its own calls and/or does not mind
> us invalidating all but one slot for them) feels a bit iffy.
> 
> Extending ownbuf[] to 6 elements and using oid_to_hex_r() would be a
> trivial way to clarify the code.
> 
>> +	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", orig_mode);
>> +	xsnprintf(ownbuf[1], sizeof(ownbuf[1]), "%o", our_mode);
>> +	xsnprintf(ownbuf[2], sizeof(ownbuf[2]), "%o", their_mode);
> 
> And these mode bits would not need GIT_MAX_HEXSZ to begin with.
> This smells like a WIP that hasn't been carefullly proofread.
> 
> 	char oidbuf[3][GIT_MAX_HEXSZ] = { 0 };
> 	char modebuf[3][8] = { 0 };

So here I picked GIT_MAX_HEXSZ + 1 and 10 for those buffers, they are
already used by builtin/diff.c.

> 	char *args[] = {
> 		data, oidbuf[0], oidbuf[1], oidbuf[2], path,
> 		modebuf[0], modebuf[1], modebuf[2], NULL,
> 	};
>         
>         if (orig_blob)
> 		oid_to_hex_r(oidbuf[0], orig_blob);
> 	...
> 	xsnprintf(modebuf[0], ...);
> 
> 
> Eh, wait.  Is this meant to be able to drive "git-merge-one-file",
> i.e. a missing common/ours/theirs is indicated by an empty string
> in both oiod and mode?  If so, an unconditional xsnprintf() would
> either give garbage or "0" at best, neither of which is an empty
> string.  So the body would be more like
> 
> 	if (orig_blob) {
> 		oid_to_hex_r(oidbuf[0], orig_blob);
> 		xsnprintf(modebuf[0], "%o", orig_mode);
> 	}
> 	if (our_blob) {
> 		oid_to_hex_r(oidbuf[1], our_blob);
> 		xsnprintf(modebuf[1], "%o", our_mode);
> 	}
> 	...
> 
> wouldn't it?
> 

Yes, especially since you suggested to error out if an empty oid has a
non-empty mode in the second patch.

>> +	return run_command_v_opt(arguments, 0);
>> +}
>> +
>> +static int merge_entry(struct index_state *istate, int quiet, int pos,
>> +		       const char *path, merge_cb cb, void *data)
> 
> When we use an identifier "cb", it typically means callback data,
> not a callback function which is often called "fn".  So, name the
> type "merge_fn" (or "merge_func"), and call the parameter "fn".
> 
>> +{
>> +	int found = 0;
>> +	const struct object_id *oids[3] = {NULL};
>> +	unsigned int modes[3] = {0};
>> +
>> +	do {
>> +		const struct cache_entry *ce = istate->cache[pos];
>> +		int stage = ce_stage(ce);
>> +
>> +		if (strcmp(ce->name, path))
>> +			break;
>> +		found++;
>> +		oids[stage - 1] = &ce->oid;
>> +		modes[stage - 1] = ce->ce_mode;
>> +	} while (++pos < istate->cache_nr);
>> +	if (!found)
>> +		return error(_("%s is not in the cache"), path);
>> +
>> +	if (cb(oids[0], oids[1], oids[2], path, modes[0], modes[1], modes[2], data)) {
>> +		if (!quiet)
>> +			error(_("Merge program failed"));
>> +		return -2;
>> +	}
>> +
>> +	return found;
>> +}
> 
> This copies from builtin/merge-index.c::merge_entry().
> 
>> +int merge_one_path(struct index_state *istate, int oneshot, int quiet,
>> +		   const char *path, merge_cb cb, void *data)
>> +{
>> +	int pos = index_name_pos(istate, path, strlen(path)), ret;
>> +
>> +	/*
>> +	 * If it already exists in the cache as stage0, it's
>> +	 * already merged and there is nothing to do.
>> +	 */
>> +	if (pos < 0) {
>> +		ret = merge_entry(istate, quiet, -pos - 1, path, cb, data);
>> +		if (ret == -1)
>> +			return -1;
>> +		else if (ret == -2)
>> +			return 1;
>> +	}
>> +	return 0;
>> +}
> 
> Likewise from the same function in that file.
> 
> Are we removing the "git merge-index" program?  Reusing the same
> identifier for these copied-and-pasted pairs of functions bothers
> me for two reasons.
> 
>  - An indentifier that was clear and unique enough in the original
>    context as a file-scope static may not be a good name as a global
>    identifier.  
> 
>  - Having two similar-looking functions with the same name makes
>    reading and learning the codebase starting at "git grep" hits
>    more difficult than necessary.
> 

I don't plan to remove `git merge-index' -- nor any other program, for
that matter.  Why not renaming merge_one_path() and merge_all(),
merge_index_path() and merge_all_index()?

>> +int merge_all(struct index_state *istate, int oneshot, int quiet,
>> +	      merge_cb cb, void *data)
>> +{
>> +	int err = 0, i, ret;
>> +	for (i = 0; i < istate->cache_nr; i++) {
>> +		const struct cache_entry *ce = istate->cache[i];
>> +		if (!ce_stage(ce))
>> +			continue;
>> +
>> +		ret = merge_entry(istate, quiet, i, ce->name, cb, data);
>> +		if (ret > 0)
>> +			i += ret - 1;
>> +		else if (ret == -1)
>> +			return -1;
>> +		else if (ret == -2) {
>> +			if (oneshot)
>> +				err++;
>> +			else
>> +				return 1;
>> +		}
>> +	}
>> +
>> +	return err;
>> +}
> 
> Likewise.
> 
>> diff --git a/merge-strategies.h b/merge-strategies.h
>> index b527d145c7..cf78d7eaf4 100644
>> --- a/merge-strategies.h
>> +++ b/merge-strategies.h
>> @@ -10,4 +10,21 @@ int merge_strategies_one_file(struct repository *r,
>>  			      unsigned int orig_mode, unsigned int our_mode,
>>  			      unsigned int their_mode);
>>  
>> +typedef int (*merge_cb)(const struct object_id *orig_blob,
>> +			const struct object_id *our_blob,
>> +			const struct object_id *their_blob, const char *path,
>> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
>> +			void *data);
> 
> Call it "merge_one_file_func", probably.
> 
>> +int merge_program_cb(const struct object_id *orig_blob,
> 
> Call it spawn_merge_one_file() perhaps?
> 
>> +		     const struct object_id *our_blob,
>> +		     const struct object_id *their_blob, const char *path,
>> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
>> +		     void *data);
>> +
>> +int merge_one_path(struct index_state *istate, int oneshot, int quiet,
>> +		   const char *path, merge_cb cb, void *data);
>> +int merge_all(struct index_state *istate, int oneshot, int quiet,
>> +	      merge_cb cb, void *data);
>>  #endif /* MERGE_STRATEGIES_H */

Ack for the rest, the two function names are the only thing I am still
missing on this patch right now.

Alban

