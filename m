Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60F4A13A4
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812405; cv=none; b=scCZhwQkMyA0ac7Mmx6K4oWIAS8ycVDKeoUbosiHNdN5AOK9P02QtFC27nzOcUQRoY4MaTDr8qc4ozpoi4CoVgtoN+mRJW2xrHDdquuERTKd1Oo9VdTCfZUdF7qOhCg6yyTAyXBNueA3/ezSBbvw1d/gN8jgUNHZHnFgKt0FlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812405; c=relaxed/simple;
	bh=AjGUOMnlqVQtCOYtasdoci1vWn7utIdKijq9KJ+tHQw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=euV+WLV4o/+44yq23Yyr6iBeXSR3/2wylCVh9jUj9i9P4d2BgYUZsXY3U0cRa1D8388XuODlH2fSgeBUMZ6aOvKxh0O5MM/zV3KKf8JxvggDVqNAPL+74H0UYb+YHKq4XxpJqirz1hNBuhuRkiMLVv7Hoq7HQG2zZ4k5140NFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8yhnCVM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8yhnCVM"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c953950dfso4793901fa.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784812395; x=1785417195; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=azs5drk3KRLAmmrIlinakIpOk4mRX/FxMjB1SPbmOY4=;
        b=o8yhnCVMI7zc+I0VXTsOQ6l5DLpxLflfQvQyvxH3ihw6oUs8oo5IYTcooo/G9UO0on
         2+au3Y5RWh7wrH1hJCjcrDzL/wIc6YGZWDfp602QtWnzSNlXAdLyv+9YgEsu4KPVWvWx
         Byg3RDqGVZtcY/FvzeR7zmA1jSH5/et9mMgyUGOmu0l4j3XFxYrWAQtgbbx5y0dld8W9
         iG/R3BEA1kJQ4bSlYDN/SnRRPp9UWYRR8a/6mD6V8cJ2W96IUG4houvpzg8hvaGvlWbF
         kuN9zEZoyk/FhgavPEtKzZpAD9GPLAZXlLCw+hWTvlNkRHCIynGds3Hk1ZwFYUjOxq3r
         YitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812395; x=1785417195;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azs5drk3KRLAmmrIlinakIpOk4mRX/FxMjB1SPbmOY4=;
        b=WpGoEEDjzEnHQms+vP7oOKiaBJa0hGwCwIz3BQEdXE40DMV+hZlRR7I5eX588W9i81
         g2yqZm8n2FSrlAtrphiHsANaOjsbsrnLfQAWfyiOWPjrE9dyPtJRxVdvCNA7AyotUT5v
         N6m6emYwrqrSGwHNP91M66jBgUNmBKCF+o2mwe0U7iSxR0KImwEoeZlrhzRCY9MaQxx4
         qSz7y38kRSo01OX1yrwe5NldZZ9iYCOMVybqjIPnnk8NXVIGfMff1WK0e8Xf8dt2S5TA
         kNjJvJZ+UFkTRrJvVFcYzvufMyiNfLUn06zD4tCPxcWKMahCAqNqkYYnNP5lkcEBrqbA
         5Svg==
X-Gm-Message-State: AOJu0YwQ1nF1Y64CEbiv1njzLlwDD2BCZKnEUYlGg1hq7GVLs4pAJqxY
	/mFajodgruA6hc6EDNS6gx2Q/HwjFSY0q2ALumS/nvU0SsN0Yfqx1rsPBgRQes4t
X-Gm-Gg: AR+sD12oRDHGaWmlnFvJdlvlTqn+LSbyWWbbAtF1UFjuOF5mkY/C/6ZD5hNyDnT+TMK
	NDLP45svUxCjaa7mH74zCH75iSIbKajCjIilykyd1d1PwNKBiXz8JE0kmkl3KUCgcrwlr4FGrow
	2gPmkYaiMpavAYyaIHTBViYUwJgZMpZerxb8unx0E35WOypFhWst7x5mLeU/UEo9mFn9KdtDdh8
	nCdctWcbiSdiGpOvCpvYyYh3u8IEmtxLmRTVujrRTmCO4/NynifsAIZS4i8jNccgUO+jiAYvBIh
	ajDidSu81ajaCfh7rZ0eVwf7jX+xTqHtnB4j+Awt8a46ZotfKJfo/UKHcr3ItE2AEGKeYP6gWRP
	tqiPu0yBqCEBpm3yK/VIhduUaPmuP1Q5mz70FXwH0hHAkoiTmb87R4ANDSCF6j5n56cO9YM1VRu
	y6P27X
X-Received: by 2002:a2e:b8ca:0:b0:39a:ee64:36f4 with SMTP id 38308e7fff4ca-39f07c24ecfmr6097761fa.1.1784812395093;
        Thu, 23 Jul 2026 06:13:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.103.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6c41c9bsm8906001fa.19.2026.07.23.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:13:14 -0700 (PDT)
Message-Id: <1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 13:13:10 +0000
Subject: [PATCH v2 2/2] mv: check for missing destination directory before
 renaming
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

Moving a file into a directory that does not exist fails at rename(2)
with ENOENT. The checking phase already rejects a missing destination
directory when the destination ends in a slash, but a destination that
names a file inside a non-existent directory is not caught and only
fails later at the syscall. As a consequence "git mv -n" does not
detect the problem either: the dry run never reaches rename(2) and
reports a move that would not actually succeed.

Detect this during the checking phase. For entries that will be renamed
on disk, stat the destination's leading directory and, if it is
missing, fail with the existing "destination directory does not exist"
message. Guard the check with the same condition under which rename(2)
is invoked, so that directory moves, whose child entries are expanded
to paths under a not-yet-created directory, and sparse or out-of-cone
destinations, which are not written to the worktree, are not flagged
incorrectly.

This is a best-effort diagnostic rather than a guarantee: the
destination directory can still disappear between the check and the
rename(2). It fixes the common case and, unlike the syscall path,
lets "git mv -n" report the failure.

Add tests covering both the error path and the dry-run detection.

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
 builtin/mv.c  | 21 +++++++++++++++++++++
 t/t7001-mv.sh | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 35e504484a..eb59fe0f31 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -444,6 +444,27 @@ dir_check:
 			goto act_on_entry;
 		}
 
+		/*
+		* If we are going to move SRC to DST on disk, DST's leading
+		* directories must already exist.
+		*/
+		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
+				char *dst_dir = xstrdup(dst);
+				char *slash = strrchr(dst_dir, '/');
+
+				if (slash) {
+						struct stat dir_st;
+						*slash = '\0';
+						if (lstat(dst_dir, &dir_st) < 0 && errno == ENOENT) {
+								free(dst_dir);
+								bad = _("destination directory does not exist");
+								goto act_on_entry;
+						}
+				}
+				free(dst_dir);
+		}
+
 		if (ignore_sparse &&
 		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
 		    index_entry_exists(the_repository->index, dst, strlen(dst))) {
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7cf4aa5ba1..2d8a98d8b0 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -114,6 +114,20 @@ test_expect_success 'clean up' '
 	git reset --hard
 '
 
+test_expect_success 'moving to non-existent destination parent directory' '
+	git reset --hard &&
+	mkdir -p from &&
+	echo content >from/file &&
+	git add from/file &&
+	test_must_fail git mv from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
+test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
+	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
 test_expect_success 'moving to existing untracked target with trailing slash' '
 	mkdir path1 &&
 	git mv path0/ path1/ &&
-- 
gitgitgadget
