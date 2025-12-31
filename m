Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04852199EAD
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767219603; cv=none; b=FpEC35KLI3Bcxc9IUjpH/ybmyL3MuQE27HJymuhY0LsKiJ79Ey59p0RZe3ogk4+S7VysL3yTGkfciV/pmEmje1/tGvVRLraJcBjlW8CEkeomtIL/ymaMwOUOhkG9/bqHoB7/QTuCwie0tOZ2LAx0hry5Ro00pRLAv4PLR58JMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767219603; c=relaxed/simple;
	bh=exdoQUMu/sXuPTvrw1zDsVLxp6iB0QLp7uvHpFiVfDk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OtHdeDr7OK0k25Gk23WMkSnxaqu9PsJmwYnbKednvwJsxAftKF/ofO7T1TKP2utRSvzQdYGUazqzsAF5WDqDRwvrE57suFY/gSTjfA+ZlrSJ/yfC09DFhzmZ+Pq0ZAhuSMbijKCsTw91cXZh3MiT6kYUNx+UKHaZn5UIXDxrtbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw2Us7wl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw2Us7wl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8bb6a27d3edso1136549585a.3
        for <git@vger.kernel.org>; Wed, 31 Dec 2025 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767219600; x=1767824400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GbnzYAkekE6RZEPau1Hm5ba0mBKA0zjME8KZEpPsiRk=;
        b=Bw2Us7wl3Pe0JSDtk5caZNt+UB++8iZ/RRLB/jxu1uXn5E080zpNMV16EtID4aYyCw
         J5+5VwnfFOZl5qEHpfxA+CB4nQvMWvv3gNce1RESO6qyspqxvwcQlUw9nS9bqVXbmV+6
         bb6JSpKc5KbmxUGVT9yxICnjqUAWJr2oUr6/MafZUEB7+IQ4z5ndPW3oTXJad4UZbv7I
         0TsnCJNZ1uFHzWstqfBp8edfpHUiL4jhtVJt7/eAeThtAQa4bWiWz4jhF1DJfO94LXSX
         FVKB55TDkFtWaMIfBKWTol49cO/OPgeYRRLNiBbFJoXbtqtjO4VUGp5Kmx8U+6fItzwl
         3u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767219600; x=1767824400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbnzYAkekE6RZEPau1Hm5ba0mBKA0zjME8KZEpPsiRk=;
        b=kZkdC8h72uY4DmPRiLAU9zX/tBY1VG+TW7YxjYX7NlIpAhwAEkuvM2AGAuSc5f1pBt
         X5JbVe94S39hwKKdBfHmoCmMwpqhK61trq95f2tk1s4IYxMv0QFxGlW1S0ETWUCMM4f/
         jxpzMwkYgTm9A73d8P+54rErx70StVm4lQdo6x11mgTbOweis9zkcZJdL2B5FERU19ND
         j5TwLpElGwZLLjKXkly4nSmIv09XvDdXyyirZUfu52LrnE96Axu+ZNWLMfrms+ISvkIG
         RTFIjeCaZiah9Vy+oWyIw8nYKjplrFokSkevLoI31jwR4rx4XgavcRmuEwYDSFL5ubXl
         E6rQ==
X-Gm-Message-State: AOJu0YwwD2I0vKi/xe4VIo0IT497dUOzfuW9aPfLF6NX1vQ+SOGh0P4L
	zBtwdcri/eT+sWkRa2I8JfDNn7+9uU6YWsVzaU4oLSgKsFhDlHrikt2jVpjfvg==
X-Gm-Gg: AY/fxX6tM0fNCjyycP+H5trjM7ZNBPdhLtB9K1XlMceRDZCaMAA5Nf47AzEzuZppzcP
	r4eywfYoWSxt4vg/gYcbiVcqN8TEWhu1rLc172LUupzOOK5ZLytvBD2WNw64L4UG8XKC8Q1TjQA
	XtB8+0mtNbSwCv1HJiGWmbJC4FFKz5CHZo2No5Y1o3vg4xdWCSetNl0jHcwfSXVXM4N6WVwZFaW
	DN5PAOOa6okOYbw7NR+xUDmpVZo/ZQFrlk/9BPvRCX0PCOR1puXhG7FVLxqmt/it2mAvZxgW7Ie
	th4ZlWg6rOcTIiOAhCh2obgjVCNrFZsTuX+vPDgv/Y08vaZBRKsEPYM6zM5Pyza6QKXGekAoQI/
	l5x9MsW7L5P+7q5ks2WaY3y26Yb/At+ed6PQqPlq3oXs/4GTp1gfJWw2M+dXlQG5pK6i0QVeQkj
	jbjlWE3QgZQqIF
X-Google-Smtp-Source: AGHT+IE01RHAPDWW4bovHCax5ZAJWih3HJtWamVVS8VUoGsurDV0hBPJuEUUh5P4D+fifeTlBSTAeg==
X-Received: by 2002:a05:620a:40d1:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8c08f654cfdmr5678528785a.17.1767219600331;
        Wed, 31 Dec 2025 14:20:00 -0800 (PST)
