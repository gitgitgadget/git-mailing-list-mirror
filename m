Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39221C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbiFPNN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376939AbiFPNN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:13:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240F39823
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m24so1824529wrb.10
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p5sZ8hT8FGCpW/GaA1xtofbxjAqwFVL/fvpzcF8QyJw=;
        b=FERzoFfz/dqO9h00gFP6+ElvliY/Q5AtGUk4PM4MpiXHjbd/zxfuIXvr3+lLHnmNzr
         2Ar2ZSjDm2H453SLym7nhNGepDSLlRgsFoLDN21J44EybMwNnfwKT5j9ZeLTq8zoRMP2
         DbPBxnQ3/OFPjH3SD2BwwxRMuggkww8mJAyQ4X7v2hD3zeUmSU6m87UcIosAAhjAcnpP
         dGxLTNFMg5yiXMlBva3y9jrAHNq1CYFOgD2vUVXBHJd6Mhq3jc0DRps0slmB/dMfQS/X
         a1Vsgy+qMDpw/cQ2JxSXOVd9zS//I7y7Twn0Phl4jvbEQLC+xfQNLUXLI7qtEBktvrZB
         L2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p5sZ8hT8FGCpW/GaA1xtofbxjAqwFVL/fvpzcF8QyJw=;
        b=4W4CSWDipbxIvjgHwTOkLZR85IENdmEGfGm57H1Cq7WrdCDXG/EQWN0QBq/VWQcu5b
         ayLM9Zbvz0Ih0c/hInwYSv/uwiWRedOx50MrcvCsmn5XF5gEQTbBIkQhwXnN0yLcs7ey
         C9SNGOdRKY9RazGhGU6IXlG2aGSWaJBNKQLHQWEDPehrFphIifA1EYEROvOWg7LynQOO
         E+JwtdOcZwBRJy1rqQ+VcSa03gFNshwIJwO6lSkZP7VcOHbCL0OSjhZDYk5rzVEtDl9W
         gx1A5cCJjms6Ux2OeHA4S20ODGQxXt2Z/7I/Qy3LqSN0uB9ixB/0FD9fbmz60k6vbhvV
         l//Q==
X-Gm-Message-State: AJIora+qAadRJCcW5LAzH5QzA/Ufing8uxg1a9Jc06odVM+ExW0e58Vu
        PUe/Kmkny0o5j4OJBtEQT4r5mH/IjBLL5A==
X-Google-Smtp-Source: AGRyM1vPY5TTloLR33jogtKMiJAsfnTLTdXGliIvVJfrIamrBLWBY1CwmFIvft0vToX9ZySxhk1UKA==
X-Received: by 2002:a5d:6c66:0:b0:218:4ccd:16f2 with SMTP id r6-20020a5d6c66000000b002184ccd16f2mr4652117wrz.588.1655385232710;
        Thu, 16 Jun 2022 06:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b00397342bcfb7sm2471670wmq.46.2022.06.16.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:13:51 -0700 (PDT)
Message-Id: <c22963b49e6c35f88c5819c1300dde6035fe1191.1655385230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
        <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 13:13:47 +0000
Subject: [PATCH v2 1/4] t2107: test 'git update-index --verbose'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The '--verbose' option reports what is being added and removed from the
index, but has not been tested up to this point. Augment the tests in
t2107 to check the '--verbose' option in some scenarios.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t2107-update-index-basic.sh | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index a30b7ca6bc9..07e6de84e6d 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -36,9 +36,14 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
 	echo content >file &&
 	git add file &&
 	git rev-parse :file >expect &&
-	test_must_fail git update-index --cacheinfo 100644 $ZERO_OID file &&
+	test_must_fail git update-index --verbose --cacheinfo 100644 $ZERO_OID file >out &&
 	git rev-parse :file >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	add '\''file'\''
+	EOF
+	test_cmp expect out
 '
 
 test_expect_success '--cacheinfo does not accept gitlink null sha1' '
@@ -59,9 +64,14 @@ test_expect_success '--cacheinfo mode,sha1,path (new syntax)' '
 	git rev-parse :file >actual &&
 	test_cmp expect actual &&
 
-	git update-index --add --cacheinfo "100644,$(cat expect),elif" &&
+	git update-index --add --verbose --cacheinfo "100644,$(cat expect),elif" >out &&
 	git rev-parse :elif >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	add '\''elif'\''
+	EOF
+	test_cmp expect out
 '
 
 test_expect_success '.lock files cleaned up' '
@@ -74,7 +84,8 @@ test_expect_success '.lock files cleaned up' '
 	git config core.worktree ../../worktree &&
 	# --refresh triggers late setup_work_tree,
 	# active_cache_changed is zero, rollback_lock_file fails
-	git update-index --refresh &&
+	git update-index --refresh --verbose >out &&
+	test_must_be_empty out &&
 	! test -f .git/index.lock
 	)
 '
@@ -83,7 +94,15 @@ test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
 	>A &&
 	>B &&
 	git add A B &&
-	git update-index --chmod=+x A --chmod=-x B &&
+	git update-index --verbose --chmod=+x A --chmod=-x B >out &&
+	cat >expect <<-\EOF &&
+	add '\''A'\''
+	chmod +x '\''A'\''
+	add '\''B'\''
+	chmod -x '\''B'\''
+	EOF
+	test_cmp expect out &&
+
 	cat >expect <<-EOF &&
 	100755 $EMPTY_BLOB 0	A
 	100644 $EMPTY_BLOB 0	B
-- 
gitgitgadget

