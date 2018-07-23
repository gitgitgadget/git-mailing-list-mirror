Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823731F597
	for <e@80x24.org>; Mon, 23 Jul 2018 14:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbeGWPQK (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 11:16:10 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46350 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWPQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 11:16:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so722755qtn.13
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GzUqwSm0dPC+Wtb9GRK7O9op1yUuKVd6bVyuTBb7SCg=;
        b=jweDMWfDyq7xhUrWuAJfzNc5ZZNxFbICJcPmUXrM2gizSC19CC4vIFhtCQw6JPdowg
         SvCtxm2cxMlf6jysoWCGghKPz3NWD8bjSfhYhe4yoQJT1dinh2MKyeH2dOILwQR6MROE
         EX3I6/PyMA+vLwAx0yQTIlOh42hSfxqvqKQUZljGWBFBmrwW0PKZTy3RUWbmuIYRy1Zz
         KMv8nVkX8QxtlHrDkbLT5DqkEt5u4ptBC4MfrMdJwW6wb5EPwEB+Q2DRQu1u064cjNKn
         WliFu2bb5eOVGTmHD0+yYXmnDYkHVbpTsgayWQmWZw7N7pTr74A9RBLIfwJsdGZJ211g
         PElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GzUqwSm0dPC+Wtb9GRK7O9op1yUuKVd6bVyuTBb7SCg=;
        b=Q2LnOFa9qGR0SQpoRLGNW73hcU4B7fArsUrPYLg0fnO2Wj1Wv6LPAa4wAEl2NfyE3m
         ZnSonQEk79+RwFIG0Tm9ZrobZHBw7w8PINI84/MQ2B2wSx0vnqDfXNK5YA/JqkcvjiCd
         rYAtATe5Ik6HDwl0l/JPTwdjBKBiYj3XSM/OtDnMTGWnz8ft52ruthlHblUYtcIkPZp3
         b2FZ+SOgH1wH4wzPaousD0MM0CkoZe0rIDRsWVkqkbI3CeBqlAvWXr5h62iwXzi0M1ib
         Y9jGYwYK6RwniFTgg0fRc58+PInCPXsdpgsLL7JtX322oUxs7Xp6jmNcm5bmsJ9o3+yG
         92sQ==
X-Gm-Message-State: AOUpUlExBPYzPOXFkhntxHeDjXUiP5MgOoIA4OFxd+Z60pR5yAUd8S5l
        VHhlbsb3R4tugdzM93Nl+AA=
X-Google-Smtp-Source: AAOMgpdJZoiKTOwueapJo6AOQxX4IokIYdP7xyi2FWianZOu1f8EmkJ6UjZT3eOsItE3GXAWRHx0LA==
X-Received: by 2002:ac8:19cb:: with SMTP id s11-v6mr12403900qtk.229.1532355281518;
        Mon, 23 Jul 2018 07:14:41 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m95-v6sm6022795qte.69.2018.07.23.07.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:14:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] merge-recursive: preserve skip_worktree bit when
 necessary
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, kewillf@microsoft.com
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com>
 <20180721063428.20518-3-newren@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <75aa297e-4857-d92a-7041-618ff3b0b77a@gmail.com>
Date:   Mon, 23 Jul 2018 10:14:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721063428.20518-3-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



<snip>
>   merge-recursive.c               | 16 ++++++++++++++++
>   t/t3507-cherry-pick-conflict.sh |  2 +-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 113c1d696..fd74bca17 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3069,10 +3069,26 @@ static int merge_content(struct merge_options *o,
>   	if (mfi.clean &&
>   	    was_tracked_and_matches(o, path, &mfi.oid, mfi.mode) &&
>   	    !df_conflict_remains) {
> +		int pos;
> +		struct cache_entry *ce;
> +
>   		output(o, 3, _("Skipped %s (merged same as existing)"), path);
>   		if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
>   				  0, (!o->call_depth && !is_dirty), 0))
>   			return -1;
> +		/*
> +		 * However, add_cacheinfo() will delete the old cache entry
> +		 * and add a new one.  We need to copy over any skip_worktree
> +		 * flag to avoid making the file appear as if it were
> +		 * deleted by the user.
> +		 */

nit - I find it a little odd to start a comment with "However" as if you 
are continuing a conversation.

> +		pos = index_name_pos(&o->orig_index, path, strlen(path));
> +		ce = o->orig_index.cache[pos];
> +		if (ce_skip_worktree(ce)) {
> +			pos = index_name_pos(&the_index, path, strlen(path));
> +			ce = the_index.cache[pos];
> +			ce->ce_flags |= CE_SKIP_WORKTREE;
> +		}
>   		return mfi.clean;
>   	}
>   
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 25fac490d..9b1456a7c 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -392,7 +392,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_failure 'failed cherry-pick with sparse-checkout' '
> +test_expect_success 'failed cherry-pick with sparse-checkout' '
>          pristine_detach initial &&
>          git config core.sparseCheckout true &&
>          echo /unrelated >.git/info/sparse-checkout &&
> 

Thanks Elijah, I can verify this fixes the problem with the preferred 
solution (ie it preserves the skip-worktree bit).  As such, this is:

Reviewed-by: Ben Peart <benpeart@microsoft.com>

That said, I would propose the test be updated to include a specific 
test for the skip-worktree bit so that if a future patch reverts to the 
old behavior of clearing the skip-worktree bit and writing out the file 
to the working directory, we do it explicitly instead of by accident.

diff --git a/t/t3507-cherry-pick-conflict.sh 
b/t/t3507-cherry-pick-conflict.sh
index 9b1456a7c3..bc8863ff36 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -392,17 +392,17 @@ test_expect_success 'commit --amend -s places the 
sign-off at the right place' '

         test_cmp expect actual
  '

-test_expect_success 'failed cherry-pick with sparse-checkout' '
+test_expect_success 'cherry-pick preserves sparse-checkout' '
         pristine_detach initial &&
         git config core.sparseCheckout true &&
         echo /unrelated >.git/info/sparse-checkout &&
         git read-tree --reset -u HEAD &&
         test_must_fail git cherry-pick -Xours picked>actual &&
+       test "$(git ls-files -t foo)" = "S foo" &&
         test_i18ngrep ! "Changes not staged for commit:" actual &&
         echo "/*" >.git/info/sparse-checkout &&
         git read-tree --reset -u HEAD &&
         git config core.sparseCheckout false &&
         rm .git/info/sparse-checkout
  '

  test_done

