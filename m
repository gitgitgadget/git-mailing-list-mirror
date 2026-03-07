Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B58248B
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845345; cv=none; b=lM+ktfdrSvLJ8Svj5DohETbk7TAfeKIIdJg9AwkVXYn1xNbE5ESb5vhBJpiAh0qt34EJGDCQsw7M8BED2kDupJEgzuMFSK0BDqalfKg7pPmYrp7iMJ9qB1kxkeWUINuW/Y+xmwO1S2dtXe6a6YmGFZkCetpdso7fRKOKKvDGPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845345; c=relaxed/simple;
	bh=9Up/Yr3QwQ6eQCGWlx5UVNqr2appgbSFQoYhRFMaJDc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ELTLFDIqDTnWyzOWZwnu0EaF9m5/jFBAZONSDvShA1WfD2BCzzwWxYOuvPh/t0bE+GYRMMoQTd89XvsNMixG9k0Rwf/EHOmCyvZrfUG42mad0LSk8K2iP38GsLoSFeo1MJ3wi9wuerKBG+DfO2eMf+EyQKfPdOm8EvW1mjI2rLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjLNu0rI; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjLNu0rI"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-46391e91e16so6776211b6e.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845342; x=1773450142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHDZoIrrzZADP7L9tMHhTCctXoZzttfbLJqcm2w5LOU=;
        b=OjLNu0rIGPZc5WNFQCultf83We5F3WJSscrW8ESLsUW22xRjjowIeXJpGZaIWy2mwg
         q5M0vREXuoggClmI4cNp8eV+GfN3ADUo/TfsdPcgvUZqJONoGXzI8T3M++kdNcZs18yY
         uC4nUaRlRgDxtEg333onR5rcEIwpjYcZqiR81RJ9He5tdZTIgvI/8BMIn75+/AUScek8
         EHxf8pU4wm7tbLRpWEESR21PLuifRd4SC7iNput8GJzzPPIOOblVwodjEv5jJWH0mh+v
         tVLpTVbrh82vFWd/WN1WyMQHunsItypJcmS5azKjaZfXBJCPZwDuMnpncLLaEFgIBmu4
         bVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845342; x=1773450142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHDZoIrrzZADP7L9tMHhTCctXoZzttfbLJqcm2w5LOU=;
        b=HnErKiXGSBUwxwnh4fE3U9oXq560B3bdDeFl8F/W0W7PjWydO4gC/FtSpclkNpwlBQ
         p3Jd3/LMcOqLVr9Hr6hwMalG9dqdspmect3WYzBT4achVhyzZJQxTyD0Qbi7gTONkS2r
         B6ArzCkfSBBs/LoLqYFZbseSn3C+OJxVszTWXn3woQxJBo5FuovKqjHikmFeTP5DpnM1
         SfFubGWfFKXoAHpB1y1NtMm35oPTpSHhtF86+XwY6oiRHpNiR00vjJNn4EtXCMRIJZnc
         Q6VDonc1/GZcOol0ZK2gvMMVPAbsM5o9PMsZ0wKobSZ4PfVcC/5qOiPFvZj6Xrrk0rWP
         oYbQ==
X-Gm-Message-State: AOJu0YzvqHlQMfkIx5mfkU9RKcUqd6UigOUGUhAq5n/+JTFgygpvzZ+U
	ndOH5tSqW3V4+NMi+a0kZfGknDSSmWlFZlnk0iUBA/ClSwAlyKyEJZf5+O26lQ==
X-Gm-Gg: ATEYQzy3OA1uAqUPnRFYEAPpJVsr/HFG+YqX5T5XZiLfqj88/VFoVMCnCaJtZgFGKn2
	b9zTlHLOlMted5js17+6AR8IX0nrL72Od1faFwCLHHqccvwcVq9Y8fMkSX1VG0dqUGWEr7fHYL/
	9DgXbHTQs1tsDbnGgJSl/vVnYI1t8z4jGH9Q+ZZUlVS/ALj2+tTjOzoYH0dlk7TXvdR1adgfVys
	pZc4SQ73mENQE+I4ApjZY35zljVDG3VJWJriAkQqpIggN4xu/QanP3NTyil4ZhEOCVLARZCw59/
	YlR2Vlgdy4U1lMd3QbZUDz9lYTODKc0dAZ38IRxsv/O3pGJqYI3K40QXYJ3a71Y9ZryZ2XWH2F+
	bPSjXoQ3GZFYI0+mKCH24j7Nm9DlCfFfXYpm0GzxWh6lbH5WtWEBC2HtS1IfTt6Ph16RQmTnE4B
	iERupKO6yDnfyblLp3x4v9Uaca0tc=
