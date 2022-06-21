Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7ECC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355054AbiFUXLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354574AbiFUXLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 19:11:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612152B277
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 16:11:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i64so14440088pfc.8
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oO/6GKUlcL1D0LcNx7NnINO6MrA6fQjXiq6ha4ikVQo=;
        b=eSlFb3E1g+hm/oOJfVkPMlXu+SQ3F/kAA0Qli30iMq4U4N4UP5aVDKJIm/1P2HoJuM
         IQX5OkoqZHAasOfGdu+BdReEwWVfJAe0EAXWiGvVaw7BjvjPNLczw02qC9DsU4k4qDMg
         JrhEj1fSsyWgKFhS7YfPzqBd6qd0pB5ruW9sH0N+9xVXkeaQI4dQ4uZfzb5k0C1hDc5H
         21PpJq+SF7rF/UI8/CNWsDz/988M3VYzbBTJQxBr69BENpbi+dCQySIVMiBNCsKLGGmj
         ouEM5t8LeXZqkOe751smbQrOO1m7h7fC97NDfF3oRtzUNBTq/YSm7kOh1lz/7TI++30O
         BWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oO/6GKUlcL1D0LcNx7NnINO6MrA6fQjXiq6ha4ikVQo=;
        b=ahN3Sv0IXERzo9KbLNrwa39JSyrg9FB2NJdwdUIBZk4IZ4qdjLyzPS2n5MmIt2YXLk
         f0QARlmpWPDedhInbjxgDZBO92ORSrd4l7FPmPg8+nbvLz9NZ8d/nu7CKB76I5Q+omaq
         t0jiWe4hkNfyQZG/deWEIJ94PI6pzmPag2aNxFej4eaaK6cUibOTqUZqGsb3uTdyig3/
         yJ1yFvGie5LncEUqexdum1QfCVENzkjeEHHemMHo5c1GE+4qRuvdcul91LCpOplG9nmP
         2jWgyVp2+tHTJiQDNUuzECxyf3xd2HfcdZcb+ZGTKDuQffsDvIL5VpiAC5BZEJEopjIb
         IrAw==
X-Gm-Message-State: AJIora8eSvuDrxiH8CtyirmaYeBEGVCy03fmIU4huAy2KvvGzZWeSD/r
        LdsgnKUvmxCCp3iaESZ0kU40
X-Google-Smtp-Source: AGRyM1sErTBWyJeJf20BDtjnVm7DkbgwJ4yMHrgNnICwBOPGghe7a7idZDyGSUD8tMlpUZQZdIsFJA==
X-Received: by 2002:a63:8641:0:b0:3fd:94e8:a650 with SMTP id x62-20020a638641000000b003fd94e8a650mr300656pgd.367.1655853078908;
        Tue, 21 Jun 2022 16:11:18 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id y19-20020aa79433000000b005252a06750esm4196453pfo.182.2022.06.21.16.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 16:11:18 -0700 (PDT)
Message-ID: <cabeda2a-9681-a026-fbd7-87aa6139b881@github.com>
Date:   Tue, 21 Jun 2022 16:11:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [WIP v3 7/7] mv: update sparsity after moving from out-of-cone to
 in-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-8-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220619032549.156335-8-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, "git mv" a sparse file from out-of-cone to
> in-cone does not update the moved file's sparsity (remove its
> SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
> not checked out in the working tree.
> 
> Update the behavior so that:
> 1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
>    corresponding cache entry.
> 2. The moved cache entry is checked out in the working tree to reflect
>    the updated sparsity.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 18 ++++++++++++++++++
>  t/t7002-mv-sparse-checkout.sh |  4 +---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index cb3441c7cb..a8b9f55654 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -13,6 +13,7 @@
>  #include "string-list.h"
>  #include "parse-options.h"
>  #include "submodule.h"
> +#include "entry.h"
>  
>  static const char * const builtin_mv_usage[] = {
>  	N_("git mv [<options>] <source>... <destination>"),
> @@ -399,6 +400,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		const char *src = source[i], *dst = destination[i];
>  		enum update_mode mode = modes[i];
>  		int pos;
> +		struct checkout state = CHECKOUT_INIT;
> +		state.istate = &the_index;
> +
> +		if (force)
> +			state.force = 1;
>  		if (show_only || verbose)
>  			printf(_("Renaming %s to %s\n"), src, dst);
>  		if (show_only)
> @@ -424,6 +430,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		pos = cache_name_pos(src, strlen(src));
>  		assert(pos >= 0);
>  		rename_cache_entry_at(pos, dst);

At first I wasn't sure how this would handle moving whole "sparse"
directories (i.e., directories containing all 'SKIP_WORKTREE' entries),
since this loop only iterates over 'argc'. The good news is: it does work,
successfully moving each file in the directory individually! Unfortunately,
the *reason* it works is because 'mv' changes the value of 'argc' to include
the new directories.

All this to say - your implementation is good (and IMO doesn't require any
changes), it just happens to sit alongside somewhat questionable code. :)

> +
> +		if (mode & SPARSE) {
> +			if (path_in_sparse_checkout(dst, &the_index)) {

Nit: this can be consolidated into a single condition:

		if ((mode & SPARSE) && 
		    path_in_sparse_checkout(dst, &the_index)) {

> +				int dst_pos;
> +
> +				dst_pos = cache_name_pos(dst, strlen(dst));
> +				active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
> +
> +				if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
> +					die(_("cannot checkout %s"), ce->name);
> +			}
> +		}
>  	}
>  
>  	if (gitmodules_modified)
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 30e13b9979..7734119197 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -237,7 +237,6 @@ test_expect_success 'can move out-of-cone directory with --sparse' '
>  	git mv --sparse folder1 sub 1>actual 2>stderr &&
>  	test_must_be_empty stderr &&
>  
> -	git sparse-checkout reapply &&
>  	test_path_is_dir sub/folder1 &&
>  	test_path_is_file sub/folder1/file1
>  '
> @@ -260,7 +259,6 @@ test_expect_success 'can move out-of-cone file with --sparse' '
>  	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
>  	test_must_be_empty stderr &&
>  
> -	git sparse-checkout reapply &&
>  	! test_path_is_dir sub/folder1 &&
>  	test_path_is_file sub/file1
>  '
> @@ -278,7 +276,7 @@ test_expect_success 'refuse to move sparse file to existing destination' '
>  	test_cmp expect stderr
>  '
>  
> -test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
> +test_expect_success 'move sparse file to existing destination with --force and --sparse' '
>  	test_when_finished "cleanup_sparse_checkout" &&
>  	mkdir folder1 &&
>  	touch folder1/file1 &&

