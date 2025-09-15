Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7D258EED
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930994; cv=none; b=W1Jd4Jbw0oN16TL0OXb2lunwP9lcg7KF3QcadF+jaj4Bu8dSmnWm2Fy+xegHa2MJjexqtGANLBnOsUpdkmf8cbx3iubzw0H/EPQdVcZPEJbT4RfCGYM6gx7CGzWDdAL+w2gttAl3+BiJKXV2FYGQVDzQ/ekhS25+r7r1zRQztnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930994; c=relaxed/simple;
	bh=EYLyqjlq4GRdCiMsH2AZ0tmmJp01fmEDG/ZPQL8PEgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMNGmcFQg87bPtye9vJzBS0aLkdm129FsJOk40Vt/53JzQbDD+P6K0NJRxG5thNlIe5UkVykQ93q/BuXAZdhMJbJe0Rl41GUDWWhVyUJ0TsVUION2RLhFYP/7wAGLsF+2Y1iBKS8DXi9xV49h/3meou8lLqhQzucMBVBD9AkNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9iibTzx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9iibTzx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45e03730f83so18059525e9.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757930991; x=1758535791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hta5YmRoMmkxBtDXydVO0JrSCdZxxF3VUebZJKcYk7A=;
        b=S9iibTzxKJJykCejyIR4bvjbtYsvJAksppTdOtwrVT1noVT36sQX9cOb1+FQoEaMDt
         VEgGd251QDttzdHrjD3pDjy6oMK3BPxsx8O0Ft8++/C8jCD9j0gwttmPVpu1fy/JWn6/
         kRVnlT9icDo/HRE92khiOZL5nNoXkjb7WAsijU3mQp+GoDXYrhdZf0vt08i7AvXWXN6T
         VkKSvWtltTeSJQ827CsWW/hO7KjXlUKiWn/g5iQQ9mxOTk0rAWDXNmuu4PvENc2b/8YC
         cyVIo+oLYV7c4TWs+gRXiQCc1CLvg656cA03QvwXCmassI+SLhvKztjlyLRosfxVe/+A
         kGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930991; x=1758535791;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hta5YmRoMmkxBtDXydVO0JrSCdZxxF3VUebZJKcYk7A=;
        b=lKaZ6hm6PQPzC4RTgPwSs43L4e1tZzJVG22PwCln7LeQWitYYcWiBflcpppejeKpVT
         B+I35n21vX2q4vXd5Q1hHDAu4meN0qecXoD4upVrqDE58aFZNdynEJ/h8REgIiJNLXVD
         WszNYaC4jZy/r9n2NTiFeyaAgfgm1bi/sr2Ub74+IrivXdQHFk3ndsrWD9gM4T5qkDo1
         d0genb/Nlp2SdkEbBr1LIfsOob3CdFByB9fk0/MtWFV/yAtq9/y95VIxF9Vj0mmB7fou
         I+0RwlX4z46QVM0u2wZy/lhhTgRfyr+/nuLtr4cw8k40a6Oc/Bo+TMpy802P83/bLi6C
         AkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCeFa0JVXTyF4VHWAlWVcX4jj8LQj3iRAo496T9pYHjhIajiECgBBx+hjHLSR9gp6KvLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyycu38NIQDJi2R6lkUlYSTLPhNyP/L9GzvvmGV/thBdErwqECO
	Ns/iJCfMtWuWJ7Ahnv0u5ZCuR8UUlOCYuiV5nvOPc6QepHvuq6EEPqk/
X-Gm-Gg: ASbGncuwWUwARScFEAk5X34HUmkDwzrSHlr6V+0j+cvOxEGxlfkTI/Aj37vebaH71Ri
	d2UvsQuDD0liuxJQOaju2gA4dINbq31WprQO6cp7RXIsNpo07cJ13PXAVrtFetkB7+FzUnxnd1+
	D+tLOxRjEE2hEV5uM4Z24opLp0NFfnTy8J1eo444IL/56TkietpiTP/UW2UsvpKrtlYYGv5Lm2Y
	SbeCMCMKgkplRdY9Jlk3WlhPIjOv+04ABLWj+D2X/DuF6RygkcJAIf6rn7CkRwR+3QvZNgALXEg
	HqGzaGAEQqk9FDZp+cWZD0p9p1nJODCabdvWTSZsj4HsXZ+FDjg0KhfcWxzqBeuhtGZQNP9ra+b
	wvyXqC7qqv8h1E+tnHMBM6U+nAmxv8oNwBoBInwA0Ok6g7RjKkx6t0B97He3ACPrnYr5ql8HM9b
	x6xoZhSUNbIg==
X-Google-Smtp-Source: AGHT+IFgikV+ruwYVOF3kXaXElP7Iiw9ZLJZ4s/1ao3m44AAoRm1FOANYuUU+7hk3Fnh+XDcHzVczg==
X-Received: by 2002:a05:600c:3b08:b0:45f:2c39:51af with SMTP id 5b1f17b1804b1-45f2c395323mr35899785e9.0.1757930990577;
        Mon, 15 Sep 2025 03:09:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm10974162f8f.27.2025.09.15.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:09:50 -0700 (PDT)
