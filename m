Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21019049B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483721; cv=none; b=My3uzqq2hQxVPQNeUI1v8gV/nh50td8Q4VwkbHWruqliFHMwUC2a2iFm08Ae3UuTsG4UFpvmdV+S1j4AO1Gxwfz1IYU1c0U0MphBuDC54q4mVbkzyANJoWeoH4fIrRXrxunqDnDQQ6y6yZ8ZVJ2cl9R+kM/Kq7tObipryk5ChfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483721; c=relaxed/simple;
	bh=iANfiXMr7Xapmd9xbOAncRK4GefAKoqiFkxCOPEeWFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0UQpsv3IBELlPP3qqGguCOkPLAejwCDLOk4l9ijUnhGoQuLHB5SN/N/3u29KD+nKoMEdQKjhahZa/ZEB/msGLwOeTjLyvvi3CLOdO5KT2EeLmNl05PKimt8PDIE17B1u+Bvg8ht5tGlD3okvPDw2f1Qd6iMWa7F7CcRDqF3q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG5ozg1G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG5ozg1G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4305724c12eso12344295e9.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728483718; x=1729088518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBPqZkUzJTMlEWKvxWqGqTI7UFE7tJ1STX1cB0CpRzo=;
        b=JG5ozg1G3p0F8uhOTNO9p1lLZLZ9eWrBU4yurH+KPHL/yBGjbj4PlGsYgFn9eCMblm
         v9aS7voXTFGf8m95sKT04zN8BcfgE7bCeEnorlAlHh46SVP/0ePn0AJfAyO37MuLoRN7
         oLrm5HtzHSEUBXBJZ/XUTSlOfj4iC+p1UohtmH0C1OG5r7ripUF92gcF4DMbMpmrUx2C
         fgw33GtyrfWSp5ioawteOBVWSUl20E9P0+tmAvvwlD+Pv5yERu6aZXsPLRK2BhivOWxK
         9QWzwxVpiBKyiXBDfNCEZ0KeRsigH+pebxqebNAJhiYoiS8GkJUaGDgRgFJmKAqjOshY
         j/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728483718; x=1729088518;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBPqZkUzJTMlEWKvxWqGqTI7UFE7tJ1STX1cB0CpRzo=;
        b=aRnTOGoNUHw4uTdIosgjt6ab4Ux/aUYlmpiji+CpFk8NbRTglmrONTN0jJe9nmHFs4
         GOLcYcyvDbIEkEPzEHHIJjcmFif8Bq6q67uRvlNxD3VM4dxvhi+uJiuOE/1CIfGADrjb
         x3PCb+4dbX2szvdJ+iweoFk8kTVIkYzXUXrFVqvS+70b0EkVDzyRmL4t1fnXaxwVp15C
         jj1RH4GGBqGIHe9WdBipktFwr7ziS5Sg89ZSQroW+LXrGVaQ4zAaLohdwyHXgOVc1deg
         m3A9Mb6coGiESnfGIvKHcVmSxsIUr+O9vevgw63ef9333iGyXWlyRrlRtaEvJId8n9Gy
         RvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtr8j8iLRfFBDWrrHpgeYTsfPRTgNpPf5hFdXZpTxRpjoFTXsOHvfisw9PyBDkSC1MEJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqF/ZC68JzvdZ35K1hrokybkwc7emk7+J+wjePtjXmYhiOEmGF
	sEBcLhKs1jka3+dCK18F4885QeU7iKMwWrxqvjxW0HHoAiQuCZxk
X-Google-Smtp-Source: AGHT+IFBq8Fp6qZZfKjUIPrmeZE8dudJsVYKDc0FkfPHX/8oDqaWGkxIshe9GsE2TGzSueCWWNVD+Q==
X-Received: by 2002:a05:600c:4ec7:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-430ccf1b2ddmr19095555e9.6.1728483717579;
        Wed, 09 Oct 2024 07:21:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf60b2bsm22128575e9.28.2024.10.09.07.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:21:56 -0700 (PDT)
Message-ID: <ca5f7ce3-f3ec-4627-b503-6b43695c9439@gmail.com>
Date: Wed, 9 Oct 2024 15:21:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/3] rebase-merges: try and use branch names as labels
To: Nicolas Guichard via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Nicolas Guichard <nicolas@guichard.eu>
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
 <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
 <19d8253da07624aa14ec78d00b549bba8799c55c.1728460700.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <19d8253da07624aa14ec78d00b549bba8799c55c.1728460700.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nicolas

On 09/10/2024 08:58, Nicolas Guichard via GitGitGadget wrote:
> From: Nicolas Guichard <nicolas@guichard.eu>
> 
> When interactively rebasing merge commits, the commit message is parsed to
> extract a probably meaningful label name. For instance if the merge commit
> is “Merge branch 'feature0'”, then the rebase script will have thes lines:
> ```
> label feature0
> 
> merge -C $sha feature0 # “Merge branch 'feature0'
> ```
> 
> This heuristic fails in the case of octopus merges or when the merge commit
> message is actually unrelated to the parent commits.
> 
> An example that combines both is:
> ```
> *---.   967bfa4 (HEAD -> integration) Integration
> |\ \ \
> | | | * 2135be1 (feature2, feat2) Feature 2
> | |_|/
> |/| |
> | | * c88b01a Feature 1
> | |/
> |/|
> | * 75f3139 (feat0) Feature 0
> |/
> * 25c86d0 (main) Initial commit
> ```
> yields the labels Integration, Integration-2 and Integration-3.
> 
> Fix this by using a branch name for each merge commit's parent that is the
> tip of at least one branch, and falling back to a label derived from the
> merge commit message otherwise.
> In the example above, the labels become feat0, Integration and feature2.

