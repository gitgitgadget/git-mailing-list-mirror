Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37C3EF0D4
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389668; cv=none; b=jLixaaggsGWTOmI+luFJQtcd6KAjjUZUI3uLTJxscE/WdqPpktUmBE3vDgZBHXnI4HJuCRI7vYdIK/plSkMrfeZcUiCcA+jdu3g3uT4wCrGXh19kBB/V274YvngPO6Al95teLUbXXrWLb7Hc+sPzzE5uZTF0iQfbQlHnUARSes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389668; c=relaxed/simple;
	bh=KgtGtE7wlmejNOvSBo1jKL8OhJ4QOu7VB4D6d5Jh9uI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lXhdxkvXkyXiAtEaFWe6tWlJ0b+nYXL1ntojRm+2C9MRBnk26Hy28iF+IN800WmRuGBqyDYwLLUZjmYfOyq+xaokAaN/6Z5izFkZgsRKpgs5hM+HUs5rTyfV8GAFk36nlHQ5l+aqgIK7QeDOsTKjXP/u+LeBZ2bYyyuCfL4VYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpEDR+5N; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpEDR+5N"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4362507f396so1587131f8f.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 06:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770389666; x=1770994466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efxiNBw18U+P9g09Vy0KSE4a+0VEQEKeSe0+lyijZY4=;
        b=dpEDR+5NEYy+l4CWVxi++O2TRF2vIbLOM1q0KqHATn3fi4IxjSx8wBK7BjWDBrx0hN
         mBvNyKBn/pmtS0QJdtTin+iecBEwz6+X9VkyWFjKoHhWGg5DzFdQESZib/ONp+ON8NRK
         O7cbtTc4dc3sF92xpefibnX9sg8WG7VB+Q1Yu6dS1P7CD+Xz22j3d92Cl+XFST/58M/7
         OtyOPR3gkxapOlTUCIdpKNlR1IMd6PBMA2WnV6Kk87XGVgMO7efi2/U7zADMO+w+TUR7
         OpSjZDf9Fig8keGKsj6KglVPVs1mmn4IX2YdQS9Vwd/FYRKZzupvmegCgihlwqtCY5Pv
         EXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389666; x=1770994466;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efxiNBw18U+P9g09Vy0KSE4a+0VEQEKeSe0+lyijZY4=;
        b=B39z14GedwAWPC5bQCH0SvKtNuSeGZQ8w9KURMUWiVNmS8H6qU/zowgi+iBpREVJdN
         LCON3kzwVJCL0f0hR1nZ6KdJdkHzi//0HTaVZk0xCATPR99u5VmSmOBoh1IJO3Whgvwm
         0VdtgUPLkwYYDc6faJNscH6ItaBsnRlamxg44iTU4etoIW7o6g5tuZC0ux7Wv+SnrIjm
         iMabfeUVR0nNHyFXvv9sCTpuGIhDT6Xcut7K5rGL2vLU73x5Yg/R+Q5g18YjkXyXDqKx
         uzN/XISE2XHRxNR2kylfASb6TZeop3Fazy/Y+0vH0b6EJkE0kzbrCnibxEnwzidf2dVA
         E44w==
X-Forwarded-Encrypted: i=1; AJvYcCXX/fSv4gCbQDXahl1HRLtBNPeLaCCigP09Ep3Gm+HtZzLt2NkC/SfmY7O8ECK+cqWQ7kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwceaPYv9/oa/OnFpr99kLmVHtZLLg84JXxFgmfr575gpH1Bruj
	YAgYXHA1ltdR/XlaLXmt9P1I3+EsQerpEnbAcDeScSIwH0hXl8dZLJ4Vw86dUJKv
