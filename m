Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDC1DE2C9
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017958; cv=none; b=f8gz8fqzIpomZZgaVxhD2HnibpOBemtlMKogTLztUvQflG77zW9LLcqsQDMAFUf0zO/jTd8r9W4iNM5MfNWllJ2BGKGJhoNg33p9Lnw9/0Qw0z+8sF6HLrjcdQoPJQbAflA6KTrY8d30h6Z19LtlXg1/r+LNzKEV39+E8KrvZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017958; c=relaxed/simple;
	bh=FlK0S8B0tgOpmrMGYBOT9wHH7hCjP+T8lvwTAuKPsyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=smF9DjbZGd8oUsqfhCVUmYgCVDs3aOnnnZD6wVW+mw0w56MAENQjxXX+oxhEbMVJzgRFgoAAkcwU/orwq462A42epJ/3NOtDrMlq0UGF0fNaDOPEl/DtW1qUN+B5E+cmYVEjkwVUyE+mJh0v2FrDE8mD8uIf0xRuXOvWsQcrOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgKQ2qCT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgKQ2qCT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so1739130f8f.2
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751017954; x=1751622754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D9IYy4gkr08WM5grKVl1Kxw9uk5LJHIYyQWMoxEJ/MU=;
        b=UgKQ2qCTCJs7DpVURcI7Y2u4fDxs8oV/IoBtqsCBilUn0f5kooqx1hQTuis4l48vwA
         NxAIbWA11H3rl286RVF3BkE3AS0yIgXXU91r4v3rat1u7s0CNYYy2Wyl4GedFOzaImMd
         f1sqSSbjd0dK3iNUG0Xtn+afQhdYpAVfqxRCSsZDMxRBamyfHuPZ7KJOOrOU09QXxT6g
         wubxkHjShQnQGzfioNjFck8vY7lKFBs76JJTFjz3T0XxM7jQTbdNAKNBNAOhTCvUs2V6
         3+vn8BF+ptZOFk83cGAmmTc/ufdLA45eg0Lr1NdWAf6QZ4DGcUohd46ITViXoOgmKwTy
         /hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751017954; x=1751622754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9IYy4gkr08WM5grKVl1Kxw9uk5LJHIYyQWMoxEJ/MU=;
        b=OSfFN5wPSVxdF+n5eSJo94XxvSmq+ikp2T+MGIC47zikcDrpd2+g/8mEpwi7YCjB1j
         BuwUAv3JFIKJSKc1WOfbx1iSqgiOZqpTzKItd/zI3op+g6S8juRCGkLiin+iK4LI3uY0
         CbMAHr3V3kJv3V7yZdCF8ZXLndop3WHdWn9DAAKOg6sJR/ISDMjagqaMw4uvtDQOR+dx
         G6p/8/EO9l8y72ldKTCdsljErvBQBRB/Cujfb9Lc6Hk+8ZsxSv0m/UoYhJyf0DPGnx8T
         hKNS3MsP++yUYWVQWFrDTHy3SaipFVqUVJHPeugQummOJmOcicy0g8OHNEox21fX0rZj
         yWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvd1WFVSJov03l/nk1IW/mxohAuFFkcVWLFUZteVVcv4QY4wSRq+WiQt40hMjRffDkVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7FLymSasP4CoNsX3MV71ShDhxL8EG4z9OnDtMorTO1yZGzKP
	eJqKQh5WLZaYw0zYr4HSj6dTby/FmCrK4hAtAjAqm6bozDlvtcEhXA27
