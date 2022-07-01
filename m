Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193DC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiGAKnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiGAKnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1625F7
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so2633336wrc.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYV0JTrntSRLiGnpKGXTyhYlVHtDbM5yoaT/SgykTR0=;
        b=IHRTX8GKvcVVmJzPJKz4FxtcEIg+181GoNgT4bXWdPxTKb2taIYvZMFFwOLRN/j+Ux
         5t8ufFwO+IKbQ4EFqhCHdfYvWd3bk325rk374x7BzKrtVllbrw+xvdfhCDV+W88l/+53
         /igaD5FzH50V+Q0x0DFxZ3kUikNIYydkfHNQ/SBhGO6jB9ojF6OmJ43CJmVwp5q1ik6b
         qw0y57boNO0tnwF22bHr8WnBRXZAiW8GvF4QGSQQUykSNYWLS1Ov4yM1RjP396grINxW
         n9QZuYP8Ls/ChlVXVyQJwymcrWvbC+h+GI0rqHERqHTGLv0gK0paNRLzPndPb9L+qgRs
         CgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYV0JTrntSRLiGnpKGXTyhYlVHtDbM5yoaT/SgykTR0=;
        b=F+e62L0xpRUdTLqb/OKFb0IO7nBfsmb69ADLX0tTcvn8nWc65L2JvIb7npTihc/o5v
         rYGSGocZ/wxOvpcH3L3DT2Uuk6w8MWfge80UqaW66wUwbgCNHCktPu1EoD56a886AbIj
         jRodUQXEzHi4/07rKJnqfrSqNaw3zmcRuBxFaHYZEykSufyKPND5pl174QUXhnYdSrnS
         J/vd2/fipIftlJ0t3JhwKknJcXxeOJRWlvYCAvpqXyJ/z9YXnVpeAXB5WaW4eoBYjwKy
         Nw+dECEHvzvCwx01/kgcTIF5OqYveMhBNd/E/G/jmnlJ9WHabMPEKcbF8NH4kinJ58r1
         V7kQ==
X-Gm-Message-State: AJIora+38UNPmivv2SEyBaipmA1ylF9nFVLb2ePCoqSlNQff2TvHioqf
        9d0swZ63bTd4LS8gMC1bLyr9Pg8Lcz+pBw==
X-Google-Smtp-Source: AGRyM1tPtmDRiWLZf78J3/uqZDrX08+rQkbXgXjgC9NhuFQP75PrstdGlHtoN1yT0lLt+bmTnry0dA==
X-Received: by 2002:adf:ef42:0:b0:21b:8e58:f24b with SMTP id c2-20020adfef42000000b0021b8e58f24bmr13172202wrp.257.1656672189459;
        Fri, 01 Jul 2022 03:43:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] merge-file: fix memory leaks on error path
Date:   Fri,  1 Jul 2022 12:42:56 +0200
Message-Id: <patch-v2-07.11-8658f3ad020-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "merge-file", we need to loop over the "mmfs"
array and free() what we've got so far when we error out. As a result
we can mark a test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-file.c  | 10 ++++++----
 t/t6403-merge-file.sh |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 793817f3cb9..c923bbf2abb 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -87,7 +87,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 		free(fname);
 		if (ret)
-			return ret;
+			goto cleanup;
+
 	}
 
 	xmp.ancestor = names[1];
@@ -95,9 +96,6 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	xmp.file2 = names[2];
 	ret = xdl_merge(mmfs + 1, mmfs + 0, mmfs + 2, &xmp, &result);
 
-	for (i = 0; i < 3; i++)
-		free(mmfs[i].ptr);
-
 	if (ret >= 0) {
 		const char *filename = argv[0];
 		char *fpath = prefix_filename(prefix, argv[0]);
@@ -118,5 +116,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	if (ret > 127)
 		ret = 127;
 
+cleanup:
+	for (i = 0; i < 3; i++)
+		free(mmfs[i].ptr);
+
 	return ret;
 }
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 2f421d967ab..1a7082323dd 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='RCS merge replacement: merge-file'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.37.0.900.g4d0de1cceb2

