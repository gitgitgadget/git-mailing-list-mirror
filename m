Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051FE197A7E
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900749; cv=none; b=cYdFUhZizx+5Natv2OaLs6NGtrcweFnhhnqNGJDumH3Jf/nAxwaRsWeTUQJO/gUP04p9j0j3qXHgro8wKf5XVznwhlwFyKpmVXnDx5x+R6ZMNkE/Q2Nuc3ZnMePitQC+is7tblmsXhx6OsLsNuLGE0q04KiosdoRhLSxIKTd6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900749; c=relaxed/simple;
	bh=runejZlOSLaODzXqe2CobLR4lF1K/0u1YeMHeQCdfHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kMQYj+UeRLhfLrCuoNHKCkxnN6g9Q4qMBMH5LYY8AP7xmKjPAtkxKr9f+v2G4Uff7LL+2evT195VUE/X5aAeBzK7iX4pkyIVnsk6vhRDLa9/0ye3m6hxB047PK2GYRG4ZBCvyIaqq5MZyO6jBr5Wuxktho3a6SU5nY4pr4Ccmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+HOvuEC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+HOvuEC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3684e8220f9so350245f8f.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900746; x=1722505546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1/Bs5/p+DQLa4L8P9A8xOVsYVCewbd0IUffMnTDwwU=;
        b=C+HOvuECJdUn/MW2ipphqOb5ZmUXS5/DdwqgHlUG6Mmw3+KHQJdlc+EHC5rcqAzWMM
         6L3pXW1CI+OZ3mtpygjMaF7YSO7QnejjOdlNKZjjlz6l/oXF1b40QousmOK8KEAnfC7s
         AueU3s3QG9PMQfwt54Wo6DWe2RcYIfmTSmAhsHxPEhm3P/6r2fvSlQA568HgPVh33yXi
         yR2t1Dqe8xB/EM4VbnpJJDSOWUl0E1ESM5odvf24fLIiX9lR8XsbLu9kvfcgQrlO8vDQ
         Peh3SA1VtqJ8JOiqBTigsmvDO6zJoVBhQ7Jo502+GagwENW6+FYH297NB2wdfP2qyz3H
         qAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900746; x=1722505546;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1/Bs5/p+DQLa4L8P9A8xOVsYVCewbd0IUffMnTDwwU=;
        b=KRm4kUOYb+Tt7ovY+0a20AO98Zqt0jxWayZPtg7Veshm1/2a2MV+9iGdEfNpMKiLHe
         cQxsPF0WWSDEps7T0l2Pu9fiXmUk56LtPZmKBwx9a+snfjHWz19fx5Eb8SA/HEu3Gv9f
         rlXnM5iUHA+VgIR6L/9O5bcE/pJk2cIWc5aKg5hZZwov+ojbq7JeWdo+sdnoDTrik8nD
         elHpnQKVZ4Rcd2iwyU5RZ6/3GYQzjHIVTreFF3kMKaIGo5/r6kEVgczspAKjaPASnO4P
         nbg6QQwcRo0hzbxB9tgDU/WAzB0bcUU7wlgeGwijVLrUyHUh2Tys50G7rROUloVIuSgG
         r/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWFsr6afmM6QViq9m2BEqguxGVGF7peLtRcVLnTVX6tfAZJ+7SIWhyM+gdfhD+9Q1DQWLh6YduPx1R5xxKDjbVsi/GZ
X-Gm-Message-State: AOJu0YzBp2anRqvZ6s4xoPyT++IVk6ItU8nnjbpiJ2zxYBrYxbTGjEh/
	BsLNA/gwaFcbCqwO7E+wHkm6YIynxS8J+xlLhK/Q9nV07HD33lcl
