Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E70347FCD
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001273; cv=none; b=b9Ivp4pNvdTHCAavgTJyDH9DpvGAbo2ErD3cbvBGmiSUBBVU3y5bK7fOV4Ka0umKvB13TOkaz7wax3A30ng00ZcgIgGsfgEAY0iXh4sb8ZtFLsmFfwAM0SwRX7KYjiYNzvG3WRqVHnZdd5XjaEJPUaspM75XA4yu1Rpr8B3u/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001273; c=relaxed/simple;
	bh=tqnXjlRpq+f6BMfvug/ZWquVVac1FEwHchxB3khe+Cs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mVgrWUI1Qn4/Mz11xybz5ePOkoAheL8EXvls4w4QkEweC42gkY8eGLAaO8WwLFRqghQljj0RsKPjFJZQgpw7F3xZXwvLojQbfCLPwtnfwzLH5/JPS7HeVg81U/3gBlibBTPrD6e+sTsS14jOUNJYvRbEA14OdFsMo0ICU7hq9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqCTQksD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqCTQksD"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccce57762cso15285596d6.3
        for <git@vger.kernel.org>; Thu, 28 May 2026 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001271; x=1780606071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRY1m4tn+b8NULutTTtmK4t5RAMYYCU9Py67gzHCM1E=;
        b=dqCTQksDoJsm//jNfNE9Rqarkzz3O011OAadZN/ighHcGqaO1XxaUHllaeHWfA4lYs
         IBw8LLLSuPhBIkXkRH872SIpHWPpZdIx4KEaM4bxJf8jyQZ+7jizVspSumQK4dZKZD4+
         Gqj5JXZ6en7cG66cuqDn7sea8cGuotaiDaiqLG+S9aGiEUnq79DdeveTa86vBiNkOp9S
         yWuobg3a1kIgtwMyGjF39qFwr3lYxtx92eapkz9b/k9VWlambcw/6/T3J/O9yc/PXTzZ
         CQg4HCPlRuLbmToy046+bbCdgGoC+PbhXIc6oUbidFbZWrgrneeIE7kB2Opreg8OYwQZ
         CPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001271; x=1780606071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRY1m4tn+b8NULutTTtmK4t5RAMYYCU9Py67gzHCM1E=;
        b=R2JaURWC31m0+5QnXlNQ+dSv53+UXW575mvr7MOA/4Dx8W8QDGEXpXySxYeRK1DWHj
         cuAGx39UJXa31whPTaoxnaCVDD/APAJxbP9FgBhkpVv5jo+dQ2gCNRm88Vz2aLvu2nYA
         ZNaRasXLy2+fqijXuvV95v8B1nwxXw8zJUflaaLFxaEc82yngJIJkTooxafKHMOBSKM0
         e7/rnf8ICHPcfsP8R+al3gDNYilBJiAjJzvJ10Ga+Ub/L+dUgJ1PM42gD0LGbCPbVP38
         nXoH1Z/9uLSMrC6avFJecLCTCxKsuOHKc1DN56+nSctE1rTl1DXiVMJGxvxjIorD6B4o
         PmXg==
X-Gm-Message-State: AOJu0YywVT93fxE94YDl6ZWrom6EaKBVojq/WXFrPq74v1TAREQlLN4E
	FXQO1PxXR3I66qS/3LNsNAm1siYy0o8rhJlRyfiqX8AxerhIVFemOyE8pFHOWg==
X-Gm-Gg: Acq92OFVchot+OffsxJnsulK182j8FzatQ16PybVcHNITBUV4//S/+bU0M9UZJEJcWN
	8P65KTcPZJfIcEOfIpL9CrmrrU88cIkhULvqDqC+hoPCiXIlInciAggluN+sVCFJSZXpeU+cnLh
	M2XQUuw2/1DcR9zoMCbgsP7Thx9LoeNvh/oYlmas+Z2eUshZ7257fb7dOubT1BkaOha56TvbNhV
	qH0zvity3JUdLrVc5HLQZbRN8bNzvLy+pxgqZlSfPnBb46J2yzCBZ6Vw9AQLvdD4c8KZg6FQFkL
	+z+EXiQK+LrLVnbuiJHl3kJJUG3FQTD3UPptGFoX7zQCW9/3GUWqUwqAeUF09fKiamfshxiDLgJ
	Ok8BsTgWigJ7RLZq62TXURCwHZ8hIu3jxlf1i9j3l5UG/NFuospZimK4omJfbmIeO/071r74Huu
	6wXsgBlYyfStNmXJQzHXe7IeWeUfUXkcFMwcs=
