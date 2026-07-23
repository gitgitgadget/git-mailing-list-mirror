Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372047FB09
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833125; cv=none; b=jVj24pn8lA04Uhrg1FceV2IESoTGHNDPaaUO7eIi8wb6ybM6yU8+zlZ+VsF1PqNCX4NBz6twXdhHD4AhMXAyoiqT+Y1g8ieYYGbnGpbUzH5xdey5lR4prHV0k/0XMygTPW9FyPpRFZQSfUkOWRCAQzlrPhgheObL0UZ1YCInjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833125; c=relaxed/simple;
	bh=0UOtdCyGh+CkkYY9XNRLyEz11dLSXBOoyYW2fc/snIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os0A9mDvbki6j7R/I4ybcVI2gfOG8Z8eI2uR9mLbirNUjADiBzrR5YeoxJf9ByeJxI+0FOKhk7mppMm6HdrNrIx6VP5cBo3VDKE37zy29tUjIBgDGBTwY3VvGY/7JYOZxVMBSzqrvcsSADQmAy8ptS+Tq41sCGgKqnxeKcOGcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5D5Vrhn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5D5Vrhn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954aff6088so8774155e9.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784833120; x=1785437920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EEjRvDU+Zeiy4n4kU4Z2CVk4COxFPP9XGcnnczyvlxM=;
        b=c5D5VrhnzC5a/k5L2yrKYm6Tjf+jekCNbaS71wH6vpT/yltEnrdLm9cD82O/SBTT5b
         FNu1UZX/FLTJYfb5ms/+/7aprHaEHzpbYg5kgU6JtlDSKao0wOi6aKvlbSvNCPs/r3lU
         yWwtdt9wRFgPODwYNX2RuxUBhGBkgnb+Gdziae3diNATWlATJwVybpSd0nzGw0ffBW5+
         IzA5NGn+EaAS9s0QqUJtCrFKswRfw6QxWaeBFSkJarMkK6stKuvXVYs4e8pqUSCbYDMe
         aCKj2D6AAJT1ed8FPlyx9EqO/utCG/if+l46qaWSG84uPOSJc+MeZ8dsOM/m4d9lb4ar
         1nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784833120; x=1785437920;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EEjRvDU+Zeiy4n4kU4Z2CVk4COxFPP9XGcnnczyvlxM=;
        b=tBZpBmihQKY1Dxfi9SfRcIYBv2l/9pOl34waKGv/jyNHd4Iyk6PdU9VG08ppl7U4Fy
         QqeEtDjW1botZUNhw6ymALE9zeH1/1ql/TEFWB1Bc2yUHBnufDS48sckTKaLBYiRKG0h
         0gRWBHxebcCxHWZ97k5Mj6BR01OyjNRNDHalu4NSvRKd+9ZdeElI9rZCD4diNlZo5JCH
         Gw5ZByh/4nd0OXeJqLTPB9OZmloRL7ojy7Sxji91dCQVKZ7n/m6SaCNldQndSi5KJLDX
         uk3YHIDoWrkDEo3fEDk43pJAWU8Ja+BmCKW7IOtCSlSAnfvlGRXDBAlCA4jyFrrqNmXx
         DbwA==
X-Forwarded-Encrypted: i=1; AHgh+RobUEruwMKoQ+YtGHFcthwixEuIqE3KTcDSKMZBJy8SET2E5qxxXxmrvLQzaE0YqOu2CmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6gZquXLiEti93jo9S/2fNx4kQrQ8PeZAdr+M9Ewp1WeqcGcB
	5EVUovqeK5pRPMhrosqhbK2jwY65yXPVYlrISDuHQPzZcdseTsQHmpcs
