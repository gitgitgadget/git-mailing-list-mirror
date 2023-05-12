Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45115C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjELUUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjELUU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 16:20:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72D3AB7
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:20:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1aaf6ef3580so58056915ad.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683922825; x=1686514825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjMdv9mZPAY6hmxaCh5V/WtGoaBk7zmAxZXNtf4Uvd0=;
        b=H5PMyLlf7a4BVviShh9bhXEdXdcM3lMoOS4RaVau4xAZBqVhqws7u6kSLf8ESWcBtb
         p5TC8asazFx1Z5wkkefpTTOEkECwPKP3+0kOpqzvuV4aGalWf//+TI5SC0cIpxPnS3Ld
         Jjx8aSyH1G96trY1fwL1w0XDapVc4kVeZ56NB/9zMvAK2QDBsKLBOwsyw6XKjIKmwco/
         BclVfZkt7XGjKv1y7BzdyVxh36Y6iVMnuAxyQhbM57kQUYWzParhon444s/JJ/BJ5xLr
         G/TKV4w0mDaJ2YMJmdJ7i8xsXqlZvKF2/p8u1uWZqslTOiDy0jGMAZnWCKM5+KbiFnvS
         aKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683922825; x=1686514825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjMdv9mZPAY6hmxaCh5V/WtGoaBk7zmAxZXNtf4Uvd0=;
        b=Amuy3LWq63bGp/jChDLqx5QoeYli0F4MeDjHEfJE1oDt0Y8ACZFZEe6JR2t2uENic8
         6UK818752VDnpkOaeVPnJvk9JsJqd/s/YYjqyZz7vMmLapn3g4Ix/1xt7n/IUAf0tY7C
         KUjoHhDBskz6zYUsqJ6m0LOCO0Kr5V7CAoea44Un3TgGmi77sC/EY9NKaBhlKoYR/OQX
         b43nYVC/Pp60u1GVOaudPToHS46aP876OKMp3z4TGAejKO7Gzpt0UyQWscjYp6weK+ih
         qMKU855iJ1kjAfxcbGROkqbiaTeM/hyWJb80YKxqEh3kcJ/kRboRrJyD+opsYqeQW+CU
         BHuw==
X-Gm-Message-State: AC+VfDzGjv3Dq193mP3Tbeth+btbSmwPlYXlhTjYha+baPKdU9tOh3We
        0ZBsDN3/vaqAXU7trTGjvGHQQHJYmFcU4w==
X-Google-Smtp-Source: ACHHUZ4JIhKcb4R98QkSN79XqfAwHKLpR4TKmo5ibUNe2hFQyknUSe+LxHR3k053QgfvNIjtwSg/KT/o8+Exew==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:1358:b0:1a1:f0ad:8622 with SMTP
 id jl24-20020a170903135800b001a1f0ad8622mr8216831plb.12.1683922824872; Fri,
 12 May 2023 13:20:24 -0700 (PDT)
Date:   Fri, 12 May 2023 13:20:23 -0700
In-Reply-To: <5ba9d6e68ad255a64eb7e5ad6ca53bc55c771ff4.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
 <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com> <5ba9d6e68ad255a64eb7e5ad6ca53bc55c771ff4.1683875070.git.gitgitgadget@gmail.com>
Message-ID: <kl6l7ctdz4hk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 02/27] init-db: remove unnecessary global variable
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> init_is_bare_repository's sole use in life it to cache a value in
> init_db(), and then be used in create_default_files().  This is a bit
> odd since init_db() directly calls create_default_files(), and is the
> only caller of that function.  Convert the global to a simple function
> parameter instead.
>
> (Of course, this doesn't fix the fact that this value is then ignored by
> create_default_files(), as noted in a big TODO comment in that function,
> but it at least includes no behavioral change other than getting rid of
> a very questionable global variable.)

Ah, I didn't spot v2 when I typed my earlier reply. Yeah this makes a
lot of sense within this series.

> @@ -31,7 +31,6 @@
>  
>  #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
>  
> -static int init_is_bare_repository = 0;
>  static int init_shared_repository = -1;
>  
>  static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
> @@ -199,6 +198,7 @@ static int create_default_files(const char *template_path,
>  				const char *original_git_dir,
>  				const char *initial_branch,
>  				const struct repository_format *fmt,
> +				int prev_bare_repository,
>  				int quiet)
>  {
>  	struct stat st1;
> @@ -237,7 +237,7 @@ static int create_default_files(const char *template_path,
>  	 * TODO: heed core.bare from config file in templates if no
>  	 *       command-line override given
>  	 */
> -	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
> +	is_bare_repository_cfg = prev_bare_repository || !work_tree;
>  	/* TODO (continued):
>  	 *
>  	 * Unfortunately, the line above is equivalent to
> @@ -246,7 +246,7 @@ static int create_default_files(const char *template_path,
>  	 * command line option was present.
>  	 *
>  	 * To see why, note that before this function, there was this call:
> -	 *    init_is_bare_repository = is_bare_repository()
> +	 *    prev_bare_repository = is_bare_repository()
>  	 * expanding the right hande side:
>  	 *                 = is_bare_repository_cfg && !get_git_work_tree()
>  	 *                 = is_bare_repository_cfg && !work_tree
> @@ -256,7 +256,7 @@ static int create_default_files(const char *template_path,
>  	 * calls will return the same result each time.  So, what we are
>  	 * interested in computing is the right hand side of the line of
>  	 * code just above this comment:
> -	 *     init_is_bare_repository || !work_tree
> +	 *     prev_bare_repository || !work_tree
>  	 *        = is_bare_repository_cfg && !work_tree || !work_tree
>  	 *        = !work_tree
>  	 * because "A && !B || !B == !B" for all boolean values of A & B.
> @@ -424,6 +424,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  	int exist_ok = flags & INIT_DB_EXIST_OK;
>  	char *original_git_dir = real_pathdup(git_dir, 1);
>  	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +	int prev_bare_repository;
>  
>  	if (real_git_dir) {
>  		struct stat st;
> @@ -449,7 +450,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  
>  	safe_create_dir(git_dir, 0);
>  
> -	init_is_bare_repository = is_bare_repository();
> +	prev_bare_repository = is_bare_repository();
>  
>  	/* Check to see if the repository version is right.
>  	 * Note that a newly created repository does not have
> @@ -462,6 +463,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  
>  	reinit = create_default_files(template_dir, original_git_dir,
>  				      initial_branch, &repo_fmt,
> +				      prev_bare_repository,
>  				      flags & INIT_DB_QUIET);
>  	if (reinit && initial_branch)
>  		warning(_("re-init: ignored --initial-branch=%s"),

The patch looks trivially correct.
