Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E3B1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeHPUCC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:02:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34232 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeHPUCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:02:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so16090966wme.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fzT2IkiT4QCPI+8hHj0i0TjFs6Z63z3Zbkb/IU4B7Og=;
        b=LYiQhe43KrnMxK18o94U9xO0gPtomclktC3n7fT0rlZxt7jSL8GUljLMJUSis7DtvQ
         jAd5+1qibOb0Yc6Hirdcv//H2bhfJJzKECIYkTs9xOb7LxUir1i2p0nKxBRpTrDK3q76
         qbq427GU7vkByvS071Pur519u5DhjierVqJ5vhLzlYWi3KKHLhAkTrbfanW3rnSR3eAl
         6UHbQsfmyGgyZZkL/HkE0VQwc4RV4EIcBRKAU9+LaOBCW9LgR4+X8f9du0IFL6/+kKhu
         jW6ovOLejRs2PuJ2d1N/JunRtPyej+Yv+G8vUUuv8T1T1hhC/fvcjAIBNbDHzSs09xqd
         01OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fzT2IkiT4QCPI+8hHj0i0TjFs6Z63z3Zbkb/IU4B7Og=;
        b=TTBvGq57KdpH4geqy4p428200KpY7usSVW3dtGvRy+5gSWbQD/j0Ft5KOZ6iRIOsad
         0j0V5wOU0hibY5yidQuEinTwjPltXhCQ4off3614p+S0/ukDsKEI/nbi1gcdwhsXTNpd
         xeAmdsQLUkZlHZQWjYhycbdry6rm8VkPBDgF96h7APGyqtX9oKvSwJGkjH3KwvkWeg6C
         idWeVEKVZHKOJmNRFtQIx4Q7Es90D/dvXnad1W2aB2Qt3uqjD6J7YsoJaLSeUhXxk0W6
         rL8qv4ZKnDM3iXHMnozj0ajPI1h4Qqz3moHDuKh8PbfWWPw6np6atmSCUTYDEktbF7Dg
         wMLw==
X-Gm-Message-State: AOUpUlHT7Q6/dhd9uGrrK7Bip4oXIKMREZ63SIOCVfN7MDUf/90BTVui
        RA0oOjMOZOtDThTCV3N5iwH7xK4Z
X-Google-Smtp-Source: AA+uWPzvBpgL9BN0OY5N364x7Mmm9sYygtSpjPKpm7KxIhtHnMwVENicTz8ZV++HNgKnv15EH+wtdQ==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr17132403wmd.44.1534438938180;
        Thu, 16 Aug 2018 10:02:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p13-v6sm19711895wrj.20.2018.08.16.10.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 10:02:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
References: <CACsJy8CkXRc9NXRHt3a7=v04to0bMTvZo9x7zYNZWPiGDKQqdg@mail.gmail.com>
        <20180816160608.20351-1-pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 10:02:17 -0700
In-Reply-To: <20180816160608.20351-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 16 Aug 2018 18:06:08 +0200")
Message-ID: <xmqqefeyfdnq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> --quit is supposed to be --abort but without restoring HEAD. Leaving
> CHERRY_PICK_HEAD behind could make other commands mistake that
> cherry-pick is still ongoing (e.g. "git commit --amend" will refuse to
> work). Clean it too.
>
> For --abort, this job of deleting CHERRY_PICK_HEAD is on "git reset"
> so we don't need to do anything else. But let's add extra checks in
> --abort tests to confirm.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Thanks, this makes sense.

>  builtin/revert.c                | 9 +++++++--
>  t/t3510-cherry-pick-sequence.sh | 7 ++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 76f0a35b07..9a66720cfc 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -7,6 +7,7 @@
>  #include "rerere.h"
>  #include "dir.h"
>  #include "sequencer.h"
> +#include "branch.h"
>  
>  /*
>   * This implements the builtins revert and cherry-pick.
> @@ -191,8 +192,12 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
>  	opts->strategy = xstrdup_or_null(opts->strategy);
>  
> -	if (cmd == 'q')
> -		return sequencer_remove_state(opts);
> +	if (cmd == 'q') {
> +		int ret = sequencer_remove_state(opts);
> +		if (!ret)
> +			remove_branch_state();
> +		return ret;
> +	}
>  	if (cmd == 'c')
>  		return sequencer_continue(opts);
>  	if (cmd == 'a')
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index b42cd66d3a..68b8c14e27 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -103,7 +103,8 @@ test_expect_success '--quit cleans up sequencer state' '
>  	pristine_detach initial &&
>  	test_expect_code 1 git cherry-pick base..picked &&
>  	git cherry-pick --quit &&
> -	test_path_is_missing .git/sequencer
> +	test_path_is_missing .git/sequencer &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD
>  '
>  
>  test_expect_success '--quit keeps HEAD and conflicted index intact' '
> @@ -132,6 +133,7 @@ test_expect_success '--abort to cancel multiple cherry-pick' '
>  	test_expect_code 1 git cherry-pick base..anotherpick &&
>  	git cherry-pick --abort &&
>  	test_path_is_missing .git/sequencer &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
>  	test_cmp_rev initial HEAD &&
>  	git update-index --refresh &&
>  	git diff-index --exit-code HEAD
> @@ -142,6 +144,7 @@ test_expect_success '--abort to cancel single cherry-pick' '
>  	test_expect_code 1 git cherry-pick picked &&
>  	git cherry-pick --abort &&
>  	test_path_is_missing .git/sequencer &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
>  	test_cmp_rev initial HEAD &&
>  	git update-index --refresh &&
>  	git diff-index --exit-code HEAD
> @@ -162,6 +165,7 @@ test_expect_success 'cherry-pick --abort to cancel multiple revert' '
>  	test_expect_code 1 git revert base..picked &&
>  	git cherry-pick --abort &&
>  	test_path_is_missing .git/sequencer &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
>  	test_cmp_rev anotherpick HEAD &&
>  	git update-index --refresh &&
>  	git diff-index --exit-code HEAD
> @@ -239,6 +243,7 @@ test_expect_success '--abort after last commit in sequence' '
>  	test_expect_code 1 git cherry-pick base..picked &&
>  	git cherry-pick --abort &&
>  	test_path_is_missing .git/sequencer &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
>  	test_cmp_rev initial HEAD &&
>  	git update-index --refresh &&
>  	git diff-index --exit-code HEAD
