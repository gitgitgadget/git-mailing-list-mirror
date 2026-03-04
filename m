Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9E3DEADC
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651495; cv=none; b=gczluFqKMXxeIxDCaPygEhMa7+3waL3EZV18sghDVUdRpqfMwBrr8jg8t3DGekRJtWEf90XkYBZT2lob/Y/7KHigqLiu01KVU/DhmPZOCOf5yVeM0njCGnih6Mj0jCGWimMEWsCb4ydyyQftYpyurVMOaZm5yKbYNZGC+CJU8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651495; c=relaxed/simple;
	bh=LizpiQs8KxVvXcF1R3zRIb+Jy/G0L1ibT6gTZ6iJ51E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tucopktMw+5o+dyOaCoZP5LalLgIVcXp2cd7KsjyFKtQNZFjqowQfWje6DFa3kmyYkWNLnf4SI/x76b4Tyj2AXjnx9Xl6ydNtxB8xd04ugYWi+PO8PZbjyqWfIlDL4b1w/UJ123+X8oPhQ8IxpqaAm5KDP7YraZwCgtQ1xpatiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuBOBE0n; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuBOBE0n"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1275750cfc7so381378c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772651488; x=1773256288; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlB6nWC/XgMVKoe5W9Zu7yt+BaOzod36hqbvmxoRJoM=;
        b=JuBOBE0nst1F4ACxaKXpOHHlLvDy0f9LY/Cfjf/xrfZ5ID/jHZyzFHobuqvYPZlIW8
         XTp2Z8uZwvMcT7YnZyts5jZPMBg9m7X0iVXFXZLQ2jonlvhtQ1VQlCBWxnslHgVbibFk
         RZlV1QAkevJ0i16kDpPlXcEdlfgf0vtFHs08kjq5mtasPtYDjoJWvPoauCWIe742QIIj
         KPUclX9JN8sm87daVzB8+ceoJh40FkIBi5ZecvLCsj1NrkjdjWZf6+WrbVSfv6NQW46C
         OUsD1t2v5Ha1ReBeY/b43OkQyYIRfMw40Os5zEc30o/zRc8aa5qxhTv0Cq/OJWwQEScn
         HbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772651488; x=1773256288;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlB6nWC/XgMVKoe5W9Zu7yt+BaOzod36hqbvmxoRJoM=;
        b=dIWIbA+1k96lfuAiau2li7iVRF9TPnCDxd7Z29frRx9VHE3/l9l5FcahprjjjNqU2t
         PTn0G1MGrIjdmBPOIMdm8TEKekJi8qpat/Zq7CUiZ8OHl9mhSgQiD8MH6CaRrX++Mud6
         KtVrWydjv/HBp8I1YKXwClZq7Fa/8G+BHCXEKBceZ+5+e6+VXsG9eOzuDgqK7umU2Wn9
         XhCBibs49uB/TrebPnS6knC8dh/OXhwqWq3QN01qlR5l4tkWsZiWkaActUeHGXVPc6Gu
         ZA5cIx81Hvrhy2xYCjFFGMlFjLXErBAf7sLml+tto9rHjItP52aTowt+b2cVgaWzX4XX
         Siyg==
X-Gm-Message-State: AOJu0YzR+sxiTpKIwaMupjGVGl/sBy10Yc0Q9+CHzeAt/wQaJmaR+Dki
	rsk60nmBn4m+2F50k+B81vsTj9Ze39KylBEF2kAyNcy9gnYra5b0Nb60K+2AHnPe
X-Gm-Gg: ATEYQzwUQxJJm/MZbT0QPQB2f3Zgxfe05H0CU9PvYLdBzb4EAIgb0PLRRET7+z8lTTx
	w3MYP7nwCvBwKn8yrWpYyBPqSE1AIBbqirL/C+k+3zs5wHXzeZDrnZFo/SnovbU6clCJUIr/HoE
	BWyKWMCw2u0v//Tib7ufeHx8eymI5Tt6zGX7EHo/Or5L58ZPEglE2EJOi69gxr9FTvWZr0I8doX
	5rcj1bTXnxHqWTGOS2OAK35ELdK67yvmHFG08O/0qFS0S2rRQg1B0oLP5WowzSICHnaWJaAPRa2
	V28wHpl+JMErQkXBqk98gSjNPyStoFlNyVE150yQf6iFG/3yNx1piAc08sa5TtQ3Hx1cs/qbLu+
	ajzTgsxZiy7+R7+i3R7kNMIDPgBcUAGaaepjVDEh286kTFhEWDlTRupBXQ/GBDjvnRsprDI2z4k
	IwSVrVpN5I4pDpxG2PndrnAQo=
X-Received: by 2002:a05:693c:2c07:b0:2bd:c8a2:954 with SMTP id 5a478bee46e88-2be3108db84mr1391248eec.24.1772651487620;
        Wed, 04 Mar 2026 11:11:27 -0800 (PST)
Received: from [127.0.0.1] ([40.65.61.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0cc8517dsm8307509eec.30.2026.03.04.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:11:27 -0800 (PST)
Message-Id: <6e97d88993dbab4070ac0aa999f70564368f47b1.1772651484.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 19:11:23 +0000
Subject: [PATCH 1/2] line-log: fix crash when combined with pickaxe options
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
commit made the diffcore_std() call unconditional, and with
filter_diffs_for_paths() now framing that call, a queue pruned by
pickaxe violates filter_diffs_for_paths()'s expectation that diff
pairs correspond to tracked paths, triggering an assertion failure.

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

