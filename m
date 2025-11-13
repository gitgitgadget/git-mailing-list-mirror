Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0EB15ADB4
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041124; cv=none; b=clAjU7izCGBHl5P5K/o+UnY7/dxl2nlhAALVyQIHmzkhyJ0RcQpAmFHE7KmYfP+TgweTlhtH3yU5BxZV4MuB3rJTzQ/3HZxhIsfoq3JHi2qhvlmS7dBGfWQZI+LDbyBs9UZ2DCp1RbSJzCLVBappI+f/loynQBhl5S2UNQs9CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041124; c=relaxed/simple;
	bh=09akiBnei32FEYQDsKgTn9MmSjv60e977ylGl7e/tBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gck51fwG/uS/HKQ1W/+XdjnufOpJCdUcOASosYtmaz7rgWnZMLJTyEhVnfmREDS+vKtxWjKRee/LG2523yrun39HztQgHzGTwFRCIM9wtfq0v4q1XRMqgm38Lji8/wXNZH64luQV5F5r0zI2tiqodNOxXSCzYtOpu/+OAV312ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTgyrzs/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTgyrzs/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47777000dadso6181545e9.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763041121; x=1763645921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRJ08zug2IVyXyi3SHh0NYoJJtVsKrVBJrMySSOPhW0=;
        b=PTgyrzs/t+ic9XwJSBXB4TO5cmO2BsnzULmYpJVPOTS0p9wB3O+m12+NJQxHH3fXgr
         Co16SLkj8cO1a5uiNF7/yNhVb47gx2RiJEj1WWbasZE44bkmJsRFyc4jLNc05Xh8q134
         gLJsODkAtXCsXS47W7KMd3jozmPLsk7AsQHIoGBT4U0oTCdreIKEK5oETCtoAcgdj2i8
         GtkhK0dY64lXcDa3zFGVcWtnWPf13JgZnH6dMMD5oamZODTuo5yn5v+GmSzOUsWrKSqZ
         LkiyQdql4UvuyGwm+O71dw3rpEN92SSnwN16OOcHX5ZTrLTTGkWlKqwAM2vJ1ISECxWJ
         w0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041121; x=1763645921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wRJ08zug2IVyXyi3SHh0NYoJJtVsKrVBJrMySSOPhW0=;
        b=JV2cAuJG/kEHqcPrvyHNFj1UdH4o29YhK9mnzyr1gCiOvBeF9rE7XLyGN3p6wmtRdh
         zStHhyRyR91ZhJQOg1hvlmd+4nI+seLMBmxQ17eeJvVi5PnkTp4w0rU8WknjJNsLmKj5
         ig2jaCOLVPsNzqMFF8Tmp+GFkCMho4uSr8N+SC0e723GOPE/lVU5S69Ar5dx6fh8kQ2R
         avKto1Uhgys7LgxV8kPilhN7fHZZQTm5WCoK/1mPnbVBQOyJXuoEyv7o8asXtljcZJdt
         fTrnzKaMU0at5RV+2nq/D7EcofDTWzJwYxnPbZ0ZymXGbiq0EqwaMpYDedAeCzhI1k7w
         xkaQ==
X-Gm-Message-State: AOJu0Yzh/bSTSsZKuCc8wHGINYJ2dv5UbXXGwjUSBJ/5L0gTHGIZ+B1q
	7sVZI5bXSJT5G2os/4K8oOdcc6xVVHcsiLqhWNkfPtSF1aOoFD4/10gK
X-Gm-Gg: ASbGncs8zw7z6Tt5NTcWVhYct2RpTZqSjUG5jE5Nh2pUPxYhBoYtSdfq20E1V/JJZsL
	t/mqJawMeKU4OJstwjugEzv2ayrZlHPpJ+KyaYl8YP85be6/dtgCE5cDGY7K8iG0lZLS9m6Mrzm
	87Tis02uCYRLwMwcu1vCZ4hDEXFUAAVlmt98u/CSrMLj+wmwv2W+gkandwOZYJ/Wuyd+To5+2NO
	LquLB3mn90MaeUgAmWdjranQQ03d+ZNBxIY3C0x3B4zOUgWhMmw9JqQAlEjJf9iX00BeQJatSo1
	QnQHjyQKEZG8scs9a7XgwzSimccasNy+dP4DYOY1dU2wDhkHlYKkEKM072GlgyZouNnjynJO2sf
	2YQ+/6ZE8TyyT1yZwM+A34QIBjjcxnGIotXNrv78kFewpVx6LUo/us27exCq+SNYsaBfk0fOBoI
	Ym
