Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9926AF6
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290948; cv=none; b=FfdGiEeZI9FJ+LR5q4/u5Ta7NeK6A0Nf1FEu7aMUgO2XV4vIBMYJFQ1DhODQVajjGeuDyh5azyRBkXJK3bYJ2x/Bxfy2Hf2lXnYsAAbE3e2f9OLz3ns+rurAbtQU1/+6l9nc9mmoqX0n6OAakl/LwD0isFF6PkDLJW1R9aKk4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290948; c=relaxed/simple;
	bh=foMMDeUL6Qwv2EsncbAA1NP+E7DPKB+BLn89G6nRQRc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cyX67NwXxeWdWp6aAgijxTU9V+6RKb+o7vFAdl/HTgtKyU0J/qz8Pnud5syIr1QV4iuJwy2zrCO6epxKjgawptdwUSKEZ4vQK8ySZEQhdFcSqZa85smW10GpnzhjZrEC0MkdCygvqB6rJ2RVYboXcqjhAphZxivkyHjN12unJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8zJtlW0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8zJtlW0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382456c6597so1640739f8f.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732290945; x=1732895745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHJVg2gSPVEVPcPtxCoa0XHAJmKuDfLeVqkHzNYTC4M=;
        b=i8zJtlW03qA3hq4lCvbcBlMIssTaUWu+RHueswX0JBfDCr/4K+7tAUsCvD6zeY49wZ
         IKjTJorsGfdcV6BXuaZgcrkIYlJhGgEzBc4vqkl2ZDzX/Wv5/URHPFn9d2jqJ75VyTGO
         vLZdasZtpGsEfsACuwe0zbx8G+k/hobY0m0uhTIol5zELB6wE+6lTmefQyrf4YjuT+We
         OXm66iN6ALnC9C+cb0EWWUlIyicpyj8D3uMOFAMEfE7Q6w44p34DgyqrGYOvem6mb6NS
         xPBfihZSqBPsUgReDroPMDpc+wfGQiIIHkKTql7YTyd0OnLQ5R86PbiuSqV/70ClDn10
         vniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290945; x=1732895745;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHJVg2gSPVEVPcPtxCoa0XHAJmKuDfLeVqkHzNYTC4M=;
        b=EqNQ+ShZKCZ/8fKTsrO7tNMl5FOPKlFfFD80SqlTJpegM/VkB37QBLwLAx2lzG/Ehp
         0Gp1GdnxzB9jIAd1L9qfsKysx0Bsrjbb2NjM4lulKaNi4kYt2UVs2wjTeNjF7xhvmdlj
         RPH7kuJBGs95TU6PVpu+D0e1QBWFy3GrQ9ZULKlJAUgYqqmrfmPmQgPkOMhUhbhlidGh
         VMp8JbwTEASx6LXy8VGVlX2RgWjlzQ6vvA/Ch6Jp5FiJdQ3RgaMGrtewNOZWmPjsJVaO
         lT3ZErcDIIqFtqoe6j7BS0OCMlDAcudYG6VnxtwIfdAnteMjSWlNDzmOIbtDwUnA+ZlE
         ILUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWujZZScZwWjwIOXJx46a2VEitGZYe7Vj6IhKCcjnF3pAnLkqlVrsV1xIjA32J7Uj7e3V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SC3CNdr6fyx5AoSXDfUdJbfEy1HiBhQGgVYjWE+88J3s6sgC
	yEWHmUVqH9R6YWBd8Oy31aNhZ8Sz6S7ULoxEe038Xz5EVPxPHb/ViXn5cA==
X-Gm-Gg: ASbGncvgs6olO7t8maR8OGc9yWKH+ygG3xfbE3qroifl/d9oycT3U85+YoZhN/b2mcC
	xyjLp8jF7BsXRxH6y7iS5lczY2qfsQZ9WTbcCw6PEF5wnSLghws2VSFVRGUQHOYKwvkfIEA0K7g
	5aEjnoFNccFD44tEJrKHaHVtXezoyn9tbrXmAGXvV8qf6uWR6tbjKsdIKvGJ7tGuMpF0R7Qphd8
	r6FmZsQfPSh4+i9vglkEfzfPiPhTtCr9eiVmzLusNQUl2L6/dgEWx5lv1pAYgUHkzVx1g8Wentw
	bZwG/3PiyL2b++UNzIfb8BFFUQ==
X-Google-Smtp-Source: AGHT+IHMHP/tx/RVnW5N33woqpy0yRL4TQwLQpXt4wRdapHa3jkI3ntaG+cQG9pflmSSBljE+0VXQw==
X-Received: by 2002:a05:6000:1acd:b0:382:31db:d61 with SMTP id ffacd0b85a97d-38260bcb9dbmr3362523f8f.38.1732290944698;
        Fri, 22 Nov 2024 07:55:44 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedfccsm2707652f8f.101.2024.11.22.07.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:55:44 -0800 (PST)
Message-ID: <135739ad-6722-449b-9f9b-31c0bbc9f9cb@gmail.com>
Date: Fri, 22 Nov 2024 15:55:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 7/8] worktree: add relative cli/config options to
 `repair` command
Reply-To: phillip.wood@dunelm.org.uk
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-7-07a3dc0f02a3@pm.me>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-7-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 01/11/2024 04:38, Caleb White wrote:
> This teaches the `worktree repair` command to respect the
> `--[no-]relative-paths` CLI option and `worktree.useRelativePaths`
> config setting. If an existing worktree with an absolute path is repaired
> with `--relative-paths`, the links will be replaced with relative paths,
> even if the original path was correct. This allows a user to covert
> existing worktrees between absolute/relative as desired.

