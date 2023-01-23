Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC6C54E94
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjAWPWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjAWPW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF842940A
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q5so6487828wrv.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH9IwcCpLB6DzLtgeSA7bFT1dV0sdIfD4B6P7ktcuyc=;
        b=OPA86HsnrAZiPd9Hj4oy30MWRRpjwKTN7y4FkaTUK1el/n8+K09c+wYs3GViSu2iax
         l7qg3yiwS+swCaLz85fLolkHs7/A6IRgw2IXzjZV2YnYZtsanTWILn5tCKSGwrUclygc
         FRmqPkSgU1oZxplfROCCTMMvDCuacv1/pgVPiv0oV2Xayf1L3mOc17L8jVptImA0DUfQ
         QjkSuyKBLXwcW22MlSl7RQTbarp3zav4oiosaYzA0YhEWTKhthbbCmQfaqwd857OhroB
         9tSAOrroZVfwqlm5+OB8kWzvOLtQiCKTs76wJ7VSuxMF/zpOND+TvM9Gt+CA1Q7u65vA
         xMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH9IwcCpLB6DzLtgeSA7bFT1dV0sdIfD4B6P7ktcuyc=;
        b=B0pejh0nCJye2Y2/ulpHstC/GXTmEcRDIsuB6fRJ9K2OYXFZee8SQGmWujl01Bl88P
         Yl+sRk47mg0vVZi8QbaSAXvc1t65iGgur4ZX/vT1ocDMmqX0TUj9IxVkcD+22SD/n8Bn
         M1XWLHp/JOdEW1JUjUeGr8jpEFrIlLDphr7zbcjLdGboWbfE+p5VntnRFTSzlK9d3vYa
         zz9GldAH+Ohx3zOeFMLjZPGFwxLlIBubHSopUNbdnjgjHmVw42aoabTeMroxWjdPqnFZ
         4wRu/mthdRZxqDgxTm7NdlPulnYn2uXruogBbP1St3Q6E546mzGdMOkPfzQ7mefKkzpg
         pAsA==
X-Gm-Message-State: AFqh2ko3lgZXFImO4NvQ6nL2KbWr3r+bihjmi8XVVoUz0wugLL6RjgFf
        EDbjosVzQDrSrX0yuOH5A2SWGr0S2yY=
X-Google-Smtp-Source: AMrXdXuPnMG+wsnnaqp6lEQ0c/uDOAFruORbTHgeszCGvZNnQgqQU7C58iIYZSpuQzH2frCz8+Oyyw==
X-Received: by 2002:a5d:6a86:0:b0:2bb:e805:c1ef with SMTP id s6-20020a5d6a86000000b002bbe805c1efmr21501266wru.52.1674487313288;
        Mon, 23 Jan 2023 07:21:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b002366dd0e030sm4426200wrx.68.2023.01.23.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:53 -0800 (PST)
Message-Id: <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:41 +0000
Subject: [PATCH v2 01/10] bundle: optionally skip reachability walk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When unbundling a bundle, the verify_bundle() method checks two things
with regards to the prerequisite commits:

 1. Those commits are in the object store, and
 2. Those commits are reachable from refs.

During testing of the bundle URI feature, where multiple bundles are
unbundled in the same process, the ref store did not appear to be
refreshing with the new refs/bundles/* references added within that
process. This caused the second half -- the reachability walk -- report
that some commits were not present, despite actually being present.

One way to attempt to fix this would be to create a way to force-refresh
the ref state. That would correct this for these cases where the
refs/bundles/* references have been updated. However, this still is an
expensive operation in a repository with many references.

Instead, optionally allow callers to skip this portion by instead just
checking for presence within the object store. Use this when unbundling
in bundle-uri.c.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 8 +++++++-
 bundle.c     | 3 ++-
 bundle.h     | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 36268dda172..2f079f713cf 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -322,9 +322,15 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * Skip the reachability walk here, since we will be adding
 	 * a reachable ref pointing to the new tips, which will reach
 	 * the prerequisite commits.
+	 *
+	 * Since multiple iterations of unbundle_from_file() can create
+	 * new commits in the object store that are not reachable from
+	 * the current cached state of the ref store, skip the reachability
+	 * walk and move forward as long as the objects are present in the
+	 * object store.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_SKIP_REACHABLE)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..b51974f0806 100644
--- a/bundle.c
+++ b/bundle.c
@@ -223,7 +223,8 @@ int verify_bundle(struct repository *r,
 			error("%s", message);
 		error("%s %s", oid_to_hex(oid), name);
 	}
-	if (revs.pending.nr != p->nr)
+	if (revs.pending.nr != p->nr ||
+	    (flags & VERIFY_BUNDLE_SKIP_REACHABLE))
 		goto cleanup;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
diff --git a/bundle.h b/bundle.h
index 9f2bd733a6a..24c30e5f74a 100644
--- a/bundle.h
+++ b/bundle.h
@@ -34,6 +34,7 @@ int create_bundle(struct repository *r, const char *path,
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
+	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 2),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
-- 
gitgitgadget

