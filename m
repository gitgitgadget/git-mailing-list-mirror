Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56826B761
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760890867; cv=none; b=V19jXkbT2aOo7BmERJa4jFUxcfYPgGcHw5TCpXuqSp7gf1+6jY7cc/6weJcLPmtEkBKzzlXIlTkJpWw9E4wt66gsOdeeaIh8X1p8qtKtV6p373LAxOv3TDP63Sl94CBFJWsjtutJXjsBJxa18v1IrybSPgBaAyKGq9IFbpChU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760890867; c=relaxed/simple;
	bh=nYMluXORqbGU6RoagdLfpzxvrzjCZBQrfzPNIRUsW+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zcevhfm0RLLMxclSP3Vblh3R7VT1UEbwyWNxC5kujSUdNzwYMfeteAA2Y+Tpg3dptVtXXPT1Dr+7/lQTAAC2vki+wT80x95H0ga53J6v5JHvWq9uwHixuna4+HnJYsAKVaeFElEQCjFKFzNV4S48H1R/xk2RhZxPUNEwbZftu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRlPzgYs; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRlPzgYs"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so3116202b3a.2
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760890865; x=1761495665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hWsg9PZXGjBPiUlUKFDpuKJvr7eJCsSXXRULmxb96I=;
        b=IRlPzgYs6E8LU/xeMhvvkiXl5qJeFAQr03nepcppr8wMjmXMo6Vcw00EUk1+Gx+KfR
         BgQnqUIv7R6eu3NfhsnuGd0yhNkYmiNTRjHxpUcXFzFx09CxilEkEL+cWOy37cIEp6V1
         NPPXhnCykpU6FwyZwQwe2jS1cH2OcKnJIx0njlLdgOWhiBTRYd8OPs8aVCYvg9Ri1Bat
         pgzfV/vb/gQpiYm2xzplqkQSesQPvbpvdt0bdJlVNvRUvGs73rNofXpP4M0sbLDfxV10
         o6Kf0Bt5w1DRCrdQ/nPrdGUaBQv1Ecsre4u5mmDg7Q6gcUl5jEf4cOMXEIRRdUyYJkyK
         UlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760890865; x=1761495665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hWsg9PZXGjBPiUlUKFDpuKJvr7eJCsSXXRULmxb96I=;
        b=v0sAfjHlaVnMbBxZ5sLPWzSFG7CmOh37ZFDoiRTcHXHeWxfEIG2WzSeUKdgsHCZrf4
         RupHZGwNBK+Nn7NfUNiIzwlWqOrRgUvLkQMwVkdVH/Jii1cnhk2qWUhtQYp6x3JJk0oB
         d0nD2++gJ3aAnQfDfeQSE1eTMZ3MeFtnv5Ud+KSEo02OdvAdnWgPBji6wgZ7eJhRWNd9
         ZnyxlOa6j1DLaj19ynpJS93/ukpeb8Fquq1yN8OCbB/frSxHX81fDXOsvpR7hz/Q1IZz
         37mNf8MwOPGCqaO/pUUqeXao6kGLc9bCxYFCa8dHY1TdKmuO5YkxvrYg0QjkW8uE7zRi
         WKeQ==
X-Gm-Message-State: AOJu0Yx5rpvOwgpVG7z6KJoOV0p86KkJKCxJQs4ojfEcxZs6k0AWsJY5
	YeOKSI0Uope60Vz5aCT8fk2Lx7+Z91pyKaqz81r24mJKv+cqgOrNcUD82TEZ2at3PZzeHw==
X-Gm-Gg: ASbGncut8mlA3kyyjuyVsdZlvJpdxixvToZcygOnADWyIV5rBjY4PAbpnAQsKYc5RU9
	c6nDax6EgYVYEigXU8rZtFzcp7cLrFDMtKJtdoW2iZfDdidpSt9pITlsC5jNfpGgQbti9sO37BW
	lQ72NrwRToCIAF5ktXt1d1dJDDI5MhPKhJcOP67rQUvAExfovZof5wXKv7fVjkm4G7jNLDcMI1a
	W0DxKLx4qludiTHNJrjvGBfQ+XkrbcXzhbeM4HUunpwIM1RvNSk6W8cf3A+DbTU5+45nbqIkC/Z
	eBBo61c75Ig9WMoU31GwruJ94wxY7DJ7w6mk1tzzh0nP060FozVPt+T3urATO9SHZRvbH1SyfSI
	dBW4nYSfgL/p35UJA+gnQz6Ux93VfOMIgSzdR3xGdF7alnjuITWZKsBXPwN+h61Gfe5qM5p374b
	xfNawcXNIqoG/NjkC1vmPS7FaRAroUkKwGQMJBh1y/pcGZzlVNHbJZ7qUgPAcRKeyw
X-Google-Smtp-Source: AGHT+IFGMybk5c4/se2M7eX8aOVWJxUztuL+QsANAgWtyHfL5FbTO/0/wHQIGs3bqX13Dg3vC8XkIg==
X-Received: by 2002:a05:6a00:188b:b0:781:2757:1b4f with SMTP id d2e1a72fcca58-7a2206eb750mr10852083b3a.7.1760890864542;
        Sun, 19 Oct 2025 09:21:04 -0700 (PDT)
Received: from localhost.localdomain (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230123122sm5781323b3a.72.2025.10.19.09.21.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 09:21:04 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	yldhome2d2@gmail.com,
	gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	jake@zimmerman.io,
	peff@peff.net
Subject: [PATCH v3] diff: stop output garbled message in dry run mode
Date: Mon, 20 Oct 2025 00:20:53 +0800
Message-ID: <20251019162053.14950-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251018094823.31173-1-yldhome2d2@gmail.com>
References: <20251018094823.31173-1-yldhome2d2@gmail.com>
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
 diff.c                  |  8 ++++++--
 t/t4013-diff-various.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..3c92f0d806 100644
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
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 55a06eadb3..d35695f5b0 100755
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
+	rm -f file1 file2 &&
+	mkdir file2 &&
+	echo "A" >file3 &&
+	A_hash=$(git hash-object -w file3) &&
+	echo "B" >file3 &&
+	B_hash=$(git hash-object -w file3) &&
+	cat <<-EOF | git update-index --index-info &&
+	100644 $A_hash 1	file3
+	100644 $B_hash 2	file3
+	EOF
+
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
-- 
2.50.1 (Apple Git-155)