This looks pretty good the strbuf changes rather mask the real meat of 
the patch though.

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> index 7686e60f6ad186519b275f11a5e14064c905b207..84451e903b2ef3c645c0311faf055c846588baf6 100755
> --- a/t/t2406-worktree-repair.sh
> +++ b/t/t2406-worktree-repair.sh
> @@ -216,4 +216,30 @@ test_expect_success 'repair copied main and linked worktrees' '
>   	test_cmp dup/linked.expect dup/linked/.git
>   '
>   
> +test_expect_success 'repair absolute worktree to use relative paths' '
> +	test_when_finished "rm -rf main side sidemoved" &&
> +	test_create_repo main &&
> +	test_commit -C main init &&
> +	git -C main worktree add --detach ../side &&
> +	echo "../../../../sidemoved/.git" >expect-gitdir &&
> +	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
> +	mv side sidemoved &&
> +	git -C main worktree repair --relative-paths ../sidemoved &&
> +	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
> +	test_cmp expect-gitfile sidemoved/.git
> +'
> +
> +test_expect_success 'repair relative worktree to use absolute paths' '
> +	test_when_finished "rm -rf main side sidemoved" &&
> +	test_create_repo main &&
> +	test_commit -C main init &&
> +	git -C main worktree add --relative-paths --detach ../side &&
> +	echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
> +	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
> +	mv side sidemoved &&
> +	git -C main worktree repair ../sidemoved &&
> +	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
> +	test_cmp expect-gitfile sidemoved/.git
> +'

These tests looks sensibile, we should probably check that "git worktree 
repair" repects worktree.userelativepaths. I wonder if we have any 
coverage of repair_worktrees() as I think in these tests the problem is 
fixed by repair_worktree_at_path() before we call repair_worktrees().

>   test_done
> diff --git a/worktree.c b/worktree.c
> index 6b640cd9549ecb060236f7eddf1390caa181f1a0..2cb994ac462debf966ac51b5a4f33c30cfebd4ef 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -574,12 +574,14 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
>    * pointing at <repo>/worktrees/<id>.
>    */
>   static void repair_gitfile(struct worktree *wt,
> -			   worktree_repair_fn fn, void *cb_data)
> +			   worktree_repair_fn fn,
> +			   void *cb_data,

Style wise leaving "fn" and "cb_data" on the same line would be fine. 
That applies to all the functions.

> +			   int use_relative_paths)
>   {

> [...]
>   	if (dotgit_contents) {
> @@ -612,18 +615,20 @@ static void repair_gitfile(struct worktree *wt,
>   		repair = _(".git file broken");
>   	else if (fspathcmp(backlink.buf, repo.buf))
>   		repair = _(".git file incorrect");
> +	else if (use_relative_paths == is_absolute_path(dotgit_contents))
> +		repair = _(".git file absolute/relative path mismatch");

Comparing ints as booleans makes me nervous in case we have a non-zero 
value that isn't 1 but is_absolute_path() returns 0 or 1 and we know 
use_relative_paths is 0 or 1.

>   	if (repair) {
>   		fn(0, wt->path, repair, cb_data);
> -		write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, wt->path, &tmp));
> +		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);

We used to update only the ".git", now we'll update both. In the case 
where we're changing to/from absolute/relative paths that's good because 
we'll update the "gitdir" file as well. In the other cases it looks like 
we've we've found this worktree via the "gitdir" file so it should be 
safe to write the same value back to that file.

> [...]
>   void repair_worktree_at_path(const char *path,
> -			     worktree_repair_fn fn, void *cb_data)
> +			     worktree_repair_fn fn,
> +			     void *cb_data,
> +			     int use_relative_paths)
>   {
>   	struct strbuf dotgit = STRBUF_INIT;
> -	struct strbuf realdotgit = STRBUF_INIT;
>   	struct strbuf backlink = STRBUF_INIT;
>   	struct strbuf inferred_backlink = STRBUF_INIT;
>   	struct strbuf gitdir = STRBUF_INIT;
>   	struct strbuf olddotgit = STRBUF_INIT;
> -	struct strbuf realolddotgit = STRBUF_INIT;
> -	struct strbuf tmp = STRBUF_INIT;
>
>   	char *dotgit_contents = NULL;
>   	const char *repair = NULL;
>   	int err;
> @@ -779,25 +783,25 @@ void repair_worktree_at_path(const char *path,
>   		goto done;
>   
>   	strbuf_addf(&dotgit, "%s/.git", path);
> -	if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
> +	if (!strbuf_realpath(&dotgit, dotgit.buf, 0)) {

This works because strbuf_realpath() copies dotgit.buf before it resets 
dotgit but that does not seem to be documented and looking at the output of

     git grep strbuf_realpath | grep \\.buf

I don't see any other callers relying on this outside of your earlier 
changes to this file. Given that I wonder if we should leave it as is 
which would also simplify this patch as the interesting changes are 
swamped by the strbuf tweaking.

> [...]   
>   	if (repair) {
>   		fn(0, gitdir.buf, repair, cb_data);
> -		write_file(gitdir.buf, "%s", relative_path(realdotgit.buf, backlink.buf, &tmp));
> +		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);

We used to just update "gitdir" but we now update ".git" as well. As 
above that's good when we're repairing a relative/absolute mismatch. In 
the other cases dotgit always contains the path to the ".git" file in 
the worktree so that should be fine.

Best Wishes

Phillip

