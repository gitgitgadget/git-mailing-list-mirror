Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50446304982
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588805; cv=none; b=bBGp7PkvuFRNLPHfvUTqsRXU7kVoNtqr9bdn/kQf3PWYaTkgv+GFGs4JrQd0mC+dVmN403LnUsbQq5CLRhxmxJZh2LZvPYkOFsvv+0dAB6WCNVhtMcPzO5Z+I3E8GGhLdciTA6gwL2lRvLKHRaAw3enXT3zPP8lfaZTZL+V2528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588805; c=relaxed/simple;
	bh=R6eDKFidhEYQJKnljw6y5DG8lJW+X1caLs1zFkbXjkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7ueI9fMiwYP+3Iwgmkh+eE/Z87MskpasiPWSjrgd4KT0mqhlUr/D7Cm3R1b+RdCMPpqKWEL1Q4lAKo2mBukfcQHc1uQusjSUyiNcGfAzyAX2STMCWelrof/JTx7fa8iBvTgGRAsgmMOHqPGHMftft2VeblyHAVeKbiBYhUE/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjWqiJCW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjWqiJCW"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so33853466b.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588802; x=1764193602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HOd9VEzz/Nx3BYszmWfGeOJ77DkBVwJzjHhXkITMe4=;
        b=VjWqiJCWyt98WWLVFm9yBXkKVRawQOfwgGxNYSb3LHSlZxxC1iTN3gnrlNRR23GAI3
         EjtFR/dGIA3qBlcbqy6zB68TEqeNwugonLvD16Rxwp2IaZFUbK4yLL80H/Ly1lGH3ZZ8
         iB3p14DzGmh2MO9qgcl9uKEKwrueE8bxbWYaUuxXxplkLOjuxsRf47/uEsHdOjUkgLpU
         ChTs2EwZMUP+SzfcCQx7gWfN9Ud6GhtrvbDDZOMdgvxMUvG09UHi5cGpy1tI8E5NMHmq
         FpeldpLZq1yxpzVN3LEeMIQ+xfa19vboFfG96XOin8O7L5jdU0Yvg/7NwWulecsMnuQE
         yNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588802; x=1764193602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8HOd9VEzz/Nx3BYszmWfGeOJ77DkBVwJzjHhXkITMe4=;
        b=DeMBJIKcQRV7Yj1BEj2eeGNUtd5zlgTd9tZ25Hcmo7ewG+86QFarpFyy7gDEHcrGHh
         Ea8iNjvPpAJ8u2dilVJl3kO8I4uICdFTPqInGJ21DmjaVbEz0bP16qJu220lK9D2Leb6
         mOJVIJ1cPjA5ICiRS/t/k3e55s/PK0qzHyXapP5cxaRZ3m+GMb9mEIEKiNaUVEZj0T+a
         j4+BWiYzEvNlnSRmkk0uT/PQODNYk+x01jgIOXxsi/HbirW55p1W2HePrDvvgXvRRnpE
         QO7WLJhsmWoXnMy5fVzW0aCZL7SCdAKRJkK7kb0LqkuN/84XGaY+A5tHoQQ8sYwuTrt0
         opJQ==
X-Gm-Message-State: AOJu0YyBF2WjOr9ClallTCL2Hws+Mlee/DM/+oEArZuEWzqKck+uHClx
	G3Tpu6i//k3K+rS0ji84mi5vVN00wk58iB/XryoLmM3T/GK6+rPOQw4TfuL1jg==
X-Gm-Gg: ASbGncv5MgbdcV+KhjdqZuZVQJt5+jwJwrfLLL2jYuTUNu89Mz4kdTVNUhrO4IsRqW1
	fqGNES4xhGBUexj9U3EuJSmFCJIYgsWJJVAKoFkE8qq/k5WnQU54jGTnX3KF8iVKIHlBCUb/iON
	hnmUmWry/anh2qWp01k9M/z0a90/EA/ANA1djOWDy9OXtkDlL7ytXA30MyjIXD0RvfbBTKcA2pP
	RESGqGxXRrnO9LT8DuQb73vSEzUByJI4k51+3A+UNbSJs7SdBnteAtl5A3zeT+Bq6cfdNKf+UWW
	lEzQS+QvSVhJmWS5iNaHlTFclTc0Pd5QkTG7DlQ8jcejuX+x5vVQQGvrIsHyAbZe/31dv0lkoIe
	rkAVa8Hq7i1MOQAbZGu0Ruwd/lVXZiY5NczRRaoBeEKo2NSDOjHsb+prFhm/Yb5Xqr7/Vr1KBOp
	b6XXKNDuOs7qzfTC4=
