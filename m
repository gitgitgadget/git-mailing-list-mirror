Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51B61FFE
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418373; cv=none; b=iAhl0yqwJrMTkFzUED+Eqi6vmlAQQvJaMX98zD2vS5zxe8M3Z/4P28GPpPILIKHz40/97gLCmfXVHAz1KP27c/dxy0I9Cy0JqDBXWJPRGkNHeUVQYMD5mQEAbSmVwsSKsBESsafnCUpyJKsdn5RKyDNkgv3BnTNkGAzN7hdcnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418373; c=relaxed/simple;
	bh=IbJmjhN7Z60W6czOBr/n1M3bmFggAPscCpMt1D8d7u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=a6aRWxLsMMIvUL+GPqKcSenxAcdYslJGd/Dj9VwUIWG6OriKz/idBevvvuLLVLfBq3i7J1mZasjCeN+a99rWeg+xLOzIFItuxXyRF/tWH63hbVFq162m94F1BlN5z//8zg9ti4BpJuAkDnbrYsKmag97xk2vNC9bXyQ/2AEWu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI9DJ3/U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI9DJ3/U"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so446417a12.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762418370; x=1763023170; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eurc3YQ1CKts0U1y06N7ZJCEXtIo3AghpNVt9qI2/dg=;
        b=NI9DJ3/UZc1DiLxRphWlKjZPnK0OWdbmsIMo+bcntinG8FluQL/vOGkw3/QbPBL0z9
         9KGvMKwGCm3F0EB1hYkPyOIWcreEsRTQ3oQFPrfJCAEjm8q5ii4h1B1xUU7Nh0eS4zfv
         GZmoz823bez7DKevvW85lTxT05xam+RWSNr2uqWfe8/otfqNOdOnIXer4lt8lCEAY90o
         v5NnlpfIxInB432HHVlmyiz7zJ8OTB0J8MvjOYWyGcfiTQeyxlE1/VndkolCbMxnDLdW
         1dLdiMrrSEjUBFIj0uP6LVQweTKoY9HtOww1Xrbvfscg5I9HNGJXGqJ5lq03w5lTWkpk
         5BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418370; x=1763023170;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eurc3YQ1CKts0U1y06N7ZJCEXtIo3AghpNVt9qI2/dg=;
        b=rAhp7wY4yPNHQBgyAjUJAynvIk0uZMZZUQa0N/B99oJe7lBGluq39fOFWs/LMtioLf
         HYECQ17QwKMYHlaUszUMeP9mKnJAVRHwRpTEIypnkQli2/uuZjIq5IJvk4Tf58KQa1Fh
         amqOUbxv0S//L1FTB2wXEldseHgdRy+7l70YjGK0Yluwf5G+Tdw2VYyaqmYO8ySfvoxl
         Y+yBHHjIjUJaf24A9rho53lTQ7fbyXV+gDy3sWSfOR2nhxIBRP+UmI8i/96t1BP1PdcY
         CeAEeB90zWzhyNIAUENaizgPLHqTrHArsURpWaLmdpsBdHGU0Qqr49br3k93RWPxHP3H
         aa1g==
X-Gm-Message-State: AOJu0YwZXMXmE4iExJYD9ljD3VJlzpeLPrcX0chzmmvYzAj4cw8VfPb0
	JNKvKUXl81wjXHXDc+Nqdsqpjvw7xMerw97PAiJrC3l1RHotRcHs7dtM
X-Gm-Gg: ASbGncsuJ/5eG6+QdVhQ3D9s/F4yON62aFAPS8F1f1ZMb3N8Cmwd9wXakTqMDUZ7b89
	uCqVy5cz/+uYry73FO3pDKN+3FvbwO8uOV3vMwmuXGHGzo5kuqHxkbhZn++DrMDt/+918SOkZ94
	vseBd5zQg8oIc0xN+2h17OWlpK+ZoguUPIEC1Kt0xLBw9PVg0zvJudmhHdSPO6WrSErdYfV6PYD
	6r5MLrc3eTxJ3z1wp5FYmLLJz9HTq63USJaF4SIYs61zhsV3EMpN399Se5vwhkmHhIPAjgm5Xn4
	5GWUWoFm+atnSbkOFvFGqxxCTIVh1ucyBjy6gMb42LgFdA5EWnHz7gEYg9bUgqo0nXgGk9+SIzR
	4b6Tgj5WZKQN6nGtajp22zUFrdyg7IU3NdLxhAMaR9CjmryuaQfE/9llONm6gw/yeLJGzAA7Zvg
	StMBna+HDiiYMp1lk=
X-Google-Smtp-Source: AGHT+IHAQ+wjFnK8GUFGBr3QnEcsQKznFIWzwiefIgpQtfXJYhJO2EMZAAJ4rFwVx8l888DKNEA9cA==
X-Received: by 2002:a05:6402:34c2:b0:640:74f5:d9f6 with SMTP id 4fb4d7f45d1cf-64105a5c79fmr5706397a12.25.1762418369866;
        Thu, 06 Nov 2025 00:39:29 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f85f8c7sm1364781a12.27.2025.11.06.00.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:39:29 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 06 Nov 2025 09:39:25 +0100