X-Gm-Gg: AR+sD11MVmYHGeuTsTKk7ISgYrpM84Rmaa4vMyqsTVgbQpNIHKAUNW2IRwe2DH8006Z
	GPfsxGUa7CMCBYNNjdlg/Wnj0es65c1BWewN7PjRjv8u1zdq6mPu1GpRheYHgP7QX/2+R4P5Vs9
	eWkkWURjeTwEOkFst4++Ayt9pvPjcQmDyj2yeGDvPi2vtZ86VXC+3e31Z8C9k/XAxpX6pGRiSmv
	ksERSHNTGofvzGjkage8BNJnlu+zHiPtn5tpjoB8JJTiNvzQm+91XmrpGfkwSd0d3QV48HTS0Kj
	UKyFYS5EgVEzdd1HyW5yRLkcYjfV7NGt0Izl28BgVKK++OzdHmbcB8IFikXUqg4yknX0Jj1+7Im
	oge7XAAbXh5s7r1ShCuKvuKR4nDL5EgZZ7YgOocZUr2kARwD+aOzNDCPk+ZGTj2pVGgY39kS9NY
	rPdkeb7X6rZZQit1Kup2ah8vbOiBHmw4wo1pMBLEzvk2ViNhzx/Q2NVi0QIQBJ+CKlu+E=
X-Received: by 2002:a05:600c:190b:b0:495:5e07:649b with SMTP id 5b1f17b1804b1-49573cd895amr48635925e9.24.1784833119458;
        Thu, 23 Jul 2026 11:58:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f2918sm9912095e9.2.2026.07.23.11.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 11:58:38 -0700 (PDT)
Message-ID: <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
Date: Thu, 23 Jul 2026 19:58:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
To: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2026 09:15, Son Luong Ngoc via GitGitGadget wrote:
> From: Son Luong Ngoc <sluongng@gmail.com>
> 
> git rebase --update-refs can finish rewriting the current branch and
> then fail while updating a local branch that is a symbolic ref. This can
> happen during a default-branch rename where refs/heads/main points at
> refs/heads/master while users migrate.
> 
> The problem is a partially applied ref update: the main rebase has
> already succeeded when the later ref update fails.
> 
> The sequencer queues updates from local branch decorations. Commit
> 106b6885c7 (rebase: ignore non-branch update-refs) filters out
> decorations such as HEAD and tags. A branch symref is still a local
> branch decoration, but refs_update_ref() dereferences it, so an alias to
> another branch duplicates the concrete branch update.
> 
> Resolve local branch decorations before queuing them. Skip symrefs whose
> targets are under refs/heads/ so that only the concrete branch update is
> queued. Keep an owned copy of the resolved HEAD and skip the current
> branch before checked-out handling so later ref resolution cannot change
> the comparison.
> 
> This prevents a successful rebase from being followed by a failed,
> partially applied ref update while preserving each alias as a symref.

Thanks for re-rolling I'm pretty sure the logic is sound now but I'm a 
bit confused by a couple of things - see my comments below.

> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
> ---
>   sequencer.c                   | 44 +++++++++++++++++++++++++----------
>   t/t3400-rebase.sh             |  2 +-
>   t/t3404-rebase-interactive.sh | 16 +++++++++++++
>   3 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 1355a99a09..63aba60a08 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6465,32 +6465,50 @@ static int add_decorations_to_list(const struct commit *commit,
>   				   struct todo_add_branch_context *ctx)
>   {
>   	const struct name_decoration *decoration = get_name_decoration(&commit->object);
> -	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						       "HEAD",
> -						       RESOLVE_REF_READING,
> -						       NULL,
> -						       NULL);
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	char *head_ref = refs_resolve_refdup(refs, "HEAD",
> +					     RESOLVE_REF_READING,
> +					     NULL, NULL);
>   
>   	while (decoration) {
>   		struct todo_item *item;
>   		const char *path;
> +		char *resolved_ref;
> +		int flags = 0;
>   		size_t base_offset = ctx->buf->len;
>   
>   		/*
> -		 * If the branch is the current HEAD, then it will be
> -		 * updated by the default rebase behavior.
> -		 * Exclude it from the list of refs to update,
> -		 * as well as any non-branch decorations.
>   		 * Non-branch decorations may be present if the pretty format
>   		 * includes "%d", which would have loaded all refs
>   		 * into the global decoration table.
>   		 */
> -		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
> -		    (decoration->type != DECORATION_REF_LOCAL)) {
> +		if (decoration->type != DECORATION_REF_LOCAL) {
> +			decoration = decoration->next;
> +			continue;
> +		}

It would be nice to have a comment here explaining what we're doing. 
Also I don't think we need to copy the refname so it would be more 
efficient to use refs_resolve_ref_unsafe().

> +		resolved_ref = refs_resolve_refdup(refs, decoration->name,
> +						      RESOLVE_REF_READING,
> +						      NULL, &flags);
> +		if (resolved_ref && (flags & REF_ISSYMREF) &&
> +		    starts_with(resolved_ref, "refs/heads/")) {
> +			free(resolved_ref);
> +			decoration = decoration->next;
> +			continue;
> +		}

We skip any symbolic refs that point to another branch which is good.

> +		/*
> +		 * If the branch is the current HEAD, then it will be
> +		 * updated by the default rebase behavior.
> +		 */
> +		if (head_ref && !strcmp(head_ref, decoration->name)) {
> +			free(resolved_ref);
>   			decoration = decoration->next;
>   			continue;
>   		}

Then we check to see if the decoration matches HEAD which we used to do 
above - I'm not clear why we have moved this check.

> +		path = branch_checked_out(decoration->name);
> +

This belongs in the next patch I think.

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index e62e07b894..1a02f6546b 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -471,7 +471,7 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on

Adding an extra context line shows

	git checkout topic2>   	GIT_SEQUENCE_EDITOR="cat >actual" git -c 
core.commentChar=% \
>   		 rebase -i --update-refs base &&
>   	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
> -	test_grep "% Ref refs/heads/topic2 checked out at" actual
> +	test_grep ! "% Ref refs/heads/topic2 checked out at" actual

As topic2 is checked out in the worktree where the rebase is running why 
did this line appear before?

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e64816770a..11afa8be56 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1975,15 +1975,23 @@ test_expect_success '--update-refs ignores non-branch decorations' '
>   	) &&
>   	grep ^update-ref todo >actual &&
>   	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
> +	test_grep ! "^# Ref refs/heads/update-refs checked out" todo &&

Lets move this line below test_cmp so we keep that line next to the ones 
that create the files that are being compared. Is this another case 
where we used to add this comment and no longer do so?

>   	test_cmp expect actual
>   '
>   
>   test_expect_success '--update-refs updates refs correctly' '
> +	test_when_finished "
> +		test_might_fail git symbolic-ref -d refs/heads/no-conflict-branch-alias &&
> +		test_might_fail git symbolic-ref -d refs/heads/second-alias
> +	" &&
>   	git checkout -B update-refs no-conflict-branch &&
>   	git branch -f base HEAD~4 &&
>   	git branch -f first HEAD~3 &&
>   	git branch -f second HEAD~3 &&
>   	git branch -f third HEAD~1 &&
> +	git symbolic-ref refs/heads/no-conflict-branch-alias \
> +		refs/heads/no-conflict-branch &&
> +	git symbolic-ref refs/heads/second-alias refs/heads/second &&
>   	test_commit extra2 fileX &&
>   	git commit --amend --fixup=L &&
>   
> @@ -1991,8 +1999,16 @@ test_expect_success '--update-refs updates refs correctly' '
>   
>   	test_cmp_rev HEAD~3 refs/heads/first &&
>   	test_cmp_rev HEAD~3 refs/heads/second &&
> +	test_cmp_rev HEAD~3 refs/heads/second-alias &&
>   	test_cmp_rev HEAD~1 refs/heads/third &&
>   	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
> +	test_cmp_rev HEAD refs/heads/no-conflict-branch-alias &&
> +	test_write_lines refs/heads/no-conflict-branch >expect &&
> +	git symbolic-ref refs/heads/no-conflict-branch-alias >actual &&
> +	test_cmp expect actual &&
> +	test_write_lines refs/heads/second >expect &&
> +	git symbolic-ref refs/heads/second-alias >actual &&
> +	test_cmp expect actual &&

This looks good - we check that "rebase --update-refs" succeeds withh 
branches that are symrefs and also that those refs are untouched by the 
rebase.

Thanks

Phillip

>   	q_to_tab >expect <<-\EOF &&
>   	Successfully rebased and updated refs/heads/update-refs.

