Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538743B4B8
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843959; cv=none; b=CFH5CnQm2lpY4J1nw/80FDaAh8sPLFLcwHHj5oYchVB72VhJ7mPGWBSaLurh/xUU202v6t9To60pDABgpZpogBMj46XdDH8LwmiDG7sGkG0hOCCa6QfMoTPTd7MK1PQ8+hzVD75wDL6AXCKFPfH6LIA6fhXVKmZvGbmLkbhHx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843959; c=relaxed/simple;
	bh=zvym0fwieLPyyRxHicaTPLmLOpGipozUfmEmiXjSqPs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iM77bZoId0/3j29TXCsOusCB6rJ5LUEx1aRaLqIHWW0GZywc0Lrlt3XF2BxKAnyOJu7N6bh5tNN0haPzTSwseEL/XtJFtNgyHLCSzFCtrYApqjNhKSns5z2PvfvMLpPteg29c8+opWxUqnJt4AQxkPehgn6ZmHtXMx0DTkOWo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebe7CTlp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebe7CTlp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so11411365e9.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787843952; x=1788448752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5ILsPzLPpRFtKqwTgoqLyKt9KA3mx56bT9taONMFwE=;
        b=ebe7CTlpcGqgeIrQFJNuf94laglaJ/LezqudIbp0bYBVPOWnn+1K4N6O0Qwde9FdU1
         TUuHbZZjOcuD4AWFc+WgMM1BXSCBczkR1gpHOnY4dGZHSqgYZ+9fhE492O2R2yq//jN9
         fjxIIINH+AVfqCPkx7Bug9T35RG/Lu1PxaJPKi9tgtKgDfDuuEaBxIVXPJy7k3yNh1iY
         mFd2JLhLtiMm2AK4Ggqqoo4ZRnXZXgIRNBbG1iHD26wVkafgi3KvWSwJnqp/VtkgPcjI
         AAqn4Ju+iO1VyqS3ZIxhFxsC7lTHQ/3LUOuZldnG5KmMV5NaiY1j1zhvTt+6ncklwtc5
         94Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843952; x=1788448752;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5ILsPzLPpRFtKqwTgoqLyKt9KA3mx56bT9taONMFwE=;
        b=gsFbyHlWaeVte1wbf4Qhh1S+cgjCYcMXP5plXZt+bn30fkXvh00VjOCKAPh4i0by9B
         IP4kxkxo21Y+9Bx4OBj2b4CMjYgRMLA9SqaLwglnacLc6JDrX1btXCKND670Pu4UIjW2
         qZdsd6s2a/6KuXB4i3bbrpLZaMXgVHsPB8B2MTz7RQOF+uWXRUSWT+1J8yyFUy9Fd5kR
         HgqOlFxiiWCSAk9l4zwJ5ksP0higX5ibBpmY5gBmMObm4m7NN/nAGF+yr27kKwRBEkc2
         Cx4V/0dIgTAuQGEUjLkoZs+LmrZdq4h1E4S+ZPCrwQUMaReIdW5uWGZYlZpyPeM4dcZx
         LQ8A==
X-Forwarded-Encrypted: i=1; AHgh+RrxnrZkBIUNWi76StqTycM1PUFWRRInOAEsR2uzcP+hq6UcZR666kD3UXKcU68UBOCA6Pc=@vger.kernel.org
X-Gm-Message-State: AFuF++kSbElqaSFeYE1YLfH8wTMG+dVq+y53/TIi9/YcTLktstzOBAX1
	RqsAuhBPlSy0HkbOseUHjc+k87h+GKataswULKjgWhwyDGbzPWwqYUlS
