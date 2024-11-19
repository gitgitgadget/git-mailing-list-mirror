Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A661CFEA1
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028843; cv=none; b=fBc6AZ69SDyT8+DH+he0UWMswTdp3XrwFG5w2YfTpG8t0UkKOnhfvfiwdXzDSgJj00C70tXrObLK2pmUDJqUB0lZZQX821InW1q3qZLlXBYV9AOjjfzN07rklq9MTJQTkhUflS8oggZGVDn7Qf/XLgAYNSr86LJm2lMHQKwL9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028843; c=relaxed/simple;
	bh=2NvWRlH2Rx2zZP8I95X7RzoeFMOSnuz2TYjmKgLE8ok=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=huGz15u1jHwCzPB86ag7zCC/8ZgZq5D7eAoO6U9aXuZAJfd7jpEVJ3K6SJYRshdSp3MaTDTxcSEDcVz/ZrLOCr7HRGV65veSF8otonXwimlZeiCdCt3/ahZsJnvgWu9TWslEIvoXGx6zF43/VXTgsee2h7J9ryxoi3v6l0kYVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZrItVxb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZrItVxb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315abed18aso29042825e9.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028840; x=1732633640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0HrG8v+BFXCAY6pD6/R4ZcnNqTim98/oLIWh59yNYs=;
        b=YZrItVxbIKNAPrEPczTbmXkzK844joyrnVQaNpxKrr7y5ushMmJiFBUhC1kFp/caVU
         Vxo4c7wBgP/pNNiv3hNIUMtz594VohZkW5DHF8R7ZeWaJzx1JOOBuI5l9GPmBSJt/L/d
         jqeOaZ1UoFok3oImlf5QvlbjpCAs+ZeA4v0aL3dwbAKHOgCs1xrUJTngaL3NBopKQoHJ
         82iLPX22tDGKG+XThJ2dAtfALU0uRLj3YHV1ClC9zM7nn/2P3lAm1bRepGzDLirXCZy/
         HEcGl46bBi2Q3PMno42vjP43vsnpriaR+3TSiLF0Q5qPtZHWPVSTZPqSAHDMKptDWD/8
         epkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028840; x=1732633640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0HrG8v+BFXCAY6pD6/R4ZcnNqTim98/oLIWh59yNYs=;
        b=khArdt8ijMQZxujbZ0NzQrH/E+gGQ4w03NlZuhg6628Luzx5qNr83Dn+TqpPXEKBkL
         6/KdaKbPJl/Sn+kEQSEeQA0LA7AwlPmmAnEaHz3vBZONPEB7tT9yVwTnTCPlg6gB0OaO
         ZguFnGYpAFxzRIytFaQiwyXxUMSb4GUeJh5Lex4MrV0yI5Url3m01B5XJ85FEz76gEAk
         THtc36aY8cW0XRuetLuH5cX4m6FdPbTVt+VmRXqq2Gw53K6pZG5b6rEHOBIw9SoWiF9i
         tNCX6BIB1o605EgcacR6hruYlupXhQYeIyChEbD3rU6E8Zu88EjjC+DfqYv/ymedEl/d
         Pobg==
X-Forwarded-Encrypted: i=1; AJvYcCXdoL3IT1M4Ezn1k1qXNB//PawCr8y6RmgppTptiHD5vS0m91PTHYNtZwoxM128MtSmdNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhRJRN/MNes1Lso1Y/MX8Ri6I/EcdBTLz3PDy+ZopCqxLVPFz
	pQxo2T8Pek/3YfILaV8YuGhBHu1J9/Hg7vrKqwUd8Y4JKI89vEgQ
X-Google-Smtp-Source: AGHT+IGqDkr7CqoP8+Ts9WjX9by1ndmAVIqLcQ5CPrmlKlncJgc0yrVqdS1JOhQCHCJaxudhduP0oA==
X-Received: by 2002:a05:600c:1c1f:b0:432:d82d:6a6c with SMTP id 5b1f17b1804b1-432df78d817mr155354315e9.30.1732028839449;
        Tue, 19 Nov 2024 07:07:19 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm195076185e9.12.2024.11.19.07.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:07:19 -0800 (PST)
Message-ID: <20fdb5ba-075f-48b5-9e92-f85378500710@gmail.com>
Date: Tue, 19 Nov 2024 15:07:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/8] worktree: add relative cli/config options to `add`
 command
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-5-07a3dc0f02a3@pm.me>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-5-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 01/11/2024 04:38, Caleb White wrote:
> This introduces the `--[no-]relative-paths` CLI option and
> `worktree.useRelativePaths` configuration setting to the `worktree add`
> command. When enabled these options allow worktrees to be linked using
> relative paths, enhancing portability across environments where absolute
> paths may differ (e.g., containerized setups, shared network drives).
> Git still creates absolute paths by default, but these options allow
> users to opt-in to relative paths if desired.
> 
> The t2408 test file is removed and more comprehensive tests are
> written for the various worktree operations in their own files.

