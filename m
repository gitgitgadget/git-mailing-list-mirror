Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D6C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345AD60EFE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhHRTAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhHRS77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:59:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF4C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:59:24 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so5334630otf.6
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=exgErHfCgVl/6xfXS4r9REZpzgr3NmcaLxzd+fsr2zc=;
        b=RmLME4aMzMxOPtVTUgncyQz+s7PPK/GXis6ju3xQ24oB7SvU9xOVAWWJjZRz9p6wvp
         lY4D1TQDDELFmKtoxngtmMvujSDa2ykB4/bgJgUSk+Y8tSJzTEMXEFICVeHJRpZ2+oFb
         MsrvIQHi5tZJOYR9cJEFhBenLx9EXOcrILpb84xD1OCE/RoXGYN8C4UQ4mJFzt7+AWOp
         0EkP83PK0HlrvJLfRWMypgFt4HWl58YW2GLrdQAIdfGZA+qY02Kq2qb5cS9MiuXdeqsE
         tFPieXXkXy5t1PZodIkt4a4AkYUTI8HlGELqGpWPTwJQUFSQkioTjklwqNw+IfKOIv7h
         7Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=exgErHfCgVl/6xfXS4r9REZpzgr3NmcaLxzd+fsr2zc=;
        b=N8DNnCfPjDQJF3Qt5B7G+NuX7t8qk0XSuhyhhk2/nzjOH+Ac9hi9tzZ9+TdGdI2/Gm
         yEIa5zGycRbaUcQidAbtE2TxaxcOzySsBE8H4Wy1I8vF8dIOgzomDB7INTMBmC7vAnKK
         28b6xM2qx8nIfA+UrLvptYEtnqePtLBnAQkQMFZ2cHFmAkknJ0EYe0EUzKPiCSMW7SQY
         9PCczqJIv0MftUiwnIc5C2AI8jM/ycqn2xDK+ExDxiPioRYVdX3sf0EwN+7UmKHFIgid
         DxL44l8UO7IBc3b7/9ML5m8CgQwhLbtc1Ww5DV66hwgmiId7+YMXWjjzZY+7+zT4l1Gh
         Ge4Q==
X-Gm-Message-State: AOAM53090DCA+FA8xyvjK3FMGz5PURb6ZkoydbwVEFIgrs81mV8z6bHV
        gO9oIULKL0rIyjl5ezl2UTM=
X-Google-Smtp-Source: ABdhPJxWVF97shRQP1Z9Iwu8CgZPDGj4ypgfg4r+J5I3GMV0OQFNvPLB75URVs/wBsHxMm4FrXHANw==
X-Received: by 2002:a05:6830:1009:: with SMTP id a9mr8567066otp.220.1629313163876;
        Wed, 18 Aug 2021 11:59:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:581d:96e0:cdbb:9c3d? ([2600:1700:e72:80a0:581d:96e0:cdbb:9c3d])
        by smtp.gmail.com with ESMTPSA id u27sm230367otj.6.2021.08.18.11.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 11:59:23 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <b0ece4b7dccf0cbe0477b3a6d238ea1362aed24d.1629206603.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <16cb1bd2-c284-6529-4aa3-b6fc7b37b407@gmail.com>
Date:   Wed, 18 Aug 2021 14:59:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b0ece4b7dccf0cbe0477b3a6d238ea1362aed24d.1629206603.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 9:23 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The convert_to_sparse() method checks for the GIT_TEST_SPARSE_INDEX
> environment variable or the "index.sparse" config setting before
> converting the index to a sparse one. This is for ease of use since all
> current consumers are preparing to compress the index before writing it
> to disk. If these settings are not enabled, then convert_to_sparse()
> silently returns without doing anything.
> 
> We will add a consumer in the next change that wants to use the sparse
> index as an in-memory data structure, regardless of whether the on-disk
> format should be sparse.
> 
> To that end, create the SPARSE_INDEX_IGNORE_CONFIG flag that will skip
> these config checks when enabled. All current consumers are modified to
> pass '0' in the new 'flags' parameter.

...

> -int convert_to_sparse(struct index_state *istate)
> +int convert_to_sparse(struct index_state *istate, int flags)
>  {
>  	int test_env;
>  
> @@ -135,20 +135,22 @@ int convert_to_sparse(struct index_state *istate)
>  	if (!istate->repo)
>  		istate->repo = the_repository;
>  

Above this hunk, we fail automatically if the index has a split index.

The purpose of this flag is instead to say "convert to sparse for the
purpose of in-memory computations, not for writing to disk". For such
a case, we could move the split index check to be within the hunk
below. It would be appropriate to rename the flag to something like
SPARSE_INDEX_IN_MEMORY or SPARSE_INDEX_NO_DISK_WRITE to make the
intention more clear.

Thanks to SZEDER for pointing out this failure. I will fix it in the
next version.

> -	/*
> -	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> -	 * index.sparse config variable to be on.
> -	 */
> -	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
> -	if (test_env >= 0)
> -		set_sparse_index_config(istate->repo, test_env);
> +	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
> +		/*
> +		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> +		 * index.sparse config variable to be on.
> +		 */
> +		test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
> +		if (test_env >= 0)
> +			set_sparse_index_config(istate->repo, test_env);
>  
> -	/*
> -	 * Only convert to sparse if index.sparse is set.
> -	 */
> -	prepare_repo_settings(istate->repo);
> -	if (!istate->repo->settings.sparse_index)
> -		return 0;
> +		/*
> +		 * Only convert to sparse if index.sparse is set.
> +		 */
> +		prepare_repo_settings(istate->repo);
> +		if (!istate->repo->settings.sparse_index)
> +			return 0;
> +	}

If you want to try this, here is a diff that can help:

--- >8 ---

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b06c8f885ac..c6a512a2107 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -131,7 +131,7 @@ static void clean_tracked_sparse_directories(struct repository *r)
 		 * prevents us from converting to a sparse index, then do
 		 * not try deleting files.
 		 */
-		if (convert_to_sparse(r->index, SPARSE_INDEX_IGNORE_CONFIG))
+		if (convert_to_sparse(r->index, SPARSE_INDEX_MEMORY_ONLY))
 			return;
 		was_full = 1;
 	}
diff --git a/sparse-index.c b/sparse-index.c
index e0a854f9fc3..267503b21fa 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -128,14 +128,20 @@ int convert_to_sparse(struct index_state *istate, int flags)
 {
 	int test_env;
 
-	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
+	if (istate->sparse_index || !istate->cache_nr ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!istate->repo)
 		istate->repo = the_repository;
 
-	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
+	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
+		/*
+		 * The sparse index is not integrated with a split index.
+		 */
+		if (istate->sparse_index)
+			return 0;
+
 		/*
 		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
 		 * index.sparse config variable to be on.
diff --git a/sparse-index.h b/sparse-index.h
index 475f4f0f8da..9f3d7bc7faf 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,7 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-#define SPARSE_INDEX_IGNORE_CONFIG (1 << 0)
+#define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
 int convert_to_sparse(struct index_state *istate, int flags);
 
 /*


--- >8 ---

Thanks,
-Stolee