Message-ID: <779ec8b7-9939-4860-bdc2-6d620ecfad24@gmail.com>
Date: Mon, 15 Sep 2025 11:09:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] rebase: support --ignore-other-worktrees
To: Gabriel Scherer <gabriel.scherer@inria.fr>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <20250913141327.2775228-3-gabriel.scherer@inria.fr>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250913141327.2775228-3-gabriel.scherer@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gabriel

On 13/09/2025 15:13, Gabriel Scherer wrote:
> From: "Gabriel.Scherer" <gabriel.scherer@inria.fr>
> 
> rebase can currently fail if the branch to rebase is checked out in
> another worktree, and there is no way for users to override this
> error. We add support for the '--ignore-other-worktrees' option of
> 'checkout'.

I'm not sure we want to be encouraging users to rebase a branch that is 
already checked out in another worktree. Unlike the checkout case where 
they maybe just reading the code and not updating the branch, rebase 
will update the branch which is going to be confusing. We could, 
perhaps, add a hint suggesting that if they are making experimental 
changes, they might want to rebase a detached HEAD instead with

     git rebase <upstream> <branch>^0

but I'm not sure if that is helpful or if using a detached HEAD will 
just confuse users.

Thanks

Phillip

> Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>
> ---
>   Documentation/git-rebase.adoc |  6 ++++++
>   builtin/rebase.c              | 11 ++++++++++-
>   t/t3400-rebase.sh             |  4 +++-
>   3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 005caf6164..b703d4056e 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -305,6 +305,12 @@ see the `--empty` flag.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> +--ignore-other-worktrees::
> +	By default, `git rebase` refuses when the branch to rebase is
> +	already checked out or otherwise in use by another
> +	worktree. With this option, other worktrees are ignored and
> +	the rebase proceeds anyway.
> +
>   --reapply-cherry-picks::
>   --no-reapply-cherry-picks::
>   	Reapply all clean cherry-picks of any upstream commit instead
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 3c85768d29..7a57ebd852 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -128,6 +128,7 @@ struct rebase_options {
>   	struct strbuf git_format_patch_opt;
>   	int reschedule_failed_exec;
>   	int reapply_cherry_picks;
> +	int ignore_other_worktrees;
>   	int fork_point;
>   	int update_refs;
>   	int config_autosquash;
> @@ -146,6 +147,7 @@ struct rebase_options {
>   		.git_format_patch_opt = STRBUF_INIT,	\
>   		.fork_point = -1,			\
>   		.reapply_cherry_picks = -1,             \
> +		.ignore_other_worktrees = -1,           \
>   		.allow_empty_message = 1,               \
>   		.autosquash = -1,                       \
>   		.rebase_merges = -1,                    \
> @@ -1234,6 +1236,8 @@ int cmd_rebase(int argc,
>   			 N_("automatically re-schedule any `exec` that fails")),
>   		OPT_BOOL(0, "reapply-cherry-picks", &options.reapply_cherry_picks,
>   			 N_("apply all changes, even those already present upstream")),
> +		OPT_BOOL(0, "ignore-other-worktrees", &options.ignore_other_worktrees,
> +			 N_("do not check if another worktree is using the branch to rebase")),
>   		OPT_END(),
>   	};
>   	int i;
> @@ -1580,6 +1584,10 @@ int cmd_rebase(int argc,
>   			(options.flags & REBASE_INTERACTIVE_EXPLICIT);
>   	}
>   
> +	if (options.ignore_other_worktrees == -1) {
> +		options.ignore_other_worktrees = 0;
> +	}
> +
>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
>   			options.type = REBASE_MERGE;
> @@ -1679,7 +1687,8 @@ int cmd_rebase(int argc,
>   		strbuf_reset(&buf);
>   		strbuf_addf(&buf, "refs/heads/%s", branch_name);
>   		if (!refs_read_ref(get_main_ref_store(the_repository), buf.buf, &branch_oid)) {
> -			die_if_checked_out(buf.buf, 1);
> +			if (!options.ignore_other_worktrees)
> +				die_if_checked_out(buf.buf, 1);
>   			options.head_name = xstrdup(buf.buf);
>   			options.orig_head =
>   				lookup_commit_object(the_repository,
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index c0c00fbb7b..08448b4d4e 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -407,7 +407,9 @@ test_expect_success 'switch to branch checked out elsewhere fails' '
>   	# we test in both worktrees to ensure that works
>   	# as expected with "first" and "next" worktrees
>   	test_must_fail git -C wt1 rebase shared shared &&
> -	test_must_fail git -C wt2 rebase shared shared
> +	test_must_fail git -C wt2 rebase shared shared &&
> +        # with --ignore-other-worktrees the rebase succeeds
> +	git -C wt1 rebase --ignore-other-worktrees shared shared
>   '
>   
>   test_expect_success 'switch to branch not checked out' '

