Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF320C00C
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767472816; cv=none; b=mCMYlAP8BjPjB1ZzjTZ4Jdsa1p/8jOEkplINuVGT63uiVkXS3ELo0qvDJEmn+URksyL+aPAFQ1GR0CRR2kb7J6fv5f/IbKlpTTQ/PvGbir66ex1R2PZg+r3uzEi+Oquafqo2TnR8dGsr9EPCyJBvbzO6/7vcqtk5rjYsGxYRsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767472816; c=relaxed/simple;
	bh=XlE7PoVU+gJfA+fnGrYo22pkdRQxn6VNSPLMlucTmcg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FyYOqDdtTxECXiq9I0BOJwlQPycvyV9YFWp0NICl4R5XhKI4NM0dSPqlRdQe3P/GFOJwnX7fb/6fAjFRi5nbipQZdDoUMTUpY+I/gXcXRu6OeuWmob/3HIQNvte5Kz5u7BsF7UygcmCFxHUqb9LaLJT2GJcYquQqBCtveTxU0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIH/rNB0; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIH/rNB0"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4510974a8cdso7023901b6e.0
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767472813; x=1768077613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfJl3whulbD35uyXEXpxTbkPFc6l4RyvQlcfqI5CXmI=;
        b=fIH/rNB0zGufJh195CJFb9oX/th38qXPFbHiqSsGC6CML1+e/McCL9Qimo1lQBMaXu
         ZOahnnwaXWqHRFATC04RtjUq4pwHtR+yXG+885FEXLYVlN8bxngS+Brj/B6fLhTeEj+W
         9cYudFhsz/4EeU0dAgazrgxMI/G4GeVKArBtmze4+coy7RBZXCfKe6BxTJHrmt86VwGm
         jkrITxZ1xJnnM8GOZ7FAV90u3O6EWj9kJn6YcspZSKbbcRuEh47zg/elYG1WiKXCj30z
         eXx9plwVyaSwmuWp2S8tNW7r8yOQXPXANLbNw6nuC5E7HSejci0hA8TH/rTwxq0NNZMR
         SHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767472813; x=1768077613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfJl3whulbD35uyXEXpxTbkPFc6l4RyvQlcfqI5CXmI=;
        b=nR8SWw51fx/WTWqNEBxLaFWpAg0rcVHq59GgPbGEO9KvoXpIlYQ55LnxQNEPxRX8CM
         Ael9fJpB5p6qgTLQq07OZREdzIn4NzCH6B+4g91E7M2LwB8noJSq+jd5+JRp+cFkX1fM
         vj1lJ46XLG8oNQgtp+bcOJIBPEKZKnJsx1sVLmpDbXOYUg0QC5g+BmjIB8sKvcXQAhbP
         SCUqKgFdyXKYRijJ0ZJ8r7FpCUQjZRiJTcHGA3Y3S/VV7dUjmf6rEEuqZMRa8/PTjWrn
         6Kyurpv3meuGAUUK93VJE55BUdH0W1EMGp5mJSxT/MlwZtfl2cBwXtA3LYxJHRF1U0uf
         K2uA==
X-Gm-Message-State: AOJu0YyA4wVfqgiM6Q2PH5YmLevz2swfgzT8ubQp9m5+6KO0kmWPS6ft
	mqtO6GRGjyRBdtNAvlkMnR9el5+OTFU31nNrQ+Q1a4Hr4LUwXlyI7HjPgzS1og==
