Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4B2FF140
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588804; cv=none; b=R2BOxY6wdyFSqpBlcYtw7NKyu2TQxZdKdJyqh0ZnA4fSkyYQWQ5gDBXH22nBWOeHbxHJCOCLd1x1Kxp+9KjsGj60RivGoXkL7PUqPg58ziIvgwY4rU3xanMs1BkgNajAam5F3DkAJ/8SIaxzpRMh9mdc5oMFpQfO7w0zu6/5OOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588804; c=relaxed/simple;
	bh=2k7HhaIYOOs3BXh12x4/laVna60CmztFvFCcmQaKggU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILRbHXm8lPMxgeS4U2Ryzcy8sxyVU10ETC1gDcl3Z1VECv4wSyTxXvb/SIEtcxCVDFFo4NRpto17ZXHDaNUKQfnxv/d/WSL+rIMMzzXFJtspuy8A8gwZlPUlpwhWsmniUGxB13tiL+2uKej2C6t/ouZ0VPjKC1zmwY2XKrsX/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtcqrYwg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtcqrYwg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7355f6ef12so45628166b.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588801; x=1764193601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnaAKwk7x7oDqcRXpULbV9nX0QVS5pHyYgmJtTViigs=;
        b=ZtcqrYwgVXjGnfPHcXxuPr1ub0shKYLhZRgjej7SXkCp3gdJdCvhfdYnLqF2Im+bYN
         tFEJhpKyvOei1/TNAYMNr60DzNhkPrRePCo3sEuY9r5aSTGuE34aS+nVK6Qa2RIXzPSP
         DhVO4+Ds+qQkUUk9EN2wPuaOlrdU8x4jmDABNina9u3UtOqaaSXXAnHr2t+AQeMJuRht
         X+iilvZY6JYFeinTJZIzkIyVHPLcrX0IUcemOG83SalxrHDVJXnLXkfHyo4/lAzaBToW
         kxD94r4H1UWBsJwH+mGKKKdjLz4whodyFQpm7Fa0uaz/nv5RJHIZbeLkCcA4xdu7GCq0
         Af+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588801; x=1764193601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnaAKwk7x7oDqcRXpULbV9nX0QVS5pHyYgmJtTViigs=;
        b=i6k+nRlZkFz9qX2mKZCDvcvAPs2sNNekJXCdav0rebC5TGfrN0psQdHaAk1+jPS73j
         gdJrsAg85CtRjOvYreQ1ni9XnUMvQ58jnJm+j1KTlzSwtDBa/r9ZFEkQEI9i580axUEj
         1u5IJP0Vbp2qOMrQDx1glomhONZZpvg/GG9OQGXhmVNDsWciJfH1ncOaIKb2nGOw2dMd
         lMxL3pZNV8amgZ+1TDcnzXJ7ZbX3rgGD01OnasblDGnrelP2cFSko9BN+F/F0/suq86k
         0C2Z8nGF4gOEwrnp9yrgeDSaoccSGktJ3s79LNpjiwyXKNUJN28pkor0EBLz/4QOPb7U
         ne+Q==
X-Gm-Message-State: AOJu0YzgCUkVEjQshU/DS/PPFftJk5hcpAj4jO9xrCtt6OQQyZt88Q0p
	CxU0gVRfcGW/6mRFR8yPy/dVRrYGRrEtjmKqgv3QDBomAoRfXu67n36z
X-Gm-Gg: ASbGnctrcov8SlFSg3U3iX4Ukdpd06GgBI4g+Gk8QVBQJXUkNYVLzYh2Yn5Gz3jkq+v
	QGoRMfp3tZ2KFSLiv8wIibRv0vUfPg+Ey9nQL/VsDUe22/ESSWz9y0Ga0rQBvzp2K2ij/2MqW2F
	Zc+x941gkvyunh16M208ts9cC+WYNlqB9ud1/M056Kn/Wgw00pDdhd45XlK50DccYv8mzH7Vd5G
	WLnNpZt+H96T8pJ3JS5WH8JL3oEqlJjT7crShrC7Y8Pw4r2F9YTyvElYZxV+eXWdqQB7CBjFIYQ
	ynYEKsLDx3PGmotcOiDBLyw/UsqCvp1pPSRGTE+cP0PeL027p+fHvkr5pNefLsZA5DBZyXwS8AX
	45/9Rut1NafPi8RC0WunSlHNZBwHLjSGcfKtY4dF9budnThj2UHeFKXl4EKQKFokbeM8vHGVuKf
	/olTAROYLsDzlknnGYuV9G4oKbHA==
X-Google-Smtp-Source: AGHT+IHVICT38y4fcJgG+lrX5Y1qTasLo2pJhXXaAKtkePCiWaAuqt+kjPU6Tm4x2xYWh+5DAfieBQ==
X-Received: by 2002:a17:906:c10b:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b7654fd4d56mr61038066b.56.1763588800433;
        Wed, 19 Nov 2025 13:46:40 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm40760866b.24.2025.11.19.13.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:46:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Nov 2025 22:46:33 +0100
Subject: [PATCH v7 2/3] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-fix-tags-not-fetching-v7-2-0c8f9fb1f287@gmail.com>
References: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
In-Reply-To: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4724; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2k7HhaIYOOs3BXh12x4/laVna60CmztFvFCcmQaKggU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkeOrs1tN8Xe28SRtzSWN/hb3qTOjpNEyWUG
 FdhKCP3XSAJn4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjq7AAoJED7VnySO
 Rox/trwL/1XDvWgxOIpTJVdTc4uSbb3julPzam2qjnT+Iukc0w9S2+BKkW6E28gwW4ffGuib/8T
 Q8ld12JAbuwkaIpFeMVcAgopBKlOqjgeU8z1OGi/YRcwzDDHJTmHeQ7IN93tGAtaJqVbj2sth0k
 IVwbSSttW4myxe0GDEi2y99/x0QQkE4JEkgmdIPuzQBSrzcIkE6DPkwhkVUo7fAHSCoDXcz/zCO
 +vdy9ZoIP0xv/XuyKI3BzKilCqDUaTmEtc2Qq/KBhXuQc7DaSyIS4ZIJ9RSRmjRXGYI0AAG2r7V
 uWioHKgm4Fo5n8zBlESqAiGgzEw82sq8a3QK7Vhd6yRmPvmM7OR68Z0nZIjdq7g4eYa+aHECnw8
 5XuZv9qdvDTtAr6e/0Tq1f8QdiQmaH3HTKP8f5MyrRJYQU/0DWSSi0HDr9n/db4+Jqm6TscJO+K
 4zgltZpPA4LDfZjANqgB8QUm4G4YqMwR4OFUYEeGQOCs9/qbDbdNjSSv6jyd+oHVxPule82x5i5
 y4=
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
2.51.2

