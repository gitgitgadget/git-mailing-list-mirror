Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0942A82
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775387407; cv=none; b=jxKTUvGSo88ntBf9yrU1tGpKQb2aB2mN8Ay7acT28m3NlmL1719vgFRuSzU2weRViqhHtvry5xBR4R9P5SJKy312ohtMDWvuBAfy+NQKpN486OW1WMvKBcABK2ecm998zwsgWjM+AzNiq5XErIzvRMjKkZ8s72m9CxM6ZBQ1W2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775387407; c=relaxed/simple;
	bh=S3CafAsXK3t2EYRs/yuwS5f0OJdTMJKenYgE9RWL/Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHkFSOjoxlK3m6ZOESEM2DOhqZVak7gKROnVAgFraGAnFaXmdbuxgx4SDZUOgv2LISDQewU2tBEJvB6FOejK1bOKSvJhJ1h/gmAjt6HVU5F05gJIF7/AIyd5lpQ0jncSaRVuwBUQ4P/0+N+OHt873pjDQC91X3NWkaLYm9Ml6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXtAqiPi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXtAqiPi"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748257f5fso2423976b3a.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775387405; x=1775992205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h0c5r3ULC/nwljA4cZHvOnoNX0QKWrZj/11DqccNzU=;
        b=VXtAqiPikWiQEXhEG23NVai/YfQ5YYDbsrrVqxBwbfgqHMI8LXON9nui3KxEDKf18F
         Hr/gawj/3bqbAKyhENV+A8snhffm0EvxVv2VnvjmcR8OphR1YKsFs516bwKIrWeGP5pY
         fxvbZ9kMdOPv3QiS5gjrhCKSa+7Hkf2bkbuiQuPZPsZDTd657ZmJqW9IEcObAIjQaCR4
         JRHBNeygkGQt/22piRTVW38jGlzz/sX1zjdgRdlLBPI99eTVEhhGayIg71BNnBxIhtck
         sfoWDwSsorrRbdiKIr9QofDv957C/gHZo3A+A0qLf16vTaLBDxLlc3iAuD83WXKfnt8P
         47/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775387405; x=1775992205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2h0c5r3ULC/nwljA4cZHvOnoNX0QKWrZj/11DqccNzU=;
        b=X1uBdLglvKPUMz5dcMttTJyVTDdNXODqsaNsBce9dor5qVWXn3V7MJp+UYc/xBg5AH
         5QqP8RHHOxwaJMOWMvhlL8Uny87Sod0qJ2DQMbK353Dwv//TCxHznpTohV0Q9IRHscxV
         NmKfjIdndfKHnR2480eFR2bWBBGc0tlo79GBqLBE5S1b0Xq2vACxKnVu8d6YI637pLVi
         +dAUIiyuBzZgi3nvV+kXAmcQxkhq07E1TY8XHeyzZR+rPe9E06bmFeGITvg5zfrrd12w
         H5dSLCSCskeP2jg/RRyytCduUSNZrCc3LfCgHrmepjP4w9/DCehytdcwrARwWN0/uWNS
         lcsg==
X-Gm-Message-State: AOJu0Ywz5DjhTK8nyXtGlg1pSGQgAaZDOxlpbqZP69+6CxQ+YyOMExJB
	HtWwx0y4mN4kZ5QuFgRdtiAIdtc/2saIlUwPfYLKpfY+sPN/HwqC6diyKnH7zQ==
