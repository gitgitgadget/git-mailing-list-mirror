Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4481C7EE24
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbjELVfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbjELVeq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:34:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DFB10F5
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a37bf6fd0so170894667b3.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683927284; x=1686519284;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IVNqL36sy+Lszl3UThls0sIbg9TEHOL4Z8AFrU0NaYE=;
        b=1aEaw/TetgUPbXXRdReJ3G8grkYhTtY70UMIen4Y3Vjp0+Rxb9lneNkS8pnpk6KSTj
         UrIn5BN7a2imj98E1Gy634h4Me9qnqibDPY2Ci78g8Tf1uRMvvsUVINYqNPk5OHjPHdm
         0chsma/QGZbQlDWP0KD5rQHYrGX++0+lFvcZRv0V1gm3KijHPdvpXnjeA2M04Q3ALUJo
         BY1KHDUBXI+bfFBMF9Ke4QM1WP/xO5w4bQNx/6DHJM3dXR+G3rlivjSD5UU7XR6eWHy3
         RjoviQRt4bkDjlDADfNPLSvtQVhTGY8GVA5XE4l3Fs66cMb9pd/7zU44FDcGULVjVlZ0
         1S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927284; x=1686519284;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVNqL36sy+Lszl3UThls0sIbg9TEHOL4Z8AFrU0NaYE=;
        b=h2tbgTYQYfMZpj3d0Bu0tzn/uwwLrYHZI0BkoN7d1clI2YdYVxLPjbSp/xIE8f3oRV
         qXC1GQdFD8dcveZp8JpdH/RaobtHuJehn1noiuo5U0SDruqcdsE5b1nvP5XPRmHbPfEn
         4vmOMiunoMrL+XC8Qp3kmHOlGhPwTtOu8pWwkK/KVMBM9P/7OuP6SCAhGcholPHrcefW
         1uW/EKn/ZfKLOZ4XVCtgQrJDNA2dZGF3rj0h/P34a+78PxWH8ShksmnxmC2G/46X/LvK
         F5AoBuu9i49AhF0dAnd0d2yGwVEqXrUYECHiZ88xKZy5AnmOZrxRzlHgbRY+3alKvwY1
         ZiFw==
X-Gm-Message-State: AC+VfDw5GvysSwk0VFmA1mDdwWmdpfyKLX63h7/n8Sy2E6/HfhPfc+9x
        gZwJaDJ5EZKCwavFZVoTRxg+lySiHUNheuhzE89C
X-Google-Smtp-Source: ACHHUZ5iy8UQF1ODNLfP99FC545f8V3d//Ri5HWEqbdXH7YQb11s74Q2N0UCYwiRGaOoYrpBzccG2KBfJhThIdoZ49jj
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:fca5:20a4:493f:ac3a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af0e:0:b0:55a:5641:54be with
 SMTP id n14-20020a81af0e000000b0055a564154bemr16040058ywh.6.1683927284147;
 Fri, 12 May 2023 14:34:44 -0700 (PDT)
Date:   Fri, 12 May 2023 14:34:41 -0700
In-Reply-To: <f7ee69e7e687e8cbdead070df644c5bca23d7578.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512213441.1127721-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 01/27] init-db: document existing bug with core.bare in
 template config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> -	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
>  	if (init_shared_repository != -1)
>  		set_shared_repository(init_shared_repository);
> +	/*
> +	 * TODO: heed core.bare from config file in templates if no
> +	 *       command-line override given
> +	 */
> +	is_bare_repository_cfg = init_is_bare_repository || !work_tree;

This patch moves this line down a few lines, but that's fine because
set_shared_repository() doesn't modify any of the relevant variables.

> +	/* TODO (continued):
> +	 *
> +	 * Unfortunately, the line above is equivalent to
> +	 *    is_bare_repository_cfg = !work_tree;
> +	 * which ignores the config entirely even if no `--[no-]bare`
> +	 * command line option was present.
> +	 *
> +	 * To see why, note that before this function, there was this call:
> +	 *    init_is_bare_repository = is_bare_repository()

This is in init_db(), indeed.

> +	 * expanding the right hande side:

s/hande/hand/

> +	 *                 = is_bare_repository_cfg && !get_git_work_tree()
> +	 *                 = is_bare_repository_cfg && !work_tree
> +	 * note that the last simplification above is valid because nothing
> +	 * calls repo_init() or set_git_work_tree() between any of the
> +	 * relevant calls in the code,

Yes, the only calls are check_repository_format() and
validate_hash_algorithm() (as can be seen in init_db()) before
get_git_work_tree() is called at the start of create_default_files().

> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 1b6437ec079..c02fd64793b 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -52,6 +52,28 @@ test_expect_success 'shared=all' '
>  	test 2 = $(git config core.sharedrepository)
>  '
>  
> +test_expect_failure 'template can set core.bare' '

I would have preferred a test_expect_success with the exact failing line
documented and prepended with test_must_fail, but I can see why someone
would prefer test_expect_failure.