X-Google-Smtp-Source: AGHT+IFuU4sfxaNEVZVw0qyFVSJ8u04Sxfk24B3PJntY7lpDKTTOQa/8JmAm8l6HGyXaQcHLPoBnJw==
X-Received: by 2002:a05:6000:1252:b0:366:e9f7:4e73 with SMTP id ffacd0b85a97d-369f6667f6fmr3517082f8f.5.1721900746347;
        Thu, 25 Jul 2024 02:45:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d? ([2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dc2sm1558822f8f.77.2024.07.25.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:45:46 -0700 (PDT)
Message-ID: <d9d1115a-d530-479a-acf8-189713632adf@gmail.com>
Date: Thu, 25 Jul 2024 10:45:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] safe.directory clean-up
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240723021900.388020-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

Thanks for picking this up, I think this looks like a good approach 
apart from resolving relative entries in safe.directory which is 
intrinsically unsafe as we don't know which directory the user wants to 
consider safe. With these changes it should not be necessary to add "." 
to safe.directory to get "git daemon" to work and all the other code 
paths use an absolute path from getcwd() so I don't think there is any 
need to support relative directories.

I'll be off the list for the next couple of weeks

Best Wishes

Phillip

On 23/07/2024 03:18, Junio C Hamano wrote:
> Changes since v1:
> 
>   - two "extra" patches for optimization that are unnecessary have
>     been dropped.
>   - a patch to add test for safe.directory="." use case has been
>     added.
> 
> Recently we discussed what we should do when either the path
> configured in the safe.directory configuration or coming from
> the caller of ensure_valid_ownership() function as a result of
> repository discovery is not normalized and textual equality check is
> not sufficient.  See the thread the contains
> 
>    https://lore.kernel.org/git/6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.com/
> 
> Here are three patches that implement the comparison between
> normalized path and configuration value.
> 
> Imagine that you have a repository at /mnt/disk4/repos/frotz
> directory but in order to make it simpler to manage and use, you
> have your users use /projects/frotz to access the repository.  A
> symlink /projects/frotz pointing at /mnt/disk4/repos/frotz directory
> allows you to do so.
> 
>   - The first patch normalizes the path to the directory that we
>     suspect is a usable repository, before comparing it with the
>     safe.directory configuration variable.  The safe.directory may
>     say /mnt/disk4/repos/frotz or /mnt/disk4/repos/*, but the path to
>     the repository for the users may be /mnt/disk4/repos/frotz or
>     /projects/frotz, depending on where they come from and what their
>     $PWD makes getcwd() to say.
> 
>   - The second patch normalizes the value of the safe.directory
>     variable.  This allows safe.directory to say /projects/frotz
>     or /projects/* and have them match /mnt/disk4/repos/frotz (which
>     is how the first patch normalizes the repository path to).
> 
>   - The third patch only adds a test to illustrate what happens when
>     the safe.directory configuration is set to ".", which was a
>     plausible setting for those who run "git daemon".  The
>     normalization done by the first two patches is sufficient to make
>     this just work.
> 
> Junio C Hamano (3):
>    safe.directory: normalize the checked path
>    safe.directory: normalize the configured path
>    safe.directory: setting safe.directory="." allows the "current"
>      directory
> 
>   setup.c                   |  28 ++++++--
>   t/t0033-safe-directory.sh | 146 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 170 insertions(+), 4 deletions(-)
> 
> Range-diff against v1:
> 1:  20e1160946 ! 1:  86d5c83ee7 safe.directory: normalize the checked path
>      @@ t/t0033-safe-directory.sh: test_expect_success 'local clone of unowned repo acce
>       +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>       +		git config --global safe.directory "$(pwd)/repository"
>       +	) &&
>      -+	git -C repository/ for-each-ref >/dev/null &&
>      -+	git -C repo/ for-each-ref
>      ++	git -C repository for-each-ref &&
>      ++	git -C repository/ for-each-ref &&
>      ++	git -C repo for-each-ref &&
>      ++	git -C repo/ for-each-ref &&
>      ++	test_must_fail git -C repository/.git for-each-ref &&
>      ++	test_must_fail git -C repository/.git/ for-each-ref &&
>      ++	test_must_fail git -C repo/.git for-each-ref &&
>      ++	test_must_fail git -C repo/.git/ for-each-ref
>       +'
>       +
>       +test_expect_success SYMLINKS 'checked leading paths are normalized' '
>      @@ t/t0033-safe-directory.sh: test_expect_success 'local clone of unowned repo acce
>       +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>       +		git config --global safe.directory "$(pwd)/repository/*"
>       +	) &&
>      -+	git -C repository/s for-each-ref >/dev/null &&
>      -+	git -C repo/s for-each-ref
>      ++	git -C repository/s for-each-ref &&
>      ++	git -C repository/s/ for-each-ref &&
>      ++	git -C repo/s for-each-ref &&
>      ++	git -C repo/s/ for-each-ref &&
>      ++	git -C repository/s/.git for-each-ref &&
>      ++	git -C repository/s/.git/ for-each-ref &&
>      ++	git -C repo/s/.git for-each-ref &&
>      ++	git -C repo/s/.git/ for-each-ref
>       +'
>       +
>        test_done
> 2:  06de9038b7 ! 2:  c4998076da safe.directory: normalize the configured path
>      @@ setup.c: static int safe_directory_cb(const char *key, const char *value,
>       
>        ## t/t0033-safe-directory.sh ##
>       @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked leading paths are normalized' '
>      - 	git -C repo/s for-each-ref
>      + 	git -C repo/s/.git/ for-each-ref
>        '
>        
>       +test_expect_success SYMLINKS 'configured paths are normalized' '
>      @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked leading paths a
>       +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>       +		git config --global safe.directory "$(pwd)/repo"
>       +	) &&
>      -+	git -C repository/ for-each-ref >/dev/null &&
>      -+	git -C repo/ for-each-ref
>      ++	git -C repository for-each-ref &&
>      ++	git -C repository/ for-each-ref &&
>      ++	git -C repo for-each-ref &&
>      ++	git -C repo/ for-each-ref &&
>      ++	test_must_fail git -C repository/.git for-each-ref &&
>      ++	test_must_fail git -C repository/.git/ for-each-ref &&
>      ++	test_must_fail git -C repo/.git for-each-ref &&
>      ++	test_must_fail git -C repo/.git/ for-each-ref
>       +'
>       +
>       +test_expect_success SYMLINKS 'configured leading paths are normalized' '
>      @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked leading paths a
>       +	git init repository/s &&
>       +	ln -s repository repo &&
>       +	(
>      -+		cd repository &&
>      ++		cd repository/s &&
>       +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>       +		test_commit sample
>       +	) &&
>      @@ t/t0033-safe-directory.sh: test_expect_success SYMLINKS 'checked leading paths a
>       +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>       +		git config --global safe.directory "$(pwd)/repo/*"
>       +	) &&
>      -+	git -C repository/s for-each-ref >/dev/null &&
>      -+	git -C repo/s for-each-ref
>      ++	git -C repository/s for-each-ref &&
>      ++	git -C repository/s/ for-each-ref &&
>      ++	git -C repository/s/.git for-each-ref &&
>      ++	git -C repository/s/.git/ for-each-ref &&
>      ++	git -C repo/s for-each-ref &&
>      ++	git -C repo/s/ for-each-ref &&
>      ++	git -C repo/s/.git for-each-ref &&
>      ++	git -C repo/s/.git/ for-each-ref
>       +'
>       +
>        test_done
> -:  ---------- > 3:  ffc3f7364e safe.directory: setting safe.directory="." allows the "current" directory
