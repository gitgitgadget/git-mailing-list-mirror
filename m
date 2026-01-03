Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E525247280
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433153; cv=none; b=HLAGNyQksWCQYEx4DcQMijN6Qjhd0Ufn38cXvg1sEsiCnX+nQXe6H/LC+zMU8qBZsp0XUJQnlH8gBxOGVhjgXVt8uVm3LdnIc5/eySh2rFSIg1T4WDyzB9XUdO1WeOl6aOCxyzHPzlsHTt6qtKA0Ud0dtCtB9ZNnMfqjtaWJf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433153; c=relaxed/simple;
	bh=UQCIgK+OftUNFAwNhGqvV7Bmb5L53KwqxOcFpvADgeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRuMSWr/1DwVbJUagUHg5JQ4pkSqD0PwM45mV59HPJHgudQOMwxrhxN1Hx/3TALwvCpOtWIbl2gv+iFq2vu1PRQy/6UOkI0ueEiLI6hRteppYWzqvOpYwbAhYmEHJkP0p4kPsuOV+6Lc3+XNBDSeJfq9YxyoZChDE+rO6aGwStE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mxhv87Yn; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxhv87Yn"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so6019895f8f.2
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767433148; x=1768037948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GQoKIhePSv8bW6wM11KPiZTmLlCrUd9gm0M2Qt0M3wU=;
        b=Mxhv87Ynb6ScNHjmNSc9ddU7sTDHsb8wP++MYeJN4nG8jUC5M10vVrFKI3nDyfevVE
         m9ZNXhhXueif52IQ/Wo4o/F04gxZxwcPinjiJexJlUOZXUJrlK84zTr2phXNW+etYXTk
         xDz+HkptT/wgP9psnhuPqraNhrJPOZs5EXPmuCK0cq40tbWI402Es3mkNTqtPV1Hnfg4
         c6esjJxwRlerW3cEETaDZGqZ/nHg6ZUHvR4LYbDTNZR6C2xTeQLIP4LcGVruTAMiqJKi
         mE6qzaFH+/EtIzRIbCr9B5axERKNy/ZUw16TZgYmCNyf5vdfiafqpV6JJypDtCxGmzcS
         +1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767433148; x=1768037948;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQoKIhePSv8bW6wM11KPiZTmLlCrUd9gm0M2Qt0M3wU=;
        b=Aowfhj0LZJGNegIdWjIh6rDPEXWR+tgmyEEuRjl+KKmyxxUch+bljzoEwTycogRuvi
         If8CpY4anKNPGCJKKp97otOQnvzhp6uti9sCS8hiwtF3kBz+l0ss9gbhd3/FfTwn5mav
         s5VxFJXwcLeRjXQwWmjoEAYGmpKYUnvP2YNfyvy549U98hMMCFtULtAkuWH/UZqeeGNH
         Ny75dK4iIb3GU30GmHCBGl+ujoiWKwoIHHxcEoTK+sbrbTws252tOeBASGcJXdSTNSWL
         TSbr/wE2Y6MgQ84EJEC0RuWK1sdcEi6pAgFWjIEqngxm4i4cARNOqjntOp6lUnio6vU1
         b8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVhI18/g7z3l9m3QPpxQuDtmbhaXgHzsZETwXUeSyfh9hyRkSUTN4N+WXaZ8o7Gtjq2N+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdin7EKVbU45C4t2S8zCeYsLc8FM6T4J0r9q14g71HjG/YvS3l
	AIM9c20LR6P/dqvtCYbbx6XSJu2UzmIqifBpnGQRgoTS3QFabdBWhsi+
X-Gm-Gg: AY/fxX7A6Y7z98snBo+gkwNjck9y4Ydu/Iu3kuK7TbDkYGuflndlul9/JOjBN5iAifi
	FO7fd7n6ICI73OvCKsSO+cZ0bKfyALrPMQcD67xBIArYe5dnCYCm6nNviqN2LrdYT1qPeMRKbDW
	v6fRGxIo4BRJOs33N2q/lEaLkGrX4xxjTvJkdqCtYnmLcVDusvLTiCgL9C/Mf9mw4MvOI1Kc00+
	04nJbLoaKYho1KojFFzpM7ICPErJzbfElMrh6Yk4vMEPXKvD1MNQcnx23Ekus/Sfw1wUoQ6mzT0
	lB63/ULzZ+VpoZDFus3hWg6pZY2EGGoJRtMiSg8OmH3hl7X1ZIjtZC9tF+/zwbo0lcG5TMRzKh8
	RYFKW9pbT2FHF7DqkancmxPcshnO9tLwU2GIwr3FzDWh4V52VgFprSTsAOXPyt9i8Tnh45YPutK
	H25/OW/1uwHn0ylf0aTAqhFs/NtztmJ190RIzqSEGs/DFUXi5MAv/BFM88rodAJ3sHYA==
X-Google-Smtp-Source: AGHT+IHjmlPW8eKnnNTIz//dUfw6YKugNNhipH5CqTq+uyY2b7R3Wv8oVblMQXcxamjEdK3NnORG5Q==
X-Received: by 2002:a05:6000:3113:b0:42f:bb4a:9989 with SMTP id ffacd0b85a97d-4324e4d0fc1mr49619396f8f.28.1767433148118;
        Sat, 03 Jan 2026 01:39:08 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm87761169f8f.22.2026.01.03.01.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 01:39:07 -0800 (PST)
