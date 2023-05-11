Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F167C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 20:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbjEKUnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjEKUnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 16:43:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5250A2
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:43:03 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e116d1a05so8660710a91.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683837783; x=1686429783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwypswIzaObBuf6tibn2R8Ptwwpg2/gGrOVMDwaXpbo=;
        b=R7bU+2qpIGoh2upk6qDX5qxF7VWDv72/swgPHZrme/jrecxcIdv7UR4lmCkzEzqXkh
         Yohhfk6cFJZGZdfSEZjf0FTiRk7jSagk6BmyI16icWb2Rg1GPoCJaEjZIE/G451VGlH7
         xUvJEPb5rMY/lxwmZoyxxIdezfvlC9xwyIs9UyT9+LdMiqEUJj3F30KGoRiGQdPLNc+c
         PCfX4XEmG9SBBvd1UHeNhJnIX2Q2npQXA1OXGlEEDtnfNj9Ht2OZ/nCAyXiwkaYCG6YS
         z5A7e/1twvDttBYgVozUqcIcr7S/L5/JtDXJw3oWYs/CGYtLl58mWAfAYKBJdTS2WwR5
         De/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837783; x=1686429783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwypswIzaObBuf6tibn2R8Ptwwpg2/gGrOVMDwaXpbo=;
        b=ZUjQ2fOhE6cego8w/WNacXFY+YdS57PL8GgWSb9m7wYNDODnYRCsvNlZqfszGRUP0K
         9K+JzfCBOAgya/2AYa026OMW8qYEdXlBENnDO6nnrSVpPQ6FZWgttX4nnVLU3wiUfCCH
         Ytp8pP9pdhDGDi5cwO4AxFVaDQc0HkGqx6U4um9euFzV/Hzn1Jp8WzLP8lck4aHpx2mW
         Z9bYYFEdfJ/9UPrdeN3kEX4STaXdAOz/aJ15ko4pCtUrExmxYxpoCdlKkSVADUStMXed
         u8olSZqPq+zhzFv/Rvj3Il1iW1X1UeYPFmN8ejjwVhc42zaW1UmrCw+Our4Rr8e+R6ti
         o1Fg==
X-Gm-Message-State: AC+VfDwI5NKwYZOeW3bnqqO/WiWuJAB8E8c0UCUFVhOFLGk5i4KtIoUB
        RnLbcMN1JvlGXDcDsxyZ6SD6jASo7wW5lg==
X-Google-Smtp-Source: ACHHUZ4oq3SfPcPLoyoY/Z+8IsRa/eiMogJbw7iTZ5qmenwQnAb3L5DoaXVD6wTm33SRhO0qB0Nir1a0XkJ/ag==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:e98:b0:24d:f3d9:48b5 with SMTP id
 fv24-20020a17090b0e9800b0024df3d948b5mr6834319pjb.3.1683837783236; Thu, 11
 May 2023 13:43:03 -0700 (PDT)
Date:   Thu, 11 May 2023 13:43:01 -0700
In-Reply-To: <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com> <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
Message-ID: <kl6lsfc2zjje.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 01/24] init-db: remove unnecessary global variable &
 document existing bug
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> This commit was prompted by a desire to move the functions which
> builtin/init-db.c and builtin/clone.c share out of the former file and
> into setup.c.  One issue that made it difficult was the
> init_is_bare_repository global variable.
>
> init_is_bare_repository is actually not very useful.  It merely stores
> the return value from is_bare_repository() and only for the duration of
> a few additional function calls before its value is checked, and none of
> those functions do anything that could change is_bare_repository()'s
> return value.  So, we can simply dispense with the global by replacing
> it with is_bare_repository().

I think the purpose of init_is_bare_repository is something different.
But based off my different understanding, I can't reproduce any
different behavior. I don't know if I'm just confused or not, but I'll
leave some breadcrumbs here to check my understanding.

Reordering the hunks for clarity,

