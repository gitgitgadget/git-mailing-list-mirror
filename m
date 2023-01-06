Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D76C5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 16:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjAFQcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjAFQcE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 11:32:04 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA276EF5
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 08:32:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs20so1755889wrb.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 08:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/HpHSxTSF0Y5I/DH6rhmOa+ACyaZbJlJ7dQWlMWApI=;
        b=gxasuBSECslO6L8I/cURMukJ5aGRFyvWw95QaYZ9e+ytYqTkSfvjAkEFxgU/i0wJmB
         3K6te44dQeWVArCuQIBDqzc2k2mtrzS3ljRyiLEeZpEHvTMWn9v3iw8rChaYuyk1vtgS
         yQsPld6rUIJbrlbQQumymm/EMVSiUVA8rIVS6fPRjbFQDeBoAVFpR1JnCGQ3QWcCIu0a
         niC/MglWrFBwCuvsKUAikiwqSqVrZf6mZ9nkCtcTTDqiodxyX1y/DGsVWuEsR+Ur3r4O
         pHB6Gzbg+3h6HlR8WV9x/mbxZlN3qTsMPMZzl0REkuIqyvVwtnIGHIoaOk+sgZ0tnFO4
         hs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/HpHSxTSF0Y5I/DH6rhmOa+ACyaZbJlJ7dQWlMWApI=;
        b=qdLOBJ2F4h9aVgZ/L9Jvgd5FIPe+W18JrxU+eeIiY+0Y2ae4D8MKS1Po0kW3J62TAN
         Cz5UHc24macvLEM/PSuV4DlpzHv/aBjOf2lnIpm71lMMKWBTqRtKb8j0UI1/l2AYcHlc
         9lZi4Xya+1+eAKkHWZkjjyu27aTCYIgunkxKwsCdAExVNmlNb53a6Fp+BbYBeanZv2BH
         z2baQCBrXTZdvfkHPER4A2yoPXN+UXYLDzBlJmu9ECZfaSda+QN6038p2hLxg/N4QaiQ
         UMry3EFVuIXQMxFyeohiYE8cPE+q1fMMm+HZJFY3GMCGX82oQi7oHtfSw0+hIKHQj+Nb
         D88w==
X-Gm-Message-State: AFqh2krQiCJQ+0WGMP1fkcjRam96WtYfVR0nWGncQL/RTvViu+1MDiMh
        gvPx4EgC68OPxHIgFeS7H+pbbk02rL0=
X-Google-Smtp-Source: AMrXdXtT/fAEFkiGQPuWTpsleA1w8pgMCKAf7Z3Z2sQXbZMZL7e+PzmMYXItnrk374J+Qn9qJ8jQ6A==
X-Received: by 2002:adf:cc8f:0:b0:242:14bb:439d with SMTP id p15-20020adfcc8f000000b0024214bb439dmr36505047wrj.43.1673022720988;
        Fri, 06 Jan 2023 08:32:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5007000000b0023662d97130sm1593588wrt.20.2023.01.06.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 08:32:00 -0800 (PST)
Message-Id: <dab9b15de4794fd8ed45edff86ba89f4f63a335c.1673022717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
References: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
        <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 16:31:55 +0000
Subject: [PATCH v5 3/4] test-lib-functions: add helper for trailing hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to check that a file format with a trailing hash has a
specific hash in the final bytes of a written file. This is made more
apparent by recent changes that allow skipping the hash algorithm and
writing a null hash at the end of the file instead.

Add a new test_trailing_hash helper and use it in t1600 to verify that
index.skipHash=true really does skip the hash computation, since
'git fsck' does not actually verify the hash. This confirms that when
the config is disabled explicitly in a super project but enabled in a
submodule, then the use of repo_config_get_bool() loads config from the
correct repository in the case of 'git add'. There are other cases where
istate->repo is NULL and thus this config is loaded instead from
the_repository, but that's due to many different code paths initializing
index_state structs in their own way.

Keep the 'git fsck' call to ensure that any potential future change to
check the index hash does not cause an error in this case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1600-index.sh        | 5 +++++
 t/test-lib-functions.sh | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 98c5a83db73..2f792bb8ffa 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -68,6 +68,9 @@ test_expect_success 'out of bounds index.version issues warning' '
 test_expect_success 'index.skipHash config option' '
 	rm -f .git/index &&
 	git -c index.skipHash=true add a &&
+	test_trailing_hash .git/index >hash &&
+	echo $(test_oid zero) >expect &&
+	test_cmp expect hash &&
 	git fsck &&
 
 	test_commit start &&
@@ -76,6 +79,8 @@ test_expect_success 'index.skipHash config option' '
 	git -C sub config index.skipHash true &&
 	>sub/file &&
 	git -C sub add a &&
+	test_trailing_hash .git/modules/sub/index >hash &&
+	test_cmp expect hash &&
 	git -C sub fsck
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..60308843f8f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1875,3 +1875,11 @@ test_cmp_config_output () {
 	sort config-actual >sorted-actual &&
 	test_cmp sorted-expect sorted-actual
 }
+
+# Given a filename, extract its trailing hash as a hex string
+test_trailing_hash () {
+	local file="$1" &&
+	tail -c $(test_oid rawsz) "$file" |
+		test-tool hexdump |
+		sed "s/ //g"
+}
-- 
gitgitgadget

