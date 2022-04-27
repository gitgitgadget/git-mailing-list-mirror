Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A6C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiD0W2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiD0W2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:28:18 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253CF4968A
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:25:05 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id q21-20020a056830233500b00605db4a91a0so867831otg.17
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=50kJ80G8V+XvyfTmopr5NVLudxHJDXnwEgR95WOyRtY=;
        b=GTdG9y+lizOwZ/tXhaElt/ssifIS+O2td5ziiKiEniHz4hLxLzIo3/GBCzpl+9m4++
         glm49AFvjcCyyKkqoTA0I3/P/rH6XvKYOeytPyt3uzYqY/HfHAiz7ay8/rqZb2fU8mWH
         zWV5yB1KUaW/Rhb3anPplWuvKnPmBE2ECItUdo+Mug3sca0nVq5LbVyEyD9rmBgObaO+
         1cRYOvAXMaBYwDrsS1e42h4dTuk+Sd8YGhaWRIYuop5/Nq+PF0iecVHkfG/U5+vbzf3i
         01HtJMUWdhcj072lqg/FBMCkhCtH9X1KO2DldFAR+8KVASqLaqebXau2ygffpxcrraIT
         CRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=50kJ80G8V+XvyfTmopr5NVLudxHJDXnwEgR95WOyRtY=;
        b=fB6TpEUbveYXcSq+2NhPPTjwi6Iu6bikgUB64t0dp50LwaUzSKJ1id2wazaK7nZvBZ
         41gX1kDnDLA7z8+uGh0vnZLT3CCCIQWqwyQ/2QkHa1j3KuFugW9RnkGz4WKFG96XT8Ic
         Jj/g7O1KNEAS/+RmRs8v3/j4xHv/xuku1pz1hUaEUy8ht0zg8Jv18ZNwtknMEZmvQaDd
         HqVpByS6z5oAKDWMYgJu1jSQyCMksgh8v6ObXw+xbzojME2r25ldD2V69WT6nUQkLGlA
         u5ZS5nxFUTccKX68ajD6jkIbn1gBApT0cqLpAY0av+pmwKP1OKQH5lGrUG4uv6/fVu7l
         gbxg==
X-Gm-Message-State: AOAM5327nU6Sm7g6sxqEWIOBo865BR+UJuPJJM7nmIRTTgpMaMNXye1n
        Lkani2itJTJ1egfqusVg4VxjgO2BZHZqPQ==
X-Google-Smtp-Source: ABdhPJzHrIbb+QJktxF5uztp5q9DH4Y3Q50wRNBtB/eK6R+MzAPj2mOkT1gTAZZBLFPJuumkx0mTm43KS42zvw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:7cc3:0:b0:641:3bea:93a5 with SMTP id
 x186-20020a257cc3000000b006413bea93a5mr26889913ybc.315.1651097964609; Wed, 27
 Apr 2022 15:19:24 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:19:21 -0700
In-Reply-To: <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
Message-Id: <kl6lfslyp3ti.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com> <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] submodule--helper: fix initialization of warn_if_uninitialized
From:   Glen Choo <chooglen@google.com>
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> The .warn_if_uninitialized member was introduced by 48308681
> (git submodule update: have a dedicated helper for cloning,
> 2016-02-29) to submodule_update_clone struct and initialized to
> false.  When c9911c93 (submodule--helper: teach update_data more
> options, 2022-03-15) moved it to update_data struct, it started
> to initialize it to true but this change was not explained in
> its log message.
>
> The member is set to true only when pathspec was given, and is
> used when a submodule that matched the pathspec is found
> uninitialized to give diagnostic message.  "submodule update"
> without pathspec is supposed to iterate over all submodules
> (i.e. without pathspec limitation) and update only the
> initialized submodules, and finding uninitialized submodules
> during the iteration is a totally expected and normal thing that
> should not be warned.
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     submodule--helper: fix initialization of warn_if_uninitialized
>     
>     The .warn_if_uninitialized member was introduced by 48308681 (git
>     submodule update: have a dedicated helper for cloning, 2016-02-29) to
>     submodule_update_clone struct and initialized to false. When c9911c93
>     (submodule--helper: teach update_data more options, 2022-03-15) moved it
>     to update_data struct, it started to initialize it to true but this
>     change was not explained in its log message.
>     
>     The member is set to true only when pathspec was given, and is used when
>     a submodule that matched the pathspec is found uninitialized to give
>     diagnostic message. "submodule update" without pathspec is supposed to
>     iterate over all submodules (i.e. without pathspec limitation) and
>     update only the initialized submodules, and finding uninitialized
>     submodules during the iteration is a totally expected and normal thing
>     that should not be warned.
>     
>     Signed-off-by: Orgad Shaneh orgads@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1258%2Forgads%2Fsub-no-warn-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1258/orgads/sub-no-warn-v2
> Pull-Request: https://github.com/git/git/pull/1258
>
> Range-diff vs v1:
>
>  1:  089a52a50b4 ! 1:  1e34c9cad18 submodule--helper: fix initialization of warn_if_uninitialized
>      @@ Metadata
>        ## Commit message ##
>           submodule--helper: fix initialization of warn_if_uninitialized
>       
>      -    This field is supposed to be off by default, and it is only enabled when
>      -    running `git submodule update <path>`, and path is not initialized.
>      +    The .warn_if_uninitialized member was introduced by 48308681
>      +    (git submodule update: have a dedicated helper for cloning,
>      +    2016-02-29) to submodule_update_clone struct and initialized to
>      +    false.  When c9911c93 (submodule--helper: teach update_data more
>      +    options, 2022-03-15) moved it to update_data struct, it started
>      +    to initialize it to true but this change was not explained in
>      +    its log message.
>       
>      -    Commit c9911c9358 changed it to enabled by default. This affects for
>      -    example git checkout, which displays the following warning for each
>      -    uninitialized submodule:
>      -
>      -    Submodule path 'sub' not initialized
>      -    Maybe you want to use 'update --init'?
>      -
>      -    Amends c9911c9358e611390e2444f718c73900d17d3d60.
>      +    The member is set to true only when pathspec was given, and is
>      +    used when a submodule that matched the pathspec is found
>      +    uninitialized to give diagnostic message.  "submodule update"
>      +    without pathspec is supposed to iterate over all submodules
>      +    (i.e. without pathspec limitation) and update only the
>      +    initialized submodules, and finding uninitialized submodules
>      +    during the iteration is a totally expected and normal thing that
>      +    should not be warned.
>       
>           Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>       
>      @@ builtin/submodule--helper.c: struct update_data {
>        	.single_branch = -1, \
>        	.max_jobs = 1, \
>       -	.warn_if_uninitialized = 1, \
>      -+	.warn_if_uninitialized = 0, \
>        }
>        
>        static void next_submodule_warn_missing(struct submodule_update_clone *suc,
>
>
>  builtin/submodule--helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2c87ef9364f..1a8e5d06214 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2026,7 +2026,6 @@ struct update_data {
>  	.references = STRING_LIST_INIT_DUP, \
>  	.single_branch = -1, \
>  	.max_jobs = 1, \
> -	.warn_if_uninitialized = 1, \
>  }
>  
>  static void next_submodule_warn_missing(struct submodule_update_clone *suc,
>
> base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
> -- 
> gitgitgadget

This was clearly a mistake on my part :( The fix looks good to me,
thanks!