> @@ -422,8 +436,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  
>  	safe_create_dir(git_dir, 0);
>  
> -	init_is_bare_repository = is_bare_repository();
> -
>  	/* Check to see if the repository version is right.
>  	 * Note that a newly created repository does not have
>  	 * config file, so this will not fail.  What we are catching

Here, init_db() caches the value of is_bare_repository(), which itself
reads the value of is_bare_repository_cfg, which can be modified by when
we read "core.bare" via git_config(git_default_config) or similar
(basically, any config callback that uses git_default_config). It is
also modified in other places though, like setup.c.

IIUC, we haven't actually parsed "core.bare" at this point. The
git_config() call just above this calls "plaform_core_config", which is
either "mingw_core_config" (doesn't read "core.bare") or
noop_core_config (noop).

> @@ -231,9 +230,24 @@ static int create_default_files(const char *template_path,
>  	 * We must make sure command-line options continue to override any
>  	 * values we might have just re-read from the config.
>  	 */
> -	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
>  	if (init_shared_repository != -1)
>  		set_shared_repository(init_shared_repository);
> +	/*
> +	 * TODO: heed core.bare from config file in templates if no
> +	 *       command-line override given
> +	 *
> +	 * Unfortunately, this location in the code is far too late to
> +	 * allow this to happen; both builtin/init.db and
> +	 * builtin/clone.c setup the new repository and call
> +	 * set_git_work_tree() before this point.  (Note that both do
> +	 * that repository setup before calling init_db(), which in
> +	 * turn calls create_default_files().)  Fixing it would
> +	 * require too much refactoring, and no one seems to have
> +	 * wanted this behavior in 15+ years, so we'll continue
> +	 * ignoring the config for now and just override
> +	 * is_bare_repository_cfg unconditionally.
> +	 */
> +	is_bare_repository_cfg = is_bare_repository() || !work_tree;
>  
>  	/*
>  	 * We would have created the above under user's umask -- under

Now, we're in the midst of the re-init. Expanding the context a little,
we see:

	git_config(git_default_config, NULL);

	/*
	 * We must make sure command-line options continue to override any
	 * values we might have just re-read from the config.
	 */
	is_bare_repository_cfg = init_is_bare_repository || !work_tree;

So now we've read the new config of the re-inited repo, which might have
"core.bare" set to a value other than what "git init-db [--bare]"
started with, so we want to _intentionally_ ignore it. We do this by
reading out the cached value, _not_ by calling is_bare_repository()
again. So it seems to me like this patch changes the intent.

Where I struggling with is how to make this behave badly. The lines
above seem to be defensive in nature - we never use
is_bare_repository_cfg past this point, but we want to guard against
unintentional behavior in the future.

But I thought that logging this value would show a difference in
behavior, e.g.

  diff --git a/builtin/init-db.c b/builtin/init-db.c
  index ba6e0b20fa..da3579d46d 100644
  --- a/builtin/init-db.c
  +++ b/builtin/init-db.c
  @@ -229,6 +229,8 @@ static int create_default_files(const char *template_path,
    * values we might have just re-read from the config.
    */
    is_bare_repository_cfg = init_is_bare_repository || !work_tree;
  +	printf_ln("is_bare_repository_cfg is %d", is_bare_repository_cfg);
  +
    if (init_shared_repository != -1)
      set_shared_repository(init_shared_repository);

  diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
  index 1b6437ec07..e4b978992e 100755
  --- a/t/t1301-shared-repo.sh
  +++ b/t/t1301-shared-repo.sh
  @@ -15,6 +15,14 @@ TEST_PASSES_SANITIZE_LEAK=true
  # Remove a default ACL from the test dir if possible.
  setfacl -k . 2>/dev/null

  +test_expect_success 're-init respects core.bare' '
  +	git init bare.git >actual &&
  +	grep "is_bare_repository_cfg is 0" actual &&
  +	git -C bare.git config core.bare true &&
  +	git init bare.git >actual &&
  +	grep "is_bare_repository_cfg is 1" actual
  +'
  +
  # User must have read permissions to the repo -> failure on --shared=0400
  test_expect_success 'shared = 0400 (faulty permission u-w)' '
    test_when_finished "rm -rf sub" &&

But apparently this doesn't work at all. I can't get this to print
"is_bare_repository_cfg is 1" no matter what I do, before or after your
patch. Maybe there's more at play here (e.g. with setup.c), but I
haven't figured that out.

If I'm right (which I'm not sure about), we might need to keep
init_is_bare_repository around _somewhere_. Not a global, but maybe
as a param.