X-Gm-Gg: AZuq6aKx/FSnk4ZmHHDoH+W7CuUCj3rvI6bfW5VDseccXZxOsO1txQMKYxHVW7aTClG
	wrt0cV44q9KNa9xZTlhy1quKwA0B508GkQh/set0ZONIWL3ahtPfm8LdvGaPaq0fYqNq2bU2Q82
	URd1BgIRV1l+6hhipRWZaqdeDoPevY2W+LTLUaKfMCXWzy9a852ocFfq9PrXFyge/MnnMpIn+T0
	Nw/lnUWbgZLGt1brZMF1nRvhYg5EXOPuWvef8XX+6norm0ZJScopYgf2/PAOgS8Nyitrotef+Ow
	OiKX1MR9IUZXgsYW2fRQQ90ce9hxpODt9+6WGBHMy8bhL2aL9/RGCtXBxK1wyAxavpcEnNcCWH2
	qIGYiAs9nvb6stSh0wtixM6C30EaApvzi/pZCSvTe6V+xnL/Gl35Nj3lbCVJkIeYqRcJR5MEbaO
	yMp6mNBMtmkH0058YTIeL14xj+mZgj11dHRbPJTQeBRUn090AEXbPR48EGUjlxXHJVZw==
X-Received: by 2002:a5d:588d:0:b0:435:94f8:e7c6 with SMTP id ffacd0b85a97d-4362933ac28mr4045475f8f.9.1770389665268;
        Fri, 06 Feb 2026 06:54:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm6896135f8f.31.2026.02.06.06.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 06:54:24 -0800 (PST)
Message-ID: <997a4a47-2d00-418f-b0a6-3e4dc2f45bbb@gmail.com>
Date: Fri, 6 Feb 2026 14:54:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <20260206093257.1178858-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260206131017.1199921-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
In-Reply-To: <20260206131017.1199921-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2026 12:57, Shreyansh Paliwal wrote:
> I tried this out below, and it showed no fails in tests.
> After this we can just directly replace all the_repository with 'r' or 's->repo'
> without the hassle of checking the worktree is defined or not.

As we're trying to remove uses of "the_repository" I think you should 
use "wt->repo" where we know always "wt != NULL". There are not many 
callers of these functions so is easy to do necessary analysis (see below).