X-Google-Smtp-Source: AGHT+IEw93SYcZ5qeJtOed6OckLdh/lGlS3MeSfVO4WDAreJTukMu1VYt6osTC4XgnL7zVgOT4gt2w==
X-Received: by 2002:a05:6000:2509:b0:42b:3e20:f1b2 with SMTP id ffacd0b85a97d-42b4bb8b8fcmr5165749f8f.4.1763041121163;
        Thu, 13 Nov 2025 05:38:41 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm3861166f8f.37.2025.11.13.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:38:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 13 Nov 2025 14:38:37 +0100
Subject: [PATCH v5 2/2] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-fix-tags-not-fetching-v5-2-371ea7ec638d@gmail.com>
References: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
In-Reply-To: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4724; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=09akiBnei32FEYQDsKgTn9MmSjv60e977ylGl7e/tBk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkV312bPQwjScQC/cg4afuQMF5IvC/2EZBwi
 tAvE2W7CV0pbIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpFd9dAAoJED7VnySO
 Rox/S8kMAJznCSgZ2qd8pNRB/osR7++rM41dx2M6cfCkkeKHThgqYKa7V28rg7F8vntASB0uP1E
 vzogWUoFlBFfj1JEwsoEiLPByO3CCC1l4A3vgrNLlnijzl9TazXoi25IeWu8RvZeBHpzTOt9C/L
 rKOJKKtiFb6ZADmN0wtKDoSq/16x6UhMFXztdv2BQ4lqsHsh2y2lXaqfPApkt9YSAE+mRw7nZD3
 j+xHK36Ion5RuzWraI4JgbmDXeWGR3FvUVXrjG3oJXgZpli93Qj3403omn2t9HBMcfZmvX1eVHS
 NG5hfXrxayc0EkW8efW5SvS9+cBkJpW1e2ytnm3A5bhGjIemdf6lbEJnrbRcdX9hYqZWteNnI1t
 RJSAtR07logoyDikinCYQeyuYk1tC8aKxQFSIJUM8hnkeZHL40Sj6VQiDiJUlSoJRkO+K3GR3u3
 5xrno6pbvhd+eeDmxW/oWl5lFYupsFNJ+ntsgl6ndW0F0niilSy+NI8YGo4NdFJ2d+1990HUrk6
 kI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
updated the 'git-fetch(1)' command to use batched updates. This batches
updates to gain performance improvements. When fetching references, each
update is added to the transaction. Finally, when committing, individual
updates are allowed to fail with reason, while the transaction itself
succeeds.

One scenario which was missed here, was fetching tags. When fetching
conflicting tags, the `fetch_and_consume_refs()` function returns '1',
which skipped committing the transaction and directly jumped to the
cleanup section. This mean that no updates were applied. This also
extends to backfilling tags which is done when fetching specific
refspecs which contains tags in their history.

Fix this by committing the transaction when we have an error code and
not using an atomic transaction. This ensures other references are
applied even when some updates fail.

The cleanup section is reached with `retcode` set in several scenarios:

   - `truncate_fetch_head()`, `open_fetch_head()` and `prune_refs()` set
     `retcode` before the transaction is created, so no commit is
     attempted.

   - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
     cases this fix targets, both setting a positive `retcode` to
     trigger the committing of the transaction.

This simplifies error handling and ensures future modifications to
`do_fetch()` don't need special handling for batched updates.

Add tests to check for this regression. While here, add a missing
cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  8 ++++++++
 t/t5510-fetch.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f90179040b..b19fa8e966 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1957,6 +1957,14 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
+	/*
+	 * When using batched updates, we want to commit the non-rejected
+	 * updates and also handle the rejections.
+	 */
+	if (retcode && !atomic_fetch && transaction)
+		commit_ref_transaction(&transaction, false,
+				       transport->remote->name, &err);
+
 	if (retcode) {
 		if (err.len) {
 			error("%s", err.buf);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b7059cccaa..4b113d7c27 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 	)
 '
 
+test_expect_success 'fetch --tags fetches existing tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-1 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-1" out &&
+	git -C repo fetch --tags &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-1" out
+'
+
+test_expect_success 'fetch --tags fetches non-conflicting tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+	git -C base tag tag-1 &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-2 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-2" out &&
+
+	git -C base commit --allow-empty -m "second empty-commit" &&
+	git -C base tag -f tag-1 &&
+
+	test_must_fail git -C repo fetch --tags 2>out &&
+	test_grep "tag-1  (would clobber existing tag)" out &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-2" out
+'
+
+test_expect_success "backfill tags when providing a refspec" '
+	test_when_finished rm -rf source target &&
+
+	git init source &&
+	git -C source commit --allow-empty --message common &&
+	git clone file://"$(pwd)"/source target &&
+	(
+	    cd source &&
+	    test_commit history &&
+	    test_commit fetch-me
+	) &&
+
+	# The "history" tag is backfilled eventhough we requested
+	# to only fetch HEAD
+	git -C target fetch origin HEAD:branch &&
+	git -C target tag -l >actual &&
+	cat >expect <<-\EOF &&
+	fetch-me
+	history
+	EOF
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.0

