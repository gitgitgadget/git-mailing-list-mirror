Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45627FB05
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780921; cv=none; b=TTZrMo8/iHRz91g+EDTRug1+QiJ1uh3q19kUUH/78oQSVoiv9Jl8AdphlKcQMOX46wRekZdAPSHpEOfBTPn8WyfGIzvSTarhpS0ry/dHfViP2ZPy6ib0+lfUmUWszyq6iPBbCNtHZiKOVv8lEVcsAMxwQvpwazRRst6uNfGiOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780921; c=relaxed/simple;
	bh=bW4Wxhfzpho0v3yrVg1GqO3SAOgegMkIHFAKqwiI3HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1psFoenNSMIEUbNwI83rwVmXTdDF5+kc3xCcu3zQxgMfD9H/a5xkL9UyUeYkVdqi/nYw71RR1huUPaT4MLjdgg7nGLevzT6ObQY15OuJfaInuCK9+tHY2GnhlemKgkw4UsotZl+SVkL2VuX7WWVJrmC4vqsQrlam2l89+qCBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ6fXFOQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ6fXFOQ"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29226bc4bafso12059165ad.0
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760780919; x=1761385719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeXXh5pFNC+prsflryWyBbX1zO6wTsAbh/1oEkIY0Ww=;
        b=cJ6fXFOQiLH1Zt688ISxWtEH8chiKrpgXiUhsjZzFeMRulwA2eI2P4dZLryV4URxkf
         D0pAgrokKShgli5yytzRrfyMXMTE+uJ8Lhu7vO5d+KPgDvydv0FEvrRgPcS3+Rl+lqS7
         4W8x9x9dQd5ETNBoa2CfT9kfg2F+roG3WLvkt9A6tArtEuVTfRcR4ZwVuzHATaMywnKR
         dLENHf2A1NqcjFpqFWRGX7AXb61V0prSrLVCXXpSK0hKifPdhVW55sLpJdjJaLx6rzws
         kVeZKBKUTuRAYvh1Am7bdr0S4vfq6SEioTpvp8r6zbAjeadsPu/7HuYiWttSfxIY1S7x
         VWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760780919; x=1761385719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeXXh5pFNC+prsflryWyBbX1zO6wTsAbh/1oEkIY0Ww=;
        b=Cr8uYK2SYNXbWAK+Coz5pnjRVyQB5QOW8acCcyazam1VfeU898T0AWdrKI1xsqnGGj
         boORRx4OliHCnQGxHZX7qG8OEPV1EfkfWauydLAVBGOHq2Xp1WLvLLQDhHzVbaLdk2oF
         cZCJ2OTnNqnvdQXIhKyDNT5O+5//hi+S31mQObBtt5Oiyh1CNK+UEseMzzw4dR0pNb4B
         dbEIvd0YGvS+zeNLLmNsTh+ybwveWB8ULym+R79bshu7Zjp0VZHLQocbOWMeuNaohQ1s
         APbde7nzO/J5C8koOxKshCxJgXBQir4mzcptddeakJF+gef7khp0YTh7A19IZNDe2uy/
         6jSw==
X-Gm-Message-State: AOJu0YwhnxKA9giQ3S75U5goTBY9Z2g4K9nXBxjAGEnr0UcDl1chIbmp
	tX0Ni26TEU8QEqQh3P0Y4vlInrufPFIaZxpxLPkwr/KLtVW7X+YJ4wjl
X-Gm-Gg: ASbGncvOPR9qjWn34PqxWJU23Ki4eT7bbNiBvhG5EXa0K2sGAHsOTnw7YZKg4TPO9I0
	DqFkrXtidFhQFppR2j2SnHQEHGfGVlp+HxJtfGfgucoCLSs7vEuBzf/WNRyyQFmJ7BEDKaOMX/q
	RQZQbV/EYDzMY5KoHBdU82xfgENm/EolPmr9A5JqR/GugW/reKxMES9Vdh1acjrrlFD43CKAqTy
	llCJRD352tZAuT9W4CIa5hfofh345TOtqM6Wt+Qwex2IEzVukR2nZbsEolvMQ46agGrnGyCpTmV
	GBa6Elu6K1t1Cx6PssGuHzaj0itG4E8xk/7w+OXqKEpwyd3IYey1L77EWq8wRiX6nL+d91YQtmn
	rn8HfUFei+zVcYdXSbjxZf7FKXxU9jFkO5LwVPF3V3uUw+43bGUQr31hI5fWAFyMNyMk6o//TxM
	f1dsGieyv/kgwXb2K0YzqpMKYG0IStxsx2H13DRbVRbXg=
X-Google-Smtp-Source: AGHT+IEJboAX5rZEutrj+hO7rcdiM1Zf1dSfHUhHyg1FJWdMME3bxoiNKXS3hbq38TeN1cT4I1gjWw==
X-Received: by 2002:a17:903:1a70:b0:274:5030:2906 with SMTP id d9443c01a7336-290cb27bcc3mr89440395ad.46.1760780918820;
        Sat, 18 Oct 2025 02:48:38 -0700 (PDT)
