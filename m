Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9D29E0FD
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835559; cv=none; b=NhjK0M08HR61eQuRxU+29k6w+QNGhXuBaNcYs2KnI6Gd6+TnYe5MAfkcsphJ4NZGTxFag3FvEWZL8AG8z5HqMSHA4RRE0yX5z78Zq9cp0nDO9nrA/3LDzMlDW25PoVweB9etuIg2GCXeQvz8zbDZHyrUzF6fvxDcR3kqLpkX1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835559; c=relaxed/simple;
	bh=7xsA8ufGut7ho8syAPi3TwYcExFUq/TbsTQpmiKU8r0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MNc+U9V21gchkzYx9S6rdRGI6Jb66DavyCa0b4OJWj2zY6iMfJ1q4AWVi5MfHUcMZ2BtzYmn9FPLQKr6baxpTfgqIMJx3xwvtuCWL673kTbU4NMGWGK6VuLAPczOliZNxOsBzuPSxhOe8Jl4pPzLKZ5nshbp1jlcIPcYHpxQZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJXZ23A8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJXZ23A8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfbd17589so1529256f8f.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835556; x=1776440356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e90WlgtXmcfsZmSMCX4qQIzLVoMRywJZbRI0qgEpQA=;
        b=CJXZ23A8VqBOfM/UW+TjinMEosJ+xse4GqeGd6FZsSaoKnR8RyHPMDo62pGBeLePXw
         S/Q2b1Hc5Sy6jBFCmzLOpYThgibZBQ87l4Ppdf2XKYRzjMytCWdKKFFDb7rcdak1Rx4/
         V2QVUMB7Z9+DKNs9k6SHRvap1exu2xrYyLVqPRr6ftSH/awRG6SvpiNKbcfKcd8kmY6P
         0Hb+Jbo3UAw2Kg1XbyLpo6v9r9GvOk8Yh3ks1V7MdlEO9QrrcelNiw58wEbFnzEPpCYi
         QHRLuPOTyVxCdIDalcqwLhD7xjJOxJ072N6vYUsIXyV8R2oKwZ4tIVCVbHxQmkxl8dCe
         1hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835556; x=1776440356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e90WlgtXmcfsZmSMCX4qQIzLVoMRywJZbRI0qgEpQA=;
        b=JtTgb5QRJCf2P3whH3ylq8LJm5FRnArlIOynBFKwDQn5ITiDzChtq2bTEGIdO/KgQ8
         SlY0fSuTjXKtcUDqXGdm5TlQYnzdpamolGk1ORdYLuCh1MpQygJt7QeFFb88Q8VUddze
         ZUIFyMvlwIhnhNyrv5Y/dkXfaSU0gERM7MdV67pua7/TAC/nqiq7q42wlCDW9KFX64wl
         8/d4DLKn7hCfDe/7Wo0ODCcIECqMVz62zWDNwHfTYoQ2tpIZkKWgKGGq2pOtMb8SNaHR
         Xb+zCZkVIBPGG0NiUIdIHmk5+uwyppI49s6Rgsss+KinyPWlXMN/l7F4WH4rJKbVIMDJ
         s8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXIp1AM1LeMGoKQm9/RjIK6NjLAfNWDEWnyzATOxdjjU1fCER8uevdYmYKLFl/TibrevZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjX8IL9ZPvmJMJo66c5oe6E/Ui4YIDpyqQjzNBrTZ7amRsxyd
	Xe3VSjWdOho1vfNIf7nF9zGXzfMJhewuIFZQMzJ2LPP2XhcxlyJWedMCamd2jQ==
X-Gm-Gg: AeBDiesZD13xVA3s55rWw0GcOSJ60ppXWAGX4XrMDQRpmWtnwTk7vmZM24zKU3u4p5p
	LlEyD1xu8Np6NE64xMH5dC/Oofl3tpLzMI7ptWHk1RaO058LGN+rXw/fEevCbqORxXJwMCNdfSM
	VO4dTGdT+z6RgnYup8gKOWyfmLK4NMwDGY2bdLgJdpMRs3q1Awqagmvrbi+Ak/qIOU0XDGuFPNz
	YLC6N77RylNAsRmWkY37NeQW8PD+i8awhbKe4wwazbdAdBmjeajo8WnlqU2bewK28jbAEOfDLrU
	V0o7YglOLMz7ptLOa+zKuU1wLOxPkwXbx4KQaa9qlg9jOj2TH/w/yQvhS1+nXTxTcsIij5AfnY/
	5O4pNHPY8cG3I4VsGzxJxJ6sA9jMsIel/7Rm54xpGfxX15sUMFZp+h/bITgUNdLme6pJvUalMjG
	rzm9K384Pw7ARI06zs5jOjExpUxTHpWGsMQuPu7zQqPVfVzPB8UReoJAr22nluYUTdVArJxfaXG
	hHE81gbQ0eHdA==