This looks good, I've left a couple of comments below - there are a few 
places where the tests could be cleaned up (I've only commented on the 
first instance of each cleanup) but the coverage looks good and the 
implementation looks good to me too. I'll leave it here for today, sorry 
it has taken me so long to get round to looking at these. I should be 
able to look at the rest of the patches this week.

> +worktree.useRelativePaths::
> +	Link worktrees using relative paths (when "true") or absolute
> +	paths (when "false"). This is particularly useful for setups
> +	where the repository and worktrees may be moved between
> +	different locations or environments. Defaults to "false".
> ++
> +Note that setting `worktree.useRelativePaths` to "true" implies enabling the
> +`extension.relativeWorktrees` config (see linkgit:git-config[1]),
> +thus making it incompatible with older versions of Git.
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 70437c815f13852bd2eb862176b8b933e6de0acf..88d2261012166a929b7f167d79720e4d965fd71b 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -216,6 +216,10 @@ To remove a locked worktree, specify `--force` twice.
>   This can also be set up as the default behaviour by using the
>   `worktree.guessRemote` config option.
>   
> +--[no-]relative-paths::
> +	Overrides the `worktree.useRelativePaths` config option, see
> +	linkgit:git-config[1].

I think it would be helpful to describe what this option does directly, 
rather than in terms of a config setting which is documented elsewhere 
and that may not be set

>   --[no-]track::
>   	When creating a new branch, if `<commit-ish>` is a branch,
>   	mark it as "upstream" from the new branch.  This is the
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index dae63dedf4cac2621f51f95a39aa456b33acd894..e3b4a71ee0bc13d5e817cf7dcc398e9e2bd975de 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -120,12 +120,14 @@ struct add_opts {
>   	int quiet;
>   	int checkout;
>   	int orphan;
> +	int relative_paths;

Excellent - thanks for getting rind of the global in /worktree.c

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index cfc4aeb1798c6d023909cec771e5b74e983af5ea..d36d8a4db0e924877787697579544f10f92dc0cf 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -1207,4 +1207,58 @@ test_expect_success '"add" with initialized submodule, with submodule.recurse se
>   	git -C project-clone -c submodule.recurse worktree add ../project-5
>   '
>   
> +test_expect_success 'can create worktrees with relative paths' '
> +	test_when_finished "git worktree remove relative" &&
> +	git config worktree.useRelativePaths false &&

Using test_config instead of "git config" ensures the setting is cleared 
at the end of the test

> +	git worktree add --relative-paths ./relative &&
> +	cat relative/.git >actual &&

There's no need to copy the file just so we can say "actual" below

> +	echo "gitdir: ../.git/worktrees/relative" >expect &&
> +	test_cmp expect actual &&
> +	cat .git/worktrees/relative/gitdir >actual &&
> +	echo "../../../relative/.git" >expect &&
> +	test_cmp expect actual
> +
> +'
> +
> +test_expect_success 'can create worktrees with absolute paths' '
> +	git config worktree.useRelativePaths true &&
> +	git worktree add ./relative &&
> +	cat relative/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/relative" >expect &&
> +	test_cmp expect actual &&
> +	git worktree add --no-relative-paths ./absolute &&
> +	cat absolute/.git >actual &&
> +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual
> +'

We're only checking ".git" here and not the "gitdir" file as well, I 
guess that's ok as the implemntation that writes the files is tested 
above and here we're interesting in testing the config setting.

> +test_expect_success 'move repo without breaking relative internal links' '
> +	test_when_finished rm -rf repo moved &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config worktree.useRelativePaths true &&
> +		test_commit initial &&
> +		git worktree add wt1 &&
> +		cd .. &&
> +		mv repo moved &&
> +		cd moved/wt1 &&
> +		git status >out 2>err &&
> +		test_must_be_empty err

This relies on "git status" failing if the worktree links are broken. A 
more direct test might be to check the output of "git worktree list" or 
"git rev-parse --git-dir".

> +	)
> +'
> +
> +test_expect_success 'relative worktree sets extension config' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	git -C repo commit --allow-empty -m base &&
> +	git -C repo worktree add --relative-paths ./foo &&
> +	git -C repo config get core.repositoryformatversion >actual &&
> +	echo 1 >expected &&
> +	test_cmp expected actual &&

This can be done with

	test_cmp_config -C repo 1 core.repositoryformatversion

> +	git -C repo config get extensions.relativeworktrees >actual &&
> +	echo true >expected &&
> +	test_cmp expected actual
> +'
Best Wishes

Phillip