X-Gm-Gg: ASbGncvKCIsplvHTNwgTOYqS1Xhj50LqvOumPDK8zBnEuJwdGZD7O66BQcm+2l7mLyr
	M8TyXerNYQPrUGh+iX2FT/DQVi8hzCLWfMTT60Go3GsTnD5NcfkUzJFuQTP66DFIwG5OIRHXsvo
	EfqQJvTXhgu11BT0jq05hWUg7zAazbNtTLAGFjqX/cGp8a0TteCbk63oSaJDkPDO7BKGPhSiR8s
	RU9AWozRClj2kMwaFHlBhx/d+xTtG5+L/qJ2nZ1Ay5/3dZsUJ6hrVT57v9++LTcLBxm7N+s94GO
	h7hPUnLn8ylJwL5wNZpTTRbRh5BxxyIQNLFf8mWyatOfnPYYD4KsuU3TD0ucxkp841PbD70nNyg
	PZQW8x3c4DkZBtagTUGJVNX2uxn7QAhkG6p6ZpdwBMdOt/Ngf
X-Google-Smtp-Source: AGHT+IHMGQz31yRgnNAF0ZUq0oH6nurcXqakA/z4CRQirpZYTJr8RvmTjuTKtNfboV0xbuYhCO2DEQ==
X-Received: by 2002:adf:e885:0:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3a8feb702b6mr1934767f8f.48.1751017954185;
        Fri, 27 Jun 2025 02:52:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c8esm2261307f8f.55.2025.06.27.02.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 02:52:33 -0700 (PDT)
Message-ID: <073cffb5-7f15-4c41-a7ac-9f8ad1f4fffd@gmail.com>
Date: Fri, 27 Jun 2025 10:52:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase interactive breaks when working on a secondary
 worktree
To: =?UTF-8?Q?Denilson_S=C3=A1_Maia?= <denilsonsa@gmail.com>,
 git@vger.kernel.org
References: <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 11:49, Denilson Sá Maia wrote:
> git rebase interactive breaks when working on a secondary worktree
> 
> ## What did you do before the bug happened?
> 
> 1. `git clone` a repository.
> 2. `git worktree add` to have a second branch checked out in another directory.
> 3. Continue working as normal. The main branch has a bunch of extra
> commits (at the main worktree).
> 4. At the second worktree, after a while, try `git rebase -i
> hash_of_a_few_commits_ago`, or `git rebase -i main` (where main is the
> main branch at the main worktree).
> 5. Approve the plan, even without any changes.
> 
> ## What did you expect to happen?
> 
> It should work.
> 
> ## What happened instead?
> 
> I get this error:
> 
>      error: Your local changes to the following files would be
> overwritten by checkout:
> 
> Followed by a list of several files that were NOT changed in my
> secondary branch at my secondary worktree.

Do you have any line ending or filter attributes set on those files? 
Another possibility is that we're failing to refresh the index before 
the checkout. Looking at the code the index is definitely refreshed 
before the checkout when '--autostash' is given but I'm not sure it is 
otherwise.

> What's more, if I redo the `git rebase` but without `-i`, it works
> fine without any errors.
> 
> ## What's different between what you expected and what actually happened?
> 
> If I try following the exact same steps (the exact same git rebase -i)
> on the exact same branch, but this time having it checked out at the
> main worktree, then everything works.
> 
> ## Anything else you want to add:
> 
> I've been hitting this error for several months.
> 
> It doesn't happen every time, it depends on the commits from both
> branches. Thus, it's hard for me to give you a minimal reproducible
> example git repository.

Unfortunately that makes it hard to figure out what is wrong.

> Given the circumstances, I believe some part of the `git rebase
> --interactive` codepath is not working correctly with worktrees, and
> thus it's misbehaving.

I'd be surprised if the fact that it was a secondary worktree was the 
problem. Is the worktree on the same file system as the main repository? 
Is the worktree synced to a cloud service?

Thanks

Phillip

> 
> 
> [System Info]
> git version:
> git version 2.49.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:29
> PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T6030 arm64
> compiler info: clang: 17.0.0 (clang-1700.0.13.3)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
> 
> 
> [Enabled Hooks]
> applypatch-msg
> commit-msg
> post-applypatch
> post-checkout
> post-commit
> post-merge
> post-rewrite
> pre-applypatch
> pre-auto-gc
> pre-commit
> pre-merge-commit
> pre-push
> pre-rebase
> prepare-commit-msg
> 
> 

