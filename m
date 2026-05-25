Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A392386562
	for <git@vger.kernel.org>; Mon, 25 May 2026 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738068; cv=none; b=rdbNeFkjUuwccx7A6L/MuVPNmefKmQAX1Ai0yD1woCTBs9w6O3PaxL79cSJdbR48EgC/RgQK2w2K9PimNcCrCtaaxKenlAKJRoEuXRHlev0eRndT0afadIqnfwZyOrJk1DD4CLQXjPNj3DIu26vqCh6VK3oue5t1vNZvuu7SoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738068; c=relaxed/simple;
	bh=kTLNSaoN8YE60gKoLTuRljPGCdygoZXAqEVxdzB78a8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lgB1O7oAjkn/uLJaOMptAOalYRcjXqIvFvmLMnnreIaRLQBWPO7j4ZW7ry5L2rkLWbxK8FHxoTXH+7xHciFdovLplxa0GrluIkZTnwAZbyccmFuf3bKAC1E6zQlJPX6YrHyzv36+UZkieu5yLMaofKdD3kqYz7VaiNx3Nvj/bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5mY7Dhx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5mY7Dhx"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4855562f32eso1157215b6e.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738066; x=1780342866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOcD4eP5U6ypIEZiR1aFN8sfOuUUBakJwtIAchQx34U=;
        b=J5mY7Dhx3RueGUk5ZLViaeCYqiRxQsNQkQwtpRgnF48RBGeJioH2NAIiHtRf7V2w0E
         puqwLmLrGjh4YPsk1pudvDL06WYtqPSKJt2Dvsb2UiknWAzYRD56XdiMYHx41lqVXFCQ
         0sdDQ7CweTCi0IVwn2xCoiZKam1lyEixq0pUpme4yt9barSQL0L14E0AlyEbu5ScVjRz
         efp5zZ6Aw+hFhab29hJtJkgUlR4Gx7NgwrBxuy2u6cgn/AWJwfWQqInWWSHLNhqqvXF6
         cYfVMYJf9Yfs6gOf6LfxRMifrzzfa67mt07EJ1yVRwoQHWciDFM2Ey2/pSQzcDGjw2AJ
         I80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738066; x=1780342866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOcD4eP5U6ypIEZiR1aFN8sfOuUUBakJwtIAchQx34U=;
        b=KwiHxWDMGwlFqCHdBQB3K2buIlP4Z++PMR9f/u481bIMX8+5PGnBpNlJ16rS4WXhRM
         qSHg4c52rmOAGwb7cnK/W826lRjsyGsqKY+V/SoyGELwJGpPQbBQBrd0b03vaytTswD3
         p8o0CSTJNpp33sOb8zAaYI/th8k0XG/hoI/rj2XtxG2lljt+eC8BfXD0Z4A4BB4hZfjp
         ySRZ9KtqTY/Pw+jM0TEqWFDfHkOuTFcS/An+pjQ0KmtqJIRwFBSUgCBsiEj1jrNY+xBl
         SlKy1NNBfQjMrv7bi3dmiye9qlgHRsJFijuylbPs3NakmqpcQyZhMoXYVB5bSDmLgd5v
         6SFA==
X-Gm-Message-State: AOJu0Yz8PLQ1Wl5IbYlGVAaTrD/+FwRaN0rCk9StDEujLoHJMwD9/gfG
	y7WAcGk7cfIm8nZ5u9FeUbJA2vwepdAn5wh8OaNyb0j+AKqxFTRS4Oyyd+amwg==
X-Gm-Gg: Acq92OE0Hqy/G9j+azD20OpRmFVmRmr8RG9b2/hmytxBByLKSj3295WLzW/ERmkPKQ1
	R8RBftI10R/OyjjPUUvt+25XoNFRlMKNp4v2LYJLx2pC19guV5eL4Zor90yYky0ZWt+nkk4U2o6
	HJU/lB3U+jthMBD1ps/qSu2BNiwNlukc6RRvg8NdQLwIgBqzmEyVKARiWrfeYMpfGGNK1c5sQmO
	8xo7HswQPOs0jV/Ghy3B8WfcW86NSxCnUS/rUmfi9wheHC2zm/pD4/FCQzdVQYURAnKi1VAKYAf
	Y4PQm8J1W8D0fMoIxXjZqzlFRRQUcbWJ+dBFYOe9yxXU1cBZaf9q24pb0jYrb2mDNQUisUyHoky
	hs30Du8WSaDh2h+Itn9XNEggPHY8EsL/fOUMVfSz7/rcoqSMSe0+M54GnZR8ga9O6v3F3CwW2K2
	opxoz5qpBQe4mkeRvK9MaOIRkq+is=
X-Received: by 2002:a05:6808:1581:b0:485:a785:266b with SMTP id 5614622812f47-485a78528edmr151462b6e.44.1779738065820;
        Mon, 25 May 2026 12:41:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.164.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5155355b6e.15.2026.05.25.12.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:41:05 -0700 (PDT)
Message-Id: <10a3d8dde2dbc16fd7918f1196065b06151d496a.1779738059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
	<pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 19:40:58 +0000
Subject: [PATCH v2 3/3] line-log: allow non-patch diff formats with -L
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
index e3937138a9..4722ec3e29 100755
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
+	! test_grep "^diff --git" actual &&
+	! test_grep "^@@" actual
+'
+
+test_expect_success '--name-only shows path' '
+	git log -L1,24:b.c --name-only --format= >actual &&
+	test_grep "^b.c$" actual &&
+	! test_grep "^diff --git" actual &&
+	! test_grep "^@@" actual
+'
+
+test_expect_success '--name-status shows status and path' '
+	git log -L1,24:b.c --name-status --format= >actual &&
+	test_grep "^M	b.c$" actual &&
+	! test_grep "^diff --git" actual &&
+	! test_grep "^@@" actual
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
