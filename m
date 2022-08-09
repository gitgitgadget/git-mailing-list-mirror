Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74BC00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 03:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHIDQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 23:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHIDQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 23:16:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1AF1C928
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 20:16:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so7868813pgm.5
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WSiExACYiDi/zj6W8MVO9YO3Fqb7COisKWpSs3T9k34=;
        b=KW5+A2I7+egv0nL2Cd+bK2/AJN3bNo0j47DQksV76zPyM8osWxfauE7cXa1eKCyH7N
         j6IKCeG/ScjgBGux7oul1Lb8Sn147xIll8bwi5vOSCTfHh2Pf+qiBCUvJAryhPylj0Cb
         GQF9HURwUiIFDG3+BSTfk80qZBUsat1+YqDCOeqChMmBp4Z7wY6WdU1u4LpgIwhreR2F
         JNkHfg2vJatVeXy3VALrpOxxgC08LdM747H+A33wwfTv18+ZtiTyyXVINoLY8QPOf1Lh
         hbfyrjYXEJZBnede/sIjyEfOp/SVMWeYYx8ENc/LCDHd6SHISgG1ZFnjrZmdQSYiyvw/
         7/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WSiExACYiDi/zj6W8MVO9YO3Fqb7COisKWpSs3T9k34=;
        b=p4/zkZLxGzkO8EoytvbkXqUIcvd8QSbWE+wyNqKCQcT48jZ/G6hAGdZqRKtooJ/DMF
         LyhMmITOFKgTAZ3OKA+GVL8Pjy1Yq5RxvQVL8sgAl0mB0r2qYkSySL+aGB+Zew6sGklo
         W0BupZpfEV2s3pYrM/uA9v30x0RBRd9SIIyNsUiFN/jxE+U1XeB113G/1/qaVgoF/fdR
         X6vL6BEhijEQS2X492HkIrQScQk3xtkG2Z3wSS4S/4TVIAFDXoI0dx/5cizp7DUG2tlY
         7+lW0f62dhUKpFcIwc0eIetpibCsGEFga74LMLSV53GlaRBTEhfCURxIYm135g+HaqMb
         /qMA==
X-Gm-Message-State: ACgBeo1+yF80EkVoJ/RkdLD4m5wOOWanRmvhnTft7x7t5Q48+x8BvZ9N
        xL5uwvaXSTdVXmHX3zl+JOBcx0OnztSK8g==
X-Google-Smtp-Source: AA6agR7M1gGGFTcCKPHrz8vnCCwd6cPOadOaJ82W9sZBUCwCB4KoSkJKorCfBQxVTKyKqmJdKMs28g==
X-Received: by 2002:a63:2b8e:0:b0:41d:6d37:b259 with SMTP id r136-20020a632b8e000000b0041d6d37b259mr6876626pgr.208.1660014968716;
        Mon, 08 Aug 2022 20:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b0016efad0a63csm9550963plb.100.2022.08.08.20.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 20:16:08 -0700 (PDT)
Message-ID: <c6888e45-79d6-40b4-dc1c-0454486fc6f1@gmail.com>
Date:   Tue, 9 Aug 2022 11:16:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/9] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-7-shaoxuan.yuan02@gmail.com>
 <9718ab8a-5a1a-d93c-ae8f-aa06f6822577@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <9718ab8a-5a1a-d93c-ae8f-aa06f6822577@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/9/2022 8:53 AM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> Originally, moving an in-cone <source> to an out-of-cone <destination>
>> was not possible, mainly because such <destination> is a directory that
>> is not present in the working tree.
>>
>> Change the behavior so that we can move an in-cone <source> to
>> out-of-cone <destination> when --sparse is supplied.
>>
>> Such <source> can be either clean or dirty, and moving it results in
>> different behaviors:
>>
>> A clean move should move the <source> to the <destination>, both in the
>> working tree and the index, then remove the resulted path from the
>> working tree, and turn on its CE_SKIP_WORKTREE bit.
> It looks like this description is the same as what you wrote in patch 1 [1].
> That's fine with me but, as noted in [2], I wanted to double-check whether
> the "move <src> to <dst> in worktree, then remove <dst> from worktree" is an
> accurate description of what's happening.
>
> [1] https://lore.kernel.org/git/20220805030528.1535376-2-shaoxuan.yuan02@gmail.com/
> [2] https://lore.kernel.org/git/bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com/

This description is incorrect, as I mentioned in a previous email [3] :)
[3] 
https://lore.kernel.org/git/651d89e2-5282-2cf8-ffc3-8650a023c80a@gmail.com/

