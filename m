Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073B314B96
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609220; cv=none; b=XjGnm2dSeci1XkLTXtQzZp0LXkQctDw/7InmXbEFBn2zNbDUEkCkK/psmCb8ZAAhvRz/HbBn4DrX/GuHnHdLNk6l5IaFXOrgDQBxO7oNlLKwn3XvwafOx/qFExjTXNKdH83IR6UIrewb4H2IiUBPAWQaKmRN0/HqIQmCS473jl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609220; c=relaxed/simple;
	bh=F643QqeWFrmlA5RKY2CH+IrmkLD7HBLxP50DiwbfEK0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SOiVV0CIg/DB4M/hufk0DtoBWGQ99pNODm9DWs13dXWrhdlH3x+5aHKiFyA1xJsw90oMnPLfa2for+NIdFu+KAM0kt5X3dJ0xVerfpUY6XFeaJ+pHImxkABCth9uNbTEDjsNkxLzM/WWoKv8wM0v628vkHinBsFjqXSgUkpcJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5uvdFPd; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5uvdFPd"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47774d3536dso14688425e9.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767609216; x=1768214016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4l4gJHeJ7OLAMlW3ZTgFHtjGe+Er25pcSiggtk+Bk4s=;
        b=U5uvdFPdy5gYRsCo5psJ9UN7qkhPj7cq8rODPRgFd5Dng6/gjqcD4a8FDiRso1SdWU
         7zx3EfPWOyArm/pC3quE+F/fkVEF1DZEmbmrSu5RPspU/eMD096OtII6VDFG/pz+1q5G
         Jt43pBHWJdxMx88Zq9Ap58HZcLw1kTpQwfVtWMPJ0zBX/NWyoooG3Favdpr6y1QFrD1L
         vZnZYjxltCIkwUEd1Xev4svvD4nZ5t9bgNU0ALo5C1cAxf6rz/MNOr+0Q6+DjYGOx/tZ
         w1q/j4XZ0T3ijMEuSwj55tMoSTuF/reroPU3Ai4RrucJIjCLhRa7F9eza9Dnq89Dfl7R
         uVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609216; x=1768214016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4l4gJHeJ7OLAMlW3ZTgFHtjGe+Er25pcSiggtk+Bk4s=;
        b=MG6yCPvI9SLeSKvhw50ObZaiIfYravE7y8QRW9SisVE0hvrUIaQfqKKU/6zp3gHhTh
         k8cKX7EcewcDLSFg1tq+PUzwvLhHkVnPR9zpKzNzVEYdeMX2UFWi0Z2y+dDg5jj5JImq
         gfl2wCLCZTb6uGv2tvw1OdFIMaikIf30Y47VTM0teuwhdFPrn37QBGkvQcB6zNGyjYFf
         hbFaKQaSCNvjR3twoDYOe276HnaEyDc3Y6qjt5wwRnpvG7sROY+dwRF1IjUeCv9yeQ9A
         kvIBOj/k0XVyRG7/3BMV48hnCAB98QJkya66rdB9Z8XQbzENnSNPmjMUtNAytNOqu/q/
         Tgdw==
X-Forwarded-Encrypted: i=1; AJvYcCVLhY97ad87batjZMURafeusL6B3lekXxscOegpY1mz1yWOH8vQr00Td6i5+VkPrzLTh4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOAW9vISqgk7WuZfYkTf1vJFapdRSdkG11oOmAVmOD6184Few
	UwYe/gkNZEhEV8/3WruUV926n0bGz/5ufwnqwvNw2TOZ47YpmpGzyGuO
X-Gm-Gg: AY/fxX5cyo4a/T4nGuaETCxxrIwQUV8iPaHa0G4IWG8CXKYu1kewnKB2b3+0Tm20yAX
	IgplqkslojG+kDeGPSUrjgH+0GaspovF0zaV7O9WYK91BWMG/OT0wcpeCHDmp0Hc83fsmjG6jc0
	Z7zLImoGykPAWRsMeHcT8gOzjDgjjRMUpwTZgnThXQfl9r5ykv/GK7TLIiq7A/wTLkeRRYI9eyu
	1yoaofpajJdXJ1x6jyrajAXRLiTE10xUigzB9N+pLTVZoJSUN4MtRWIwUF4mIKd63eAqXRccmdd
	t4e2bk0u+k5YTpwi45Dz8ygVCJloyHdpWbN3GSXQ03TmSlwqZ3aBrG+oExTkG4v2m9KY/6YWU0/
	/lJISOM5n8PEmBWbSKHV9jypxLWkE6/Tu9zNkKjEu3z5scccaRue7f677kfDNwQNrH7uK9nLa+O
	hN8Hz1GazFQSPj505pdznnntPrdvdvWQeliHS0ivnDGgJD/VHexcFgVFLb/gvmYBMhlg==
