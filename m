Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7CF366042
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363563; cv=none; b=H0eQHrL5JLTr6X1QeN+LDw0c4ZYigTfq5zyLOWsTeMQfR45P5Pe4OKv6iApfwhSiwV3wQIr6RbmgyNyXPHG6uCHOQYYD1vamojsPX89yMg7qQocowKXiEx2+uxZCeIyhi6fioCqIY4Ip7F5fDpqZbXHLRsoDCQPlcSWN9AUZp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363563; c=relaxed/simple;
	bh=EBQosKmu6p7yITSnYMORFgHByindP/mQrJbS+oQJWI8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=keWhuPVMuAnuO9+L6Cs4r9ftCHSVUvAIG6tp41MQtECUTgWGQl+s1KRu1Nz3uf/EOYS9QNnw81KZG1fXEOSxGQeo3likAxmOqpsZrk6oGkaQhgK6yd173V6liR1VakCkTPzlxrh0Devtg9S34hNhxQ3jlNgBB04aGPucxQwGMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pREP0IPq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pREP0IPq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so12742015e9.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363557; x=1788968357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OKu2B/yD2Q/36xWJGrz0jrLffSKALMQ6tDQbLslev0Q=;
        b=pREP0IPqcfBxyik5hhfiXzvTWV5XIww7PCE3eVcMXXMYmBYPPjJlYnscbXZy1MQ/bc
         RBiHPmCj5blzDj7SmyHr/J2yVbQshZi9MJi4Is+uZ5ewWJN8UFfwORCwHOq84HfL7oye
         ceQVZfsjqG62uhXR+IuXFJr/bMg/TdIIYgr2Zk3upSEB1KxKwdBzbSKRF5swz6+O+uN3
         WWyAlB9fK3Vrp4pjeg9famtCbXeim04PXQVVabBEENLChONyOhyNhWAxK4zriBXQBRXh
         OlqsRCvm5gtp6G0YltWhEWMbLHvZPjt03lFUvpr8Sl2iJYIKZr0M0UWExx1zM2RH3596
         dzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363557; x=1788968357;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKu2B/yD2Q/36xWJGrz0jrLffSKALMQ6tDQbLslev0Q=;
        b=Mhy8W/35QgFammV8bPoBfR+3VG+y+7CClXiCnpszhDi2Y+x+kODBcE5J6L21onOa+N
         3MlWq6MFcMHgcZVrLNhN7vKp60ZZUKpZeVRA9H43Ew94VkslYMXcLqR9dk6Q44fK76/6
         bXMTBG2fkO3PwFDYrbdjUs1ArK/VJmzCCLdaLx8K7DfUA+hVVOsPzEja7SMDtFYtH4zY
         5iHsj7BNaGwiW07w6ktgR7EqG2FXBUILnCQ/NaMz3xX/N5XcWI+QBV42Dxzw1Bl5XlM1
         xTKckIYA78Ipsa94IGz6VWHwOtn/+cm3sXsCzqgA0pWbeiSLYRNfEPuP5kbHoCx3gKed
         DsOQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAgY7jkGDK7gutr2zLjjfh1xZOtJ5KtU1Z4GCFmJunD46nh+2W9/AdV2uwCv+LLDCvhC0=@vger.kernel.org
X-Gm-Message-State: AFuF++nT2asOHhVr8kK2LpClDru61O7o85vrC9ofrxOj7KPBTBaPcorv
	qqNvfs094pVTGvCAOun8wku6vqC8EQZp+5ghV3vGKFfhZ+rDfGOFk5Yk