This looks like a nicely described useful improvement, thank you for 
working on it. The way the code is structured means we always calculate 
the fallback label before seeing if there is a branch name we could use 
instead but as calculating the fallback is cheap I don't think that's a 
problem in practice.

Thanks

Phillip

> Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
> ---
>   sequencer.c                   | 25 +++++++++++++++++--------
>   t/t3404-rebase-interactive.sh |  4 ++--
>   t/t3430-rebase-merges.sh      | 12 ++++++------
>   3 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 97959036b50..353d804999b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5819,7 +5819,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
>   	int skipped_commit = 0;
>   	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
> -	struct strbuf label = STRBUF_INIT;
> +	struct strbuf label_from_message = STRBUF_INIT;
>   	struct commit_list *commits = NULL, **tail = &commits, *iter;
>   	struct commit_list *tips = NULL, **tips_tail = &tips;
>   	struct commit *commit;
> @@ -5842,6 +5842,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   	oidmap_init(&state.commit2label, 0);
>   	hashmap_init(&state.labels, labels_cmp, NULL, 0);
>   	strbuf_init(&state.buf, 32);
> +	load_branch_decorations();
>   
>   	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
>   		struct labels_entry *onto_label_entry;
> @@ -5902,18 +5903,18 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   			continue;
>   		}
>   
> -		/* Create a label */
> -		strbuf_reset(&label);
> +		/* Create a label from the commit message */
> +		strbuf_reset(&label_from_message);
>   		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
>   		    (p1 = strchr(p1, '\'')) &&
>   		    (p2 = strchr(++p1, '\'')))
> -			strbuf_add(&label, p1, p2 - p1);
> +			strbuf_add(&label_from_message, p1, p2 - p1);
>   		else if (skip_prefix(oneline.buf, "Merge pull request ",
>   				     &p1) &&
>   			 (p1 = strstr(p1, " from ")))
> -			strbuf_addstr(&label, p1 + strlen(" from "));
> +			strbuf_addstr(&label_from_message, p1 + strlen(" from "));
>   		else
> -			strbuf_addbuf(&label, &oneline);
> +			strbuf_addbuf(&label_from_message, &oneline);
>   
>   		strbuf_reset(&buf);
>   		strbuf_addf(&buf, "%s -C %s",
> @@ -5921,6 +5922,14 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   
>   		/* label the tips of merged branches */
>   		for (; to_merge; to_merge = to_merge->next) {
> +			const char *label = label_from_message.buf;
> +			const struct name_decoration *decoration =
> +				get_name_decoration(&to_merge->item->object);
> +
> +			if (decoration)
> +				skip_prefix(decoration->name, "refs/heads/",
> +					    &label);
> +
>   			oid = &to_merge->item->object.oid;
>   			strbuf_addch(&buf, ' ');
>   
> @@ -5933,7 +5942,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   			tips_tail = &commit_list_insert(to_merge->item,
>   							tips_tail)->next;
>   
> -			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
> +			strbuf_addstr(&buf, label_oid(oid, label, &state));
>   		}
>   		strbuf_addf(&buf, " # %s", oneline.buf);
>   
> @@ -6041,7 +6050,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   	free_commit_list(commits);
>   	free_commit_list(tips);
>   
> -	strbuf_release(&label);
> +	strbuf_release(&label_from_message);
>   	strbuf_release(&oneline);
>   	strbuf_release(&buf);
>   
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index f171af3061d..4896a801ee2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1870,7 +1870,7 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>   		pick $(git log -1 --format=%h branch2~1) F
>   		pick $(git log -1 --format=%h branch2) I
>   		update-ref refs/heads/branch2
> -		label merge
> +		label branch2
>   		reset onto
>   		pick $(git log -1 --format=%h refs/heads/second) J
>   		update-ref refs/heads/second
> @@ -1881,7 +1881,7 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>   		update-ref refs/heads/third
>   		pick $(git log -1 --format=%h HEAD~2) M
>   		update-ref refs/heads/no-conflict-branch
> -		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
> +		merge -C $(git log -1 --format=%h HEAD~1) branch2 # merge
>   		update-ref refs/heads/merge-branch
>   		EOF
>   
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 2aa8593f77a..cb891eeb5fd 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -108,19 +108,19 @@ test_expect_success 'generate correct todo list' '
>   
>   	reset onto
>   	pick $b B
> -	label E
> +	label first
>   
>   	reset onto
>   	pick $c C
>   	label branch-point
>   	pick $f F
>   	pick $g G
> -	label H
> +	label second
>   
>   	reset branch-point # C
>   	pick $d D
> -	merge -C $e E # E
> -	merge -C $h H # H
> +	merge -C $e first # E
> +	merge -C $h second # H
>   
>   	EOF
>   
> @@ -462,11 +462,11 @@ test_expect_success 'A root commit can be a cousin, treat it that way' '
>   '
>   
>   test_expect_success 'labels that are object IDs are rewritten' '
> -	git checkout -b third B &&
> +	git checkout --detach B &&
>   	test_commit I &&
>   	third=$(git rev-parse HEAD) &&
>   	git checkout -b labels main &&
> -	git merge --no-commit third &&
> +	git merge --no-commit $third &&
>   	test_tick &&
>   	git commit -m "Merge commit '\''$third'\'' into labels" &&
>   	echo noop >script-from-scratch &&

