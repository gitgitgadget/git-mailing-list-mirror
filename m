Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2771AA7A6
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226769; cv=none; b=GE4YKMc1gOkbRR5owx2O+LUf5pZDb6NxyZ5gA5ns3/+aeIkaStqZ0QM9ydLZIJFRn2R521sn7IUe6DZHlPryl2M0+v+siaF6wGUuKTtANCDk/9Yquo2ecburSgFCUCgzVyjh8mbANFcUINR2mJ02HNpzafa7vhsB8egLR/Lbqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226769; c=relaxed/simple;
	bh=hBbFFixBguI6J7m7Xhlg29gv2SIe90JlSbZPSY8ZDw4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AqhcPUaMfnVZXm7RmEGTvngEt1fiTaNkSBj38kwCYLMVG8dczJmY5O2+SHh3XAiWBIu7/TFAFlIrhAAqVsnYoHNrRP3vC+3TZiSibHuLV87TbJxTX2RVTFm7iq3/uA13hF6Zvhaox6MRt/f37a73bqBn+Bp40n+jvH/dwhiDaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuQSudIT; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuQSudIT"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-455a461ab6eso3457671b6e.2
        for <git@vger.kernel.org>; Wed, 31 Dec 2025 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767226766; x=1767831566; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh1e28G63inVQr68ouGNWc+QmgEQGmw5YdYAA34UNzU=;
        b=iuQSudIT83C/ITXPp5T4r8G+Wu9QNWnvUER6smIe4CNrKYCUaCZO9rTUSTbDuKjX6q
         C2Pu51aDxQEBo5XiPwW+Xq7rlKgZA8UAzAt6JNGKCdxb6w1NLf1QEyIDaquQkURlGdzt
         /l0QnoCNxMg/ncJpQAL9i6lX6jwu4OwJ1yhOtAqvHf0vSSW/jlS14cbltryNzOEo55s4
         Tu8idHQ8SsHt3tp+Bo2dgsuGOMxZP5pyjmbGGXiZlLIFwPht3x0n45LuOGT1EcLG8d7x
         5GMUbZicB45wxuLbQWewXAhJoJEYM8tL+sXhBAW91SpokJzRiBdszb+WQ5CKFttUmwha
         nFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767226766; x=1767831566;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vh1e28G63inVQr68ouGNWc+QmgEQGmw5YdYAA34UNzU=;
        b=BLlABv51FliF0TeU41Ev/WQxzfHsYhNL+8CjACshLuX2vWrVvHI941sVes+D/FM4a5
         m45LbL6Gec2Usi2MeI/6unRppeVcXzuFLyLJTJMupBpogWT4te7T9AO1U4MohzzpETzg
         25860ELIfPvf5PAq9rE4AEWjaXkBb2V1T3gjPl6kH96/kdLL3SH7YhUjNLhw2K0+ymxw
         y+F4maIpzPKCUZq8wB4IJNtrcqfgRED1ojedsxKjZ0Jcpoux0YgJy4tjkaewhbHhIZ07
         5kM/lwwYg8xn6m+hJxNgyRf47pCPmy3u5KK+nNN0w3aB3qJjceCt/rSWEJcxKneA4lKR
         vweA==
X-Gm-Message-State: AOJu0Ywlttl+rpBk6BB3Z5xBcpV+p1xJ2fP0FhR4lUJIAcQHPgUZUUAh
	ChlQdbMPZbdDtwFR/dYkPPhlB5pO+fva1AMPmlkq8qx99zWH+tjvIxuT9ND7LCKt
X-Gm-Gg: AY/fxX6VTivitBIxlXCv/50mi29berrxByYswWBrriqp+xmAdgwdmIBd2AhdesZXI9a
	VM1eLz7NoKfOEzuk+/DVg3U1qqR38JpqCGrh/rFptEVY26fXvWHU4uYLPKOscgz/OsQtELEgRoA
	u9GaRx+suW6ZluFkgkRuJv9YgdE22Z7pltu4gIsFScPXEq6FpM7AX/Mt376qTvQDLITzGflY3nL
	DJxhUOstypOjribkR/LV4TKlF3CHQ+f5jnNONDBh5lON2mN+Rof9fms7g0HvzVMw2XnWw7jrZwn
	oKAgm2jYNVCE5B7IT/aCd9QsRFBZAj+ZlAtLQgD6RCvPO4/Y3Rqx1CY1jafSXLo1w7lP0z320XS
	6nfUhhZgIh61bh7K9KpIOdUmxTMXUA14BwXbDzdDq29UJqxbvBc+QTPtvRZOkW6wLAOBkoMsrXF
	VWDeT+jx2BccNE