X-Google-Smtp-Source: AGHT+IEd2T5/Deg3+9MesH8shD7z214NSmglSWaFPui9RdEo0oz4CfJWqqNBrly7jGc+elFYFGQj9g==
X-Received: by 2002:a17:906:c14a:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b7654e4198emr75043666b.25.1763588801457;
        Wed, 19 Nov 2025 13:46:41 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm40760866b.24.2025.11.19.13.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:46:41 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Nov 2025 22:46:34 +0100
Subject: [PATCH v7 3/3] fetch: fix failed batched updates skipping
 operations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-fix-tags-not-fetching-v7-3-0c8f9fb1f287@gmail.com>
References: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
In-Reply-To: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=R6eDKFidhEYQJKnljw6y5DG8lJW+X1caLs1zFkbXjkY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkeOrzr2hmrVjWlchWiS1SPO0g9UcXljUbIP
 vAbz+7GMSJWiYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjq8AAoJED7VnySO
 Rox/u/MMAIrK3qGKy807huybOKS7CdQrET/9Vqdl6loXEbUAQ9YdYpDv18UDr30DyT75FpxlkUD
 GXS8wN72/2UKjkVPvtvEPC0ixEF+jm80/CiIw8z3+/oL/mraphxOnz780bznBy+p1zt3MJo81hg
 3TCqFbD2cazWMwJ1Mz8V15pQCLItWys7tW5TcEC9EoWrw3DEV4/KHLuPMhnEeKwR4+bYfe6WdfQ
 RhZMHDgxKqLb7zykwb47a6PR7k1eTXDjHkaLy/wKfg+Yk4riOsVrYgOYc2MOoNqLDtsBc7rDKPa
 0UbGORXeYgrMq0bzr/gnegNZBmkfC/5nf7VLRtE3nIHRGlS7pEF9UZBGr/H/7jCMI0NYkIjoLeQ
 /H95sOpR+cwiPkISkXp8BKtvih9Wdvhg7kE4sJFQrNjPB3kVSYh/E23rJgRQ5qVvHfCzmLlQpTs
 lgpW1QXwhMmxJu09+0aV5hChbswFQkO9tJ+2+PWhOWGG+ayS3xc0Y4U4Yvmiw+dMZ4SqsBzuTC3
 rE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Fix a regression introduced with batched updates in 0e358de64a (fetch:
use batched reference updates, 2025-05-19) when fetching references. In
the `do_fetch()` function, we jump to cleanup if committing the
transaction fails, regardless of whether using batched or atomic
updates. This skips three subsequent operations:

  - Update 'FETCH_HEAD' as part of `commit_fetch_head()`.

  - Add upstream tracking information via `set_upstream()`.

  - Setting remote 'HEAD' values when `do_set_head` is true.

For atomic updates, this is expected behavior. For batched updates,
we want to continue with these operations even if some refs fail to
update.

Skipping `commit_fetch_head()` isn't actually a regression because
'FETCH_HEAD' is already updated via `append_fetch_head()` when not
using '--atomic'. However, we add a test to validate this behavior.

Skipping the other two operations (upstream tracking and remote HEAD)
is a regression. Fix this by only jumping to cleanup when using
'--atomic', allowing batched updates to continue with post-fetch
operations. Add tests to prevent future regressions.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  6 +++-
 t/t5510-fetch.sh | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b19fa8e966..74bf67349d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1890,7 +1890,11 @@ static int do_fetch(struct transport *transport,
 
 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
 					 transport->remote->name, &err);
-	if (retcode)
+	/*
+	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
+	 * continue to fetch head and perform other post-fetch operations.
+	 */
+	if (retcode && atomic_fetch)
 		goto cleanup;
 
 	commit_fetch_head(&fetch_head);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b113d7c27..cd55958bdc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1639,6 +1639,93 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	(
+		cd base &&
+		test_commit "updated" &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @
+	) &&
+
+	git init --bare repo &&
+	(
+		cd repo &&
+		! test -f FETCH_HEAD &&
+		git remote add origin ../base &&
+		>refs/heads/foo.lock &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test -f FETCH_HEAD
+	)
+'
+
+test_expect_success "upstream tracking info is added with --set-upstream" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base "updated" &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		git fetch origin --set-upstream main &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES "upstream tracking info is added even with conflicts" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base "updated" &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		test_must_fail git config get branch.main.remote &&
+
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/main.lock &&
+		test_must_fail git fetch origin --set-upstream main &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES "HEAD is updated even with conflicts" '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	(
+		cd base &&
+		test_commit "updated" &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @
+	) &&
+
+	git init --bare repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+
+		! test -f refs/remotes/origin/HEAD &&
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/branch.lock &&
+		test_must_fail git fetch origin &&
+		test -f refs/remotes/origin/HEAD
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.2

