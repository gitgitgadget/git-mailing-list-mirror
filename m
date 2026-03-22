Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3062F3C3D
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197439; cv=none; b=m6uSN+UHNKHvH3EwxDn2uc2eaSSuX2EpD63wGa3pL72lWnkEI37cJzXnGt5Z3xDV+Sykd2l3r7RBxZz6ezlFRags80Dy1rRur/c8d5zFHPwtAxThpFkY90xjZuEbjB/5qhoylZTd26+5Z+Y0juHUc/o6eE/OszgojWDiKMHUcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197439; c=relaxed/simple;
	bh=pFOSW/29F13GKdBJIEP9kSH3Stt9z5HoSuBH+jvMKa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WluvgcLRoqIMhGzrrYM+7xp+fEnJLCxjCusG/es1+A8WC9/ESGpf99R9WtYsMmtUUsMa5m/3SoMLDM1rGV1Yzy96aWqlgDQHi39/rILiJVBCHRrmFRwshNmTSG/2vav7vKu3OqrHT329X1koIPXojb74/Haot3CRff6UJJRZxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AryVUSJo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AryVUSJo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a8720818aeso4173855ad.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197438; x=1774802238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frtwKbu77qdakhoBtX0l+jD5z56mUs0C641tVXx8uCw=;
        b=AryVUSJoODfiTFq9hIL1xbwaHjtSi20Rzv+rTXFjlUj84JqgYqnDIMwOFLRCRnJPI4
         YPOkK6XKKts8qu402EOEyiddEP0YakZa8atf3kiemXVVz5PZ+HJsBWsZZ5Ny58WeP3pq
         kStCJjzRLVI2DrNRz31IpLJvdvsns3X5NBHO0JGn7+sbDhZuWXCUzGT0QEHWmaewQTFV
         yyJmMtqhWi9032jg8uR3llrxZUFlyYyh3yUj97EOYlvzoK1N1xNK/FrId6SDF/UQTRHJ
         Qh6wsgG2L2MD85e5BrE5Lrd0kkF2BBQyvwiuTa6g4aJWdlsBrGVDj7Vshk84JNyg9zUg
         oQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197438; x=1774802238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frtwKbu77qdakhoBtX0l+jD5z56mUs0C641tVXx8uCw=;
        b=LEjN8uYcKnmrXyYNR7Jqp+nAX3qGPwMeQUBNcGh06+l/AhQW8CmVkOkIjl1TYkMbR4
         N86UYqAcH6gIL5P0kuIbAq4nZ7QvblIAL3CjFAnMbNvEYobsd4x46WLDktFDfhCmN5Ke
         11rDg77A7nt3/J4t3/1fGxP6uwYqhhDOdIw5cAiUQ197rKfldxIZ7Gz4GLRT5NHFTin2
         DhrWNXTugeARdi02W4l4yr3Hul1YhljedwsgjK+at2H8F0VXUtTmcNMmiA2t+YrE9F/l
         b9nklt+nmwdMIT71QbWQ2zPk8Ju66/aWFvegPevtjIBOSi+Ltr7QBAkLGcwk1jXhWZmh
         30JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy2iZHcpJXhJEGlnkV/YSmx29GHQxut8ulhsi7lpx4+OFWOa37xV6NaoASi1mmEgi6MKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9N8k9hFg908EehuRfWILYazaGL448lC6yAQ6zT1YSk3TBzZc0
	MZICZJKKy46jutXIA799rkySdks9miIiABIOsFVRIEM7sv3naADEmD3v
