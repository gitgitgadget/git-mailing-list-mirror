Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686E71747
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128494; cv=none; b=GZzGa01jy2e6zruQaZLhln9K6qFyQ5Xuja/PfbYdH6f9iQ139NthpBM0qB64ycQaV5dkpBO7+MWHYRnUA2dau1i02luYHZkm6pR/RrY9mItOkEoXomoEVMw0o1Wm1Hc8hSmA42C0wleopBSusPi5jxW/hdNKLqpSwYSw+tHIKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128494; c=relaxed/simple;
	bh=Jgc/xD+z0bNawdvigieOhDmJFVJKIJO8dGKJ/8FnGkA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gQI1QwgeGYFTUAg6XN9gdLOv7EnN7SeZGa9tW/QhDC28+pP2gKoJC8ZryRFTXCTU59e3Mkqp/Aq+RVmgZbqgTjgxCF7s7cg7rvq4eLhWNnW33OEbB/4vlFbSuDqBvevZJDlmX3fXiirJk5yMfca4cSpQpt15y8KtG85nsUnAm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4K3pXil; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4K3pXil"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a575a988f9so1936635f8f.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751128490; x=1751733290; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgNn5CJHtF2CYmU/oJNowekVJuDK5rqLzXySKKjzU5Q=;
        b=E4K3pXilw8DOhH5ML+hiPSNBrAhT5lxXHIWBGADFUFqvWgjGXcOnXWy9fJtDnQ0la9
         TGKU7Yg4CyrVYcINaI27QFOpHunBgcM6ucM7GLrffKWQILxFjgeXk5pn2o6IE98FEnf1
         fOj4xFqcBpyQ9aimWSGNeF9uUBnOe37Od7tt7tFiQR7CJUxpFHSxoRvjtqZ4f6DWQ9tE
         +uVQxmvSCpDTEfaSgA6raR+u48yhCR+CtumUQkONrwG0BYztcQjw2kbLHmwbEAnPOUA+
         3b+wg2OV5F+3dAnmP7GiGg2bjxdQWjjh0diObUK7mq7gJYMVhlqRHpX0szrcI6DqE2En
         dp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751128490; x=1751733290;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgNn5CJHtF2CYmU/oJNowekVJuDK5rqLzXySKKjzU5Q=;
        b=uVx4xTDvXFPERVQc2H2Vzw6N89ObYUSokNHEaUVh7wAcbrvGN4mFgdNEfUkuRvGGsn
         hocuXE8B2gYMOkBaoqQWOdFbP1bKNWaV+neDdhGK9HVUrIpmcqz4GVMM7IzYn+rcwaJA
         u7z+rKzoo64XXniIfETsHipNi8kfrozLF2IieKmF8c1RggRSd4jT12omPtnwn/uhoaZ8
         TTXGkRMs5Wma4buiRbUxSNA8s9NsXEzm1XVLAAo4YT5fJTNVKGmvhAByzvcm8jomnC52
         C/TXp5F1JZYUGkrtMwoPmcHF6CIRefmGbUr5BERV6NBLEN+yYBXAV7zseklrOHVrnWT5
         60sg==
X-Gm-Message-State: AOJu0YzODZYtdmgt4LKaLW40ANwVoDS87Gu7LoeYGjI3WSM02KWr9lGQ
	TxA2ZdXFhpcfP6eFDJVDj0IkxZCDLKh5+vOqmOjApt5vjSTZdwJShuIjLA7UqA==
X-Gm-Gg: ASbGncuKvbzMfmmcivTKJFMOleSJafegV8fnRIw59uFUILZnP0cYfo1d4y2pdsuZ1Cc
	GKyyPFzzhG7KMt1xsWOsN3K3UKCCqltM1XsPknbWW7bexnWNTTpF+w7I6CPi48lXhBVdTATArbf
	A79H9SU5RiyS7xkb1SJ9eVjvBY9YQloLWDIbq1cuBd9oDNIL81GEEprX2fcgY8xqTNhI3AYhjaS
	p6l/SzoDwi+08Vx0ylyl1J0asgn6NjrvgvGQqLrOhS2kOOHsH0d/VxA879CWOgAM2KQ2QKp1Iqx
	HP3pKUkw21herMitB90T7/jt2uzLEep7WtER3cLFMT4Ax+78NwwPQEdilEDQVRw=
X-Google-Smtp-Source: AGHT+IF1dFXYEHU1w5xrS97X7Q+/w2J346EBr90Uf1ZX5RD6Vny1etbDqcM9egOtQVL5AaMxlCf4Bg==
X-Received: by 2002:a05:6000:65a:b0:3a5:8d9d:27fa with SMTP id ffacd0b85a97d-3a8fdb2ae51mr6315167f8f.3.1751128490096;
        Sat, 28 Jun 2025 09:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a35sm5740147f8f.57.2025.06.28.09.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:34:49 -0700 (PDT)
Message-Id: <044a93014b677914870a872a9c317a46a5a81699.1751128487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Jun 2025 16:34:43 +0000
Subject: [PATCH v3 1/4] test: use "test_grep"
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

Use the modern "test_grep" test utility instead of regular "grep" which
provides better debug information if tests fail.

This is a prerequisite to the commits that follow which add to both test
files.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 t/t3701-add-interactive.sh | 48 +++++++++++++++++++-------------------
 t/t4055-diff-context.sh    | 28 +++++++++++-----------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b8a05d95f3f1..b088ee141ff4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -63,7 +63,7 @@ test_expect_success 'setup (initial)' '
 '
 test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
-	grep "+1/-0 *+2/-0 file" output
+	test_grep "+1/-0 *+2/-0 file" output
 '
 
 test_expect_success 'setup expected' '
@@ -86,7 +86,7 @@ test_expect_success 'revert works (initial)' '
 	git add file &&
 	test_write_lines r 1 | git add -i &&
 	git ls-files >output &&
-	! grep . output
+	test_grep ! . output
 '
 
 test_expect_success 'add untracked (multiple)' '
@@ -109,7 +109,7 @@ test_expect_success 'setup (commit)' '
 '
 test_expect_success 'status works (commit)' '
 	git add -i </dev/null >output &&
-	grep "+1/-0 *+2/-0 file" output
+	test_grep "+1/-0 *+2/-0 file" output
 '
 
 test_expect_success 'update can stage deletions' '
@@ -141,7 +141,7 @@ test_expect_success 'revert works (commit)' '
 	git add file &&
 	test_write_lines r 1 | git add -i &&
 	git add -i </dev/null >output &&
-	grep "unchanged *+3/-0 file" output
+	test_grep "unchanged *+3/-0 file" output
 '
 
 test_expect_success 'reject multi-key input' '
@@ -185,7 +185,7 @@ test_expect_success 'setup fake editor' '
 test_expect_success 'bad edit rejected' '
 	git reset &&
 	test_write_lines e n d | git add -p >output &&
-	grep "hunk does not apply" output
+	test_grep "hunk does not apply" output
 '
 
 test_expect_success 'setup patch' '
@@ -198,7 +198,7 @@ test_expect_success 'setup patch' '
 test_expect_success 'garbage edit rejected' '
 	git reset &&
 	test_write_lines e n d | git add -p >output &&
-	grep "hunk does not apply" output
+	test_grep "hunk does not apply" output
 '
 
 test_expect_success 'setup patch' '
@@ -313,8 +313,8 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
 	git diff --cached file >out &&
-	grep "new mode" out &&
-	grep "+content" out &&
+	test_grep "new mode" out &&
+	test_grep "+content" out &&
 	git diff file >out &&
 	test_must_be_empty out
 '
@@ -636,7 +636,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	printf "%s\n" s e     q n q q |
 	EDITOR=: git add -p &&
 	git diff >actual &&
-	! grep "^+15" actual
+	test_grep ! "^+15" actual
 '
 
 test_expect_success 'split hunk "add -p (no, yes, edit)"' '
@@ -648,7 +648,7 @@ test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff >actual &&
-	! grep "^+31" actual
+	test_grep ! "^+31" actual
 '
 
 test_expect_success 'split hunk with incomplete line at end' '
@@ -682,7 +682,7 @@ test_expect_success 'edit, adding lines to the first hunk' '
 	EDITOR=./fake_editor.sh git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached >actual &&
-	grep "^+22" actual
+	test_grep "^+22" actual
 '
 
 test_expect_success 'patch mode ignores unmerged entries' '
@@ -696,7 +696,7 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_must_fail git merge side &&
 	echo changed >non-conflict.t &&
 	echo y | git add -p >output &&
-	! grep a/conflict.t output &&
+	test_grep ! a/conflict.t output &&
 	cat >expected <<-\EOF &&
 	* Unmerged path conflict.t
 	diff --git a/non-conflict.t b/non-conflict.t
@@ -728,7 +728,7 @@ test_expect_success 'diffs can be colorized' '
 
 	# We do not want to depend on the exact coloring scheme
 	# git uses for diffs, so just check that we saw some kind of color.
-	grep "$(printf "\\033")" output
+	test_grep "$(printf "\\033")" output
 '
 
 test_expect_success 'colors can be overridden' '
@@ -743,7 +743,7 @@ test_expect_success 'colors can be overridden' '
 		-c color.interactive.error=blue \
 		add -i 2>err.raw <input &&
 	test_decode_color <err.raw >err &&
-	grep "<BLUE>Huh (trigger)?<RESET>" err &&
+	test_grep "<BLUE>Huh (trigger)?<RESET>" err &&
 
 	test_write_lines help quit >input &&
 	force_color git \
@@ -863,7 +863,7 @@ test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	printf y >y &&
 	force_color git -c diff.wsErrorHighlight=all add -p >output.raw 2>&1 <y &&
 	test_decode_color <output.raw >output &&
-	grep "old<" output
+	test_grep "old<" output
 '
 
 test_expect_success 'diffFilter filters diff' '
@@ -876,7 +876,7 @@ test_expect_success 'diffFilter filters diff' '
 
 	# avoid depending on the exact coloring or content of the prompts,
 	# and just make sure we saw our diff prefixed
-	grep foo:.*content output
+	test_grep foo:.*content output
 '
 
 test_expect_success 'detect bogus diffFilter output' '
@@ -886,7 +886,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	test_config interactive.diffFilter "sed 6d" &&
 	printf y >y &&
 	force_color test_must_fail git add -p <y >output 2>&1 &&
-	grep "mismatched output" output
+	test_grep "mismatched output" output
 '
 
 test_expect_success 'handle iffy colored hunk headers' '
@@ -896,7 +896,7 @@ test_expect_success 'handle iffy colored hunk headers' '
 	printf n >n &&
 	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
 		add -p >output 2>&1 <n &&
-	grep "^XX$" output
+	test_grep "^XX$" output
 '
 
 test_expect_success 'handle very large filtered diff' '
@@ -1002,7 +1002,7 @@ test_expect_success 'add -p does not expand argument lists' '
 	# update it, but we want to be sure that our "." pathspec
 	# was not expanded into the argument list of any command.
 	# So look only for "not-changed".
-	! grep -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
+	test_grep ! -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
 '
 
 test_expect_success 'hunk-editing handles custom comment char' '
@@ -1072,21 +1072,21 @@ test_expect_success 'setup different kinds of dirty submodules' '
 
 test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	git -C for-submodules add -i </dev/null >output &&
-	grep dirty-head output &&
-	grep dirty-both-ways output &&
-	! grep dirty-otherwise output
+	test_grep dirty-head output &&
+	test_grep dirty-both-ways output &&
+	test_grep ! dirty-otherwise output
 '
 
 test_expect_success 'handle submodules' '
 	echo 123 >>for-submodules/dirty-otherwise/initial.t &&
 
 	force_color git -C for-submodules add -p dirty-otherwise >output 2>&1 &&
-	grep "No changes" output &&
+	test_grep "No changes" output &&
 
 	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
 	git -C for-submodules ls-files --stage dirty-head >actual &&
 	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
-	grep "$rev" actual
+	test_grep "$rev" actual
 '
 
 test_expect_success 'set up pathological context' '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index ec2804eea67c..c66f966a3ab3 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -38,36 +38,36 @@ test_expect_success 'setup' '
 
 test_expect_success 'the default number of context lines is 3' '
 	git diff >output &&
-	! grep "^ d" output &&
-	grep "^ e" output &&
-	grep "^ j" output &&
-	! grep "^ k" output
+	test_grep ! "^ d" output &&
+	test_grep "^ e" output &&
+	test_grep "^ j" output &&
+	test_grep ! "^ k" output
 '
 
 test_expect_success 'diff.context honored by "log"' '
 	git log -1 -p >output &&
-	! grep firstline output &&
+	test_grep ! firstline output &&
 	git config diff.context 8 &&
 	git log -1 -p >output &&
-	grep "^ firstline" output
+	test_grep "^ firstline" output
 '
 
 test_expect_success 'The -U option overrides diff.context' '
 	git config diff.context 8 &&
 	git log -U4 -1 >output &&
-	! grep "^ firstline" output
+	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'diff.context honored by "diff"' '
 	git config diff.context 8 &&
 	git diff >output &&
-	grep "^ firstline" output
+	test_grep "^ firstline" output
 '
 
 test_expect_success 'plumbing not affected' '
 	git config diff.context 8 &&
 	git diff-files -p >output &&
-	! grep "^ firstline" output
+	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'non-integer config parsing' '
@@ -85,8 +85,8 @@ test_expect_success 'negative integer config parsing' '
 test_expect_success '-U0 is valid, so is diff.context=0' '
 	git config diff.context 0 &&
 	git diff >output &&
-	grep "^-ADDED" output &&
-	grep "^+MODIFIED" output
+	test_grep "^-ADDED" output &&
+	test_grep "^+MODIFIED" output
 '
 
 test_expect_success '-U2147483647 works' '
@@ -94,9 +94,9 @@ test_expect_success '-U2147483647 works' '
 	test_line_count = 16 x &&
 	git diff -U2147483647 >output &&
 	test_line_count = 22 output &&
-	grep "^-ADDED" output &&
-	grep "^+MODIFIED" output &&
-	grep "^+APPENDED" output
+	test_grep "^-ADDED" output &&
+	test_grep "^+MODIFIED" output &&
+	test_grep "^+APPENDED" output
 '
 
 test_done
-- 
gitgitgadget