Received: from localhost.localdomain (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm20921645ad.79.2025.10.18.02.48.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Oct 2025 02:48:38 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	yldhome2d2@gmail.com,
	gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	jake@zimmerman.io,
	peff@peff.net
Subject: [PATCH v2] diff: stop output garbled message in dry run mode
Date: Sat, 18 Oct 2025 17:48:23 +0800
Message-ID: <20251018094823.31173-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier, b55e6d36 (diff: ensure consistent diff behavior with
ignore options, 2025-08-08) introduced "dry-run" mode to the
diff machinery so that content-based diff filtering (like
ignoring space changes or those that match -I<regex>) can first
try to produce a patch without emitting any output to see if
under the given diff filtering condition we would get any output
lines, and a new helper function diff_flush_patch_quietly() was
introduced to use the mode to see an individual filepair needs
to be shown.

However, the solution was not complete. When files are deleted,
file modes change, or there are unmerged entries in the index,
dry-run mode still produces output because we overlooked these
conditions, and as a result, dry-run mode was not quiet.

Since dry-run mode is only set in diff_flush_patch_quietly(),
setting the output file to "/dev/null" within diff_flush_patch_quietly()
ensures no output is emitted in dry-run mode. To improve performance
of dry-run mode, add a check before outputting to determine if we
should exit early to avoid unnecessary output processing.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
I copied Peff's code from https://lore.kernel.org/git/20251017083641.GB4073661@coredump.intra.peff.net/

 diff.c                  | 20 ++++++++++++++++++--
 t/t4013-diff-various.sh | 37 +++++++++++++++++++++++++++++++++++++
 t/t4035-diff-quiet.sh   |  4 ++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..ec05ac565b 100644
--- a/diff.c
+++ b/diff.c
@@ -1351,6 +1351,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	int len = eds->len;
 	unsigned flags = eds->flags;
 
+	if (o->dry_run)
+		return;
+
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -4420,7 +4423,7 @@ static void run_external_diff(const struct external_diff *pgm,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
+	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_run;
 	int rc;
 
 	/*
@@ -4615,7 +4618,8 @@ static void run_diff_cmd(const struct external_diff *pgm,
 		    p->status == DIFF_STATUS_RENAMED)
 			o->found_changes = 1;
 	} else {
-		fprintf(o->file, "* Unmerged path %s\n", name);
+		if (!o->dry_run)
+			fprintf(o->file, "* Unmerged path %s\n", name);
 		o->found_changes = 1;
 	}
 }
@@ -6194,14 +6198,26 @@ static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options
 {
 	int saved_dry_run = o->dry_run;
 	int saved_found_changes = o->found_changes;
+	int saved_color_moved = o->color_moved;
+	int saved_close_file = o->close_file;
+	FILE *saved_file = o->file;
 	int ret;
 
 	o->dry_run = 1;
 	o->found_changes = 0;
+	o->color_moved = 0;
+	o->close_file = 1;
+	o->file = xfopen("/dev/null", "w");
 	diff_flush_patch(p, o);
 	ret = o->found_changes;
+	if (o->file)
+		fclose(o->file);
+
 	o->dry_run = saved_dry_run;
 	o->found_changes |= saved_found_changes;
+	o->color_moved = saved_color_moved;
+	o->close_file = saved_close_file;
+	o->file = saved_file;
 	return ret;
 }
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 55a06eadb3..2f8fe191b8 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -661,6 +661,43 @@ test_expect_success 'diff -I<regex>: ignore matching file' '
 	test_grep ! "file1" actual
 '
 
+test_expect_success 'diff -I<regex>: ignore all content changes' '
+	test_when_finished "git rm -f file1 file2 file3" &&
+	: >file1 &&
+	git add file1 &&
+	: >file2 &&
+	git add file2 &&
+	: >file3 &&
+	git add file3 &&
+
+	echo "A" >file3 &&
+	A_hash=$(git hash-object -w file3) &&
+	echo "B" >file3 &&
+	B_hash=$(git hash-object -w file3) &&
+	cat <<-EOF | git update-index --index-info &&
+	100644 $A_hash 1	file3
+	100644 $B_hash 2	file3
+	EOF
+
+	rm -f file1 file2 &&
+	mkdir file2 &&
+	test_diff_no_content_changes () {
+		git diff $1 --ignore-blank-lines -I".*" >actual &&
+		test_line_count = 3 actual &&
+		test_grep "file1" actual &&
+		test_grep "file2" actual &&
+		test_grep "file3" actual &&
+		test_grep ! "diff --git" actual
+	} &&
+	test_diff_no_content_changes "--raw" &&
+	test_diff_no_content_changes "--name-only" &&
+	test_diff_no_content_changes "--name-status" &&
+
+	: >actual &&
+	test_must_fail git diff --quiet -I".*" >actual &&
+	test_must_be_empty actual
+'
+
 # check_prefix <patch> <src> <dst>
 # check only lines with paths to avoid dependency on exact oid/contents
 check_prefix () {
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 0352bf81a9..35eaf0855f 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -50,6 +50,10 @@ test_expect_success 'git diff-tree HEAD HEAD' '
 	test_expect_code 0 git diff-tree --quiet HEAD HEAD >cnt &&
 	test_line_count = 0 cnt
 '
+test_expect_success 'git diff-tree -w HEAD^ HEAD' '
+	test_expect_code 1 git diff-tree --quiet -w HEAD^ HEAD >cnt &&
+	test_line_count = 0 cnt
+'
 test_expect_success 'git diff-files' '
 	test_expect_code 0 git diff-files --quiet >cnt &&
 	test_line_count = 0 cnt
-- 
2.50.1 (Apple Git-155)