X-Gm-Gg: AY/fxX7u2dSpGq2OV7seW7lEvKM3TCzA98CBjHcgzQKkUf9lG45lfBBg9hb2R/26pwo
	4iH92g5KbdzOIKC/E+hHZsLel5taiFQFXNd1yT4teiR4CKe3QFhLxnpQuLiCakh+kQ/ezgANYQT
	4RJy6OBneXCKtthTbtYPU39xb5k7c7Q5uxv6F2qvAasI6uNfhX+XViU1P4H+4Ff92bJNrWWyv1v
	3/KpuwZ4loAi4u+vGAFabX2NXkoqkyHUgKYzEIcHpH3R789gDutrfJ8EQ7i/3XigmwLnGVLCLJR
	sbSFBD2VuWNonC6SJAFExd1oWmFmxxfUcrhHAYNUd1j2X76IphH2xllGPFGpaEFSBEN+t3qYtmM
	lpRxO8yHDmV/VVxMRcI+x5hdsGtb3DW9KPf0tGCPXOOblbnD8OJTW0fyz0hu5Fe+U4hHSrHYSqN
	pjGC1PKwjjG2hp+Q==
X-Google-Smtp-Source: AGHT+IEJtLJos/zmfuHsS8f5+m8fIvo2ZHtPOvL//uw5L3URy/Tck7ZkBFifbgTfoibodRgRxwwlcg==
X-Received: by 2002:a05:6808:1781:b0:44f:e512:4ca2 with SMTP id 5614622812f47-457b1fc8d8bmr21885136b6e.40.1767472812912;
        Sat, 03 Jan 2026 12:40:12 -0800 (PST)
Received: from [127.0.0.1] ([52.176.138.179])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b4c463e5sm21572844b6e.4.2026.01.03.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 12:40:11 -0800 (PST)
Message-Id: <pull.2149.v3.git.git.1767472809897.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 20:40:09 +0000
Subject: [PATCH v3] t7800: fix racy "difftool --dir-diff syncs worktree" test
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The "difftool --dir-diff syncs worktree without unstaged change" test
fails intermittently on Windows CI, as seen at:

  https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416

The root cause is that the original file content and the replacement
content have identical sizes:

  - Original: "main\ntest\na\n" = 12 bytes
  - New:      "new content\n"   = 12 bytes

When difftool's sync-back mechanism checks for changes, it compares
stat data between the temporary index and the modified files. If the
modification happens within the same timestamp granularity window and
file size stays the same, the change goes undetected.

On Windows, this is more likely to manifest because Git relies on
inode changes as a fallback when other stat fields match, but Windows
filesystems lack inodes. This is a real bug that could affect users
scripting difftool similarly, as seen at:

  https://github.com/git-for-windows/git/issues/5132

Fix the test by changing the replacement content to "modified content"
(17 bytes), ensuring the size difference is detected regardless of
timestamp resolution or platform-specific stat behavior.

Note: This fixes the test flakiness but not the underlying issue in
difftool's change detection. Other tests with same-size file patterns
(t0010-racy-git.sh, t2200-add-update.sh) are not affected because they
use normal index operations with proper racy-git detection.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
    t7800: fix racy "difftool --dir-diff syncs worktree" test
    
    The "difftool --dir-diff syncs worktree without unstaged change" test
    fails intermittently on Windows CI, as seen at:
    
    https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
    
    The root cause is that the original file content and the replacement
    content have identical sizes:
    
     * Original: "main\ntest\na\n" = 12 bytes
     * New: "new content\n" = 12 bytes
    
    When difftool's sync-back mechanism checks for changes, it compares stat
    data between the temporary index and the modified files. If the
    modification happens within the same timestamp granularity window and
    file size stays the same, the change goes undetected.
    
    On Windows, this is more likely to manifest because Git relies on inode
    changes as a fallback when other stat fields match, but Windows
    filesystems lack inodes. This is a real bug that could affect users
    scripting difftool similarly (see
    https://github.com/git-for-windows/git/issues/5132 for a related
    real-world report).
    
    Fix the test by changing the replacement content to "modified content"
    (17 bytes), ensuring the size difference is detected regardless of
    timestamp resolution or platform-specific stat behavior.
    
    Note: This fixes the test flakiness but not the underlying issue in
    difftool's change detection. Other tests with same-size file patterns
    (t0010-racy-git.sh, t2200-add-update.sh) are not affected because they
    use normal index operations with proper racy-git detection.
    
    Changes since v2
    
     * Added Reviewed-by to the commit message
     * Updated URL to be a full link to github
     * Reduced speculation from commit message
    
    Changes since v1
    
     * Added Reviewed-by
    
    Signed-off-by: Paul Tarjan github@paulisageek.com Reviewed-by: Johannes
    Schindelin Johannes.Schindelin@gmx.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2149%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149/ptarjan/claude/fix-difftool-test-DDxDC-v3
