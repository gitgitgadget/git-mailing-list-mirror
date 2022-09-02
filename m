Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E3CECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIBTDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIBTDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 15:03:24 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A78B792D8
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 12:03:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f14so2514944qkm.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wAJbsN+Gv478UuZ9zWqTZU3rd7+OdfZe9adV8BADpB8=;
        b=meDfOnvIdkOzPGRxs/6n8NF7hWced6U+c1BpUpsbGZq5+MBdR7XXTP9gJy1t0PHOEH
         T9dgQubLivD1FAKQffHsPZfT9ojLhyvc+nIgEUqer2icFA5RFuj7EY51gJ0NrLETjHoD
         0pIDsmixb0eyw/KeZ+KohwdJexxhpwSDiXbBnnbzJzyJ2gEnyMu/NqVultIcqbn2byEy
         Qr89UVP+pi2oh2kFs4Ey0O9tVtbZRV7iT3h7P3+onvt+lWBguVOqCb3jbWAfU+HDokP8
         T1lkUdDW+WX9rl97i2W1wFbpwUdbGqmAYOQqc8TjcjMRLYpXMIf9MUojUMGKojKcAq7i
         3a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wAJbsN+Gv478UuZ9zWqTZU3rd7+OdfZe9adV8BADpB8=;
        b=Pdahe3NqPiFW4zahN5ZS11ytvbCOU5csL9pIiY9lkYPfgm8NcMbLoIygw+6h6aAGNL
         ko9s2SB2C1J1Ai6xoZgHdrsxJXPBvN2iLGcxhKvgipSo9BhY4NlvEvvCvwLxLCIIvIJ3
         y5NUVxSyvLUz0zgpA08xBz28hmBbMsZSDSLsmcBjPTa0b4jmh/HGq/xr6Om/oRhqm2EK
         EmVjtc7T15TVMEU/BgEyI1AETFP3bvSLGsYmqInuZ4wqOkT8UjFIz0m+u+YzXI/knVQ+
         ZkE3c6JGpfGyPSwW/35C8cHF6GSk703VEHVRja0xkP8xVmlOahXQ4O1s8oBWJkJ2Yqa1
         vdIw==
X-Gm-Message-State: ACgBeo39NwUIusIhYu97cgW5aGSljfJtYhUQ1Gd6QRH67K9Mw4or8nCq
        /QeOjrj09rtLTN+M7YQXRWg=
X-Google-Smtp-Source: AA6agR6foRQMnn7PZxVxLEA1HHdbrQySP256aztqt1RqAmu5wHuJ6HEwiMJBdAUwIGcyFq8mAd/p9w==
X-Received: by 2002:a05:620a:101a:b0:6bb:e7de:791f with SMTP id z26-20020a05620a101a00b006bbe7de791fmr25073067qkj.463.1662145402298;
        Fri, 02 Sep 2022 12:03:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:a495:4a99:7b49:28da? ([2600:1700:5a60:7720:a495:4a99:7b49:28da])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b0031f287f58b4sm1633046qta.51.2022.09.02.12.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 12:03:21 -0700 (PDT)
Message-ID: <b3516420-872f-e556-dcea-d2dc5317f8dc@gmail.com>
Date:   Fri, 2 Sep 2022 12:03:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] unpack-trees: fix sparse directory recursion check
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
References: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 2:02 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Ensure 'is_sparse_directory_entry()' receives a valid 'name_entry *' if one
> exists in the list of tree(s) being unpacked in 'unpack_callback()'.
> 
> Currently, 'is_sparse_directory_entry()' is called with the first
> 'name_entry' in the 'names' list of entries on 'unpack_callback()'. However,
> this entry may be empty even when other elements of 'names' are not (such as
> when switching from an orphan branch back to a "normal" branch). As a
> result, 'is_sparse_directory_entry()' could incorrectly indicate that a
> sparse directory is *not* actually sparse because the name of the index
> entry does not match the (empty) 'name_entry' path.
> 
> Fix the issue by using the existing 'name_entry *p' value in
> 'unpack_callback()', which points to the first non-empty entry in 'names'.
> Because 'p' is 'const', also update 'is_sparse_directory_entry()'s
> 'name_entry *' argument to be 'const'.
> 
> Finally, add a regression test case.
> 
> Reported-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>

The issue is well explained: even I don't have prior knowledge but I
still get the gist out of it! The added tests in t1092 reflect the
changes brought by the diff!

Thanks,
Shaoxuan

> ---
>     unpack-trees: fix sparse directory recursion check
>     
>     This issue was found when the updates from v2.37.3 introduced a test
>     failure in a downstream test suite.
>     
>     The issue stems from the fact that, before v2.37.3, 'unpack_callback()'
>     could previously "assume" that 'names[0]' was non-empty if a cache entry
>     was unpacked as a sparse index. When b15207b8cf (unpack-trees: unpack
>     new trees as sparse directories, 2022-08-08)) was introduced, it
>     invalidated that assumption by allowing sparse directories to be
>     unpacked based on the contents of other 'names' entries, rather than
>     unnecessarily recursing into them and unpacking files individually. As a
>     result, certain scenarios could cause a sparse directory to be unpacked
>     then also recursively unpacked via 'traverse_trees_recursive()',
>     creating duplicate index entries.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1344%2Fvdye%2Fbugfix%2Fsparse-index-orphan-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1344/vdye/bugfix/sparse-index-orphan-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1344
> 
>  t/t1092-sparse-checkout-compatibility.sh | 9 +++++++++
>  unpack-trees.c                           | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 0302e36fd66..b9350c075c2 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -380,6 +380,15 @@ test_expect_success 'checkout with modified sparse directory' '
>  	test_all_match git checkout base
>  '
>  
> +test_expect_success 'checkout orphan then non-orphan' '
> +	init_repos &&
> +
> +	test_all_match git checkout --orphan test-orphan &&
> +	test_all_match git status --porcelain=v2 &&
> +	test_all_match git checkout base &&
> +	test_all_match git status --porcelain=v2
> +'
> +
>  test_expect_success 'add outside sparse cone' '
>  	init_repos &&
>  
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 90b92114be8..bae812156c4 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1423,7 +1423,7 @@ static void debug_unpack_callback(int n,
>   * from the tree walk at the given traverse_info.
>   */
>  static int is_sparse_directory_entry(struct cache_entry *ce,
> -				     struct name_entry *name,
> +				     const struct name_entry *name,
>  				     struct traverse_info *info)
>  {
>  	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
> @@ -1562,7 +1562,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>  			}
>  		}
>  
> -		if (!is_sparse_directory_entry(src[0], names, info) &&
> +		if (!is_sparse_directory_entry(src[0], p, info) &&
>  		    !is_new_sparse_dir &&
>  		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>  						    names, info) < 0) {
> 
> base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819

