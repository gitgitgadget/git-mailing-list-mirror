Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB0274B2A
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177757; cv=none; b=l5uSAnWl1BvNAWc+/s9ddM0f5IhK8q6f8U5N/kYkaj6sUcGMeqxDPq2udm7xebWCup26woqS2Rsl+fGxPPbIqgqspUMtqK55U+hP3zmffXqN++aX0ekKbiXR9N/S3E/tEbAFk1Z/1VmvbmTLWHOBxQM32jht+NnTHC891RXF0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177757; c=relaxed/simple;
	bh=OwfFPm/eQ9oNgoe0UJ35laE04Zi/3GAdCwNAsayw+k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WzE+ECcFn0W42SerK7TBfIx+j+5gPsS7LRoQenvmwj+yxxoVS3dUwtB31Q/BVAvvkuAp7+kdF9ciaXBfiyN8QZYz22QYvq9YbssmNLVY2OoYzE/joQ7lwjWxQqZ9UGlltkgCmw6znX0JrdOL/ayUBCtgxflLwu0auaWRYdJWm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBn9BbDQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBn9BbDQ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b713c7096f9so124825666b.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762177753; x=1762782553; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inipCdDnnGvL+HTbxi/1weCXKTwgRFifcJ9OskfHokQ=;
        b=GBn9BbDQ/gWB7/qpuGkRwz5dTPhID93nFwujLzZ5i0apYZGPq6gptala/9uGT024jA
         xlTzBLZ7gkg/OKlNTaQsgkMlnVdb1za2Onr7q/yPvy+D3ImDZ/XX8YMyC8RwJuggRGJR
         6cFv7FUASgwGVBZReLC4ljCpx65UA6NFbn5N3kLtnTeFCWrY1xdzMhzUAqUJvFQLyihE
         kJXs44fa7NDBPHEPnbl3Y9Tg+7myIfd/nEjx6WwvhQ0W3ScGG8OT+uMY4LJEqFX81GAm
         IMyyaPKLOplA2vSL14CbviNNWjg5pxDGfhgnnubT1kFB4RNktyEWsZLg80si3H6cd05a
         tkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177753; x=1762782553;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inipCdDnnGvL+HTbxi/1weCXKTwgRFifcJ9OskfHokQ=;
        b=DvBtzOCqljdRY6bswAF/bi1+y29CBW/80d5O1uJm2kCyItfJfBvLrnDr0jAh8tdAJI
         geL3CQLaxPvcqpDe/HPOvzIjxa9jE+LF7af1LgwotTStTC6wXwM+kpFaS+MSgLCqTS4v
         92wXmLsUe06IJkjiK0umanIAlVYUiiL3XOHiwoUZ/N+F4cnwORk40yTyEJ2f4iY6YMyK
         ubW1Uhy6JuNzgMaoygI9xfQaLi3gniGmNpa/Sqrckw7RU1C+Ia/yfuKPrBE+r3vyHIUa
         MjcZ1D9jZf2ECiLFdFtUiv6lnOYUuNprsbXhzNUE44Gyon2YUP7V8uSzeEzUP95Svm46
         2NRQ==
X-Gm-Message-State: AOJu0YyJ/MYlZnk2SvBIJtWqlo0/IPnc82Fbi2KpafCPW8wZSntkYIBG
	Yte+j/jsNUjEzxC0Q2IlXTq6Y8Oymf89+cXoJlgfJs6IBcVYOkUcW9ZrNFmrvo+X
X-Gm-Gg: ASbGncsPe1xfS3HldG9Pr97PODy6RwvzFfR1Lyx6SdmbNDTQNjRAQsn3of6dFssRLPv
	qh9EAWR2hI+Uev9Q2Zlq9nDXsvMEiw+KiIDww8l+dwuQnW0hXhnB8daeBIakSBdA3kzvb69jREu
	tIcwjvuPtgIPuumh3xWyz7Azh7haNEufjEbjWmPDhSX8qkz0CXuB17RPocq8TiKsoMLj5a/B18C
	nSFRI2/glHEGwmvWPWJP+iMPDcY/jsZdJkZPKW6YBKcCWQ9k6VKbf2aw0Ht8yHsquTen+bCTPqA
	wP5u0jo6N9F0cWbSDgohb+kRBbMKF6RMcHiO7lzNtZqv0jQM3NYcGN6wnfWs8W9qoYOBiyFWxye
	1t8phN25Nm0quCoD1MrTXIAjaNeAUT5glK+V8HF35RCjynQvFNWu4T+T9+1LQ7VVaQetXn1UpbU
	puz0zy16ll90PAPA==
X-Google-Smtp-Source: AGHT+IHI8JLfEVOOBWiPSsQwaTM+8Gw5ylHj3kkqSqaQPwnuf06M39LDxVjLQEmrTzCblfspIxM4Hw==
X-Received: by 2002:a17:906:9fcc:b0:b6d:68cf:68e2 with SMTP id a640c23a62f3a-b70708a235emr1266627866b.65.1762177753073;
        Mon, 03 Nov 2025 05:49:13 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:c27:4bfd:ebaf:70c:f4d2:acb7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71b1a37e14sm76720866b.53.2025.11.03.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:49:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 03 Nov 2025 14:49:06 +0100