X-Google-Smtp-Source: AGHT+IEUfG/pgeRnesKzwD8TNDnTdJz734W65s1znDU/jX0Z+BLwrFTMXFRe149ItNv5IEPQHDDfAw==
X-Received: by 2002:a05:6808:8c6:b0:459:b48b:d50d with SMTP id 5614622812f47-459b48c8ecfmr6042937b6e.23.1767226766264;
        Wed, 31 Dec 2025 16:19:26 -0800 (PST)
Received: from [127.0.0.1] ([52.242.243.96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a098b133csm614369b6e.13.2025.12.31.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 16:19:24 -0800 (PST)
Message-Id: <pull.2150.v2.git.git.1767226763360.gitgitgadget@gmail.com>
In-Reply-To: <pull.2150.git.git.1767224411233.gitgitgadget@gmail.com>
References: <pull.2150.git.git.1767224411233.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Jan 2026 00:19:23 +0000
Subject: [PATCH v2] t7527: fix flaky fsmonitor event tests with retry logic
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

The fsmonitor event tests (edit, create, delete, rename, etc.) were
flaky because there can be a race between the daemon writing events
to the trace file and the test's grep commands checking for them.

Add a retry_grep() helper function (similar to retry_until_success
in lib-git-p4.sh) that retries grep with a timeout, and use it in
all event-checking tests to wait for one expected event before
checking the rest.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    t7527: fix flaky fsmonitor event tests with retry logic
    
    This failed in
    https://github.com/git/git/actions/runs/20628166110/job/59242063331 on
    an unrelated commit.
    
    The fsmonitor event tests (edit, create, delete, rename, etc.) were
    flaky because there can be a race between the daemon writing events to
    the trace file and the test's grep commands checking for them.
    
    Add a retry_grep() helper function (similar to retry_until_success in
    lib-git-p4.sh) that retries grep with a timeout, and use it in all
    event-checking tests to wait for one expected event before checking the
    rest.
    
    Changes since v1:
    
     * Use retry_grep for all event checks, not just the first one (any
       event can be delayed)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2150%2Fptarjan%2Fclaude%2Ffix-fsmonitor-test-jsXoE-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2150/ptarjan/claude/fix-fsmonitor-test-jsXoE-v2
Pull-Request: https://github.com/git/git/pull/2150

Range-diff vs v1:

 1:  6fafc812e1 ! 1:  c275732e95 t7527: fix flaky fsmonitor event tests with retry logic
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'edit some files' '
      -	test-tool fsmonitor-client query --token 0 &&
      -
      -	grep "^event: dir1/modified$"  .git/trace &&
     +-	grep "^event: dir2/modified$"  .git/trace &&
     +-	grep "^event: modified$"       .git/trace &&
     +-	grep "^event: dir1/untracked$" .git/trace
      +	retry_grep "^event: dir1/modified$" .git/trace &&
     - 	grep "^event: dir2/modified$"  .git/trace &&
     - 	grep "^event: modified$"       .git/trace &&
     - 	grep "^event: dir1/untracked$" .git/trace
     ++	retry_grep "^event: dir2/modified$"  .git/trace &&
     ++	retry_grep "^event: modified$"       .git/trace &&
     ++	retry_grep "^event: dir1/untracked$" .git/trace
     + '
     + 
     + test_expect_success 'create some files' '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'create some files' '
       
       	create_files &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'create some files' '
      -	test-tool fsmonitor-client query --token 0 &&
      -
      -	grep "^event: dir1/new$" .git/trace &&
     +-	grep "^event: dir2/new$" .git/trace &&
     +-	grep "^event: new$"      .git/trace
      +	retry_grep "^event: dir1/new$" .git/trace &&
     - 	grep "^event: dir2/new$" .git/trace &&
     - 	grep "^event: new$"      .git/trace
     ++	retry_grep "^event: dir2/new$" .git/trace &&
     ++	retry_grep "^event: new$"      .git/trace
       '
     + 
     + test_expect_success 'delete some files' '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'delete some files' '
       
       	delete_files &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'delete some files' '
      -	test-tool fsmonitor-client query --token 0 &&
      -
      -	grep "^event: dir1/delete$" .git/trace &&
     +-	grep "^event: dir2/delete$" .git/trace &&
     +-	grep "^event: delete$"      .git/trace
      +	retry_grep "^event: dir1/delete$" .git/trace &&
     - 	grep "^event: dir2/delete$" .git/trace &&
     - 	grep "^event: delete$"      .git/trace
     ++	retry_grep "^event: dir2/delete$" .git/trace &&
     ++	retry_grep "^event: delete$"      .git/trace
       '
     + 
     + test_expect_success 'rename some files' '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename some files' '
       
       	rename_files &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename some files' '
      -	test-tool fsmonitor-client query --token 0 &&
      -
      -	grep "^event: dir1/rename$"  .git/trace &&
     +-	grep "^event: dir2/rename$"  .git/trace &&
     +-	grep "^event: rename$"       .git/trace &&
     +-	grep "^event: dir1/renamed$" .git/trace &&
     +-	grep "^event: dir2/renamed$" .git/trace &&
     +-	grep "^event: renamed$"      .git/trace
      +	retry_grep "^event: dir1/rename$" .git/trace &&
     - 	grep "^event: dir2/rename$"  .git/trace &&
     - 	grep "^event: rename$"       .git/trace &&
     - 	grep "^event: dir1/renamed$" .git/trace &&
     ++	retry_grep "^event: dir2/rename$"  .git/trace &&
     ++	retry_grep "^event: rename$"       .git/trace &&
     ++	retry_grep "^event: dir1/renamed$" .git/trace &&
     ++	retry_grep "^event: dir2/renamed$" .git/trace &&
     ++	retry_grep "^event: renamed$"      .git/trace
     + '
     + 
     + test_expect_success 'rename directory' '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename directory' '
       
       	mv dirtorename dirrenamed &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename directory' '
      -	test-tool fsmonitor-client query --token 0 &&
      -
      -	grep "^event: dirtorename/*$" .git/trace &&
     +-	grep "^event: dirrenamed/*$"  .git/trace
      +	retry_grep "^event: dirtorename/*$" .git/trace &&
     - 	grep "^event: dirrenamed/*$"  .git/trace
     ++	retry_grep "^event: dirrenamed/*$"  .git/trace
       '
       
     + test_expect_success 'file changes to directory' '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'file changes to directory' '
       
       	file_to_directory &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'file changes to directory' '
      -	test-tool fsmonitor-client query --token 0 &&
      -
      -	grep "^event: delete$"     .git/trace &&
     +-	grep "^event: delete/new$" .git/trace
      +	retry_grep "^event: delete$" .git/trace &&
     - 	grep "^event: delete/new$" .git/trace
     ++	retry_grep "^event: delete/new$" .git/trace
       '
       
     + test_expect_success 'directory changes to a file' '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'directory changes to a file' '
       
       	directory_to_file &&


 t/t7527-builtin-fsmonitor.sh | 79 +++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 409cd0cd12..e7b4065469 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -408,9 +408,8 @@ move_directory() {
 # ensure we are getting the OS notifications and do not try to confirm what
 # is reported by `git status`.
 #
-# We run a simple query after modifying the filesystem just to introduce
-# a bit of a delay so that the trace logging from the daemon has time to
-# get flushed to disk.
+# We use retry_grep to handle races between the daemon writing events
+# to the trace file and our check.
 #
 # We `reset` and `clean` at the bottom of each test (and before stopping the
 # daemon) because these commands might implicitly restart the daemon.
@@ -422,6 +421,24 @@ clean_up_repo_and_stop_daemon () {
 	rm -f .git/trace
 }
 
+# Retry a grep up to RETRY_TIMEOUT times until it succeeds.
+#
+RETRY_TIMEOUT=5
+
+retry_grep () {
+	nr_tries_left=$RETRY_TIMEOUT
+	until grep "$1" "$2" 2>/dev/null
+	do
+		if test $nr_tries_left -eq 0
+		then
+			grep "$1" "$2"
+			return
+		fi
+		nr_tries_left=$(($nr_tries_left - 1))
+		sleep 1
+	done
+}
+
 test_expect_success 'edit some files' '
 	test_when_finished clean_up_repo_and_stop_daemon &&
 
@@ -429,12 +446,10 @@ test_expect_success 'edit some files' '
 
 	edit_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/modified$"  .git/trace &&
-	grep "^event: dir2/modified$"  .git/trace &&
-	grep "^event: modified$"       .git/trace &&
-	grep "^event: dir1/untracked$" .git/trace
+	retry_grep "^event: dir1/modified$" .git/trace &&
+	retry_grep "^event: dir2/modified$"  .git/trace &&
+	retry_grep "^event: modified$"       .git/trace &&
+	retry_grep "^event: dir1/untracked$" .git/trace
 '
 
 test_expect_success 'create some files' '
@@ -444,11 +459,9 @@ test_expect_success 'create some files' '
 
 	create_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/new$" .git/trace &&
-	grep "^event: dir2/new$" .git/trace &&
-	grep "^event: new$"      .git/trace
+	retry_grep "^event: dir1/new$" .git/trace &&
+	retry_grep "^event: dir2/new$" .git/trace &&
+	retry_grep "^event: new$"      .git/trace
 '
 
 test_expect_success 'delete some files' '
@@ -458,11 +471,9 @@ test_expect_success 'delete some files' '
 
 	delete_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/delete$" .git/trace &&
-	grep "^event: dir2/delete$" .git/trace &&
-	grep "^event: delete$"      .git/trace
+	retry_grep "^event: dir1/delete$" .git/trace &&
+	retry_grep "^event: dir2/delete$" .git/trace &&
+	retry_grep "^event: delete$"      .git/trace
 '
 
 test_expect_success 'rename some files' '
@@ -472,14 +483,12 @@ test_expect_success 'rename some files' '
 
 	rename_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/rename$"  .git/trace &&
-	grep "^event: dir2/rename$"  .git/trace &&
-	grep "^event: rename$"       .git/trace &&
-	grep "^event: dir1/renamed$" .git/trace &&
-	grep "^event: dir2/renamed$" .git/trace &&
-	grep "^event: renamed$"      .git/trace
+	retry_grep "^event: dir1/rename$" .git/trace &&
+	retry_grep "^event: dir2/rename$"  .git/trace &&
+	retry_grep "^event: rename$"       .git/trace &&
+	retry_grep "^event: dir1/renamed$" .git/trace &&
+	retry_grep "^event: dir2/renamed$" .git/trace &&
+	retry_grep "^event: renamed$"      .git/trace
 '
 
 test_expect_success 'rename directory' '
@@ -489,10 +498,8 @@ test_expect_success 'rename directory' '
 
 	mv dirtorename dirrenamed &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dirtorename/*$" .git/trace &&
-	grep "^event: dirrenamed/*$"  .git/trace
+	retry_grep "^event: dirtorename/*$" .git/trace &&
+	retry_grep "^event: dirrenamed/*$"  .git/trace
 '
 
 test_expect_success 'file changes to directory' '
@@ -502,10 +509,8 @@ test_expect_success 'file changes to directory' '
 
 	file_to_directory &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: delete$"     .git/trace &&
-	grep "^event: delete/new$" .git/trace
+	retry_grep "^event: delete$" .git/trace &&
+	retry_grep "^event: delete/new$" .git/trace
 '
 
 test_expect_success 'directory changes to a file' '
@@ -515,9 +520,7 @@ test_expect_success 'directory changes to a file' '
 
 	directory_to_file &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1$" .git/trace
+	retry_grep "^event: dir1$" .git/trace
 '
 
 # The next few test cases exercise the token-resync code.  When filesystem

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