X-Gm-Gg: AR+sD12c5Aoq3RkVrNoFwxn6A/MTFXv/op130Tu1wwGtGK2SQHKry3vkNPIL/Oynf2G
	MiWvgdhI6T1SBD6/GDQIoj4pyBzZfrmmBJ80R+KfWuJ2dgyLB44Mb4oEyFxechWY0KMKcWn8K4h
	zUP/GdZIWQS2D/H7d1c9vhlJELdLqkUCbm6RnioNc+Ki8o8PW8edCohT6kQknju4zeHMXyE5Ynf
	twhm3xH36dDeFXZY58a3YDCIEiAiKWRiXbILq/CDYbQXTXJ/M388wnzgVianAtp4YYLmurswGkF
	EEXlOt9ERNQaiMdr4d0izgTmHHJOR19RoNjoTWBFVkpr+u0sDNq3y8A9P4/IRce+jPNQbr+uQdS
	Z6I8hFWZF8eAcSUi02h8VU5zkbT+oh0IdzaDhtAnr4/AulZ9Xk3pOqi2OZ0ZsVWKJOYm7mHHk6K
	y2CHsOSMCj/zolEpb2+MlWWSgrDj7qtSlkf8GTJTWKJk5zKJqOYObafiUTyU0d5JYAPR/bhdWlm
	mQzHC52DfYA2Xr3a8exazKsJJsVMX4W3zv/MXxMSVcC8sNzEOsBPQ==
X-Received: by 2002:a05:600c:c87:b0:495:7888:281c with SMTP id 5b1f17b1804b1-499dc693e38mr160125975e9.0.1787843951715;
        Thu, 27 Aug 2026 08:19:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49610170sm129285965e9.6.2026.08.27.08.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:19:10 -0700 (PDT)
Message-ID: <dec05fd6-b99c-4a71-b80e-24e7d6de4b62@gmail.com>
Date: Thu, 27 Aug 2026 16:19:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
 <65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 27/08/2026 02:02, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When a rebase applies a commit that becomes empty, it stops and asks the
> user to decide whether to keep it or drop it.  HEAD still points at the
> previously-applied commit at that point, so either amending or creating
> a partial commit is refused, with one of the following messages:
> 
>      You are in the middle of a rebase -- cannot amend.
>      cannot do a partial commit during a rebase.
> 
> Neither message hints that the real problem is a commit that became
> empty, and "during a rebase" is overly broad besides -- amending and
> partial commits are fine at an `edit` or `break` stop.  Reword both to
> describe the actual situation.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/commit.c              | 4 ++--
>   t/t3404-rebase-interactive.sh | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 28f6174503..0d908d72bb 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -521,7 +521,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>   		else if (is_from_cherry_pick(whence))
>   			die(_("cannot do a partial commit during a cherry-pick."));
>   		else if (is_from_rebase(whence))
> -			die(_("cannot do a partial commit during a rebase."));
> +			die(_("cannot do a partial commit while resolving a commit that became empty."));

"while committing a commit that became empty" would be clearer to me, 
but I what you have is definitely an improvement on the existing message.

Thanks

Phillip

>   	}
>   
>   	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
> @@ -1334,7 +1334,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		else if (is_from_cherry_pick(whence))
>   			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>   		else if (whence == FROM_REBASE_PICK)
> -			die(_("You are in the middle of a rebase -- cannot amend."));
> +			die(_("You are resolving a commit that became empty -- cannot amend."));
>   	}
>   	if (fixup_message && squash_message)
>   		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff11abb2f2..1e78dbfd90 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1868,7 +1868,7 @@ test_expect_success 'correct error message for partial commit after empty pick'
>   	) &&
>   	echo x >file1 &&
>   	test_must_fail git commit file1 2>err &&
> -	test_grep "cannot do a partial commit during a rebase." err
> +	test_grep "cannot do a partial commit while resolving a commit that became empty." err
>   '
>   
>   test_expect_success 'correct error message for commit --amend after empty pick' '
> @@ -1881,7 +1881,7 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	) &&
>   	echo x>file1 &&
>   	test_must_fail git commit -a --amend 2>err &&
> -	test_grep "middle of a rebase -- cannot amend." err
> +	test_grep "resolving a commit that became empty -- cannot amend." err
>   '
>   
>   test_expect_success 'todo has correct onto hash' '