X-Received: by 2002:a05:6214:328e:b0:8ac:a6a5:1f41 with SMTP id 6a1803df08f44-8cce214acadmr13346886d6.27.1780001271216;
        Thu, 28 May 2026 13:47:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306c57sm213467486d6.34.2026.05.28.13.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:47:50 -0700 (PDT)
Message-Id: <ae0b7f3ca8a0cb103bd9f65e414f8ac970b7ecb2.1780001267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
References: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
	<pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 20:47:46 +0000
Subject: [PATCH v3 3/3] line-log: allow non-patch diff formats with -L
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Now that -L flows through log_tree_diff_flush() and diff_flush(),
metadata-only diff formats work because they only read filepair
fields (status, mode, path, oid) already set on the pre-computed
pairs.

Expand the allowlist in setup_revisions() to also accept --raw,
--name-only, --name-status, and --summary.  Diff stat formats
(--stat, --numstat, --shortstat, --dirstat) remain blocked because
they call compute_diffstat() on full blob content and would show
whole-file statistics rather than range-scoped ones.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc | 10 +++---
 revision.c                            |  4 ++-
 t/t4211-line-log.sh                   | 47 +++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index ecb2c79fb9..72f639b5e7 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -8,12 +8,14 @@
 	give zero or one positive revision arguments, and
 	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
-	Patch output can be suppressed using `--no-patch`, but other diff formats
-	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-	`--name-only`, `--name-status`, `--check`) are not currently implemented.
+	Patch output can be suppressed using `--no-patch`.
+	Non-patch diff formats `--raw`, `--name-only`, `--name-status`,
+	and `--summary` are supported.  Diff stat formats
+	(`--stat`, `--numstat`, `--shortstat`, `--dirstat`) are not
+	currently implemented.
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
-as are pickaxe options (`-S`, `-G`).
+as are pickaxe options (`-S`, `-G`) and `--diff-filter`.
 +
 include::line-range-format.adoc[]
diff --git a/revision.c b/revision.c
index c903f7a1b4..f26fc1f4d5 100644
--- a/revision.c
+++ b/revision.c
@@ -3181,7 +3181,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->line_level_traverse &&
 	    (revs->full_diff ||
 	     (revs->diffopt.output_format &
-	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT))))
+	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
+		DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
+		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY))))
 		die(_("-L does not yet support the requested diff format"));
 
 	if (revs->expand_tabs_in_log < 0)
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index e3937138a9..ca4eb7bbc7 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -155,8 +155,45 @@ test_expect_success '-p shows the default patch output' '
 	test_cmp expect actual
 '
 
-test_expect_success '--raw is forbidden' '
-	test_must_fail git log -L1,24:b.c --raw
+test_expect_success '--raw shows mode, oid, status and path' '
+	git log -L1,24:b.c --raw --format= >actual &&
+	test_grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M	b.c$" actual &&
+	test_grep ! "^diff --git" actual &&
+	test_grep ! "^@@" actual
+'
+
+test_expect_success '--name-only shows path' '
+	git log -L1,24:b.c --name-only --format= >actual &&
+	test_grep "^b.c$" actual &&
+	test_grep ! "^diff --git" actual &&
+	test_grep ! "^@@" actual
+'
+
+test_expect_success '--name-status shows status and path' '
+	git log -L1,24:b.c --name-status --format= >actual &&
+	test_grep "^M	b.c$" actual &&
+	test_grep ! "^diff --git" actual &&
+	test_grep ! "^@@" actual
+'
+
+test_expect_success '--stat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --stat 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '--numstat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --numstat 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '--shortstat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --shortstat 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '--dirstat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --dirstat 2>err &&
+	test_grep "does not yet support" err
 '
 
 test_expect_success 'setup for checking fancy rename following' '
@@ -738,4 +775,10 @@ test_expect_success '-L --oneline has no extra blank line before diff' '
 	test_grep "^diff --git" line2
 '
 
+test_expect_success '--summary shows new file on root commit' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --summary --format= >actual &&
+	test_grep "create mode 100644 file.c" actual
+'
+
 test_done
-- 
gitgitgadget
