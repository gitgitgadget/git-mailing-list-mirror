Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD137C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiF3G5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiF3G5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:57:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893CE33886
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so619659wmc.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lsc5EyVpS552vR5zcqPPpPMZr11Ex7VObsH2VsBFBg8=;
        b=Fw3tzRAxzt/oioumaI2NFN2/9vPNveJHzOnNfFBngNt9BreQaHB0tDt2Ky3vRISDUV
         I7ALww0PlIRGJk6JFkR6CUlquZ1MF7/0jkLwnA6udsJSuir5Yq+nZzZ/7/sCfJ5UkG6h
         NR9FJIIG6YKeoMUwn/jOEQLiiApEKnOQsEv0vnlo3+O3EYpOK2rUWP62tiTL70/O8EF1
         QFg2/mPWSZdJO8MDVAkWpLN4ToRZRqeXT7xxqxALHpSgxFdxrKvzBOH8jwooREPa8WFM
         vjFnWBcYLvIEDDWitFso0hdTJY87Jjn00vj/flSUVh2+xpuAvlSjRlGK7aT+5BShvyRW
         K7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lsc5EyVpS552vR5zcqPPpPMZr11Ex7VObsH2VsBFBg8=;
        b=p15bctE4kj8xp6DH13W0Y7vvDHV65FXiLZm8c2eKuHFEYT2Gua/dRoEeZ5jxEnQYbm
         qz3iJpa4df5Ng12rJ4a8yosQ5sndzik0s9Y0r2jgr/0/F2r3G8IinP3+KLLSdtrecCdl
         o59pSXO6tdbZ0qbrLerLlmrzRKj/S32SFuPmxfs1Cv6iNOZqoiweXrs6ffbNtdZEbRlH
         dytXg7coalyV2w+kVJ0+13rGeDVQ++byWJNV8y9jBi1TLMXH4QaHCgaM4LL3y2zMgpsX
         SPg+LGiUf16S5ZzIbcUzzPkPEE6HhIUKMCX62FZuA9DOGvZ25hsjpshtCveKuXu/LP30
         enZA==
X-Gm-Message-State: AJIora9wbR85pgW7mEoJu+0Qag7PihdPsdCQeb4FzHYqWMqGiwPXdbth
        4cO2BL8YWuF2qC5Z05CWTSHQ/b2/BxLfvw==
X-Google-Smtp-Source: AGRyM1saT/HKkK1S75R8F+JnrevkfwKZAnC0WqJnHolvHDoXxUa3RnhZfcOA7aIH6y+fNz/jczQBHg==
X-Received: by 2002:a05:600c:1c29:b0:39c:52b6:aad0 with SMTP id j41-20020a05600c1c2900b0039c52b6aad0mr9850320wms.203.1656572228765;
        Wed, 29 Jun 2022 23:57:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm1532283wms.14.2022.06.29.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:57:08 -0700 (PDT)
Message-Id: <bf4c03d01d5730503eb710e92a80136d5caa981a.1656572225.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
        <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 06:57:03 +0000
Subject: [PATCH v2 1/3] t6423: add tests of dual directory rename plus add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is an attempt at minimalizing a testcase reported by Glen Choo
with tensorflow where merge-ort would report an assertion failure:

    Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410

reversing the direction of the merge provides a different error:

    error: cache entry has null sha1: ...
    fatal: unable to write .git/index

so we add testcases for both.  With these new testcases, the
recursive strategy differs in that it returns the latter error for
both merge directions.

These testcases are somehow a little different than Glen's original
tensorflow testcase in that these ones trigger a bug with the recursive
algorithm whereas his testcase didn't.  I figure that means these
testcases somehow manage to be more comprehensive.

Reported-by: Glen Choo <chooglen@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 102 ++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 479db32cd62..db13bb995f3 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5199,6 +5199,108 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 	)
 '
 
+# Testcase 12l, Both sides rename a directory into the other side, both add
+#   a file which after directory renames are the same filename
+#   Commit O: sub1/file,                 sub2/other
+#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
+#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
+#
+#   In words:
+#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
+#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
+#
+#   Expected: sub3/{file, newfile, sub2/other}
+#             CONFLICT (add/add): sub1/sub2/new_add_add_file
+
+test_setup_12l () {
+	test_create_repo 12l_$1 &&
+	(
+		cd 12l_$1 &&
+
+		mkdir -p sub1 sub2
+		echo file >sub1/file &&
+		echo other >sub2/other &&
+		git add sub1 sub2 &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv sub1 sub3 &&
+		echo conflicting >sub2/new_add_add_file &&
+		git add sub2 &&
+		test_tick &&
+		git add -u &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo dissimilar >sub2/new_add_add_file &&
+		echo brand >sub1/newfile &&
+		git add sub1 sub2 &&
+		git mv sub2 sub1 &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+	test_setup_12l BintoA &&
+	(
+		cd 12l_BintoA &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		git rev-parse >actual \
+			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
+			:2:sub1/sub2/new_add_add_file \
+			:3:sub1/sub2/new_add_add_file &&
+		git rev-parse >expect \
+			O:sub1/file  B:sub1/newfile O:sub2/other \
+			A:sub2/new_add_add_file \
+			B:sub1/sub2/new_add_add_file &&
+		test_cmp expect actual &&
+
+		git ls-files -o >actual &&
+		test_write_lines actual expect out >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+	test_setup_12l AintoB &&
+	(
+		cd 12l_AintoB &&
+
+		git checkout -q B^0 &&
+
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+
+		git rev-parse >actual \
+			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
+			:2:sub1/sub2/new_add_add_file \
+			:3:sub1/sub2/new_add_add_file &&
+		git rev-parse >expect \
+			O:sub1/file  B:sub1/newfile O:sub2/other \
+			B:sub1/sub2/new_add_add_file \
+			A:sub2/new_add_add_file &&
+		test_cmp expect actual &&
+
+		git ls-files -o >actual &&
+		test_write_lines actual expect out >expect &&
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