>> A dirty move should move the <source> to the <destination>, both in the
>> working tree and the index, but should *not* remove the resulted path
>> from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>> Helped-by: Victoria Dye <vdye@github.com>
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>   builtin/mv.c                  | 55 +++++++++++++++++++++++++++++------
>>   t/t7002-mv-sparse-checkout.sh |  8 ++---
>>   2 files changed, 50 insertions(+), 13 deletions(-)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 1dc55153ed..e4a14aea2d 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -171,12 +171,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   	};
>>   	const char **source, **destination, **dest_path, **submodule_gitfile;
>>   	const char *dst_w_slash;
>> -	enum update_mode *modes;
>> +	enum update_mode *modes, dst_mode = 0;
>>   	struct stat st;
>>   	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>>   	struct lock_file lock_file = LOCK_INIT;
>>   	struct cache_entry *ce;
>>   	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
>> +	struct string_list dirty_paths = STRING_LIST_INIT_NODUP;
>>   
>>   	git_config(git_default_config, NULL);
>>   
>> @@ -214,6 +215,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
>>   		    empty_dir_has_sparse_contents(dst_w_slash)) {
>>   			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
>> +			dst_mode = SKIP_WORKTREE_DIR;
>>   		} else if (argc != 1) {
>>   			die(_("destination '%s' is not a directory"), dest_path[0]);
>>   		} else {
>> @@ -408,6 +410,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   		const char *src = source[i], *dst = destination[i];
>>   		enum update_mode mode = modes[i];
>>   		int pos;
>> +		int sparse_and_dirty = 0;
>>   		struct checkout state = CHECKOUT_INIT;
>>   		state.istate = &the_index;
>>   
>> @@ -418,6 +421,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   		if (show_only)
>>   			continue;
>>   		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
>> +		    !(dst_mode & SKIP_WORKTREE_DIR) &&
>>   		    rename(src, dst) < 0) {
>>   			if (ignore_errors)
>>   				continue;
>> @@ -437,17 +441,49 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>   
>>   		pos = cache_name_pos(src, strlen(src));
>>   		assert(pos >= 0);
>> +		if (!(mode & SPARSE) && !lstat(src, &st))
>> +			sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);
>>   		rename_cache_entry_at(pos, dst);
>>   
>> -		if ((mode & SPARSE) &&
>> -		    (path_in_sparse_checkout(dst, &the_index))) {
>> -			int dst_pos;
>> +		if (ignore_sparse &&
>> +		    core_apply_sparse_checkout &&
>> +		    core_sparse_checkout_cone) {
>> +			if ((mode & SPARSE) &&
>> +			    path_in_sparse_checkout(dst, &the_index)) {
>> +				/* from out-of-cone to in-cone */
>> +				int dst_pos = cache_name_pos(dst, strlen(dst));
>> +				struct cache_entry *dst_ce = active_cache[dst_pos];
>> +
>> +				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
>> +
>> +				if (checkout_entry(dst_ce, &state, NULL, NULL))
>> +					die(_("cannot checkout %s"), dst_ce->name);
>> +			} else if ((dst_mode & SKIP_WORKTREE_DIR) &&
>> +				   !(mode & SPARSE) &&
>> +				   !path_in_sparse_checkout(dst, &the_index)) {
>> +				/* from in-cone to out-of-cone */
>> +				int dst_pos = cache_name_pos(dst, strlen(dst));
>> +				struct cache_entry *dst_ce = active_cache[dst_pos];
> It looks like the above conditions assume "out-of-cone <src>" and
> "out-of-cone <dst>" are mutually exclusive. Have you checked what happens
> when you try a move like that?

Do you mean can <src>  and <dst> both be out-of-cone (out-to-out move)?
If that's your question, I'm not sure about the answer. As for now, `mv` has
addressed the following conditions:

1. in-to-in
2. in-to-out
3. out-to-in

But out-to-out is something mysterious at this point.

> If the behavior is sensible, it would be nice to add a test (in 't7002'?)
> establishing that. Otherwise, changing that behavior is reasonably outside
> the scope of this series, so it's fine with me if you add a either
> "test_expect_failure" test, an "unsupported" warning message earlier in
> 'mv', or even just a "NEEDSWORK" comment somewhere around this code.

Yes, I will try test this mode and see where it goes. Based on the test 
result I'll
decide if that's an easy fix or should be marked as "NEEDSWORK". I 
prefer to leave
it to a future patch, though :)

Thanks for the catch!


