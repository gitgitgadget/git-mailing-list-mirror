Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8933BE748E9
	for <git@archiver.kernel.org>; Sun,  1 Oct 2023 15:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjJAPTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjJAPTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 11:19:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073EE0
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 08:19:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BD6A5C2B27;
        Sun,  1 Oct 2023 11:19:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 01 Oct 2023 11:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1696173552; x=1696259952; bh=SrTSxj1O7o
        iFkB0nUt6XAYWhwbnSE6iLkIvtRAFfUU8=; b=KMrGR9tNyJxmx40ljl/T1kOdSy
        5WfjyZQvix2JKTIKNl3FbgBNKL98iBeQ91Pv8GBKSe8SX417LbU2RrE+VnT5hVCa
        gUjZk4tDlrvrVlaznzM7kEzDfpjSXWW3xdbejUBBHAz0fSlmxcJZNpgIzTItETSN
        Gv77I2YbfgySO3jrVZKgK5UZbznlWMG2yl54LD0TpqbzJpL7pG7WkPbcIdOzQqwN
        Xc0+nA4nh5+8IkPwMp2oPFU8wE5V4Hopkus6Ynq3IPysTe+cFOaZdKALq9dXn5z/
        A8KdPo69RpMbcJQFCie+THAFcszwXJq1dujT7AaJj5xIC5U9gNF5L3DcQa8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696173552; x=1696259952; bh=SrTSxj1O7oiFk
        B0nUt6XAYWhwbnSE6iLkIvtRAFfUU8=; b=lBG8nbQP14pBIBBmR5vZ6sz182nnQ
        BcdPwTVJrKqjWhuW3QOZX/xwYWD2Iw8DV+UBnGmEITF5oNG93LO7uow5/GW9bPtX
        EF1hpNdennOpZTyUM48s+qMvzybxwNroFBj2GAYpiRu+zGg4zaq2yCh061Ssn3mN
        A1SJ305V9npxaj15Wo0p5pNClGmwE8hPvOhBCYa1wdCJFXiJkkB+OEXZAsgi43oG
        R6LSXIyinWAYEOeN+LCVDPRodpu7NVq8fsNXGm8v8pA3GA89WrJD3uSTNfHGPZOD
        QoxejVVxNw96P4K1qN1Hidn7FBhKD4/KqcGaqQfyPQJLwyX71uqh+WYzw==
X-ME-Sender: <xms:740ZZW7eHgM-VTkpVVpOBTLdhzZ1sGQkNlar9FgsZ0avCVHtp55aQw>
    <xme:740ZZf6kWckQjnX927gDAN8PgJb5bEMzjtgp4ARazvq27Wge4FzfJCp7ss9YUkTHb
    WmW970bUNLx545xQw>
X-ME-Received: <xmr:740ZZVfM75q34HzSTdVmrBjK3MUk0buGaHm-yDtWOFQXQ7FHRrJ-WajFtJdfSct-YrzKrVJROZ96ZGyU8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehkefgtd
    evtedtkeduudeguefgudejheeugfelgeettdfhffduhfehudfhudeuhfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
    hish
X-ME-Proxy: <xmx:740ZZTKXx4DKuyAYFKOyqrZD0ZRVUQ1KCgNLNyvk_w4pJT-r4josiQ>
    <xmx:740ZZaIQLiFJpwBIog4JAKPzmG1MiK-OPV4LHXU99S_c91WgFE_YyQ>
    <xmx:740ZZUw9zdWIoqcJqOxChMoP_fr76gzvU7r-Z0Mz20TFNBOprVO6LA>
    <xmx:8I0ZZUx9s6KTpptZUT4D1DjBMdcCedu8-qHHmU1PWA0FmccXIXpxvg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 11:19:11 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
        id D3624310; Sun,  1 Oct 2023 15:19:09 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>
Subject: [PATCH] diff: fix --merge-base with annotated tags
Date:   Sun,  1 Oct 2023 15:18:45 +0000
Message-ID: <20231001151845.3621551-1-hi@alyssa.is>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking early for OBJ_COMMIT excludes other objects that can be
resolved to commits, like annotated tags.  If we remove it, annotated
tags will be resolved and handled just fine by
lookup_commit_reference(), and if we are given something that can't be
resolved to a commit, we'll still get a useful error message, e.g.:

> error: object 21ab162211ac3ef13c37603ca88b27e9c7e0d40b is a tree, not a commit
> fatal: no merge base found

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 diff-lib.c                           |  2 --
 t/t4068-diff-symmetric-merge-base.sh | 13 ++++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 6b0c6a7180..543398b4d8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -572,8 +572,6 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags)
 			die(_("--merge-base does not work with ranges"));
-		if (obj->type != OBJ_COMMIT)
-			die(_("--merge-base only works with commits"));
 	}
 
 	/*
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 2d650d8f10..541642650f 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
 	echo c >c &&
 	git add c &&
 	git commit -m C &&
-	git tag commit-C &&
+	git tag -m commit-C commit-C &&
 	git merge -m D main &&
 	git tag commit-D &&
 	git checkout main &&
@@ -109,6 +109,13 @@ do
 		test_cmp expect actual
 	'
 
+	test_expect_success "$cmd --merge-base with annotated tag" '
+		git checkout main &&
+		git $cmd commit-C >expect &&
+		git $cmd --merge-base commit-C >actual &&
+		test_cmp expect actual
+	'
+
 	test_expect_success "$cmd --merge-base with one commit and unstaged changes" '
 		git checkout main &&
 		test_when_finished git reset --hard &&
@@ -143,7 +150,7 @@ do
 	test_expect_success "$cmd --merge-base with non-commit" '
 		git checkout main &&
 		test_must_fail git $cmd --merge-base main^{tree} 2>err &&
-		test_i18ngrep "fatal: --merge-base only works with commits" err
+		test_i18ngrep "is a tree, not a commit" err
 	'
 
 	test_expect_success "$cmd --merge-base with no merge bases and one commit" '
@@ -169,7 +176,7 @@ do
 
 	test_expect_success "$cmd --merge-base commit and non-commit" '
 		test_must_fail git $cmd --merge-base br2 main^{tree} 2>err &&
-		test_i18ngrep "fatal: --merge-base only works with commits" err
+		test_i18ngrep "is a tree, not a commit" err
 	'
 
 	test_expect_success "$cmd --merge-base with no merge bases and two commits" '

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
2.42.0

