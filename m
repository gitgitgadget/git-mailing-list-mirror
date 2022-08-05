Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB29C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiHER7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbiHER67 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:58:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569501F2E1
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:58:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so4068505wrh.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=8PD338yoh6NaWVkAN2uELjkh9/3oJJ+sT1DcZR+einY=;
        b=SCoHB7CJm9IIS0b1TJaEayJzi8cksFXB8L9snyPj7CGQ6UZi11jKeJSKPIQjdmuw3n
         Xdmja4xkU/HhsNmlC5+jcYAJAGtrAZrpx1KQcfD3wvuvX5lsd/fSA9i2hTqeNjinuaYT
         EoQIRkBIlCM+yFPXK0LIw883sBDgHctH65aD8A5CUluQXUKUsQtK4iwplBHe0NC+3eYS
         XJJX5yocCZ2EwrgLVBjsd7EkvWaXi4geXDL1N7EsoyKWnWk67YzPJ4cHFgFR3Lk7vp3b
         gjH9vNpgZ2JBx+QcAN41DLjXnjYVi5hApJuTi0MLKb5F25GWUjM3ak2O1leykurRICOK
         I2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=8PD338yoh6NaWVkAN2uELjkh9/3oJJ+sT1DcZR+einY=;
        b=ZzTJgWSj+ik9WYOQ3nUjLFMq8NFx9wyr4QTKquf58GvwLNNZk95eRjI6imu6dJEUxl
         rCh5484KO/dS0pg9kLuI361Ul1RVYlXMdhdGalA3PcOrLa91Hu0RsefXri8nk4/Jgr4p
         ZxAPGGtaZwSxIIfQc78bpkNbo98FiuKUXzJSRc1VnzalVOVvLulmBEDepIedQad1oDPC
         oz28udZh+cgn98lJ3XHMLieyxWnuH9L8DGwVfcwyPGG0IIFDeTN7oPBVRPgJQVdOGmAf
         dnsYgfeKMwv7qSA3ivXvieJiyi4Vt3Oa73s/Pb5H0nwMn6RN7mfQZP/Ibcx04BJv8QkS
         1Kjw==
X-Gm-Message-State: ACgBeo24v2YvPxWenvmuhBGxqHR/FisKC5FhUToTmDAibTc+q1VGUfS7
        MJoHR69ZKMOk0vooH34NAGSmWGw2xyU=
X-Google-Smtp-Source: AA6agR4z921GYoeGkgd/Zp2OoNRSKcZ5XFpN0x69GSLHukXesOgocLevOc1Nj5p1gx6iJ60zdyitjw==
X-Received: by 2002:a5d:5712:0:b0:21f:ba2:2b1a with SMTP id a18-20020a5d5712000000b0021f0ba22b1amr4959477wrv.144.1659722333483;
        Fri, 05 Aug 2022 10:58:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003a30c3d0c9csm10733354wms.8.2022.08.05.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:52 -0700 (PDT)
Message-Id: <fafe20c1e82d604acf40d9a2152904a8cd902f15.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:35 +0000
Subject: [PATCH v3 03/11] t4207: test coloring of grafted decorations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 t/t4207-log-decoration-colors.sh | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 324412d0839..ded33a82e2c 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -17,6 +17,7 @@ test_expect_success setup '
 	git config color.decorate.remoteBranch red &&
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
+	git config color.decorate.grafted black &&
 	git config color.decorate.HEAD cyan &&
 
 	c_reset="<RESET>" &&
@@ -27,6 +28,7 @@ test_expect_success setup '
 	c_tag="<BOLD;REVERSE;YELLOW>" &&
 	c_stash="<MAGENTA>" &&
 	c_HEAD="<CYAN>" &&
+	c_grafted="<BLACK>" &&
 
 	test_commit A &&
 	git clone . other &&
@@ -66,4 +68,55 @@ On main: Changes to A.t
 	cmp_filtered_decorations
 '
 
+test_expect_success 'test coloring with replace-objects' '
+	test_when_finished rm -rf .git/refs/replace* &&
+	test_commit C &&
+	test_commit D &&
+
+	git replace HEAD~1 HEAD~2 &&
+
+	cat >expect <<-EOF &&
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
+${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+EOF
+
+	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
+	cmp_filtered_decorations &&
+	git replace -d HEAD~1 &&
+
+	GIT_REPLACE_REF_BASE=refs/replace2/ git replace HEAD~1 HEAD~2 &&
+	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent \
+		--no-abbrev --decorate --oneline --color=always HEAD >actual &&
+	cmp_filtered_decorations
+'
+
+test_expect_success 'test coloring with grafted commit' '
+	test_when_finished rm -rf .git/refs/replace* &&
+
+	git replace --graft HEAD HEAD~2 &&
+
+	cat >expect <<-EOF &&
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
+${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	EOF
+
+	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
+	cmp_filtered_decorations &&
+	git replace -d HEAD &&
+
+	GIT_REPLACE_REF_BASE=refs/replace2/ git replace --graft HEAD HEAD~2 &&
+	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent \
+		--no-abbrev --decorate --oneline --color=always HEAD >actual &&
+	cmp_filtered_decorations
+'
+
 test_done
-- 
gitgitgadget

