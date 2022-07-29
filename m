Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486DC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiG2T3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiG2T3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17D606BE
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i10-20020a1c3b0a000000b003a2fa488efdso2364186wma.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Evi/S2XBMDmcNt2aElcJYPive8tSadhed7YNYWDiBDQ=;
        b=ojOWk9OAS0Vv2/dDndpyY/zi7bnnTb9NSqyRfmf6ReEFKxMMT6iIz7OIUy03hKCYvV
         lujO2uPWKp+Jild7ISqu8j/6f+CPgn9d15f/1IBgAvSnwJdGR7WQUVilD8LyhkJNx1G0
         P8yLWiVEVn1mSrkRjrqXZHtSKq4SajR4uGvbF2DU0BX9if97vtSajMCKYTqFxLkTf4b5
         oclEx8yKZFphc3St0KIhm7lfuyKWoMSHiA9g4sKFV0Djey7BRpbWMJi/WusVuqgzxrXF
         IE7BfY/z9YthtGGGmG/jxmRMQ+xPHQtzu1Euc2QWS0z0Zc8nymV6wrCWEJoqMxjGFlgT
         OW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Evi/S2XBMDmcNt2aElcJYPive8tSadhed7YNYWDiBDQ=;
        b=AtoxMgjR7fkTGDvn7EKIt8xWho4A97CubpYN4ryZ/CsPeIMxrQXWVXcM0l6PP+J+6S
         pqo3EabbYl1wuw8A/4HZNMF3I6qql3wg6kjB/caITr7J8eQ3K9ZljqbnCGww25SvXz+Z
         CbIl8RnvlV08QtkhaQ55UScHZP/mmOPkqgUriLpqphcT10fMnQaBatZkNKJLiTC37Yuw
         Goa/ZlH5KB3WkvhImBH3p03xiFChzaIdBk0g2Dw2jXu5BAUk3YvDBfBxYGXKX5oDslwY
         PELMD8o3dBqNwsIMN3wC2s9JIKEdihuCmwOTfEaWr8268+0qSudEJ3H+Jsfdon2ZWV/R
         EzbA==
X-Gm-Message-State: AJIora+JWBsngH7Z306G0zSmr0D2Hiuj4lmNiFHvR5Oncc86J2O8Hd/o
        sAcznnIh7B2B5qlaX30ZkJQRMVcEp/c=
X-Google-Smtp-Source: AGRyM1v40juCDYWt631TReB3ZNhVz0CmSQj3+5Lib0smWV42whaK7IwUJo4QD7Gv+IgScJ8GfDi6eg==
X-Received: by 2002:a05:600c:19d2:b0:3a3:3aca:a83d with SMTP id u18-20020a05600c19d200b003a33acaa83dmr3622805wmq.88.1659122982796;
        Fri, 29 Jul 2022 12:29:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003a2fdde48d1sm4993786wmk.25.2022.07.29.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:42 -0700 (PDT)
Message-Id: <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:31 +0000
Subject: [PATCH v2 02/10] t4207: test coloring of grafted decorations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The color.decorate.<slot> config option added the 'grafted' slot in
09c4ba410b0f (log-tree: allow to customize 'grafted' color, 2018-05-26)
but included no tests for this behavior. When modifying some logic
around decorations, this ref namespace was ignored and could have been
lost as a default namespace for 'git log' decorations by default.

Add two tests to t4207 that check that the replaced objects are
correctly decorated. Use "black" as the color since it is distinct from
the other colors already in the test. The first test uses regular
replace-objects while the second creates a commit graft.

Be sure to test both modes with GIT_REPLACE_REF_BASE unset and set to an
alternative base.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t4207-log-decoration-colors.sh | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 36ac6aff1e4..69f8ac602d6 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
 	git config color.decorate.HEAD cyan &&
+	git config color.decorate.grafted black &&
 
 	c_reset="<RESET>" &&
 
@@ -27,6 +28,7 @@ test_expect_success setup '
 	c_tag="<BOLD;REVERSE;YELLOW>" &&
 	c_stash="<MAGENTA>" &&
 	c_HEAD="<CYAN>" &&
+	c_grafted="<BLACK>" &&
 
 	test_commit A &&
 	git clone . other &&
@@ -63,4 +65,61 @@ test_expect_success 'Commit Decorations Colored Correctly' '
 	test_cmp expected out
 '
 
+cat >expected <<EOF
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
+ ${c_reset}${c_branch}main${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit},\
+ ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+EOF
+
+test_expect_success 'test coloring with replace-objects' '
+	test_when_finished rm -rf .git/refs/replace* &&
+	test_commit C &&
+	test_commit D &&
+
+	git replace HEAD~1 HEAD~2 &&
+	git log --first-parent --abbrev=10 --decorate --oneline --color=always HEAD |
+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
+	test_decode_color >out &&
+	test_cmp expected out &&
+	git replace -d HEAD~1 &&
+
+	GIT_REPLACE_REF_BASE=refs/replace2/ git replace HEAD~1 HEAD~2 &&
+	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent --abbrev=10 \
+		--decorate --oneline --color=always HEAD |
+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
+	test_decode_color >out &&
+	test_cmp expected out
+'
+
+cat >expected <<EOF
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
+ ${c_reset}${c_branch}main${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: D${c_reset}${c_commit},\
+ ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+EOF
+
+test_expect_success 'test coloring with grafted commit' '
+	test_when_finished rm -rf .git/refs/replace* &&
+
+	git replace --graft HEAD HEAD~2 &&
+	git log --first-parent --abbrev=10 --decorate --oneline --color=always HEAD |
+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
+	test_decode_color >out &&
+	test_cmp expected out &&
+	git replace -d HEAD &&
+
+	GIT_REPLACE_REF_BASE=refs/replace2/ git replace --graft HEAD HEAD~2 &&
+	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent --abbrev=10 \
+		--decorate --oneline --color=always HEAD |
+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
+	test_decode_color >out &&
+	test_cmp expected out
+'
+
 test_done
-- 
gitgitgadget

