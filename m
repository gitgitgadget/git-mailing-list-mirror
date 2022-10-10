Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA1CC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJJQFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJJQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CE11C08
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j7so17728658wrr.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5coDUwHZsaHn1PK1IbXppO0kgOOoZfGb5G1Ie7WV8E=;
        b=SfDlgQLy/H27nKbjlkECMqKc3i/9w24jb/YvSPRQ0XdRHyGY9x0QcCaftiiMssuwDa
         7LUXfRh2/ykH8dchoVKTm9jj9AOENmTXG4jXZ4Y2zwwNdzd0a5+eJ+a+O+iNbZmhz8bC
         wZO6sZKSleDMXUp3wUPvOwb6mriBaDyqxxzOtdGZlZPsIyvYB/SAOJMsnZs1IWJhgK9n
         SKiOyB57U2xKn4PJJBbnnLMwfap6t4lvrwyc6nsu+l+X3rEuMzlr7rcUDx0GKEe0JGtc
         Wyp9mEroi3chnugKS5+dg2jnKQcBUHh3G/Wt9Fd8V1LOFTVXCCepOedfoSVcDH9zzEXt
         9CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5coDUwHZsaHn1PK1IbXppO0kgOOoZfGb5G1Ie7WV8E=;
        b=6y974ftKAuKYouksAM2G5vXiliGLs5t3FOd8mKA2Ybz10ZsfORjO/+7Pif6s+OUbI1
         H2cq6WyY0B2N6OQ9a+835UmiY+rn/JfnaKXra6E6qMmnQlvNtU7afk8uLeUhTGP6lI/i
         Xy8wcaBu+83J4yVS6vSewR4ZAI1jH3ZDPYDpGKvfr8v3kyBc/qm8dXHHwKlMVePfdqon
         r36Qkep/Wp1+ILo6C5TjRxWbk9DmaklpFphuLOC1RysV4mNZUWwcQKjWrv3GrcrVM2X4
         FCUs0NwNaNMpuVrKv85R+O0v6YLInJ09wmFYKEQ6KaJXrZumjM8xtShjmaRQxEGjTUwZ
         PfwQ==
X-Gm-Message-State: ACrzQf1wre7Tc8lvQPxertbndVmhZj9J3tpqlliiZZ/CXEYBU99KnVSM
        DVafdzPFd+kSrS8/pNQg/17vqf0onYg=
X-Google-Smtp-Source: AMsMyM5d/bLpOR6hYtAmFrfLMeTcpNF7I28xvsQJFHVs8ZFOoNPObaPjOgPGf6lGxRGzIB0IG700UA==
X-Received: by 2002:a5d:428c:0:b0:22e:5d4e:c71e with SMTP id k12-20020a5d428c000000b0022e5d4ec71emr11709244wrq.19.1665417873342;
        Mon, 10 Oct 2022 09:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003b4e009deb2sm12708267wmc.41.2022.10.10.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:32 -0700 (PDT)
Message-Id: <1cae309662457be8a006de3c317a4f5f09438930.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:18 +0000
Subject: [PATCH v4 10/11] bundle-uri: quiet failed unbundlings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When downloading a list of bundles in "all" mode, Git has no
understanding of the dependencies between the bundles. Git attempts to
unbundle the bundles in some order, but some may not pass the
verify_bundle() step because of missing prerequisites. This is passed as
error messages to the user, even when they eventually succeed in later
attempts after their dependent bundles are unbundled.

Add a new VERIFY_BUNDLE_QUIET flag to verify_bundle() that avoids the
error messages from the missing prerequisite commits. The method still
returns the number of missing prerequisit commits, allowing callers to
unbundle() to notice that the bundle failed to apply.

Use this flag in bundle-uri.c and test that the messages go away for
'git clone --bundle-uri' commands.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                |  2 +-
 bundle.c                    | 10 ++++++++--
 bundle.h                    |  3 ++-
 t/t5558-clone-bundle-uri.sh | 25 ++++++++++++++++++++-----
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index c0a6fb05fad..18b993c207f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -309,7 +309,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_SKIP_REACHABLE)))
+			       VERIFY_BUNDLE_SKIP_REACHABLE | VERIFY_BUNDLE_QUIET)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 36ffeb1e0eb..143e7c4508f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -218,7 +218,10 @@ int verify_bundle(struct repository *r,
 			add_pending_object(&revs, o, name);
 			continue;
 		}
-		if (++ret == 1)
+		ret++;
+		if (flags & VERIFY_BUNDLE_QUIET)
+			continue;
+		if (ret == 1)
 			error("%s", message);
 		error("%s %s", oid_to_hex(oid), name);
 	}
@@ -246,7 +249,10 @@ int verify_bundle(struct repository *r,
 		assert(o); /* otherwise we'd have returned early */
 		if (o->flags & SHOWN)
 			continue;
-		if (++ret == 1)
+		ret++;
+		if (flags & VERIFY_BUNDLE_QUIET)
+			continue;
+		if (ret == 1)
 			error("%s", message);
 		error("%s %s", oid_to_hex(oid), name);
 	}
diff --git a/bundle.h b/bundle.h
index 9f798c00d93..ba453404163 100644
--- a/bundle.h
+++ b/bundle.h
@@ -32,7 +32,8 @@ int create_bundle(struct repository *r, const char *path,
 
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
-	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 1)
+	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 1),
+	VERIFY_BUNDLE_QUIET = (1 << 2),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index a86dc04f528..9b159078386 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -99,7 +99,10 @@ test_expect_success 'clone bundle list (file, no heuristic)' '
 		uri = file://$(pwd)/clone-from/bundle-4.bundle
 	EOF
 
-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-list-file &&
+	git clone --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from clone-list-file 2>err &&
+	! grep "Repository lacks these prerequisite commits" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-list-file cat-file --batch-check <oids &&
 
@@ -141,7 +144,10 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
 	EOF
 
 	GIT_TRACE2_PERF=1 \
-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-all-some &&
+	git clone --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from clone-all-some 2>err &&
+	! grep "Repository lacks these prerequisite commits" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-all-some cat-file --batch-check <oids &&
 
@@ -169,7 +175,10 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
 		uri = file://$(pwd)/clone-from/bundle-5.bundle
 	EOF
 
-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-all-fail &&
+	git clone --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from clone-all-fail 2>err &&
+	! grep "Repository lacks these prerequisite commits" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-all-fail cat-file --batch-check <oids &&
 
@@ -195,7 +204,10 @@ test_expect_success 'clone bundle list (file, any mode)' '
 		uri = file://$(pwd)/clone-from/bundle-5.bundle
 	EOF
 
-	git clone --bundle-uri="file://$(pwd)/bundle-list" clone-from clone-any-file &&
+	git clone --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from clone-any-file 2>err &&
+	! grep "Repository lacks these prerequisite commits" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-file cat-file --batch-check <oids &&
 
@@ -284,7 +296,10 @@ test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 		uri = $HTTPD_URL/bundle-4.bundle
 	EOF
 
-	git clone --bundle-uri="$HTTPD_URL/bundle-list" clone-from clone-list-http &&
+	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
+		clone-from clone-list-http  2>err &&
+	! grep "Repository lacks these prerequisite commits" err &&
+
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-list-http cat-file --batch-check <oids
 '
-- 
gitgitgadget