> diff --git a/branch.c b/branch.c
> index 243db7d0fc..0a0097dd85 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
>   			free(old);
>   		}
>   
> -		if (wt_status_check_rebase(wt, &state) &&
> +		if (wt_status_check_rebase(the_repository, wt, &state) &&

As I said yesterday we know "wt != NULL" here so it is fine to use 
"wt->repo" rather than introduce a new use of "the_repository", you just 
need to explain that in the commit message.

>   		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
>   		    state.branch) {
>   			struct strbuf ref = STRBUF_INIT;
> @@ -425,7 +425,7 @@ static void prepare_checked_out_branches(void)
>   		}
>   		wt_status_state_free_buffers(&state);
>   
> -		if (wt_status_check_bisect(wt, &state) &&
> +		if (wt_status_check_bisect(the_repository, wt, &state) &&

The same is true here.

>   		    state.bisecting_from) {
>   			struct strbuf ref = STRBUF_INIT;
>   			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
> diff --git a/worktree.c b/worktree.c
> index 9308389cb6..86eff384ae 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -443,7 +443,7 @@ int is_worktree_being_rebased(const struct worktree *wt,
>   	int found_rebase;
>   
>   	memset(&state, 0, sizeof(state));
> -	found_rebase = wt_status_check_rebase(wt, &state) &&
> +	found_rebase = wt_status_check_rebase(the_repository, wt, &state) &&

This function is called from 
builtin/branch.c:reject_rebase_or_bisect_branch() with "wt != NULL". It 
is also called from worktree.c:is_shared_symref() which dereferences wt 
before calling this function so we can assume "wt != NULL" there as 
well. That means we can use "wt->repo" here.

>   		       (state.rebase_in_progress ||
>   			state.rebase_interactive_in_progress) &&
>   		       state.branch &&
> @@ -460,7 +460,7 @@ int is_worktree_being_bisected(const struct worktree *wt,
>   	int found_bisect;
>   
>   	memset(&state, 0, sizeof(state));
> -	found_bisect = wt_status_check_bisect(wt, &state) &&
> +	found_bisect = wt_status_check_bisect(the_repository, wt, &state) &&

The same analysis for is_worktree_being_rebased() applies here.

The changes to get_branch() below look sensible

Thanks

Phillip

>   		       state.bisecting_from &&
>   		       skip_prefix(target, "refs/heads/", &target) &&
>   		       !strcmp(state.bisecting_from, target);
> diff --git a/wt-status.c b/wt-status.c
> index e12adb26b9..ea81418bdd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -984,7 +984,7 @@ static int stash_count_refs(const char *refname UNUSED,
>   	return 0;
>   }
>   
> -static int count_stash_entries(void)
> +static int count_stash_entries(struct repository *r)
>   {
>   	int n = 0;
>   	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
> @@ -994,7 +994,7 @@ static int count_stash_entries(void)
>   
>   static void wt_longstatus_print_stash_summary(struct wt_status *s)
>   {
> -	int stash_count = count_stash_entries();
> +	int stash_count = count_stash_entries(s->repo);
>   
>   	if (stash_count > 0)
>   		status_printf_ln(s, GIT_COLOR_NORMAL,
> @@ -1287,7 +1287,7 @@ static void show_am_in_progress(struct wt_status *s,
>   	wt_longstatus_print_trailer(s);
>   }
>   
> -static char *read_line_from_git_path(const char *filename)
> +static char *read_line_from_git_path(struct repository *r, char *filename)
>   {
>   	struct strbuf buf = STRBUF_INIT;
>   	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
> @@ -1325,8 +1325,8 @@ static int split_commit_in_progress(struct wt_status *s)
>   	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
>   		return 0;
>   
> -	rebase_amend = read_line_from_git_path("rebase-merge/amend");
> -	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
> +	rebase_amend = read_line_from_git_path(s->repo, "rebase-merge/amend");
> +	rebase_orig_head = read_line_from_git_path(s->repo, "rebase-merge/orig-head");
>   
>   	if (!rebase_amend || !rebase_orig_head)
>   		; /* fall through, no split in progress */
> @@ -1350,7 +1350,7 @@ static int split_commit_in_progress(struct wt_status *s)
>    * The function assumes that the line does not contain useless spaces
>    * before or after the command.
>    */
> -static void abbrev_oid_in_line(struct strbuf *line)
> +static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
>   {
>   	struct string_list split = STRING_LIST_INIT_DUP;
>   	struct object_id oid;
> @@ -1372,7 +1372,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
>   	string_list_clear(&split, 0);
>   }
>   
> -static int read_rebase_todolist(const char *fname, struct string_list *lines)
> +static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
>   {
>   	struct strbuf buf = STRBUF_INIT;
>   	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
> @@ -1392,7 +1392,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
>   		strbuf_trim(&buf);
>   		if (!buf.len)
>   			continue;
> -		abbrev_oid_in_line(&buf);
> +		abbrev_oid_in_line(r, &buf);
>   		string_list_append(lines, buf.buf);
>   	}
>   	fclose(f);
> @@ -1413,8 +1413,8 @@ static void show_rebase_information(struct wt_status *s,
>   		struct string_list have_done = STRING_LIST_INIT_DUP;
>   		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
>   
> -		read_rebase_todolist("rebase-merge/done", &have_done);
> -		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
> +		read_rebase_todolist(s->repo, "rebase-merge/done", &have_done);
> +		if (read_rebase_todolist(s->repo, "rebase-merge/git-rebase-todo",
>   					 &yet_to_do))
>   			status_printf_ln(s, color,
>   				_("git-rebase-todo is missing."));
> @@ -1618,7 +1618,7 @@ static void show_sparse_checkout_in_use(struct wt_status *s,
>   /*
>    * Extract branch information from rebase/bisect
>    */
> -static char *get_branch(const struct worktree *wt, const char *path)
> +static char *get_branch(struct repository *r, struct worktree *wt, const char *path)
>   {
>   	struct strbuf sb = STRBUF_INIT;
>   	struct object_id oid;
> @@ -1718,8 +1718,9 @@ static void wt_status_get_detached_from(struct repository *r,
>   	strbuf_release(&cb.buf);
>   }
>   
> -int wt_status_check_rebase(const struct worktree *wt,
> -			   struct wt_status_state *state)
> +int wt_status_check_rebase(struct repository *r,
> +	 			const struct worktree *wt,
> +			    struct wt_status_state *state)
>   {
>   	struct stat st;
>   
> @@ -1730,29 +1731,30 @@ int wt_status_check_rebase(const struct worktree *wt,
>   				state->am_empty_patch = 1;
>   		} else {
>   			state->rebase_in_progress = 1;
> -			state->branch = get_branch(wt, "rebase-apply/head-name");
> -			state->onto = get_branch(wt, "rebase-apply/onto");
> +			state->branch = get_branch(r, wt, "rebase-apply/head-name");
> +			state->onto = get_branch(r, wt, "rebase-apply/onto");
>   		}
>   	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
>   		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
>   			state->rebase_interactive_in_progress = 1;
>   		else
>   			state->rebase_in_progress = 1;
> -		state->branch = get_branch(wt, "rebase-merge/head-name");
> -		state->onto = get_branch(wt, "rebase-merge/onto");
> +		state->branch = get_branch(r, wt, "rebase-merge/head-name");
> +		state->onto = get_branch(r, wt, "rebase-merge/onto");
>   	} else
>   		return 0;
>   	return 1;
>   }
>   
> -int wt_status_check_bisect(const struct worktree *wt,
> +int wt_status_check_bisect(struct repository *r,
> +			   struct worktree *wt,
>   			   struct wt_status_state *state)
>   {
>   	struct stat st;
>   
>   	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
>   		state->bisect_in_progress = 1;
> -		state->bisecting_from = get_branch(wt, "BISECT_START");
> +		state->bisecting_from = get_branch(r, wt, "BISECT_START");
>   		return 1;
>   	}
>   	return 0;
> @@ -1797,16 +1799,16 @@ void wt_status_get_state(struct repository *r,
>   	enum replay_action action;
>   
>   	if (!stat(git_path_merge_head(r), &st)) {
> -		wt_status_check_rebase(NULL, state);
> +		wt_status_check_rebase(r, NULL, state);
>   		state->merge_in_progress = 1;
> -	} else if (wt_status_check_rebase(NULL, state)) {
> +	} else if (wt_status_check_rebase(r, NULL, state)) {
>   		;		/* all set */
>   	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>   		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
>   		state->cherry_pick_in_progress = 1;
>   		oidcpy(&state->cherry_pick_head_oid, &oid);
>   	}
> -	wt_status_check_bisect(NULL, state);
> +	wt_status_check_bisect(r, NULL, state);
>   	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
>   	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
>   		state->revert_in_progress = 1;
> @@ -2259,7 +2261,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
>    */
>   static void wt_porcelain_v2_print_stash(struct wt_status *s)
>   {
> -	int stash_count = count_stash_entries();
> +	int stash_count = count_stash_entries(s->repo);
>   	char eol = s->null_termination ? '\0' : '\n';
>   
>   	if (stash_count > 0)
> diff --git a/wt-status.h b/wt-status.h
> index e40a27214a..5ac3d96210 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -164,9 +164,11 @@ void wt_status_state_free_buffers(struct wt_status_state *s);
>   void wt_status_get_state(struct repository *repo,
>   			 struct wt_status_state *state,
>   			 int get_detached_from);
> -int wt_status_check_rebase(const struct worktree *wt,
> +int wt_status_check_rebase(struct repository *r,
> +			   struct worktree *wt,
>   			   struct wt_status_state *state);
> -int wt_status_check_bisect(const struct worktree *wt,
> +int wt_status_check_bisect(struct repository *r,
> +			   struct worktree *wt,
>   			   struct wt_status_state *state);
>   
>   __attribute__((format (printf, 3, 4)))