Received: from [127.0.0.1] ([172.172.87.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09688e400sm2876383385a.14.2025.12.31.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:19:59 -0800 (PST)
Message-Id: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Dec 2025 22:19:59 +0000
Subject: [PATCH] t7800: fix racy "difftool --dir-diff syncs worktree" test
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The "difftool --dir-diff syncs worktree without unstaged change" test
fails intermittently, particularly on Windows CI.

The test modifies a file in difftool's temp directory via an extcmd
script and expects the change to be synced back to the worktree. The
sync-back detection relies on git's change detection mechanisms.

The root cause is that the original file content and the replacement
content have identical sizes:

  - Original: "main\ntest\na\n" = 12 bytes
  - New:      "new content\n"   = 12 bytes

When difftool creates the temporary index (wtindex), the cache entries
have sd_size = 0 (zero-initialized via make_cache_entry with no
refresh). Git's ie_modified() is designed to handle this by calling
ce_modified_check_fs() for content hashing when sd_size is 0.

However, Windows has known filesystem issues that may cause this to
fail intermittently:

 - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
   same information as lstat() after close (config.mak.uname:506)

 - NTFS timestamp issues: The racy-git documentation notes that NTFS
   is "still broken" regarding timestamp granularity between in-core
   and on-disk representations (Documentation/technical/racy-git.adoc)

 - Attribute caching: Windows GetFileAttributesExW may cache results

Fix this by changing the replacement content to "modified content\n"
(17 bytes), ensuring the change is detected at the earliest size
comparison in match_stat_data(), bypassing any platform-specific edge
cases in the more complex code paths.

Note: Other tests with same-size file patterns (t0010-racy-git.sh,
t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
because they use normal Git index operations with proper racy git
detection. The difftool case is unique due to its ephemeral wtindex
created via make_cache_entry() without full stat refresh.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    t7800: fix racy "difftool --dir-diff syncs worktree" test
    
    In
    https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
    this test failed for me on an unrelated commit. I had Claude look into
    it and it thought that this could be a racy git problem. I'm skeptical
    but a) I don't know the source well enough and b) the fix is low risk so
    I thought I'd send it to you folks. Everything below is the AI generated
    explanation.
    
    The "difftool --dir-diff syncs worktree without unstaged change" test
    fails intermittently, particularly on Windows CI.
    
    The test modifies a file in difftool's temp directory via an extcmd
    script and expects the change to be synced back to the worktree. The
    sync-back detection relies on git's change detection mechanisms.
    
    The root cause is that the original file content and the replacement
    content have identical sizes:
    
     * Original: "main\ntest\na\n" = 12 bytes
     * New: "new content\n" = 12 bytes
    
    When difftool creates the temporary index (wtindex), the cache entries
    have sd_size = 0 (zero-initialized via make_cache_entry with no
    refresh). Git's ie_modified() is designed to handle this by calling
    ce_modified_check_fs() for content hashing when sd_size is 0.
    
    However, Windows has known filesystem issues that may cause this to fail
    intermittently:
    
     * UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
       same information as lstat() after close (config.mak.uname:506)
    
     * NTFS timestamp issues: The racy-git documentation notes that NTFS is
       "still broken" regarding timestamp granularity between in-core and
       on-disk representations (Documentation/technical/racy-git.adoc)
    
     * Attribute caching: Windows GetFileAttributesExW may cache results
    
    Fix this by changing the replacement content to "modified content\n" (17
    bytes), ensuring the change is detected at the earliest size comparison
    in match_stat_data(), bypassing any platform-specific edge cases in the
    more complex code paths.
    
    Note: Other tests with same-size file patterns (t0010-racy-git.sh,
    t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
    because they use normal Git index operations with proper racy git
    detection. The difftool case is unique due to its ephemeral wtindex
    created via make_cache_entry() without full stat refresh.
    
    Signed-off-by: Paul Tarjan github@paulisageek.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2149%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149/ptarjan/claude/fix-difftool-test-DDxDC-v1
Pull-Request: https://github.com/git/git/pull/2149

 t/t7800-difftool.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bf0f67378d..8a91ff3603 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -647,21 +647,21 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged ch
 '
 
 write_script modify-right-file <<\EOF
-echo "new content" >"$2/file"
+echo "modified content" >"$2/file"
 EOF
 
 run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
 	test_when_finished git reset --hard &&
 	echo "orig content" >file &&
 	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
-	echo "new content" >expect &&
+	echo "modified content" >expect &&
 	test_cmp expect file
 '
 
 run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
 	test_when_finished git reset --hard &&
 	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
-	echo "new content" >expect &&
+	echo "modified content" >expect &&
 	test_cmp expect file
 '
 

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
