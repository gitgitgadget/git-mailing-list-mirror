Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C178C0B
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619734; cv=none; b=AkKvwpS+rKnUJ/A9pkdd8nOCTw0hXSrG6lkHQHh6GP61yfpLdctLAjeupSaFOfDBn9VPPoZpLdQQGpNhDrjdGhbVtLiM99IwCB26TO6pTz6b+ENasjrZHhkkuHxpDvVp6CErVl6EwbJy9SlsVG7chTtb4q7algwpGOkeDm1Ffvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619734; c=relaxed/simple;
	bh=IijtBJnYxtynCV/p4L55ysHN3w6PPywgAMuR3YI0lWQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uRE86hBuaeKg4/eKcNTHdo8UmW/IWkuaxy0g2awmirvXS3AnztE4T0We2/IO3RXLmX939ISXc552f4GAyHEeByCX4Myxy+Nxa2kb+LKV5kdRKH8yVWHXCCFfs0uiIskmEQaN+OL2LMvg188bROlLZ4/vjyV0n4snM6ZgoYn596s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYXO7D1D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYXO7D1D"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4127700a384so14118225e9.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619730; x=1709224530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1Wuqp9X58VTaC78/f9v8pX75Ydf0mnoYocAez4EsKA=;
        b=QYXO7D1Di6Zqk0crMK37FdCCdJrj00+UAaoBbbMoLOnBRHlGU3FYNLngR0tK73fmvr
         9BIETDp9Hzqc+J7iXmdc22+jf9TrbUUEe7s0MtvRB7jBQtspyroNjBWE7p+dQj36tzHi
         Lj268u5a3w1eH6qdKrnLSocr/Rxe0O/SnINcQN50Bo4jfv/oZO9Or9bUOX+GVkTdwptd
         W5HKU+2ApSxRYQmMmmFpUlduRb2n9S9mXt/zO3ndgTS+aPryyUMqKFWNVpgN+YEbop3D
         OF3IKP93TpXq6xPhFP1T1Xog5gn64fMpgXB+GkyLWeuRw961K935OMWlOgb3XQACgW7a
         Mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619730; x=1709224530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Wuqp9X58VTaC78/f9v8pX75Ydf0mnoYocAez4EsKA=;
        b=EgnMhVuEncGOoMTcxgFVxY++LtaYWlaMH76UtuCoPohjxhM56/GLCb1117Axq8HRp6
         yCn3k4YMfJBAod4hIWGT3r4N4kyLseuGmhbzvaobQSuidqblcbDxabt9294LHn3CWlfW
         uss89Vc7KUpiG7z4vnQiA5wo0h5T6jzhp7pNuFmw3BIibcl37n0gOyanLw/0NRBSxT//
         RFpL4ILZbqQjGhEwNljE3Zc9WIIjC1jjJKUNBncLzgLhK+fjXDAWJNXpaGRY/yZiXWqE
         kt52U1pfVuTfkXjZFx27TjXmraXfMCYC82qGHM2xbXHNvdouUy9UJ8h4CO4JQ6q42sn1
         44nA==
X-Forwarded-Encrypted: i=1; AJvYcCWHw1In3sTHWFiZUoh1XD4E5V+HRNgOcYFwmtpXYmd8TO9wbgmRYFRDPGPJVGhXnUR3TmJKlqsboI38pGRqS6EiXg/p
X-Gm-Message-State: AOJu0Yz9pePkLk21mijpX1qF9R6Z6QpSt/M/xHXrSGa5QC10yqaQfcxu
	fE372r3L+DWy5O3Fd9s9ln+vlN+0xMQU2JfRaO5mF7ZUWC53u8rV
X-Google-Smtp-Source: AGHT+IGQAgtOoFULrdo8lsUWx21aJrIt76CRnfq3jx5zCRKrFlj4lNSfqHBVWk9HjH+L/vRxXp9ElA==
X-Received: by 2002:a05:600c:3507:b0:412:5df4:914e with SMTP id h7-20020a05600c350700b004125df4914emr11062825wmq.0.1708619730216;
        Thu, 22 Feb 2024 08:35:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21901857wmb.42.2024.02.22.08.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:35:30 -0800 (PST)
Message-ID: <3f276e10-7b03-4480-a157-47a7648e7f19@gmail.com>
Date: Thu, 22 Feb 2024 16:35:29 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 6/8] cherry-pick: decouple `--allow-empty` and
 `--keep-redundant-commits`