Subject: [PATCH v2] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIALxeDGkC/4WNQQrCMBBFr1Jm7UgnrRVceY/SRUwn6YBNJAlFK
 bm7sRdw+T7/v79D4iic4NbsEHmTJMFXUKcGzKK9Y5S5MqhWXYjaDq28MWuX0IeMlrNZxDtsLQ2
 KdH/t5x7q9hW5Fg/vOFVeJOUQP8fNRr/0n3EjJOShM5ofgyHq7m7V8jybsMJUSvkCAn0hyLoAA
 AA=
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, sunshine@sunshineco.com, 
 David Bohman <debohman@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7537; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IbJmjhN7Z60W6czOBr/n1M3bmFggAPscCpMt1D8d7u4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMXsBKXBzSgxio4of+mSAtphe1oIWuHdJYR
 ZlRz4CPkAj6KYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDF7AAAoJED7VnySO
 Rox/uqcMAKOhgatr/iMxB9MskWCldGJfwb/nCYWEyEtl90GYgneScotMq8sIAr9baXHdW61fuWL
 47AnFxXN5/mLGrMtTPc0EAEzbyFD0Jsgb9nRjwU/d6ruA2hLRXi8qauHU0HNfaBoVR4Rf2Q2o3D
 XMDfCeRebm9DY4VCEHUaQKjdDpe0pfitmTI+EnkrN0A781zEDAV1Bzoe1ua95jwPPca3Q8sGmPK
 LYGV52PJqUP+VuitVNCwIZ4PtZo/du4MIta+xdJ4nzDiWeWeQTvmDFLqCKAtqekFfjRE2nHLnG7
 snEmSy0uKsXYeK7ZwUM6j0E+PC7cEmtAeseUZ7Gm+J6FUAmERLeZ5fUm6n+RjX0rqnAgp3CJvjq
 evIaJHEDWulenAL0lpFXKtWzJOOEjupDfI6REp3KrjGeDf6Wc3eS80XVhvd8JOKE/reTgyFsTbl
 oM2JR0IthB4y4WynrQSgg0Jm/c9tZyGxvMNbLzRvP6uqT9686/RNeOokJgj8WYFQLcy/IL7YUM7
 oU=
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
extends to backfilling tags when using the now deprecated 'branches/'
format for remotes.

Fix this by committing the transaction even when we have an error code.
This ensures other references are applied. Do this by extracting out the
transaction commit code into a new `commit_ref_transaction()` function
and using that.

Add tests to check for this regression. While here, add a missing
cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
This fixes the bug reported by David Bohman [1].

[1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com
---
Changes in v2:
- Add a comment to explain the purpose of `commit_ref_transaction()` and
  how it works.
- Also extend the same logic towards backfilling tags. While I was able
  to add a test for the happy path, I couldn't figure out how to test
  when `backfill_tags()` tags would fail.
  Tangentially, this flow seems to only be triggered when using the now
  deprecated 'branches/' remote format.
- Remove unneeded subshells from the tests.
- Link to v1: https://patch.msgid.link/20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com
---
 builtin/fetch.c  | 75 +++++++++++++++++++++++++++++++++++---------------------
 t/t5510-fetch.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 28 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..d5aee5af10 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
 	*data->retcode = 1;
 }
 
+/*
+ * Commit the reference transaction. If it isn't an atomic transaction, handle
+ * rejected updates as part of using batched updates.
+ */
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
@@ -1826,6 +1862,10 @@ static int do_fetch(struct transport *transport,
 
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
 				   &fetch_head, config)) {
+		/* As we're using batched updates, commit any pending updates. */
+		if (!atomic_fetch)
+			commit_ref_transaction(&transaction, false,
+					       transport->remote->name, &err);
 		retcode = 1;
 		goto cleanup;
 	}
@@ -1848,8 +1888,12 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config))
+					  &fetch_head, config)) {
+				if (!atomic_fetch)
+					commit_ref_transaction(&transaction, false,
+							       transport->remote->name, &err);
 				retcode = 1;
+			}
 		}
 
 		free_refs(tags_ref_map);
@@ -1858,33 +1902,8 @@ static int do_fetch(struct transport *transport,
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
index b7059cccaa..9ff656a2bc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,66 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
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
+test_expect_success 'backfill tags with branches remote format' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+	git -C base tag tag1 &&
+
+	git clone --no-tags base repo &&
+
+	git -C repo remote remove origin &&
+	mkdir -p repo/.git/branches &&
+	echo "$(cd base && pwd)#master" >repo/.git/branches/origin &&
+
+	git -C base commit --allow-empty -m "second empty-commit" &&
+	git -C base tag tag2 &&
+
+	git -C repo fetch origin &&
+	git -C repo for-each-ref refs/tags >out &&
+	test_grep "tag1" out &&
+	test_grep "tag2" out
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 



