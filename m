Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AA28690
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767224417; cv=none; b=ry+rqyHhiRInao13DPdg5QJf5e6Nuye97KeQ0bU9ODfrF3maa/sAThe511vN/ORQGONvq8tZUaMEjise2GfMsqpLuC4XOYUECW8GPNRlyHlcCmXrHvJzhqu/D65y5vupeVzfOPfJayzn/14Eb0rLH3zeA4cG7vzZ2AOadAcsi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767224417; c=relaxed/simple;
	bh=cekGd23AKJs3tGhuRmAgFLGtG6wXNQxE54+h8Epo0es=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Zr6MHv3BdaZbkpv9EjK6nXKubUC+lMYNhbP+02Hd9L7ZIlCYMpB2ksYDWntvr2mj6A8snDF61T7vWcSwC4ndxDBHQFD42hznEnMAwC72j/8CEU+iMUyQY6mFz7Q+jtzUDkkXx/2/FTfy3lVh7XLR/EFEMFIjxdoutzf2Zca9AQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wlj0qNTK; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlj0qNTK"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a32bf0248so87658696d6.0
        for <git@vger.kernel.org>; Wed, 31 Dec 2025 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767224413; x=1767829213; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fhlnEqOY//ofDqPAO7bSYI8hKovEyec3pXSj51rJPMU=;
        b=Wlj0qNTKs7TEJrVcqc7WxErqkPMNkUwtJpFqJj7z4PGVJ+EBrgj+eRQnKp2RMWwiuj
         CWqUrPeKECDfPLXhh2JzBMPRY/lQpSJICalBL9Wa2DC66Z3nTrB2FNncjo1iUbuCqkX0
         aBADvwiDII12/PEHXK6EoHvbMq2x23IunCsXixhkz5N8CocCyX1J8zQEZiiTTp74U0E0
         t+WPfTJFz69QEah9hLkyncuTTEGlWkht3d99kTmZ4BKmX7PUQUFuxG+yV1CcREeFPZCd
         qQuQggUtt79zofBxv/OTU36qUT8gBKx5L1kCd2sVfP1qi8zjOsda/Hk+Gcm+/O+2r3t1
         VIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767224413; x=1767829213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhlnEqOY//ofDqPAO7bSYI8hKovEyec3pXSj51rJPMU=;
        b=phnM3zIXHdY5/PmCswPRIR1SFbK6Oy/zK3rW85F86GfeECqMuFOXQJ4E707zupkARI
         IhrEbBQx9ldIbHed15yVVEFw9SHiASDrVNr24Rw4ZDg8ekkQ6J9a0Y/yHlSXBV3FLLfU
         zyuk+zEA0E1ujlw9lDbGRyfsqEAECzlR6OIw51qdV0LPzm1GyoAabpDSV5xQtD2iduk8
         FPp8xQPTLEDNMsUTpzEtH30qASvzTl/H9Ubtm61XeqZ5HE4/5u2H/feuJZaUuTi6knkr
         fbV4Of5qMNFRvvn5l/dfzcjSDI9/2obXitWS9uSPHzx+QEzAgHdV+vtQvrl0Pai/Dlof
         X6Kw==
X-Gm-Message-State: AOJu0YxXLdsEpKIyE2HTEQ98FucIFdJLnWqXwFc/OyeMQ5ZXVH5X9tFX
	8Dv7655n4sigbpw7rlf7BlEIX+EyD61EhQBMdVXkBg2JbAzqFys1ep9j2rQGiQ==
X-Gm-Gg: AY/fxX4EGSsr9om45loCMwWnPraMdeOngeBMejLDlf3er5VoDiahN6JJU2m7lRBgvaH
	JwwAhXb9jWm7OR9Qbax9lJxgJYho0NztSpdyld3z03nDBu9qW+DYvL03rP8j4GIYP7mtlNYxGdC
	CS+GO7aqe9RZrzx/Ezm7u0RWU3AuvwxvgVo9y6RmGP8fJrM2h3iQ9+IlSEdQJ8TtNgzPWQqE8Qs
	AhOXGIp54stg8ALSkY8jSHa88J2YZZBmB5ZzIswO1P3yr82vaFnbOCx9IqIAa0qKSkT3bPAIKFd
	fc23GG/JNDyTtWrmth2zbg2QBZwoPl21IUAEa8soUFKTymgC5//Rfe9Fd9Vp15qxT4qM1UZAHsE
	qNN9tBDlPtY3A6krBhQ2WDrv80RHFopya8ol9N4xhpttqfaZA12FHcRxMKTcHNWf5kRYXYhocQI
	G2NgeDnGCiquC5
X-Google-Smtp-Source: AGHT+IF3jSUhbVu5GTpAmZeE6SGuWnf0ccTqYxprPa+d4DkBXMWrTxd7MyFJDYyOrULd9+Y3ShwMhw==
X-Received: by 2002:a0c:fbc4:0:b0:888:fc37:f9b7 with SMTP id 6a1803df08f44-88d820414a8mr405212376d6.25.1767224412964;
        Wed, 31 Dec 2025 15:40:12 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96240314sm275962326d6.7.2025.12.31.15.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 15:40:11 -0800 (PST)
Message-Id: <pull.2150.git.git.1767224411233.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Dec 2025 23:40:11 +0000
Subject: [PATCH] t7527: fix flaky fsmonitor event tests with retry logic
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2150%2Fptarjan%2Fclaude%2Ffix-fsmonitor-test-jsXoE-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2150/ptarjan/claude/fix-fsmonitor-test-jsXoE-v1
Pull-Request: https://github.com/git/git/pull/2150

 t/t7527-builtin-fsmonitor.sh | 51 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 409cd0cd12..68a10a2100 100755
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
 
@@ -429,9 +446,7 @@ test_expect_success 'edit some files' '
 
 	edit_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/modified$"  .git/trace &&
+	retry_grep "^event: dir1/modified$" .git/trace &&
 	grep "^event: dir2/modified$"  .git/trace &&
 	grep "^event: modified$"       .git/trace &&
 	grep "^event: dir1/untracked$" .git/trace
@@ -444,9 +459,7 @@ test_expect_success 'create some files' '
 
 	create_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/new$" .git/trace &&
+	retry_grep "^event: dir1/new$" .git/trace &&
 	grep "^event: dir2/new$" .git/trace &&
 	grep "^event: new$"      .git/trace
 '
@@ -458,9 +471,7 @@ test_expect_success 'delete some files' '
 
 	delete_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/delete$" .git/trace &&
+	retry_grep "^event: dir1/delete$" .git/trace &&
 	grep "^event: dir2/delete$" .git/trace &&
 	grep "^event: delete$"      .git/trace
 '
@@ -472,9 +483,7 @@ test_expect_success 'rename some files' '
 
 	rename_files &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dir1/rename$"  .git/trace &&
+	retry_grep "^event: dir1/rename$" .git/trace &&
 	grep "^event: dir2/rename$"  .git/trace &&
 	grep "^event: rename$"       .git/trace &&
 	grep "^event: dir1/renamed$" .git/trace &&
@@ -489,9 +498,7 @@ test_expect_success 'rename directory' '
 
 	mv dirtorename dirrenamed &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: dirtorename/*$" .git/trace &&
+	retry_grep "^event: dirtorename/*$" .git/trace &&
 	grep "^event: dirrenamed/*$"  .git/trace
 '
 
@@ -502,9 +509,7 @@ test_expect_success 'file changes to directory' '
 
 	file_to_directory &&
 
-	test-tool fsmonitor-client query --token 0 &&
-
-	grep "^event: delete$"     .git/trace &&
+	retry_grep "^event: delete$" .git/trace &&
 	grep "^event: delete/new$" .git/trace
 '
 
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