Reply-To: phillip.wood@dunelm.org.uk
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-7-brianmlyles@gmail.com>
Content-Language: en-US
In-Reply-To: <20240210074859.552497-7-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
> As noted in the git-cherry-pick(1) docs, `--keep-redundant-commits`
> implies `--allow-empty`, despite the two having distinct,
> non-overlapping meanings:
> 
> - `allow_empty` refers specifically to commits which start empty, as
>    indicated by the documentation for `--allow-empty` within
>    git-cherry-pick(1):
> 
>    "Note also, that use of this option only keeps commits that were
>    initially empty (i.e. the commit recorded the same tree as its
>    parent). Commits which are made empty due to a previous commit are
>    dropped. To force the inclusion of those commits use
>    --keep-redundant-commits."
> 
> - `keep_redundant_commits` refers specifically to commits that do not
>    start empty, but become empty due to the content already existing in
>    the target history. This is indicated by the documentation for
>    `--keep-redundant-commits` within git-cherry-pick(1):
> 
>    "If a commit being cherry picked duplicates a commit already in the
>    current history, it will become empty. By default these redundant
>    commits cause cherry-pick to stop so the user can examine the commit.
>    This option overrides that behavior and creates an empty commit
>    object. Implies --allow-empty."
> 
> This implication of `--allow-empty` therefore seems incorrect: One
> should be able to keep a commit that becomes empty without also being
> forced to pick commits that start as empty. However, the following
> series of commands results in both the commit that became empty and the
> commit that started empty being picked, despite only
> `--keep-redundant-commits` being specified:
> 
>      git init
>      echo "a" >test
>      git add test
>      git commit -m "Initial commit"
>      echo "b" >test
>      git commit -am "a -> b"
>      git commit --allow-empty -m "empty"
>      git cherry-pick --keep-redundant-commits HEAD^ HEAD
> 
> The same cherry-pick with `--allow-empty` would fail on the redundant
> commit, and with neither option would fail on the empty commit.
> 
> Do not imply `--allow-empty` when using `--keep-redundant-commits` with
> git-cherry-pick(1).
>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> 
> This is the second half of the first commit[1] in v1, which has now been
> split up.
> 
> This commit proposes a breaking change, albeit one that seems correct
> and relatively minor to me. If this change is deemed too controversial,
> I am prepared to drop it from the series. See Junio's[2] and
> Phillip's[3] comments on v1 for additional context.

I agree that if we were starting from scratch there would be no reason 
to tie --apply-empty and --keep-redundant-commits together but I'm not 
sure it is worth the disruption of changing it now. We're about to add 
empty=keep which won't imply --allow-empty for anyone who wants that 
behavior and I still tend to think the practical effect of implying 
--allow-empty with --keep-redundant-commits is largely beneficial as I'm 
skeptical that users want to keep commits that become empty but not the 
ones that started empty.

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/20240119060721.3734775-2-brianmlyles@gmail.com/
> [2]: https://lore.kernel.org/git/xmqqy1cfnca7.fsf@gitster.g/
> [3]: https://lore.kernel.org/git/8ff4650c-f84f-41bd-a46c-3b845ff29b70@gmail.com/
> 
>   Documentation/git-cherry-pick.txt | 10 +++++++---
>   builtin/revert.c                  |  4 ----
>   t/t3505-cherry-pick-empty.sh      |  6 ++++++
>   3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index fdcad3d200..c88bb88822 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -131,8 +131,8 @@ effect to your index in a row.
>   	even without this option.  Note also, that use of this option only
>   	keeps commits that were initially empty (i.e. the commit recorded the
>   	same tree as its parent).  Commits which are made empty due to a
> -	previous commit are dropped.  To force the inclusion of those commits
> -	use `--keep-redundant-commits`.
> +	previous commit will cause the cherry-pick to fail.  To force the
> +	inclusion of those commits, use `--keep-redundant-commits`.
> 
>   --allow-empty-message::
>   	By default, cherry-picking a commit with an empty message will fail.
> @@ -144,7 +144,11 @@ effect to your index in a row.
>   	current history, it will become empty.  By default these
>   	redundant commits cause `cherry-pick` to stop so the user can
>   	examine the commit. This option overrides that behavior and
> -	creates an empty commit object.  Implies `--allow-empty`.
> +	creates an empty commit object. Note that use of this option only
> +	results in an empty commit when the commit was not initially empty,
> +	but rather became empty due to a previous commit. Commits that were
> +	initially empty will cause the cherry-pick to fail. To force the
> +	inclusion of those commits use `--allow-empty`.
> 
>   --strategy=<strategy>::
>   	Use the given merge strategy.  Should only be used once.
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 89821bab95..d83977e36e 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -134,10 +134,6 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>   	prepare_repo_settings(the_repository);
>   	the_repository->settings.command_requires_full_index = 0;
> 
> -	/* implies allow_empty */
> -	if (opts->keep_redundant_commits)
> -		opts->allow_empty = 1;
> -
>   	if (cleanup_arg) {
>   		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
>   		opts->explicit_cleanup = 1;
> diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
> index eba3c38d5a..2709cfc677 100755
> --- a/t/t3505-cherry-pick-empty.sh
> +++ b/t/t3505-cherry-pick-empty.sh
> @@ -59,6 +59,12 @@ test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
>   	test_must_fail git cherry-pick empty-change-branch
>   '
> 
> +test_expect_success 'cherry pick an empty non-ff commit with --keep-redundant-commits' '
> +	git checkout main &&
> +	test_must_fail git cherry-pick --keep-redundant-commits empty-change-branch 2>output &&
> +	test_grep "The previous cherry-pick is now empty" output
> +'
> +
>   test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
>   	git checkout main &&
>   	git cherry-pick --allow-empty empty-change-branch

