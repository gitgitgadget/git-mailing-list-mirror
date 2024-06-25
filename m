Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5132581
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297934; cv=none; b=FudEJqJ8ZzMOCFdzFoCXtTITRFBJd8+PsaZXrEJlD+dbjW7r5t436ZR8e9grS1Xgt9hLFYS47ThfyJM8dQoyzIQD2ddDSth0F0qm20wt4jKwzn3xhcKmnETotPRfo0ZMVEAi7Fp8lGsiz58dR499GdeAoSSUuTMnhkN+2kicqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297934; c=relaxed/simple;
	bh=LagV+j+BZYpo8Q94rZlwUFA55jwmOI51xhXyaEBbA68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvQuk7SxivsNG7GVj9JmBrtz3O+zIcVxXlbhsEkenSn/s1dOfLKzXsCkkMM2Bs2tuCuhbfpu2qQuT685nBFhZfXMGg/e2b0jtXdLYkFgM5eYV6Qy6EIeOMuGHrbgDw11mNbSmbn8YIltTG49UOd1aHWaaBI0NTr2nZFaTe+A6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjKIkTQ1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjKIkTQ1"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c7aafe3094so943790a91.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719297932; x=1719902732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAZYBt+KiqaTc910eGSCgardqLXJPYb30GjZFgJWuTk=;
        b=mjKIkTQ1G6FL600Pc3H2z7WZYC052E6xcAIRK80kG5Qe0Kep48TtyIR6s1kYfGfL36
         TNaXbnUHnv9tQz6JYWzEUH8VUss0ZyGBSIoXXOEWllzUM4/1gwjgIwcz1ulhWxOS1bfx
         Rs7Rm2rlsTnvUMDelYuuhGrQz/7yaFIkR9k5OmHuBlp612JW6OQN9hZJ39ooSMK/b9HH
         EspCjacUzGgOEwzY5D9Kudf9OSsLDPleVwFZh5kd6fztvwnu7ShKNWgsxLjsgo8qbYPd
         Neeaq193PNhk/d+f9hXp9oLHtmbYYh/uX0sksm7iZE8fy631PKsfSkqriDVSfGQNtxba
         5YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719297932; x=1719902732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAZYBt+KiqaTc910eGSCgardqLXJPYb30GjZFgJWuTk=;
        b=fTn9uiJqMeyMQg6nMKv6L5tYZTKjh1ntAws4V5p47H6v1Rw2nLIxxbDR0hah/S48DL
         QKrPmhtkZ3aBtXp7ortXThd8QsPzAvmq6vZQgVQQ+s7WKIhyQnqMuzTU9Xb2kZd2+sy5
         rckG+BZ1KK1yEffQ84EgEMzuOi+Vhq3lJkvhfhNVduaUDfEkwEcVLEM5MhGRoSe9a3z2
         x8V2bnDOKVSQJg9VyOQF3a8sSdEIQXtmZxM28vZJ/4AUgp3nlpvoEzxzYQQhvoAvOhE9
         KLDIzHKpSKH9xY+T2lk92/FOjDJXo+RowtWdHaFWa6cVdOl14zf6gVzfWtx1H5w5SEZH
         VdQQ==
X-Gm-Message-State: AOJu0Yw7TcXh4FDiryIXzUw9vatjpxTNZUhJUFdPXAWh8Q7/0rOjM+HB
	HdbxqJBw29uUzGIaEQ69xoKtdnzFAt1x3yT0m/pOCOHyLGajx0Aw4s2wsX6aGA4=
X-Google-Smtp-Source: AGHT+IHfNtSFE5QPzebMfmZRsgXKej+EBF2MiCbV1QmXyBlPYvUL+noexJ+9/kvQ1vQ0hteCFI8+Zg==
X-Received: by 2002:a17:90b:11d4:b0:2c6:de10:6ab9 with SMTP id 98e67ed59e1d1-2c845c3b9b6mr7161675a91.2.1719297932146;
        Mon, 24 Jun 2024 23:45:32 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:3e:f8f9:ded9:1f2e:64c4:580a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff97e2sm9845576a91.10.2024.06.24.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 23:45:31 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2] describe: refresh the index when 'broken' flag is used
Date: Tue, 25 Jun 2024 12:14:41 +0530
Message-ID: <20240625064504.58286-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
In-Reply-To: <xmqqsex2b4ti.fsf@gitster.g>
References: <xmqqsex2b4ti.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty if a file has
different stat info than what is recorded in the index.
Running `git update-index -q --refresh` to refresh the index
before running diff-index fixes the problem.

Also add tests to deliberately update stat info of a
file before running describe to verify it behaves correctly.

Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/describe.c  | 12 ++++++++++++
 t/t6120-describe.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..3e751f1239 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
+static const char *update_index_args[] = {
+	"update-index", "--unmerged", "-q", "--refresh", NULL
+};
+
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -645,6 +649,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			struct child_process update_index_cp = CHILD_PROCESS_INIT;
+
+			strvec_pushv(&update_index_cp.args, update_index_args);
+			update_index_cp.git_cmd = 1;
+			update_index_cp.no_stdin = 1;
+			update_index_cp.no_stdout = 1;
+			run_command(&update_index_cp);
+
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e78315d23d..ac781a7b52 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,4 +671,36 @@ test_expect_success 'setup misleading taggerdates' '
 
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
+test_expect_success 'describe --dirty with a file with changed stat' '
+	git init stat-dirty &&
+	cd stat-dirty &&
+
+	echo A >file &&
+	git add file &&
+	git commit -m A &&
+	git tag A -a -m A &&
+
+	cat file >file.new &&
+	mv file.new file &&
+	git describe --dirty >actual &&
+	echo "A" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'describe --dirty --broken with a file with changed stat' '
+	git init stat-dirty-broken &&
+	cd stat-dirty-broken &&
+
+	echo A >file &&
+	git add file &&
+	git commit -m A &&
+	git tag A -a -m A &&
+
+	cat file >file.new &&
+	mv file.new file &&
+	git describe --dirty --broken >actual &&
+	echo "A" >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.45.2.606.g9005149a4a.dirty

