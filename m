Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AFB1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 06:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeJYP1i (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 11:27:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJYP1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 11:27:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id q7-v6so8028059wrr.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e7Sy7FbcuSYqk6aaTvrx975Zs9VkzSR31G/s5Wt1Gyg=;
        b=jx+rELVF82Sd0c0Wr1XoSpszM/tkPUZTEyQR7DctPGaegjhHYPHhVvg+NnTmeZcPED
         lMSoftfV7Kulmr1qWYP218KOh+HUVp3RU02vDOebkbC8VPezuyByzonHOPipnlk6G0cC
         oGyeedNS0O6Vqzd4A77Gg0VlxcyKzD2H2AewuQsA4RIxVBsUBPIcC86Xzp52vpTzpvSg
         44lGLH/jQWqGSGZ196Tt6yET/cXOWe+8/5BOWQhTLexS5pg1y8iNc2y+dwJTr1JIzS99
         4vSunZ7Z2XwXkr1Rehz40PxVKBbS/F8ddK95QQC09baD5LTh3cur5vbuVjyHbaaL05cr
         3dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e7Sy7FbcuSYqk6aaTvrx975Zs9VkzSR31G/s5Wt1Gyg=;
        b=lDStIqAb7SCz+A5TuHd/JnuvF0BeVUej2A576AEchlpPAlKIiaW55YMxmaotns+Ewl
         tGQ4Y7wJKLJMILDi7YZuadSlAZuxEMob7YDG62H9E4gAM62Ye+tRCl1eXcNjacfMEmJh
         9fkaSd3h0U7Pgg1yFhmjLek/JdT9Ih9bg9RFoHTzxxuBCA36cw2wMgiPbTJuviT9u8P6
         Gz9XZ77xSDcgapszzDnkW8PZpp/JQ5jdKQmO8RAHZ1bhtGFyAvw5IM2hZEeywoNplXPb
         mKXcMEsG/Wfl+Qo3lSTCBwfh5fdGwu/RGNd0MQ/YbtLkiqLkVOCUiaE22Wr8Ugv4j6kT
         zv+Q==
X-Gm-Message-State: AGRZ1gIYUK2+9aGsTPkYWn4ErFJQlbEO4IyBePJLAUnphR1bA7f8Xx/4
        K8UjggAR2xvTkwZMD+fMqac=
X-Google-Smtp-Source: AJdET5ewENtgnqE9W1fLfC4U5yNikw9B2rM8h2bSyChIDo1yOsd76rTGDl+GTSbVPXhvdJNtk39CmA==
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr445573wrw.53.1540450572685;
        Wed, 24 Oct 2018 23:56:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18-v6sm3724907wre.86.2018.10.24.23.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 23:56:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to be more sensible
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
        <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
        <20181025055142.38077-1-nbelakovski@gmail.com>
Date:   Thu, 25 Oct 2018 15:56:10 +0900
In-Reply-To: <20181025055142.38077-1-nbelakovski@gmail.com> (nbelakovski's
        message of "Wed, 24 Oct 2018 22:51:42 -0700")
Message-ID: <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> lock_reason_valid is renamed to is_locked and lock_reason is removed as
> a field of the worktree struct. Lock reason can be obtained instead by a
> standalone function.
>
> This is done in order to make the worktree struct more intuitive when it
> is used elsewhere in the codebase.

So a mere action of getting an in-core worktree instance now has to
make an extra call to file_exists(), and in addition, the callers
who want to learn why the worktree is locked, they need to open and
read the contents of the file in addition?

Why is that an improvement?


>
> Some unused variables are cleaned up as well.
>
> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> ---
>  builtin/worktree.c | 16 ++++++++--------
>  worktree.c         | 55 ++++++++++++++++++++++++++++--------------------------
>  worktree.h         |  8 +++-----
>  3 files changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 41e771439..844789a21 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -634,8 +634,8 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
>  	if (is_main_worktree(wt))
>  		die(_("The main working tree cannot be locked or unlocked"));
>  
> -	old_reason = is_worktree_locked(wt);
> -	if (old_reason) {
> +	if (wt->is_locked) {
> +		old_reason = worktree_locked_reason(wt);
>  		if (*old_reason)
>  			die(_("'%s' is already locked, reason: %s"),
>  			    av[0], old_reason);
> @@ -666,7 +666,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
>  		die(_("'%s' is not a working tree"), av[0]);
>  	if (is_main_worktree(wt))
>  		die(_("The main working tree cannot be locked or unlocked"));
> -	if (!is_worktree_locked(wt))
> +	if (!wt->is_locked)
>  		die(_("'%s' is not locked"), av[0]);
>  	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
>  	free_worktrees(worktrees);
> @@ -734,8 +734,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
>  
>  	validate_no_submodules(wt);
>  
> -	reason = is_worktree_locked(wt);
> -	if (reason) {
> +	if (wt->is_locked) {
> +		reason = worktree_locked_reason(wt);
>  		if (*reason)
>  			die(_("cannot move a locked working tree, lock reason: %s"),
>  			    reason);
> @@ -860,11 +860,11 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  		die(_("'%s' is not a working tree"), av[0]);
>  	if (is_main_worktree(wt))
>  		die(_("'%s' is a main working tree"), av[0]);
> -	reason = is_worktree_locked(wt);
> -	if (reason) {
> +	if (wt->is_locked) {
> +		reason = worktree_locked_reason(wt);
>  		if (*reason)
>  			die(_("cannot remove a locked working tree, lock reason: %s"),
> -			    reason);
> +				reason);
>  		die(_("cannot remove a locked working tree"));
>  	}
>  	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
> diff --git a/worktree.c b/worktree.c
> index 97cda5f97..a3082d19d 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -14,7 +14,6 @@ void free_worktrees(struct worktree **worktrees)
>  		free(worktrees[i]->path);
>  		free(worktrees[i]->id);
>  		free(worktrees[i]->head_ref);
> -		free(worktrees[i]->lock_reason);
>  		free(worktrees[i]);
>  	}
>  	free (worktrees);
> @@ -41,13 +40,29 @@ static void add_head_info(struct worktree *wt)
>  		wt->is_detached = 1;
>  }
>  
> +
> +/**
> + * Return 1 if the worktree is locked, 0 otherwise
> + */
> +static int is_worktree_locked(const struct worktree *wt)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	int locked_file_exists;
> +
> +	assert(!is_main_worktree(wt));
> +
> +	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> +	locked_file_exists = file_exists(path.buf);
> +	strbuf_release(&path);
> +	return locked_file_exists;
> +}
> +
>  /**
>   * get the main worktree
>   */
>  static struct worktree *get_main_worktree(void)
>  {
>  	struct worktree *worktree = NULL;
> -	struct strbuf path = STRBUF_INIT;
>  	struct strbuf worktree_path = STRBUF_INIT;
>  	int is_bare = 0;
>  
> @@ -56,14 +71,11 @@ static struct worktree *get_main_worktree(void)
>  	if (is_bare)
>  		strbuf_strip_suffix(&worktree_path, "/.");
>  
> -	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> -
>  	worktree = xcalloc(1, sizeof(*worktree));
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>  	worktree->is_bare = is_bare;
>  	add_head_info(worktree);
>  
> -	strbuf_release(&path);
>  	strbuf_release(&worktree_path);
>  	return worktree;
>  }
> @@ -89,12 +101,10 @@ static struct worktree *get_linked_worktree(const char *id)
>  		strbuf_strip_suffix(&worktree_path, "/.");
>  	}
>  
> -	strbuf_reset(&path);
> -	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
> -
>  	worktree = xcalloc(1, sizeof(*worktree));
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>  	worktree->id = xstrdup(id);
> +	worktree->is_locked = is_worktree_locked(worktree);
>  	add_head_info(worktree);
>  
>  done:
> @@ -231,27 +241,20 @@ int is_main_worktree(const struct worktree *wt)
>  	return !wt->id;
>  }
>  
> -const char *is_worktree_locked(struct worktree *wt)
> +const char *worktree_locked_reason(const struct worktree *wt)
>  {
> -	assert(!is_main_worktree(wt));
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf lock_reason = STRBUF_INIT;
>  
> -	if (!wt->lock_reason_valid) {
> -		struct strbuf path = STRBUF_INIT;
> -
> -		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> -		if (file_exists(path.buf)) {
> -			struct strbuf lock_reason = STRBUF_INIT;
> -			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
> -				die_errno(_("failed to read '%s'"), path.buf);
> -			strbuf_trim(&lock_reason);
> -			wt->lock_reason = strbuf_detach(&lock_reason, NULL);
> -		} else
> -			wt->lock_reason = NULL;
> -		wt->lock_reason_valid = 1;
> -		strbuf_release(&path);
> -	}
> +	assert(!is_main_worktree(wt));
> +	assert(wt->is_locked);
>  
> -	return wt->lock_reason;
> +	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> +	if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
> +		die_errno(_("failed to read '%s'"), path.buf);
> +	strbuf_trim(&lock_reason);
> +	strbuf_release(&path);
> +	return strbuf_detach(&lock_reason, NULL);
>  }
>  
>  /* convenient wrapper to deal with NULL strbuf */
> diff --git a/worktree.h b/worktree.h
> index df3fc30f7..6717287e8 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -10,12 +10,11 @@ struct worktree {
>  	char *path;
>  	char *id;
>  	char *head_ref;		/* NULL if HEAD is broken or detached */
> -	char *lock_reason;	/* internal use */
>  	struct object_id head_oid;
>  	int is_detached;
>  	int is_bare;
>  	int is_current;
> -	int lock_reason_valid;
> +	int is_locked;
>  };
>  
>  /* Functions for acting on the information about worktrees. */
> @@ -57,10 +56,9 @@ extern struct worktree *find_worktree(struct worktree **list,
>  extern int is_main_worktree(const struct worktree *wt);
>  
>  /*
> - * Return the reason string if the given worktree is locked or NULL
> - * otherwise.
> + * Return the reason string if the given worktree is locked or die
>   */
> -extern const char *is_worktree_locked(struct worktree *wt);
> +extern const char *worktree_locked_reason(const struct worktree *wt);
>  
>  #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