X-Google-Smtp-Source: AGHT+IFFNhrMbTNB0Q3xJmGoN6F0gG6canzsYADBUluChTG+oWJ9laxHB5t7tS2c/gz6dkye21lDPg==
X-Received: by 2002:a05:600c:4704:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47d6ba8900dmr103912295e9.16.1767609216091;
        Mon, 05 Jan 2026 02:33:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d452a3bsm142583955e9.11.2026.01.05.02.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 02:33:35 -0800 (PST)
Message-ID: <c0ccc3e8-7863-47b0-abf9-99c3dba0f4eb@gmail.com>
Date: Mon, 5 Jan 2026 10:33:34 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Paul Tarjan <paul@paultarjan.com>, Paul Tarjan <github@paulisageek.com>
References: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
 <pull.2149.v3.git.git.1767472809897.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2149.v3.git.git.1767472809897.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul

Thanks for rewording the commit message. This looks good - it will be 
nice to have one less flaky test to worry about when the CI fails

Phillip

On 03/01/2026 20:40, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> The "difftool --dir-diff syncs worktree without unstaged change" test
> fails intermittently on Windows CI, as seen at:
> 
>    https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
> 
> The root cause is that the original file content and the replacement
> content have identical sizes:
> 
>    - Original: "main\ntest\na\n" = 12 bytes
>    - New:      "new content\n"   = 12 bytes
> 
> When difftool's sync-back mechanism checks for changes, it compares
> stat data between the temporary index and the modified files. If the
> modification happens within the same timestamp granularity window and
> file size stays the same, the change goes undetected.
> 
> On Windows, this is more likely to manifest because Git relies on
> inode changes as a fallback when other stat fields match, but Windows
> filesystems lack inodes. This is a real bug that could affect users
> scripting difftool similarly, as seen at:
> 
>    https://github.com/git-for-windows/git/issues/5132
> 
> Fix the test by changing the replacement content to "modified content"
> (17 bytes), ensuring the size difference is detected regardless of
> timestamp resolution or platform-specific stat behavior.
> 
> Note: This fixes the test flakiness but not the underlying issue in
> difftool's change detection. Other tests with same-size file patterns
> (t0010-racy-git.sh, t2200-add-update.sh) are not affected because they
> use normal index operations with proper racy-git detection.
> 
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>      t7800: fix racy "difftool --dir-diff syncs worktree" test
>      
>      The "difftool --dir-diff syncs worktree without unstaged change" test
>      fails intermittently on Windows CI, as seen at:
>      
>      https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
>      
>      The root cause is that the original file content and the replacement
>      content have identical sizes:
>      
>       * Original: "main\ntest\na\n" = 12 bytes
>       * New: "new content\n" = 12 bytes
>      
>      When difftool's sync-back mechanism checks for changes, it compares stat
>      data between the temporary index and the modified files. If the
>      modification happens within the same timestamp granularity window and
>      file size stays the same, the change goes undetected.
>      
>      On Windows, this is more likely to manifest because Git relies on inode
>      changes as a fallback when other stat fields match, but Windows
>      filesystems lack inodes. This is a real bug that could affect users
>      scripting difftool similarly (see
>      https://github.com/git-for-windows/git/issues/5132 for a related
>      real-world report).
>      
>      Fix the test by changing the replacement content to "modified content"
>      (17 bytes), ensuring the size difference is detected regardless of
>      timestamp resolution or platform-specific stat behavior.
>      
>      Note: This fixes the test flakiness but not the underlying issue in
>      difftool's change detection. Other tests with same-size file patterns
>      (t0010-racy-git.sh, t2200-add-update.sh) are not affected because they
>      use normal index operations with proper racy-git detection.
>      
>      Changes since v2
>      
>       * Added Reviewed-by to the commit message
>       * Updated URL to be a full link to github
>       * Reduced speculation from commit message
>      
>      Changes since v1
>      
>       * Added Reviewed-by
>      
>      Signed-off-by: Paul Tarjan github@paulisageek.com Reviewed-by: Johannes
>      Schindelin Johannes.Schindelin@gmx.de
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2149%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149/ptarjan/claude/fix-difftool-test-DDxDC-v3
> Pull-Request: https://github.com/git/git/pull/2149
> 
> Range-diff vs v2:
> 
>   1:  98bc88f336 ! 1:  3e43dcc7fd t7800: fix racy "difftool --dir-diff syncs worktree" test
>       @@ Commit message
>            t7800: fix racy "difftool --dir-diff syncs worktree" test
>        
>            The "difftool --dir-diff syncs worktree without unstaged change" test
>       -    fails intermittently, particularly on Windows CI.
>       +    fails intermittently on Windows CI, as seen at:
>        
>       -    The test modifies a file in difftool's temp directory via an extcmd
>       -    script and expects the change to be synced back to the worktree. The
>       -    sync-back detection relies on git's change detection mechanisms.
>       +      https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
>        
>            The root cause is that the original file content and the replacement
>            content have identical sizes:
>       @@ Commit message
>              - Original: "main\ntest\na\n" = 12 bytes
>              - New:      "new content\n"   = 12 bytes
>        
>       -    When difftool creates the temporary index (wtindex), the cache entries
>       -    have sd_size = 0 (zero-initialized via make_cache_entry with no
>       -    refresh). Git's ie_modified() is designed to handle this by calling
>       -    ce_modified_check_fs() for content hashing when sd_size is 0.
>       +    When difftool's sync-back mechanism checks for changes, it compares
>       +    stat data between the temporary index and the modified files. If the
>       +    modification happens within the same timestamp granularity window and
>       +    file size stays the same, the change goes undetected.
>        
>       -    However, Windows has known filesystem issues that may cause this to
>       -    fail intermittently:
>       +    On Windows, this is more likely to manifest because Git relies on
>       +    inode changes as a fallback when other stat fields match, but Windows
>       +    filesystems lack inodes. This is a real bug that could affect users
>       +    scripting difftool similarly, as seen at:
>        
>       -     - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
>       -       same information as lstat() after close (config.mak.uname:506)
>       +      https://github.com/git-for-windows/git/issues/5132
>        
>       -     - NTFS timestamp issues: The racy-git documentation notes that NTFS
>       -       is "still broken" regarding timestamp granularity between in-core
>       -       and on-disk representations (Documentation/technical/racy-git.adoc)
>       +    Fix the test by changing the replacement content to "modified content"
>       +    (17 bytes), ensuring the size difference is detected regardless of
>       +    timestamp resolution or platform-specific stat behavior.
>        
>       -     - Attribute caching: Windows GetFileAttributesExW may cache results
>       -
>       -    Fix this by changing the replacement content to "modified content\n"
>       -    (17 bytes), ensuring the change is detected at the earliest size
>       -    comparison in match_stat_data(), bypassing any platform-specific edge
>       -    cases in the more complex code paths.
>       -
>       -    Note: Other tests with same-size file patterns (t0010-racy-git.sh,
>       -    t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
>       -    because they use normal Git index operations with proper racy git
>       -    detection. The difftool case is unique due to its ephemeral wtindex
>       -    created via make_cache_entry() without full stat refresh.
>       +    Note: This fixes the test flakiness but not the underlying issue in
>       +    difftool's change detection. Other tests with same-size file patterns
>       +    (t0010-racy-git.sh, t2200-add-update.sh) are not affected because they
>       +    use normal index operations with proper racy-git detection.
>        
>            Signed-off-by: Paul Tarjan <github@paulisageek.com>
>       +    Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        
>         ## t/t7800-difftool.sh ##
>        @@ t/t7800-difftool.sh: test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged ch
> 
> 
>   t/t7800-difftool.sh | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index bf0f67378d..8a91ff3603 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -647,21 +647,21 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged ch
>   '
>   
>   write_script modify-right-file <<\EOF
> -echo "new content" >"$2/file"
> +echo "modified content" >"$2/file"
>   EOF
>   
>   run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
>   	test_when_finished git reset --hard &&
>   	echo "orig content" >file &&
>   	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
> -	echo "new content" >expect &&
> +	echo "modified content" >expect &&
>   	test_cmp expect file
>   '
>   
>   run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
>   	test_when_finished git reset --hard &&
>   	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
> -	echo "new content" >expect &&
> +	echo "modified content" >expect &&
>   	test_cmp expect file
>   '
>   
> 
> base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe

