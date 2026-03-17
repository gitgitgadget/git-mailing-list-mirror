Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30AB346A02
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714105; cv=none; b=DqImIVNSiGZN2zRQDGD0ekNzrjgmtFjpu4/GbaEJqhYLOUPH3OHPwHUTxtsmG+U4wh/5UqJ+6q7S93AUn+kiqtVZSllb+cyYrJEVFl7CLxdEQVJKsm5So6hOHjjmYEZAuT1Y9KSeuCUmTEcZhj/y9nXKEWcjo3xqk5WqQnoR8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714105; c=relaxed/simple;
	bh=7NiI4fcN0kIF/G11+nAXPZRMwepSJFbbnx7FvL2fiHE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t4ORbUF3MF6BuSkSw+CISDXRSrNU86JNnMBcsn9+/reW5rpUQutdQJc5JguPtIM3O71SZdsjZB8JGCa3KLm6jgsxJ1RlS9CKEIZFFlShsPPv8vlAx7i3FZrsuQJ9xMI1clYbmsc0DD6X9fZrjhPMwFSEI6jlzPIwOqiQ+8+QHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvl4oDVL; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvl4oDVL"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1279eced0b9so7087567c88.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714102; x=1774318902; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPyckVRnanQSH+wx86+yBLwkngQ3EWabyiDJL9pWIfY=;
        b=Wvl4oDVLhb7lQ8SfyjjiRmgN9yQNxkxgcHcf1buzxtukCEP/pQfoPBo1UCeWYo5GdN
         VriPYXKHADZmM/ReUj6FFmdJ1HCwzbvAZJwbGzKngQlyqCWmJPXj2VoGdJErejM+RKtD
         cH2RS2bP/but22H7O9BAzAsUeLG1fNbwCFlcLyZrOgtEjTEUIPtWPT3RcWuMQBFL1oTa
         QKqmQShS1A6lzKXpSfCgt6F/Xw6DCO7lG0bFqSFy+RIzqKP8ngmjYQvp2Y2P4SVDne0T
         Iar1XSm+POtYWDP2iHfNq2Q3Fmum3ffk0Ndi72sDbY/meY60z7I1AnvBAwtQk5BM8fz5
         KFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714102; x=1774318902;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPyckVRnanQSH+wx86+yBLwkngQ3EWabyiDJL9pWIfY=;
        b=XvyyzaQ++hlKsa77Rm9cjwy6MH3pzHHOMLXRgQ/rokLXxnU8Yc4sA/KXxKEMicG0wQ
         L9jpVqupW21sJeLUqPQD4fctuiucOqTKsfmdOR8OrIOCRMAygDvJwWmZBUxxYCk/oL/4
         u/EQMmO7DImQGNwfkxrimmHh1VZW9gZ5c3C1Kg+2LMN9kIr4ZW8OJMVSMhde8QAkiBq8
         5rAqQ4eMkH1tNLcTNxL+YWmm1LzoCHQaOe2XFqGocu8FGgKuwy7xRFtUzq1XGdR/VMnj
         bl5Kydgzq4AoE44JGRjdptBsS6fT4m2AqKNihdtW545EnM4QHpSdnOZnULxSDkD8iOch
         kuTA==
X-Gm-Message-State: AOJu0Yx6Kw5ZEFAf7cvzNECqhSON7WEfM7yz414dbLD/8MP0IRLgI8Bk
	u3jKb47nLyqpVa+VyrPwBPbZHXXcev5U/NaLcjw87P1rp8abDhbat/zaCKsdhHn+
X-Gm-Gg: ATEYQzyxmq7/d1UeRosDg8f3pwaIYBP9N4YhruXpv5o65hvSSKNkF1+AHepOcjc9/G0
	GiH3fNyepeU8RXMEKgmJJLEX7HWmqXjJS9VKgQA+da8uqXHCxqfmVSQNdOr9H9e8hRd5fZofOvn
	FK8dLEVV1bHutJC7QdMujq2FgKysJhKW4rc69j4Y+PeA8O+gvbYZlRvouaUivlI4CoceMvDC6Ej
	xwaX750qvf5yzVgeiKBFoXSnDo5Ab7KQI0IxWm47gfCnqGARPMeNEstwM0k2IxFMW2aWm6la7Mn
	/Ohez8o6kXcanjp5Pirr7S8mdjQ2x3TTRW95j1gH/Gq5rfixfnBEI5z4r3rPsxAuKx12KLiV/hz
	noa4/2W84WvfyjYYgKdXcOdhHb0O1C73oKSWcogG1GJc9FhTaQkfpMVtQJn9avNStqYGdrhCIra
	SNQA1Mdfq0ofKh303X70nnaVU=
X-Received: by 2002:a05:7022:2207:b0:128:d752:e074 with SMTP id a92af1059eb24-128f3d6e844mr6581543c88.1.1773714102241;
        Mon, 16 Mar 2026 19:21:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.50.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6283873sm14751560c88.1.2026.03.16.19.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 19:21:40 -0700 (PDT)
Message-Id: <cf7720ae9847c3060929ebd7ff30fd7762ac4dfe.1773714095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 02:21:34 +0000
Subject: [PATCH v2 3/4] t4211: add tests for -L with standard diff options
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Now that -L output flows through the standard diff pipeline, verify
that previously-ignored diff options work: formatting (--word-diff,
--word-diff-regex, --no-prefix, --src/dst-prefix, --full-index,
--abbrev), whitespace handling (-w, -b), output indicators
(--output-indicator-new/old/context), direction reversal (-R),
--color-moved, and pickaxe options (-S, -G).

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/t4211-line-log.sh | 281 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 6a307e911b..aaf197d2ed 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -339,6 +339,92 @@ test_expect_success 'zero-width regex .* matches any function name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for diff pipeline tests' '
+	git checkout parent-oids &&
+
+	head_blob_old=$(git rev-parse --short HEAD^:file.c) &&
+	head_blob_new=$(git rev-parse --short HEAD:file.c) &&
+	root_blob=$(git rev-parse --short HEAD~4:file.c) &&
+	null_blob=$(test_oid zero | cut -c1-7) &&
+	head_blob_old_full=$(git rev-parse HEAD^:file.c) &&
+	head_blob_new_full=$(git rev-parse HEAD:file.c) &&
+	root_blob_full=$(git rev-parse HEAD~4:file.c) &&
+	null_blob_full=$(test_oid zero)
+'
+
+test_expect_success '-L diff output includes index and new file mode' '
+	git log -L:func2:file.c --format= >actual &&
+
+	# Output should contain index headers (not present in old code path)
+	grep "^index $head_blob_old\.\.$head_blob_new 100644" actual &&
+
+	# Root commit should show new file mode and null index
+	grep "^new file mode 100644" actual &&
+	grep "^index $null_blob\.\.$root_blob$" actual &&
+
+	# Hunk headers should include funcname context
+	grep "^@@ .* @@ int func1()" actual
+'
+
+test_expect_success '-L with --word-diff' '
+	cat >expect <<-\EOF &&
+
+	diff --git a/file.c b/file.c
+	--- a/file.c
+	+++ b/file.c
+	@@ -6,4 +6,4 @@ int func1()
+	int func2()
+	{
+	    return [-F2;-]{+F2 + 2;+}
+	}
+
+	diff --git a/file.c b/file.c
+	new file mode 100644
+	--- /dev/null
+	+++ b/file.c
+	@@ -0,0 +6,4 @@
+	{+int func2()+}
+	{+{+}
+	{+    return F2;+}
+	{+}+}
+	EOF
+	git log -L:func2:file.c --word-diff --format= >actual &&
+	grep -v "^index " actual >actual.filtered &&
+	grep -v "^index " expect >expect.filtered &&
+	test_cmp expect.filtered actual.filtered
+'
+
+test_expect_success '-L with --no-prefix' '
+	git log -L:func2:file.c --no-prefix --format= >actual &&
+	grep "^diff --git file.c file.c" actual &&
+	grep "^--- file.c" actual &&
+	! grep "^--- a/" actual
+'
+
+test_expect_success '-L with --full-index' '
+	git log -L:func2:file.c --full-index --format= >actual &&
+	grep "^index $head_blob_old_full\.\.$head_blob_new_full 100644" actual &&
+	grep "^index $null_blob_full\.\.$root_blob_full$" actual
+'
+
+test_expect_success 'setup -L with whitespace change' '
+	git checkout -b ws-change parent-oids &&
+	sed "s/    return F2 + 2;/	return F2 + 2;/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Whitespace change in func2()"
+'
+
+test_expect_success '-L with --ignore-all-space suppresses whitespace-only diff' '
+	git log -L:func2:file.c --format= >without_w &&
+	git log -L:func2:file.c --format= -w >with_w &&
+
+	# Without -w: three commits produce diffs (whitespace, modify, root)
+	test $(grep -c "^diff --git" without_w) = 3 &&
+
+	# With -w: whitespace-only commit produces no hunk, so only two diffs
+	test $(grep -c "^diff --git" with_w) = 2
+'
+
 test_expect_success 'show line-log with graph' '
 	git checkout parent-oids &&
 	head_blob_old=$(git rev-parse --short HEAD^:file.c) &&