X-Received: by 2002:a05:6000:2408:b0:43d:1c75:db70 with SMTP id ffacd0b85a97d-43d642537a8mr5450705f8f.15.1775835556060;
        Fri, 10 Apr 2026 08:39:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a74sm8781852f8f.3.2026.04.10.08.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:39:15 -0700 (PDT)
Message-ID: <0d1c7bf2-6404-4779-a0d6-6db592510a04@gmail.com>
Date: Fri, 10 Apr 2026 16:39:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 1/4] stash: add --ours-label, --theirs-label,
 --base-label for apply
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
 <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
 <8fcf3778205d4742a56ed2e4c3b97defa21a1538.1775762235.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <8fcf3778205d4742a56ed2e4c3b97defa21a1538.1775762235.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/04/2026 20:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Allow callers of "git stash apply" to pass custom labels for conflict
> markers instead of the default "Updated upstream" and "Stashed changes".
> Document the new options and add a test.

Sounds sensible and the documentation looks good.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 0d27b2fb1f..54bcb6ac73 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -44,7 +44,7 @@
>   #define BUILTIN_STASH_POP_USAGE \
>   	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
>   #define BUILTIN_STASH_APPLY_USAGE \
> -	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
> +	N_("git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]")
>   #define BUILTIN_STASH_BRANCH_USAGE \
>   	N_("git stash branch <branchname> [<stash>]")
>   #define BUILTIN_STASH_STORE_USAGE \

This patch seems to be missing the implementation of these new options. 
Before submitting a patch series I find it is very helpful to run

     git rebase --keep-base -x make -x 'cd t && prove -j6 <tests that I 
think might fail>'

to catch any mistakes.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..d4e4e4d7b6 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1666,6 +1666,43 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
>   	)
>   '
>   
> +test_expect_success 'apply with custom conflict labels' '
> +	git init conflict_labels &&

Why do we need to create a new repository just to stash some changes?

> +	(
> +		cd conflict_labels &&
> +		echo base >file &&
> +		git add file &&
> +		git commit -m base &&

We have a helper test_commit() for creating commits (it is documented in 
t/test-lib-functions.sh)

> +		echo stashed >file &&
> +		git stash push -m "stashed" &&
> +		echo upstream >file &&
> +		git add file &&
> +		git commit -m upstream &&
> +		test_must_fail git -c merge.conflictStyle=diff3 stash apply --ours-label=UP --theirs-label=STASH &&
> +		test_grep "^<<<<<<< UP" file &&
> +		test_grep "^||||||| Stash base" file &&
> +		test_grep "^>>>>>>> STASH" file

Hurray for the use of test_grep here!

> +	)
> +'
> +
> +test_expect_success 'apply with empty conflict labels' '

Why do we want to support empty labels rather than making them an error?

Thanks

Phillip

> +	git init empty_labels &&
> +	(
> +		cd empty_labels &&
> +		echo base >file &&
> +		git add file &&
> +		git commit -m base &&
> +		echo stashed >file &&
> +		git stash push -m "stashed" &&
> +		echo upstream >file &&
> +		git add file &&
> +		git commit -m upstream &&
> +		test_must_fail git stash apply --ours-label= --theirs-label= &&
> +		test_grep "^<<<<<<<$" file &&
> +		test_grep "^>>>>>>>$" file
> +	)
> +'
> +
>   test_expect_success 'stash create reports a locked index' '
>   	test_when_finished "rm -rf repo" &&
>   	git init repo &&
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 29dad98c49..659ad4ec97 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -199,9 +199,9 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>   			      int size, int i, int style,
>   			      xdmerge_t *m, char *dest, int marker_size)
>   {
> -	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
> -	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
> -	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
> +	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
> +	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
> +	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
>   	int needs_cr = is_cr_needed(xe1, xe2, m);
>   
>   	if (marker_size <= 0)

