Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391B25B30D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345857; cv=none; b=TL6IUpv2nA2bYGdKfEtrPu9JTjMWLJunYaCc/+qT87wR0NsSo3ZVJ0dDrT5KKlev71WnkaNRw2eBLhkc/U09E+QRqhj5Y+GLIbGsFfscYp1eG3n0tLijQzCFBe4DWzPuixGlGM3CnHiumh3KCN/2kDZs9GDXDnJecIW1X0yVrFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345857; c=relaxed/simple;
	bh=xx8zFc40YM68Clr4aiuRzf81o0OPVsQp1n/rPOgOYcY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dfp4abp8uvtNdiaotcIWc8iRQPJMPEInX6t6GFAu6AnHFoPWbShCH/pCAtp+uwhUCjuhYyOPp0EgHbOaYIIyeD37l6heQsdn/lJ8OyE4tbKfuU2WZoKpXmZGu3qzuD59w3O3UZF9F6YKrx6mcPSzL3UczXIy564kPfL7/q3cNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz9RNq+v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz9RNq+v"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso41099735ad.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345855; x=1783950655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+szElbuaVMyc9j6kwFuG2DwrW3VwGhZOFbAVYjCKWsE=;
        b=Sz9RNq+v2E3ZNnLxjbMI/zNb3x5lOMow+Ua8VTO1s1nN6cSrQn0+e0We9EIfPIxqkC
         5zFYnn75uIz10Z6vD3bohdFeyWhISMJiebS3qg4BEHPTgHokMPRwFW3LCrMipgn+fm/E
         +7yR36TdtaVdvSkj+h3QQPZLDtlzfD2qSoj/Lj4ee3vRiBkw41aw1JJvvXjK8ZcTh5H1
         t4XN7qgD1IUS02brCaCd7iZDf4ezMq0t/058OYMt45DYyFJRDqCtyoXo/+H0Z7HgPSod
         TKJpeuII+5NRkrhEvYXUiIGWXHk/k4xaYzr+1QEOHZPzhaO9pz7dcgx2hQyzJr3k/Rqc
         XPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345855; x=1783950655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+szElbuaVMyc9j6kwFuG2DwrW3VwGhZOFbAVYjCKWsE=;
        b=sKn3mImVpvEhY/TrxqpCAPDbpfD23WxkyavSxErUgcgzceJq/m0sI3uAQD2x80xZ6E
         QSwiFgPwUkOdUBjYnOTydg3K/tFuE/IajdkPiB/xiv2TIvmfYxS3N6ugPmGVIr0HJppA
         SKt/k17xBC/DuqxaqjyX2ZBfX9mrL80nN176p4tKpbwONed+m2L8n+W1y5MmZ33OaSOq
         VHn3/pgwRGSPMaimx2UEzwGa6IaagPdMp/YBWM6yrHXkRC9E3/ZYFRprZMZCU7YMi1XQ
         8a1GZX/DY/zvnyqiKEl/xpa86cuKJpfG8dSL0RdfY7agHjnRe+BejiP+I4y7WfQ+awD+
         sXBA==
X-Gm-Message-State: AOJu0YzBF98RjelBpOBd69eZaVm7fToXL5hiN/oTSDFU7KRUrbNpkEqW
	asZ7CLo3JcH8HLbz58hsG6UtmmyO+1GOcna5xTjdqVNKycpYR66zLNUr9VvYog==
