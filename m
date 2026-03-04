Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937F3CD8A3
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652096; cv=none; b=q8+p8DKHcvUEQSYVzy8wfVRNO62/pqwCtUWEpuZXGl2UCO1IoOFmM2PQV0vkMcLSJXbsG/5rc5UlagjcOjctXT9MgIQ0CcBPQuYQtA46x1FNS6JLxVAHWp5db+9YdEv4zzph3CUWBEBZeGB1kt/qHXQa5Hpn/EiU6ojJwkcAqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652096; c=relaxed/simple;
	bh=B6kaJqCAGLr6qD2V/D49yJ8CY4xbVyoQ36s6ZQEUb+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CzKxHiCQnvO7m2+NMBYL2/sc8++yphorXM6Tgu3kR3X2ufjURlXd7hBSkrKG8r1qsyqRIzIDyKRop6xvjeB93h9IysGjy8jUhxMumm0VLSGfCZXtJmHdUGzdhsQ6XMacYZfgMwepWj/EjURnV1utxNC7YYloBlkA1brzpSqz4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8N3rHfy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8N3rHfy"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-505a1789a27so43855991cf.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652094; x=1773256894; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7sAk3/YReVTPvU3H0j0LLYaqUlc/UuyGUxKQ/kL9PI=;
        b=B8N3rHfy6Lu9uW4k0aGp6N2YgU17jUUQzoLge7u1KdDV8L/XqennrT+jX2dhXVDcdO
         wRfDOEucqAsNoIN6waCEvdxorQ9WH0nGorQC/4CgmWcmjgiJ/15y4I4To70vIne0w77T
         +yrD9X/g0Ky7t5Li8AH2C5eQE9iXvLH6Lo0szvDIh5wXQ3M5rFhPk4LMxkW0RhtCepdu
         n9IS4ewxQzqiKBNBoBIikDHjlMWEal3VOFIcHiITHCaYlROtuGosAvetnni7trk/jqNm
         B0jcJtRD/nEXrPiNKcKwZO6C61UE2udHwcWgS/mRugjjCmbkjzLXfd1PhpoLBW+RwsKE
         MqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652094; x=1773256894;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7sAk3/YReVTPvU3H0j0LLYaqUlc/UuyGUxKQ/kL9PI=;
        b=ZKdlnIN53VN8Sy6Cqos0ok3BeAMboFuug3kJkbVFYd63Rqv5Uu5nmSDU9gftrV2e5N
         XEStjJGIAQyF9LkxVkUoDyydtmHqR7N2TlV39awRPwyX0ukDDugwf5S1PuvyjJ+qqXgL
         nSvjLlJmEg9PtZt6h2+AIp8X8nC3QT007bGy+TIMss5R6fKJzNl6aWbtebUQwli9Xvad
         kJ4Ggq0j8U0IL06PEvez7LnOoJDyBPsNir8mx0O9HwdcZGzKxo7jQtpddwKbDq7hQJ2R
         ncdQZesbrYksqL1kphttpiFiahnKe4EWYssXqEW1clcDWtboZAwCotPo/LslHBDQ0q9x
         hYEQ==
X-Gm-Message-State: AOJu0YwqegQUtrLtqHHHg49yhR02oco5pVc4kXnz/vOXfClBpzzpLBjl
	uE2CqnLJQ+My+yf6UhM5rcgYdoFIWIWRDIrSpUVRM183OPg+rjtEu0MbqhNUUwG3
X-Gm-Gg: ATEYQzyLr81Hj1+QZKLJJBaRY9wfWur7tpeGnKCrsOCqcCn9iD3NlNsqTgJVGBP9Ugh
	c+qoHyMekgiJ/l7YgBg2oFqZVxG8XOHytrYVfQLVVHYIoCM6oJNVpq2gIMTqKLYlH0KqFOiq0pl
	gx+9KbYm6Ws0Z5NKPkwSEHmzuHCMAoriQmeOehzkMAwMe2i1hnqn9CVSilurkdhqomwcV203ILU
	oYiOe/uzEnlNMhUzVf7IiLWbYmGbe8ME4ibj9rcO0SybSNs+rZvdm6H9D2MsykVxD1bYotrXYy2
	+sdvBgOnLIUfAZJuSMFcpkUSCYaYlIYTJXFg8brUN8IE1bmvUyAfjjWlvJeIsxV6dsacB0HY4p6
	jRQCRRxB5YQk+RjCQnQhHJHEKn3ZtTNRT/nvrDKw7CCSR43f5BiDl/VLOCltb+Gd8+MGm5knL+r
	StKvkZJY/QUFS2y8dZ8NQvNyho29pJCVCZAA==
X-Received: by 2002:a05:622a:180a:b0:4d8:531e:f896 with SMTP id d75a77b69052e-508db2a2ce8mr39302331cf.27.1772652093867;
        Wed, 04 Mar 2026 11:21:33 -0800 (PST)
Received: from [127.0.0.1] ([52.150.28.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5075feb4db9sm109886311cf.22.2026.03.04.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:21:33 -0800 (PST)
Message-Id: <273ebf640da562d9a20daec530e82968232e99bf.1772652091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2061.v2.git.1772652091.gitgitgadget@gmail.com>
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
	<pull.2061.v2.git.1772652091.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 19:21:30 +0000
Subject: [PATCH v2 1/2] line-log: fix crash when combined with pickaxe options
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
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

queue_diffs() calls diffcore_std() to detect renames so that line-level
history can follow files across renames.  When pickaxe options are
present on the command line (-G and -S to filter by text pattern,
--find-object to filter by object identity), diffcore_std() also runs
diffcore_pickaxe(), which may discard diff pairs that are relevant for
rename detection.  Losing those pairs breaks rename following.

Before a2bb801f6a (line-log: avoid unnecessary full tree diffs,
2019-08-21), diffcore_std() was only invoked when a rename was already
suspected, so the pickaxe interference was unlikely in practice.  That
commit restructured queue_diffs() to gate both diffcore_std() and the
surrounding filter_diffs_for_paths() calls behind
diff_might_be_rename().  When pickaxe breaks rename following at one
commit, a later commit may produce a deletion pair that bypasses this
gate entirely, reaching process_diff_filepair() with an invalid
filespec and triggering an assertion failure.

Fix this by calling diffcore_rename() directly instead of
diffcore_std().  The line-log machinery only needs rename detection
from this call site; the other stages run by diffcore_std() (pickaxe,
order, break/rewrite) are unnecessary here.

Note that this only fixes the crash.  The -G, -S, and --find-object
options still have no effect on -L output because line-log uses its
own commit-filtering logic that bypasses the normal pickaxe pipeline.
Add tests that verify the crash is fixed and mark the silent-ignore
behavior as known breakage for all three options.

Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 line-log.c          |  8 +++++++-
 t/t4211-line-log.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 8bd422148d..8a404f5c22 100644
--- a/line-log.c
+++ b/line-log.c
@@ -865,7 +865,13 @@ static void queue_diffs(struct line_log_data *range,
 		diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
 
 		filter_diffs_for_paths(range, 1);
-		diffcore_std(opt);
+		/*
+		 * Call diffcore_rename() directly, as only rename
+		 * detection is needed.  diffcore_std() would also run
+		 * pickaxe, which may discard pairs needed for rename
+		 * detection and break rename following.
+		 */
+		diffcore_rename(opt);
 		filter_diffs_for_paths(range, 0);
 	}
 	move_diff_queue(queue, &diff_queued_diff);
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