X-Gm-Gg: AR+sD13llLMcOZ7BDQxJ9tXQK4smyrGkLEY6FOBm2xQi1c4vq7Hvg03w5VnjTlE7JOC
	D+nhqAsxFBR+BRWpXbbPtbsPYjWBUuemfNxt8OuX00SV5pJXIOHHBXgBX3aXFBpCjOmS90rEmaL
	wtmAyrZOUlGHbG4S1SIbCWbq0QfrsY+YwgxVVdzX56Iygx6zU+aNa8KPgQ0fp0NL5VFE19r2aUh
	Cd4R/dg/enaMMN11668qICzr0Q9YH5sVUCkfdcHaXJB2wrpVda8/kuECc3HuZX73Ua8z7/NtFYS
	GxhLhdsPTd81y3D2TbN0ZCjfDo/CCNj1JChxWg03R6QCs298YtUMJWW952WjkqkmoIgHvrvhO0Q
	nj/9H0BufQ+3eVDmBDsjeMdtvQRNd1Km6AZDh0Co5zHY6k06K4godkpmuxvEp3V5mgCgHpTHYUg
	MtRVYA37Hu5eGtPdO9r3hl4RjMfdqPWQjDh246d9DYhUlc10GMnXwB7C2usdxxjC3w8/GR+1RQd
	LoUIawEWlbPciL517fuPxbkCiU2KBLPIdKSJrLN/zI=
X-Received: by 2002:a05:600c:530e:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49ce584bb4amr118429025e9.14.1788363556716;
        Wed, 02 Sep 2026 08:39:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm7275212f8f.27.2026.09.02.08.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:39:16 -0700 (PDT)
Message-ID: <9950415d-ca3b-453b-9b0f-28c09a3d7f23@gmail.com>
Date: Wed, 2 Sep 2026 16:39:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/5] commit: allow a partial commit when a rebase pick
 becomes empty
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
 <a0b9900437e7c2833960e5046b5acb6703f014b9.1788301481.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <a0b9900437e7c2833960e5046b5acb6703f014b9.1788301481.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 01/09/2026 23:24, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> For years, we disallowed partial commits during merges or cherry-picks.
> In commit 430b75f7209c (commit: give correct advice for empty commit
> during a rebase, 2019-12-06) it was noted that the "cannot do a partial
> commit during a cherry-pick" message was also printed when rebasing a
> commit that became empty, and rather than drop the check in that case,
> that commit opted to make the message print the actual operation that
> was in progress.
> 
> Since a commit that has become empty comes without conflicts, a new
> partial commit poses no problems; remove the error in that case.

I'm not quite sure what I think about this. When we stop for a commit 
that becomes empty, we write CHERRY_PICK_HEAD and .git/MERGE_MSG so the 
user can preserve the commit by running "git commit --allow-empty". That 
makes me think we should complain about a partial commit. It also seems 
inconsistent with "git cherry-pick" where we still disallow a partial 
commit when we stop for a commit that becomes empty.

On the other hand, if the user has asked to edit the commit then 
allowing a partial commit would probably make sense as we know they 
wanted to modify it in some way. As I can't make up my mind I think its 
fair to say I don't have a strong opinion either way.

Thanks

Phillip

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/commit.c              | 2 --
>   t/t3404-rebase-interactive.sh | 5 ++---
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 17cc27e53e..01b79185e7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -520,8 +520,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
>   			die(_("cannot do a partial commit during a merge."));
>   		else if (is_from_cherry_pick(whence))
>   			die(_("cannot do a partial commit during a cherry-pick."));
> -		else if (is_from_rebase_now_empty(whence))
> -			die(_("cannot do a partial commit during a rebase."));
>   	}
>   
>   	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff11abb2f2..3588e16543 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1858,7 +1858,7 @@ test_expect_success 'post-commit hook is called' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'correct error message for partial commit after empty pick' '
> +test_expect_success 'partial commit is allowed when a rebase pick becomes empty' '
>   	test_when_finished "git rebase --abort" &&
>   	(
>   		set_fake_editor &&
> @@ -1867,8 +1867,7 @@ test_expect_success 'correct error message for partial commit after empty pick'
>   		test_must_fail git rebase -i A D
>   	) &&
>   	echo x >file1 &&
> -	test_must_fail git commit file1 2>err &&
> -	test_grep "cannot do a partial commit during a rebase." err
> +	git commit file1
>   '
>   
>   test_expect_success 'correct error message for commit --amend after empty pick' '