X-Gm-Gg: AfdE7cne05aNUcPsOjaV+Jsqy0EOmcTQN349upXzbsGOhbvQJ3ATGgOxTcWZCyx4HS6
	IQvsqnR30VKw1ZV48e8OX1onwQyCqOcA1W4Osw7isLZTyGLWTqTOWRbjfgWM8QFk3uTtQ3qspqV
	1a0k7Sw1In/SUJw6z1DA+yY/jvujcYaFPOH4+broiu0dJ1qNGglEYcX2dkO65ssGr0x/bksOe4o
	F4bjTCCdHCo/a7wR+nxPBzfZnOd7icC6YXiha5s2pTFzybe9iCRk6VpOuC6u31IIwswZK2cRGhP
	h3ZJTtgUJ7R9cZX4HLzIs6pKthV7vGAx2DQipCbPkFK5UZt8YAGZP2+i4VrCY2rWc4ejjUfRW7q
	x5WTX+kHq3Cxq7w5lgCsa+IEN1+ykJn5EFV0yRvjpIpXbdFpyDLhQ5Nk9+EncJRSRsQOFWxRC+t
	Y+PH7fH16s95UmJvE=
X-Received: by 2002:a17:903:234e:b0:2c9:c575:7e22 with SMTP id d9443c01a7336-2ccbe40efa7mr6785705ad.9.1783345854662;
        Mon, 06 Jul 2026 06:50:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7870ff3sm50313295ad.58.2026.07.06.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:50:54 -0700 (PDT)
Message-Id: <pull.2167.git.1783345853272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 13:50:52 +0000
Subject: [PATCH] sparse-index: avoid crash on intent-to-add entry outside the
 cone
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When collapsing a full index to a sparse index, the recursive
convert_to_sparse_rec() walks the cache tree to determine if any
of the cache tree entries can be used to represent a sparse directory.

As it goes, the method tracks how many cache entries are being represented
by the cache tree entry. The cache tree node's 'entry_count' represents how
many cache entries are covered by the node.

However, this value can be negative, representing that a node is invalid,
and is no longer reflecting the number of cache entries fit within. This can
happen when the user uses 'git add --intent-to-add' to mark an untracked
file with the intent-to-add bit to avoid committing without finishing the
add.

When such an intent-to-add file exists and the sparse-checkout changes to no
longer contain its parent directory, this leads to a segfault. Two tests are
added to demonstrate this fault:

* One test is added to t3705-add-sparse-checkout.sh to demonstrate
  how 'git add' behaves with sparse-checkout.

* One test is added to t1092-sparse-checkout-compatibility.sh to demonstrate
  the interaction with the sparse index and to compare it directly to how
  the commands behave with a full index or no sparse-checkout.

The fix involves engaging with the loop that iterates over all cache entries
within the parent cache tree node (from 'start' to 'end') and to set the
'span' variable slightly earlier. At this point, the cache entry is for a
file that is at least one directory deeper than the current cache tree node.
The path is also not in the sparse-checkout because of an earlier
path_in_sparse_checkout() check above the loop. So we are trying to collapse
this directory by recursively calling convert_to_sparse_rec() over that span
of entries, but the negative value prevents us from predicting that number
without scanning.

Theoretically, we could scan to find the range of entries that match this
directory and determine if they truly do have an intent-to-add bit and then
collapse as many child trees as possible (the ones with valid cache tree
nodes). That would be a non-trivial change for performance-only benefit.
Since this combination of the intent-to-add and sparse index features has so
far gone undetected by real users, this scenario is unlikely to be worth
such a change.