Pull-Request: https://github.com/git/git/pull/2149

Range-diff vs v2:

 1:  98bc88f336 ! 1:  3e43dcc7fd t7800: fix racy "difftool --dir-diff syncs worktree" test
     @@ Commit message
          t7800: fix racy "difftool --dir-diff syncs worktree" test
      
          The "difftool --dir-diff syncs worktree without unstaged change" test
     -    fails intermittently, particularly on Windows CI.
     +    fails intermittently on Windows CI, as seen at:
      
     -    The test modifies a file in difftool's temp directory via an extcmd
     -    script and expects the change to be synced back to the worktree. The
     -    sync-back detection relies on git's change detection mechanisms.
     +      https://github.com/git/git/actions/runs/20624095002/job/59231745784#step:5:416
      
          The root cause is that the original file content and the replacement
          content have identical sizes:
     @@ Commit message
            - Original: "main\ntest\na\n" = 12 bytes
            - New:      "new content\n"   = 12 bytes
      
     -    When difftool creates the temporary index (wtindex), the cache entries
     -    have sd_size = 0 (zero-initialized via make_cache_entry with no
     -    refresh). Git's ie_modified() is designed to handle this by calling
     -    ce_modified_check_fs() for content hashing when sd_size is 0.
     +    When difftool's sync-back mechanism checks for changes, it compares
     +    stat data between the temporary index and the modified files. If the
     +    modification happens within the same timestamp granularity window and
     +    file size stays the same, the change goes undetected.
      
     -    However, Windows has known filesystem issues that may cause this to
     -    fail intermittently:
     +    On Windows, this is more likely to manifest because Git relies on
     +    inode changes as a fallback when other stat fields match, but Windows
     +    filesystems lack inodes. This is a real bug that could affect users
     +    scripting difftool similarly, as seen at:
      
     -     - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
     -       same information as lstat() after close (config.mak.uname:506)
     +      https://github.com/git-for-windows/git/issues/5132
      
     -     - NTFS timestamp issues: The racy-git documentation notes that NTFS
     -       is "still broken" regarding timestamp granularity between in-core
     -       and on-disk representations (Documentation/technical/racy-git.adoc)
     +    Fix the test by changing the replacement content to "modified content"
     +    (17 bytes), ensuring the size difference is detected regardless of
     +    timestamp resolution or platform-specific stat behavior.
      
     -     - Attribute caching: Windows GetFileAttributesExW may cache results
     -
     -    Fix this by changing the replacement content to "modified content\n"
     -    (17 bytes), ensuring the change is detected at the earliest size
     -    comparison in match_stat_data(), bypassing any platform-specific edge
     -    cases in the more complex code paths.
     -
     -    Note: Other tests with same-size file patterns (t0010-racy-git.sh,
     -    t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
     -    because they use normal Git index operations with proper racy git
     -    detection. The difftool case is unique due to its ephemeral wtindex
     -    created via make_cache_entry() without full stat refresh.
     +    Note: This fixes the test flakiness but not the underlying issue in
     +    difftool's change detection. Other tests with same-size file patterns
     +    (t0010-racy-git.sh, t2200-add-update.sh) are not affected because they
     +    use normal index operations with proper racy-git detection.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
     +    Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## t/t7800-difftool.sh ##
      @@ t/t7800-difftool.sh: test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged ch


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