@@ -430,4 +516,199 @@ test_expect_failure '-L --find-object should filter commits by object' '
 	test_must_be_empty actual
 '
 
+test_expect_success '-L with --word-diff-regex' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --word-diff \
+		--word-diff-regex="[a-zA-Z0-9_]+" --format= >actual &&
+	# Word-diff markers must be present
+	grep "{+" actual &&
+	grep "+}" actual &&
+	# No line-level +/- markers (word-diff replaces them);
+	# exclude --- header lines from the check
+	! grep "^+[^+]" actual &&
+	! grep "^-[^-]" actual
+'
+
+test_expect_success '-L with --src-prefix and --dst-prefix' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --src-prefix=old/ --dst-prefix=new/ \
+		--format= >actual &&
+	grep "^diff --git old/file.c new/file.c" actual &&
+	grep "^--- old/file.c" actual &&
+	grep "^+++ new/file.c" actual &&
+	! grep "^--- a/" actual
+'
+
+test_expect_success '-L with --abbrev' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --abbrev=4 --format= -1 >actual &&
+	# 4-char abbreviated hashes on index line
+	grep "^index [0-9a-f]\{4\}\.\.[0-9a-f]\{4\}" actual
+'
+
+test_expect_success '-L with -b suppresses whitespace-only diff' '
+	git checkout ws-change &&
+	git log -L:func2:file.c --format= >without_b &&
+	git log -L:func2:file.c --format= -b >with_b &&
+	test $(grep -c "^diff --git" without_b) = 3 &&
+	test $(grep -c "^diff --git" with_b) = 2
+'
+
+test_expect_success '-L with --output-indicator-*' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --output-indicator-new=">" \
+		--output-indicator-old="<" --output-indicator-context="|" \
+		--format= -1 >actual &&
+	grep "^>" actual &&
+	grep "^<" actual &&
+	grep "^|" actual &&
+	# No standard +/-/space content markers; exclude ---/+++ headers
+	! grep "^+[^+]" actual &&
+	! grep "^-[^-]" actual &&
+	! grep "^ " actual
+'
+
+test_expect_success '-L with -R reverses diff' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -R --format= -1 >actual &&
+	grep "^diff --git b/file.c a/file.c" actual &&
+	grep "^--- b/file.c" actual &&
+	grep "^+++ a/file.c" actual &&
+	# The modification added "F2 + 2", so reversed it is removed
+	grep "^-.*F2 + 2" actual &&
+	grep "^+.*return F2;" actual
+'
+
+test_expect_success 'setup for color-moved test' '
+	git checkout -b color-moved-test parent-oids &&
+	cat >big.c <<-\EOF &&
+	int bigfunc()
+	{
+	    int a = 1;
+	    int b = 2;
+	    int c = 3;
+	    return a + b + c;
+	}
+	EOF
+	git add big.c &&
+	git commit -m "add bigfunc" &&
+	sed "s/    /	/" big.c >tmp && mv tmp big.c &&
+	git commit -a -m "reindent bigfunc"
+'
+
+test_expect_success '-L with --color-moved' '
+	git log -L:bigfunc:big.c --color-moved=zebra \
+		--color-moved-ws=ignore-all-space \
+		--color=always --format= -1 >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	# Old moved lines: bold magenta; new moved lines: bold cyan
+	grep "BOLD;MAGENTA" actual &&
+	grep "BOLD;CYAN" actual
+'
+
+test_expect_success 'setup for no-newline-at-eof tests' '
+	git checkout --orphan no-newline &&
+	git reset --hard &&
+	printf "int top()\n{\n    return 1;\n}\n\nint bot()\n{\n    return 2;\n}" >noeol.c &&
+	git add noeol.c &&
+	test_tick &&
+	git commit -m "add noeol.c (no trailing newline)" &&
+	sed "s/return 2/return 22/" noeol.c >tmp && mv tmp noeol.c &&
+	git commit -a -m "modify bot()" &&
+	printf "int top()\n{\n    return 1;\n}\n\nint bot()\n{\n    return 33;\n}\n" >noeol.c &&
+	git commit -a -m "modify bot() and add trailing newline"
+'
+
+# When the tracked function is at the end of a file with no trailing
+# newline, the "\ No newline at end of file" marker should appear.
+test_expect_success '-L no-newline-at-eof appears in tracked range' '
+	git log -L:bot:noeol.c --format= -1 HEAD~1 >actual &&
+	grep "No newline at end of file" actual
+'
+
+# When tracking a function that ends before the no-newline content,
+# the marker should not appear in the output.
+test_expect_success '-L no-newline-at-eof suppressed outside range' '
+	git log -L:top:noeol.c --format= >actual &&
+	! grep "No newline at end of file" actual
+'
+
+# When a commit removes a no-newline last line and replaces it with
+# a newline-terminated line, the marker should still appear (on the
+# old side of the diff).
+test_expect_success '-L no-newline-at-eof marker with deleted line' '
+	git log -L:bot:noeol.c --format= -1 >actual &&
+	grep "No newline at end of file" actual
+'
+
+test_expect_success 'setup for range boundary deletion test' '
+	git checkout --orphan range-boundary &&
+	git reset --hard &&
+	cat >boundary.c <<-\EOF &&
+	void above()
+	{
+	    return;
+	}
+
+	void tracked()
+	{
+	    int x = 1;
+	    int y = 2;
+	}
+
+	void below()
+	{
+	    return;
+	}
+	EOF
+	git add boundary.c &&
+	test_tick &&
+	git commit -m "add boundary.c" &&
+	cat >boundary.c <<-\EOF &&
+	void above()
+	{
+	    return;
+	}
+
+	void tracked()
+	{
+	    int x = 1;
+	    int y = 2;
+	}
+
+	void below_renamed()
+	{
+	    return 0;
+	}
+	EOF
+	git commit -a -m "modify below() only"
+'
+
+# When only a function below the tracked range is modified, the
+# tracked function should not produce a diff.
+test_expect_success '-L suppresses deletions outside tracked range' '
+	git log -L:tracked:boundary.c --format= >actual &&
+	test $(grep -c "^diff --git" actual) = 1
+'
+
+test_expect_success '-L with -S filters to string-count changes' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -S "F2 + 2" --format= >actual &&
+	# -S searches the whole file, not just the tracked range;
+	# combined with the -L range walk, this selects commits that
+	# both touch func2 and change the count of "F2 + 2" in the file.
+	test $(grep -c "^diff --git" actual) = 1 &&
+	grep "F2 + 2" actual
+'
+
+test_expect_success '-L with -G filters to diff-text matches' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
+	# -G greps the whole-file diff text, not just the tracked range;
+	# combined with -L, this selects commits that both touch func2
+	# and have "F2 + 2" in their diff.
+	test $(grep -c "^diff --git" actual) = 1 &&
+	grep "F2 + 2" actual
+'
+
 test_done
-- 
gitgitgadget