X-Gm-Gg: ATEYQzyP8gb8OahscKPX44LHDCmuYY5Xy1eeDmxk18EmyZ0cTfbhuh7Se+5yOgwqzwF
	A/7hLNtoQk11rsSnAERQyfGQVqHQ7XRcqhad6WqZTs0C/HGPVwTwNlhDbwkgok/NdNP6d24zP09
	/xgSa3fwjchgBwEyXhcaGMwPGoVrg9JgI2gQtLsKQeMSzvydGEV1HJ+57XoFprCtvSWHO1kdRYa
	qoAhzW9zx7b2LpVR5qcqYyDwc8lElzgbOZSa0hoG0fe8M2bEOozpXh0afRaPdlwUbbUa/qH/kNI
	htgnoI79lcsS51Py3Ih585jJ5CzsUPfduBbItHQg5/ZRh3QKmzi821yW/coDpypNXIiMC/jLFDM
	t6BWAlfENHVNRR0xv8xtXchIeycLVmNp3KIgVCaCRzTiXIXkH9rEKrum++h7nCEO133pDIc47aX
	AFQXTXCrzbbpjE8MaCjfWJnrZjV9LhHR3Os7Y0Cku4eEeu69WqCjydiA5JJu1Nkjehe/eEQ3Xuv
	VmOBzqKKfE=
X-Received: by 2002:a17:902:ce06:b0:2b0:426c:c00f with SMTP id d9443c01a7336-2b0827ad66fmr59323625ad.6.1774197437522;
        Sun, 22 Mar 2026 09:37:17 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354b109sm106574075ad.31.2026.03.22.09.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 09:37:17 -0700 (PDT)
Message-ID: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
Date: Mon, 23 Mar 2026 00:37:12 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t/pack-refs-tests: drop '-f' from test_path_is_missing
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
 Jayesh Daga <jayeshdaga99@gmail.com>
References: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jayesh,

> old mode 100755
> new mode 100644
> index fa27d43a58..4a85d96c6b
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -1,9 +1,3 @@
> -#!/bin/sh
> -
> -test_description='test pack-refs'
> -
> -. ./test-lib.sh
> -
>  pack_refs=${pack_refs:-pack-refs}

Above lines are included in the your 3/22/26 18:56 pm patch.

Here, you not only changed the file permission from 755 to 644, but also 
removed the shebang testing framework. That was clearly incorrect — 
fortunately, you seem to have realized this and sent another patch. ;)

> From: jayesh0104 <jayeshdaga99@gmail.com>
> 
> test_path_is_missing expects exactly one argument: the path to
> check for absence. Passing '-f' is incorrect and results in
> "bug in the test script: 1 param" during test execution.
> 
> The '-f' flag appears to have been carried over from the
> equivalent 'test -f' usage, but test_path_is_missing does not
> accept such flags.
> 
> Remove the extraneous '-f' to use the helper correctly and
> restore proper test behavior.
> 
> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
> ---
>      t/pack-refs-tests: fix helper usage
>      
>      
>      High-level (Intent & Context)
>      =============================
>      
>      The test script t/pack-refs-tests.sh has two issues that prevent it from
>      running correctly.
>      
>      It uses: ! test -f .git/refs/heads/f
>      
>      This is inconsistent with the Git test framework, where helper functions
>      such as test_path_is_missing should be used instead of raw test checks.
>      
>      
>      Low-level (Implementation & Justification)
>      ==========================================
>      
>      Without sourcing test-lib.sh, the test framework is not initialized,
>      leading to errors such as: test_expect_success: not found
>      
>      Replaced raw file check with the appropriate helper:
>      
>      - ! test -f .git/refs/heads/f
>      + test_path_is_missing .git/refs/heads/f
>      
>      
>      
>      Summary
>      =======
>      
>      Replace test -f with test_path_is_missing
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2248%2Fjayesh0104%2Ffix-pack-refs-test-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2248/jayesh0104/fix-pack-refs-test-v1
> Pull-Request: https://github.com/git/git/pull/2248
> 
>   t/pack-refs-tests.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index 2fdaccb6c7..4a85d96c6b 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
>   test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>   	git branch f &&
>   	git ${pack_refs} --all --prune &&
> -	! test -f .git/refs/heads/f
> +	test_path_is_missing .git/refs/heads/f
>   '
>   
>   test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
> 
> base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad

...

I have no objections to the changes mentioned above, but I think you 
should name this patch V2, which is the community standard. Also, I 
think it would be great if you replied to the reviewers.

Thanks,

Yuchen