Message-ID: <02749b7d-e9a4-4894-a50c-91a7c1a22d84@gmail.com>
Date: Sat, 3 Jan 2026 09:39:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Paul Tarjan <github@paulisageek.com>
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
 <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul

On 01/01/2026 18:27, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> The "difftool --dir-diff syncs worktree without unstaged change" test
> fails intermittently, particularly on Windows CI.

Thanks for working on this. I've seen it fail a lot in Windows CI runs - 
does it fail on other platforms as well?

> The test modifies a file in difftool's temp directory via an extcmd
> script and expects the change to be synced back to the worktree. The
> sync-back detection relies on git's change detection mechanisms.
> 
> The root cause is that the original file content and the replacement
> content have identical sizes:
> 
>    - Original: "main\ntest\na\n" = 12 bytes
>    - New:      "new content\n"   = 12 bytes
> 
> When difftool creates the temporary index (wtindex), the cache entries
> have sd_size = 0 (zero-initialized via make_cache_entry with no
> refresh). Git's ie_modified() is designed to handle this by calling
> ce_modified_check_fs() for content hashing when sd_size is 0.
> > However, Windows has known filesystem issues that may cause this to
> fail intermittently:
> 
>   - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
>     same information as lstat() after close (config.mak.uname:506)

As I understand it the test is flaky because the file is updated without 
changing any of the stat fields that git looks at. How does that relate 
to fstat() returning different data to lstat()? Also doesn't 
UNRELIABLE_FSTAT exist so that we can work around the problem?

>   - NTFS timestamp issues: The racy-git documentation notes that NTFS
>     is "still broken" regarding timestamp granularity between in-core
>     and on-disk representations (Documentation/technical/racy-git.adoc)

That comment is specifically talking about linux so how does it relate 
to a test that is flaky on Windows?

>   - Attribute caching: Windows GetFileAttributesExW may cache results

When git refreshes the index it calls lstat() on each path in the index. 
GitFileAttributesExW() provides an API like readir() which returns paths 
in an arbitary order and it also resolves symbolic links so I'm having a 
hard time understating where it is called by git. (There was a post [1] 
on reddit recently about using GitFileAttributesExW in this context)

[1] 
https://www.reddit.com/r/rust/comments/1prkzqg/writing_the_fastest_implementation_of_git_status/

> Fix this by changing the replacement content to "modified content\n"
> (17 bytes), ensuring the change is detected at the earliest size
> comparison in match_stat_data(), bypassing any platform-specific edge
> cases in the more complex code paths.

This stops the test from being flaky but it is a real bug. If the user 
is modifying the files interactively then they're unlikely to be able to 
update the file fast enough to be affected but if anyone is scripting 
like the test does then they might be affected.

Thanks

Phillip

> Note: Other tests with same-size file patterns (t0010-racy-git.sh,
> t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
> because they use normal Git index operations with proper racy git
> detection. The difftool case is unique due to its ephemeral wtindex
> created via make_cache_entry() without full stat refresh.
> 
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>      t7800: fix racy "difftool --dir-diff syncs worktree" test
>      
>      In
>      https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
>      this test failed for me on an unrelated commit. I had Claude look into
>      it and it thought that this could be a racy git problem. I'm skeptical
>      but a) I don't know the source well enough and b) the fix is low risk so
>      I thought I'd send it to you folks. Everything below is the AI generated
>      explanation.
>      
>      The "difftool --dir-diff syncs worktree without unstaged change" test
>      fails intermittently, particularly on Windows CI.
>      
>      The test modifies a file in difftool's temp directory via an extcmd
>      script and expects the change to be synced back to the worktree. The
>      sync-back detection relies on git's change detection mechanisms.
>      
>      The root cause is that the original file content and the replacement
>      content have identical sizes:
>      
>       * Original: "main\ntest\na\n" = 12 bytes
>       * New: "new content\n" = 12 bytes
>      
>      When difftool creates the temporary index (wtindex), the cache entries
>      have sd_size = 0 (zero-initialized via make_cache_entry with no
>      refresh). Git's ie_modified() is designed to handle this by calling
>      ce_modified_check_fs() for content hashing when sd_size is 0.
>      
>      However, Windows has known filesystem issues that may cause this to fail
>      intermittently:
>      
>       * UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
>         same information as lstat() after close (config.mak.uname:506)
>      
>       * NTFS timestamp issues: The racy-git documentation notes that NTFS is
>         "still broken" regarding timestamp granularity between in-core and
>         on-disk representations (Documentation/technical/racy-git.adoc)
>      
>       * Attribute caching: Windows GetFileAttributesExW may cache results
>      
>      Fix this by changing the replacement content to "modified content\n" (17
>      bytes), ensuring the change is detected at the earliest size comparison
>      in match_stat_data(), bypassing any platform-specific edge cases in the
>      more complex code paths.
>      
>      Note: Other tests with same-size file patterns (t0010-racy-git.sh,
>      t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
>      because they use normal Git index operations with proper racy git
>      detection. The difftool case is unique due to its ephemeral wtindex
>      created via make_cache_entry() without full stat refresh.
>      
>      Signed-off-by: Paul Tarjan github@paulisageek.com Reviewed-by: Johannes
>      Schindelin Johannes.Schindelin@gmx.de
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2149%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149/ptarjan/claude/fix-difftool-test-DDxDC-v2
> Pull-Request: https://github.com/git/git/pull/2149
> 
> Range-diff vs v1:
> 
>   1:  dd5b774451 = 1:  98bc88f336 t7800: fix racy "difftool --dir-diff syncs worktree" test
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

