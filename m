Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C823C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiGSSOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbiGSSOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:14:35 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878D5C9C8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:14:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v1so4462993ilg.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dT7/ptoat8b+z/nMLBHuGP+/a9qYOc9010lELcjS0fU=;
        b=Ev0oktgCMDgH1BeETFXZ7L1rD78+XUWmOu1XZUidx8LqfmtdpHTzlYO5zi5JlyH1Ax
         5GdDRL5By1w3fBBPgkWJeFuOgPdPf6rrwLtsJEChVYrKfz9PHhk0pCFSUcjBMxNmJynf
         asnt4f/+3jwLHMEWey1vBV7ChsDBt1F9t/cgk78ymc8fPBX+4oJNYKlPl9mmY7mdvfmE
         kHYy9BEpcMOXdgNTZ9yDS7h23vEebK5GTMLBQtKuFa5ADxnif37DUAWsGXJcpqzjaNqY
         Wy1X2W6njmO2X9F82I84jwmFnzLmsl7QL68rWGwtGzo9GmGBiElnHHychijG7u53ehmu
         YHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dT7/ptoat8b+z/nMLBHuGP+/a9qYOc9010lELcjS0fU=;
        b=KfmOpYS03xNKPFPaIzO8yYc2f3CA+rQt3NtpfItALk+Q7tKvkU8/D4LDQSgoA1nIpP
         JfCBlrTWIaZSRy07X6IsOJzc27RqnBOpXvxl1dU/5ydAJXkeXZPs0oNot/4bk9auM45U
         tzZbCx1BfycTfxC9cLPRqAQc+bCyH505IflX35VwSDI+TA9+b0SO6JjxyZLeuzGJIwHB
         NKOi+BOWFDs1abbN32fJXm+O6Ig8hFfHoytaym/xwEy/PjLOII45jxTuqOmt8RGHQ4Rl
         YXxac4As/YGAsBjybrjFVz2OesukE97osRUFClRsV3RWP5MrN4CZcrbJBA3JC74Bx+Sz
         wFtA==
X-Gm-Message-State: AJIora+33Eapri1wmtlKf+wg8EbYV6QDFvbNQozO5hEpA/TnmXUpKVyg
        6zHMwJ9gUy5pJWMDBgo1L/seUlKxMqV/
X-Google-Smtp-Source: AGRyM1urboyZMS9a5ueYvIDJCzqW0ZWxouozY1+3B5WtvlD+VADnmzIvV3blX1YOO0mW01/VrXkIbA==
X-Received: by 2002:a05:6e02:1c8b:b0:2dc:9d8d:b03c with SMTP id w11-20020a056e021c8b00b002dc9d8db03cmr16698702ill.176.1658254470615;
        Tue, 19 Jul 2022 11:14:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id x2-20020a92d302000000b002dcf9f575bbsm1397622ila.79.2022.07.19.11.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:14:30 -0700 (PDT)
Message-ID: <d30a358e-c9f0-55fa-8c8b-37f0cb0d7eb3@github.com>
Date:   Tue, 19 Jul 2022 14:14:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 6/7] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-7-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-7-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
> Originally, moving an in-cone <source> to an out-of-cone <destination>
> was not possible, mainly because such <destination> is a directory that
> is not present in the working tree.
> 
> Change the behavior so that we can move an in-cone <source> to
> out-of-cone <destination> when --sparse is supplied.
> 
> Such <source> can be either clean or dirty, and moving it results in
> different behaviors:
> 
> A clean move should move the <source> to the <destination>, both in the
> working tree and the index, then remove the resulted path from the
> working tree, and turn on its CE_SKIP_WORKTREE bit.
> 
> A dirty move should move the <source> to the <destination>, both in the
> working tree and the index, but should *not* remove the resulted path
> from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.
> Instead advise user to "git add" this path and run "git sparse-checkout
> reapply" to re-sparsify that path.

I feel like this patch should be two, instead: you can have one that
makes the commands succeed or fail properly, and another that outputs the
advice. As it is, it's a bit muddled as to what is necessary for the
movement of the index entry versus representing the error message.

This might mean that you want to pull the advice messages out of the tests
that are added in patch 1 and only apply those to the test as you implement
the advice in that later patch. Such a split of the test implementation
would allow this patch to still switch a bunch of test_expect_failure tests
to test_expect_success.

> @@ -424,6 +426,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		if (show_only)
>  			continue;
>  		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +		    !(dst_mode & SKIP_WORKTREE_DIR) &&

Here is a use of dst_mode that might be helpful to put with the change in
patch 4. Alternatively, you could delay declaring dst_mode until now.

> +		if (!(mode & SPARSE) && !lstat(src, &st))
> +			up_to_date = !ce_modified(active_cache[pos], &st, 0);

Here, you are only checking for a dirty file if (mode & SPARSE) and the
file exists.

Perhaps it would be helpful to negate this and rename the variable?

	sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);

This makes it clear that we can't use the variable except in this
particular case.

> -		if ((mode & SPARSE) &&
> -		    (path_in_sparse_checkout(dst, &the_index))) {
> -			int dst_pos;
> +		if (ignore_sparse &&
> +		    core_apply_sparse_checkout &&
> +		    core_sparse_checkout_cone) {
>  
> -			dst_pos = cache_name_pos(dst, strlen(dst));
> -			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
> +			/* from out-of-cone to in-cone */
> +			if ((mode & SPARSE) &&
> +			    path_in_sparse_checkout(dst, &the_index)) {
> +				int dst_pos = cache_name_pos(dst, strlen(dst));
> +				struct cache_entry *dst_ce = active_cache[dst_pos];
>  
> -			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
> -				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
> +				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
> +
> +				if (checkout_entry(dst_ce, &state, NULL, NULL))
> +					die(_("cannot checkout %s"), dst_ce->name);
> +				continue;
> +			}

Here, it helps to ignore whitespace changes. This out to in was already
handled by the existing implementation.

> +			/* from in-cone to out-of-cone */
> +			if ((dst_mode & SKIP_WORKTREE_DIR) &&

This is disjoint from the other case (because of !path_in_sparse_checkout()),
so maybe we could short-circuit with an "else if" here? You could put your
comments about the in-to-out or out-to-in inside the if blocks.

> +			    !(mode & SPARSE) &&
> +			    !path_in_sparse_checkout(dst, &the_index)) {
> +				int dst_pos = cache_name_pos(dst, strlen(dst));
> +				struct cache_entry *dst_ce = active_cache[dst_pos];

(It took me a while to realize that dst_ce is the right entry because we
already called rename_cache_entry_at() earlier.)

> +				char *src_dir = dirname(xstrdup(src));

The xstrdup(src) return string is being lost here.

> +
> +				if (up_to_date) {

Based on my recommendation earlier, this would become

	if (!sparse_and_dirty) {

> +					dst_ce->ce_flags |= CE_SKIP_WORKTREE;
> +					unlink_or_warn(src);
> +				} else {
> +					string_list_append(&dirty_paths, dst);
> +					safe_create_leading_directories(xstrdup(dst));
> +					rename(src, dst);

Ok, still doing the file rename, but leaving it unstaged.

> +				}

Please provide some whitespace between the close of an if/else chain before
starting the next if.

> +				if ((mode & INDEX) && is_empty_dir(src_dir))
> +					rmdir_or_warn(src_dir);

This is an interesting cleanup of the first-level directory. Should it be
recursive and clean up an entire chain of paths?

Thanks,
-Stolee