Subject: [PATCH] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
X-B4-Tracking: v=1; b=H4sIANGyCGkC/x2MQQqAIBAAvxJ7bsE1K+gr0UFstb1oqEQQ/T3pO
 DAzDxTOwgWW7oHMlxRJsQH1HbjDxsAoe2PQSo9EakAvN1YbCsZU0XN1h8SAytOkyZrZ7AZae2Z
 u4v9dt/f9AMzWfURnAAAA
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
To: git@vger.kernel.org
Cc: David Bohman <debohman@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5655; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=OwfFPm/eQ9oNgoe0UJ35laE04Zi/3GAdCwNAsayw+k0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkIstiDA0usYhdd45ueF4FhdOQhcNe7Tdi7x
 qv8YBLZHe3lxIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCLLYAAoJED7VnySO
 Rox/itkMAJqyladJhYdtKsItf1rDnKJb3lr03hNmqlZhNA64lK6Ya80bK2+LlNB4CnVffN9oZtf
 cEhrhL2fdzBPLBeXQK0lmvbThefkRQVPaIy/OEP1Z2u786CJ7c4tbKMGsRAPjCrgzYPDyu7ZLiV
 sU/RtEKNQ8WG/OSCP9VpRX5KKvOMaNnumbCodzdZS+8l8p43+vMRNO0mLYyV40MQF4HgmWUX9nM
 DLL+Zi3K9gFb4W3hMPJDaYTVQQ1Zab6O1WFMyhg34pgwwCVH0RZ3zztGhBcdD4q8bRIPGZax+Vn
 IkkS9zvaxq9FxSpxnWsx3VncEP/0pfC9lKpxv2AmOb/l4J8Y9c9+VHO5W0laclYLDUc3pZpmqGV
 NoD32XdCIMGhoNVtIkiHBZj+UG9n8ehg4X5Ee/AysycqJYqWAdssLGbsoMCpnjy+SwEAjoBh0oc
 lxabPUrWh5yc5at5U/CCZxXdTw6bK9AIlGp/LpVmolKJb0356Xjck7zcmr2GBLWlTWnIxgHx4p5
 z8=
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
cleanup section. This mean that no updates were applied.

Fix this by committing the transaction even when we have an error code.
This ensures other references are applied. Do this by extracting out the
transaction commit code into a new `commit_ref_transaction()` function
and using that.

Add two tests to check for this regression. While here, add a missing
cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
This fixes the bug reported by David Bohman [1].

[1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com
---
 builtin/fetch.c  | 65 +++++++++++++++++++++++++++++++++-----------------------
 t/t5510-fetch.sh | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..8dea08dc74 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,38 @@ static void ref_transaction_rejection_handler(const char *refname,
 	*data->retcode = 1;
 }
 
+static int commit_ref_transaction(struct ref_transaction **transaction,
+				  bool is_atomic, const char *remote_name,
+				  struct strbuf *err)
+{
+	int retcode = ref_transaction_commit(*transaction, err);
+	if (retcode) {
+		/*
+		 * Explicitly handle transaction cleanup to avoid
+		 * aborting an already closed transaction.
+		 */
+		ref_transaction_free(*transaction);
+		*transaction = NULL;
+	}
+
+	if (*transaction && !is_atomic) {
+		struct ref_rejection_data data = {
+			.conflict_msg_shown = 0,
+			.remote_name = remote_name,
+			.retcode = &retcode,
+		};
+
+		ref_transaction_for_each_rejected_update(*transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
+
+		ref_transaction_free(*transaction);
+		*transaction = NULL;
+	}
+
+	return retcode;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1826,6 +1858,10 @@ static int do_fetch(struct transport *transport,
 
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
 				   &fetch_head, config)) {
+		/* As we're using batched updates, commit any pending updates. */
+		if (!atomic_fetch)
+			commit_ref_transaction(&transaction, false,
+					       transport->remote->name, &err);
 		retcode = 1;
 		goto cleanup;
 	}
@@ -1858,33 +1894,8 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
-	retcode = ref_transaction_commit(transaction, &err);
-	if (retcode) {
-		/*
-		 * Explicitly handle transaction cleanup to avoid
-		 * aborting an already closed transaction.
-		 */
-		ref_transaction_free(transaction);
-		transaction = NULL;
-		goto cleanup;
-	}
-
-	if (!atomic_fetch) {
-		struct ref_rejection_data data = {
-			.retcode = &retcode,
-			.conflict_msg_shown = 0,
-			.remote_name = transport->remote->name,
-		};
-
-		ref_transaction_for_each_rejected_update(transaction,
-							 ref_transaction_rejection_handler,
-							 &data);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
-			goto cleanup;
-		}
-	}
+	retcode = commit_ref_transaction(&transaction, atomic_fetch,
+					 transport->remote->name, &err);
 
 	commit_fetch_head(&fetch_head);
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b7059cccaa..92b3a8e79e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,46 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 	)
 '
 
+test_expect_success 'fetch --tags fetches existing tags' '
+	test_when_finished rm -rf base repo &&
+	(
+		git init base &&
+		git -C base commit --allow-empty -m "empty-commit" &&
+
+		git clone --bare base repo &&
+
+		git -C base tag tag-1 &&
+		git -C repo for-each-ref >out &&
+		test_grep ! "tag-1" out &&
+		git -C repo fetch --tags &&
+		git -C repo for-each-ref >out &&
+		test_grep "tag-1" out
+	)
+'
+
+test_expect_success 'fetch --tags fetches non-conflicting tags' '
+	test_when_finished rm -rf base repo &&
+	(
+		git init base &&
+		git -C base commit --allow-empty -m "empty-commit" &&
+		git -C base tag tag-1 &&
+
+		git clone --bare base repo &&
+
+		git -C base tag tag-2 &&
+		git -C repo for-each-ref >out &&
+		test_grep ! "tag-2" out &&
+
+		git -C base commit --allow-empty -m "second empty-commit" &&
+		git -C base tag -f tag-1 &&
+
+		! git -C repo fetch --tags 2>out &&
+		test_grep "tag-1  (would clobber existing tag)" out &&
+		git -C repo for-each-ref >out &&
+		test_grep "tag-2" out
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 



