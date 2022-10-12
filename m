Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539E8C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJLMxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJLMxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:53:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C28C823F
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so1150860wmb.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP2j5/Hfsewkj2oC+Yr4l+5lEuk6HhreKDodb/i3CSg=;
        b=A5A6xZv0ermae83JAo4JUUy0/p8V2qXlXOCHMUT7SGffTj0iurd19ajaPDvaYG4Q9o
         0ahPmywvUyWi5zQT9Uz4URHuSlDNHi+C6qWJmM0mY8m+TVxI57XOnjVk8siB+VBZQ4zW
         iZ0EnRDtD8cpNs2Q2YYZfHB3QRlKfGT3Qvn5C/zUrSqoZHaAH6Vf8aw3gg9loo03sGmO
         MUmf0jsej9vXtiO48KhYV8UZ4o3N6QR+fU1q91/jlsssQKdiH2Ib4MSjAIBF48lgmRSS
         8Vu5gq0dUWfcAr79xn+7gguVz8NERrhx6LDcJsAs/U4MJwJaUFQA7kniCRS7qt/29Dex
         2lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP2j5/Hfsewkj2oC+Yr4l+5lEuk6HhreKDodb/i3CSg=;
        b=QdyYZHFA94DfNJaBEfOE341aJMNsoQGsHP/it9WhzzuwT1itHYGStgGxSqNodut98h
         PaXWIpYYaE0jas3KlRBIz9F/n1yNSiiL3YFJ5Jwt9P+urh9N8fz40PLF0D8TqmaQPx3M
         y/i3PhpF081rKJts+PnDeCKrwrUxbfOwS4KakFFAEFW3LYu3MlTcIEWfmHAz+7RTFyjU
         FeYGBwMxpCVmHiiyRQGMNY9vrvrgg2Xb9wutPUnzAzrZL4iaVXiJ+cqbVK3ToAn93L1Z
         a1QUWAXaW+cJKjzd498dpmB+rOKKWdNwyoC8zWPH0xX0wUXM+mMym9/I3cjcANeWyGjF
         tLyw==
X-Gm-Message-State: ACrzQf2wKoMgOb8zmd2/RWBlAwslDvkfgzTDKl8FcL1cvbVMi+Ri7+0C
        RVjJlMHQd2wlTa4Py7gZ6uI6i/B6vL4=
X-Google-Smtp-Source: AMsMyM5P5UX7+d7UXi9Gskbv4CQOiVGwau4+saJXHmBo6CXLpIDwYf953ttWDWTd36fO9Qp+zVlq7A==
X-Received: by 2002:a05:600c:214f:b0:3c6:ce02:8a68 with SMTP id v15-20020a05600c214f00b003c6ce028a68mr2739907wml.187.1665579175807;
        Wed, 12 Oct 2022 05:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c065600b003c6c2ff7f25sm1641298wmm.15.2022.10.12.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:55 -0700 (PDT)
Message-Id: <2e0bfa834f14e1f4f66adf36d4326e5f1c2c9c20.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:38 +0000
Subject: [PATCH v5 11/12] bundle-uri: quiet failed unbundlings
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
 builtin/bundle.c            |  2 +-
 bundle-uri.c                |  3 ++-
 bundle.c                    | 10 ++++++++--
 bundle.h                    |  1 +
 t/t5558-clone-bundle-uri.sh | 25 ++++++++++++++++++++-----
 5 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 7d983a238f0..fd4586b09e0 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -120,7 +120,7 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	}
 	close(bundle_fd);
 	if (verify_bundle(the_repository, &header,
-			  quiet ? 0 : VERIFY_BUNDLE_VERBOSE)) {
+			  quiet ? VERIFY_BUNDLE_QUIET : VERIFY_BUNDLE_VERBOSE)) {
 		ret = 1;
 		goto cleanup;
 	}
diff --git a/bundle-uri.c b/bundle-uri.c
index d9060be707e..d872acf5ab0 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -308,7 +308,8 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * a reachable ref pointing to the new tips, which will reach
 	 * the prerequisite commits.
 	 */
-	if ((result = unbundle(r, &header, bundle_fd, NULL, 0)))
+	if ((result = unbundle(r, &header, bundle_fd, NULL,
+			       VERIFY_BUNDLE_QUIET)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 1f6a7f782e1..4ef7256aa11 100644
--- a/bundle.c
+++ b/bundle.c
@@ -216,7 +216,10 @@ int verify_bundle(struct repository *r,
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
@@ -243,7 +246,10 @@ int verify_bundle(struct repository *r,
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
index 6652e819981..575c34245d1 100644
--- a/bundle.h
+++ b/bundle.h
@@ -32,6 +32,7 @@ int create_bundle(struct repository *r, const char *path,
 
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
+	VERIFY_BUNDLE_QUIET = (1 << 1),
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