We settle for the simplest change that prevents a bug: don't try to collapse
a node that is invalid for this reason. The tests that would demonstrate a
segfault now pass. Further, they demonstrate that the intent-to-add bit
persists in the index file after changing the sparse-checkout scope. The
test in t1092 demonstrates how some sparse directories could be collapsed
further with a more involved fix, if so desired in the future.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    sparse-index: avoid crash on intent-to-add entry outside the cone
    
    I discovered this while taking inventory of the un-audited
    ensure_full_index() calls, finding this block:
    
    /* TODO: audit for interaction with sparse-index. */
    ensure_full_index(the_repository->index);
    for (i = 0; i < the_repository->index->cache_nr; i++)
    	if (ce_intent_to_add(the_repository->index->cache[i]))
    		ita_nr++;
    committable = the_repository->index->cache_nr > ita_nr;
    
    
    This led me to realize that the sparse-index collapse algorithm didn't
    take intent-to-add into account for avoiding a collapse. We already
    avoid collapse to a sparse directory if there exists a submodule
    somewhere, but we don't do the same for intent-to-add.
    
    I thought I'd just find a normal bug, not a segfault, but that made the
    fix somewhat simpler though less efficient in the final result.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2167%2Fderrickstolee%2Fita-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2167/derrickstolee/ita-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2167

 sparse-index.c                           |  9 ++++-
 t/t1092-sparse-checkout-compatibility.sh | 48 ++++++++++++++++++++++++
 t/t3705-add-sparse-checkout.sh           | 26 +++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 1ed769b78d..c1fa231a89 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -113,10 +113,17 @@ static int convert_to_sparse_rec(struct index_state *istate,
 			continue;
 		}
 
+		span = ct->down[pos]->cache_tree->entry_count;
+		if (span < 0) {
+			/* cache-tree entry is invalidated, cannot collapse. */
+			istate->cache[num_converted++] = ce;
+			i++;
+			continue;
+		}
+
 		strbuf_setlen(&child_path, 0);
 		strbuf_add(&child_path, ce->name, slash - ce->name + 1);
 
-		span = ct->down[pos]->cache_tree->entry_count;
 		count = convert_to_sparse_rec(istate,
 					      num_converted, i, i + span,
 					      child_path.buf, child_path.len,
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8186da5c88..c433de2c1e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -384,6 +384,54 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'intent-to-add entries outside sparse-checkout' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_sparse_match git sparse-checkout set deep folder1 &&
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/newita &&
+	test_sparse_match git add -N folder1/newita &&
+
+	test_sparse_match git sparse-checkout set deep &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_sparse_match git ls-files --stage
+'
+
+test_expect_success 'intent-to-add with --sparse outside sparse-checkout' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	run_on_all mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/newita &&
+	test_all_match git add --sparse --intent-to-add folder1/newita &&
+
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git ls-files --stage &&
+	test_all_match git diff --cached --stat &&
+
+	# Ensure sparse index stores correct sparse directories and
+	# intent-to-add path.
+	git -C sparse-index ls-files --format="%(path)" --sparse >out &&
+
+	# These paths should be present in index as-is.
+	test_grep "^before/\$" out &&
+	test_grep "^folder1/newita\$" out &&
+	test_grep "^folder2/\$" out &&
+	test_grep "^x/\$" out &&
+
+	# folder/0/ could theoretically be collapsed to a sparse
+	# directory entry, but the current implementation avoids the
+	# reduction because of folder1/newita
+	test_grep "^folder1/0/0/0\$" out
+'
+
 test_expect_success 'git add, checkout, and reset with -p' '
 	init_repos &&
 
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 53a4782267..cf3f42a353 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -233,4 +233,30 @@ test_expect_success 'refuse to add non-skip-worktree file from sparse dir' '
 	test_cmp expect stderr
 '
 
+test_expect_success 'intent-to-add entry and sparse index' '
+	test_when_finished "git sparse-checkout disable" &&
+	test_when_finished "git reset --hard" &&
+
+	git sparse-checkout disable &&
+	mkdir -p in out &&
+	echo base >in/file &&
+	echo base >out/file &&
+	git add in/file out/file &&
+	git commit -m "in and out directories" &&
+
+	# enable sparse-checkout, but with all child directories.
+	git config index.sparse true &&
+	git sparse-checkout set in out &&
+
+	# create a new path and set intent-to-add bit
+	echo new >out/newita &&
+	git add -N out/newita &&
+
+	# collapse sparse-checkout, and make sure that the sparse index
+	# maintains the intent-to-add bit.
+	git sparse-checkout set in &&
+	git ls-files --error-unmatch out/newita &&
+	git status --porcelain
+'
+
 test_done

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