X-Received: by 2002:a05:6808:c1e7:b0:45f:131b:db33 with SMTP id 5614622812f47-466dc9ea77cmr2572902b6e.4.1772845342571;
        Fri, 06 Mar 2026 17:02:22 -0800 (PST)
Received: from [127.0.0.1] ([172.212.169.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466df93e85fsm1677873b6e.2.2026.03.06.17.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:02:21 -0800 (PST)
Message-Id: <e7b8cc2c78b0e67420a46dae8fd444dfe925a6ec.1772845338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 01:02:15 +0000
Subject: [PATCH 1/4] line-log: fix crash when combined with pickaxe options
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

queue_diffs() passes the caller's diff_options, which may carry
user-specified pickaxe state, to diff_tree_oid() and diffcore_std()
when detecting renames for line-level history tracking.  When pickaxe
options are present on the command line (-G and -S to filter by text
pattern, --find-object to filter by object identity), diffcore_std()
also runs diffcore_pickaxe(), which may discard diff pairs that are
relevant for rename detection.  Losing those pairs breaks rename
following.

Before a2bb801f6a (line-log: avoid unnecessary full tree diffs,
2019-08-21), this silently truncated history at rename boundaries.
That commit moved filter_diffs_for_paths() inside the rename-
detection block, so it only runs when diff_might_be_rename() returns
true.  When pickaxe discards a rename pair, the rename goes
undetected, and a deletion pair at a subsequent commit passes
through uncleaned, reaching process_diff_filepair() with an invalid
filespec and triggering an assertion failure.

Fix this by building a private diff_options for the rename-detection
path inside queue_diffs(), following the same pattern used by blame's
find_rename().  This isolates the rename machinery from unrelated
user-specified options.

Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 line-log.c          | 22 ++++++++++++++++----
 t/t4211-line-log.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index eeaf68454e..9d12ece181 100644
--- a/line-log.c
+++ b/line-log.c
@@ -858,15 +858,29 @@ static void queue_diffs(struct line_log_data *range,
 	diff_queue_clear(&diff_queued_diff);
 	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
 	if (opt->detect_rename && diff_might_be_rename()) {
+		struct diff_options rename_opts;
+
+		/*
+		 * Build a private diff_options for rename detection so
+		 * that any user-specified options on the original opts
+		 * (e.g. pickaxe) cannot discard diff pairs needed for
+		 * rename tracking.  Similar to blame's find_rename().
+		 */
+		repo_diff_setup(opt->repo, &rename_opts);
+		rename_opts.flags.recursive = 1;
+		rename_opts.detect_rename = opt->detect_rename;
+		rename_opts.rename_score = opt->rename_score;
+		rename_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+		diff_setup_done(&rename_opts);
+
 		/* must look at the full tree diff to detect renames */
-		clear_pathspec(&opt->pathspec);
 		diff_queue_clear(&diff_queued_diff);
-
-		diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
+		diff_tree_oid(parent_tree_oid, tree_oid, "", &rename_opts);
 
 		filter_diffs_for_paths(range, 1);
-		diffcore_std(opt);
+		diffcore_std(&rename_opts);
 		filter_diffs_for_paths(range, 0);
+		diff_free(&rename_opts);
 	}
 	move_diff_queue(queue, &diff_queued_diff);
 }
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 0a7c3ca42f..7acc38f72d 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -367,4 +367,53 @@ test_expect_success 'show line-log with graph' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for -L with -G/-S/--find-object and a merge with rename' '
+	git checkout --orphan pickaxe-rename &&
+	git reset --hard &&
+
+	echo content >file &&
+	git add file &&
+	git commit -m "add file" &&
+
+	git checkout -b pickaxe-rename-side &&
+	git mv file renamed-file &&
+	git commit -m "rename file" &&
+
+	git checkout pickaxe-rename &&
+	git commit --allow-empty -m "diverge" &&
+	git merge --no-edit pickaxe-rename-side &&
+
+	git mv renamed-file file &&
+	git commit -m "rename back"
+'
+
+test_expect_success '-L -G does not crash with merge and rename' '
+	git log --format="%s" --no-patch -L 1,1:file -G "." >actual
+'
+
+test_expect_success '-L -S does not crash with merge and rename' '
+	git log --format="%s" --no-patch -L 1,1:file -S content >actual
+'
+
+test_expect_success '-L --find-object does not crash with merge and rename' '
+	git log --format="%s" --no-patch -L 1,1:file \
+		--find-object=$(git rev-parse HEAD:file) >actual
+'
+
+test_expect_failure '-L -G should filter commits by pattern' '
+	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure '-L -S should filter commits by pattern' '
+	git log --format="%s" --no-patch -L 1,1:file -S "nomatch" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure '-L --find-object should filter commits by object' '
+	git log --format="%s" --no-patch -L 1,1:file \
+		--find-object=$ZERO_OID >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