X-Gm-Gg: AeBDieugKtlrN1nxnjKignL7/mm8vo9R83AHi77iPEP03qZrSfwd0GGROxMID4oLqOL
	w1x9ztbxS4L0GpDqCujHwPiu5TFUersuIzW6i2D5fz63z4xyhMX5AbWvfox6HFrejQyx5rOYv4n
	FF2uB4TcVLBi/GETde/udn7oD6/pLYba+cGpN+C2BIahtWwYMc4/i/12dh7M5PQlFrDmbF+r6z/
	3mccNur0MtB3RE0yIMPPGJSnsvcwh0OsFE+5JQ3QK9x37UmV5rVPjwTrLZpVfE6e1oHEqXNxUY+
	MOL4IlK6HH+AXd/GvKrA7o86MkPLen2tKja5bx5SyQo0i6PLu0XIFvGbwYJT2ScZpAhXPhZoTXL
	67CnQB9SB7PqYb0RA6MYpfvhhZG1pZNFuruhvHCCLV0F54HI+CWJlRzLzkj3X/O0CCCPzANsGLY
	l0qYCFGYtH4bB8YePX54gBJwGSLcW1dyXFZ14LF6Rx+93rVa+M
X-Received: by 2002:a05:6a00:94ee:b0:82a:75d2:73c6 with SMTP id d2e1a72fcca58-82d003221acmr10324725b3a.18.1775387405294;
        Sun, 05 Apr 2026 04:10:05 -0700 (PDT)
Received: from d ([106.207.213.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2443dsm13796673b3a.4.2026.04.05.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 04:10:04 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	mroik@delayed.space,
	quentin.bernet@bluewin.ch,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v3] stash: infer "push" when push-specific options are given
Date: Sun,  5 Apr 2026 11:09:53 +0000
Message-ID: <20260405110953.3316-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260404143640.6679-1-deveshigurgaon@gmail.com>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git stash" is run without the "push" subcommand, the command
tries to assume "push" but rejects any non-option arguments (i.e.,
pathspecs without "--") to avoid treating a misspelled subcommand
name as a pathspec.  The only exception is "-p", which sets
force_assume and allows pathspecs to follow.

This means "git stash -m foo file" is rejected even though "-m" is
unambiguously a "push" option, and the user's intent is clear.  The
same applies to other push-specific options like "--staged",
"--keep-index", "--include-untracked", and "--pathspec-from-file".

Expand the set of options that force the "push" assumption to
include all push-specific options, so that pathspec arguments are
accepted without requiring "--" or the explicit "push" subcommand
when the command line already contains a push-only option.

This was marked as #leftoverbits in [1].

[1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---

Changes since v2:
  - Clean up staged file with git reset --hard at end of test
  - Update documentation to reflect new push inference behavior

 Documentation/git-stash.adoc |  7 ++++---
 builtin/stash.c              |  4 +++-
 t/t3903-stash.sh             | 23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..e4e77c2f07 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -61,9 +61,10 @@ COMMANDS
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
 non-option arguments are not allowed to prevent a misspelled
-subcommand from making an unwanted stash entry.  The two exceptions to this
-are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
-which are allowed after a double hyphen `--` for disambiguation.
+subcommand from making an unwanted stash entry.  Pathspec elements
+are allowed after a double hyphen `--` for disambiguation.  When
+any push-specific option is given, the "push" subcommand is inferred
+and pathspec arguments are also accepted without `--`.
 
 `save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..197814241c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1877,7 +1877,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage, flags);
-		force_assume |= patch_mode;
+		force_assume |= patch_mode || stash_msg ||
+			keep_index != -1 || only_staged ||
+			include_untracked || pathspec_from_file;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..f021dc9068 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -414,6 +414,29 @@ test_expect_success 'dont assume push with non-option args' '
 	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
 '
 
+test_expect_success 'assume push when options imply push' '
+	git reset --hard &&
+	echo changed >file &&
+	git add file &&
+	git stash -m "implied push" file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --staged file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --keep-index file &&
+	git stash pop &&
+
+	echo untracked >untracked-file &&
+	git stash --include-untracked untracked-file &&
+	test_path_is_missing untracked-file &&
+	git stash pop &&
+	rm -f untracked-file &&
+	git reset --hard
+'
+
 test_expect_success 'stash --invalid-option' '
 	echo bar5 >file &&
 	echo bar6 >file2 &&

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.230.gd8af7cadaa

