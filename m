Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A05C2D0D5
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4A20643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiJ1ATKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLXLGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:09 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:35170 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLXLGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:06:02 -0500
Received: by mail-qv1-f47.google.com with SMTP id u10so7285871qvi.2
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3hRU+fqnAEdWhaHhgxjxvWGuQ2nCDHFjrxD+49aImA=;
        b=KiJ1ATKaWUItYDXuuBXiBpV10sxTqts4xp83uaWO2U1PnMF2WdTKAOyWGJOhVOaFnh
         8c7Bv5HhXa2qextydUym+kGr6pCEFuk2EBGi04gyw5HvyNLJy+k1GXI88L46PpIp1CWK
         pqHHMQvGZQXRrB/Ck9IYCNlQFeI0zx1u5HJQAlmuX0kmlFOQPvAPnvxKVCHh9PMlH0SR
         he6Ahz7zdXo09Pf+nuZAxP00P4OFQfyXJpk9fJzEw+7m3W7Pmn2/F68zjQzsd0DkmLe5
         BTzNcmdyJMNEkMbw9gnLwI3w1GdYi+xuZn5NxUgvPg+MoEFmtG63ZDOVju3e7VAzLZps
         Xy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3hRU+fqnAEdWhaHhgxjxvWGuQ2nCDHFjrxD+49aImA=;
        b=rbBHbFIPX35QYHSkScaBAunVaHc1AboVC6kY93M0+l3Ul3UZWnD520KZCy7oFBMiGu
         yOVkGI6y4oOYMDWvkXeq4jqmKwL9BAPyQgVgMiHgOVOo6Ip+6He/rPCB00FfC/QasUAA
         vkwe3d/i3K+tL9zDU1+E04gEngU0jq+lKFuxYscv3hM+7BBR2k0GrVJjh16U1r0kWBHP
         030GqIxNXohpGRrEOfBkzlqNhhRve1GgFFr5mFgQCgFlhSF/adtF5gvOtTiq9T9iEDko
         x8kTKdWyq4U8HwlvixX2zDwqNluyjDZuqEXRqiukYH0g2DBMG7fD20EsGzUMtNynW6To
         xyUQ==
X-Gm-Message-State: APjAAAXMlMRuKYR7XpE0kS3xMZb1AmmlldJOyfomGQ6AbiBLk9lNJ8p1
        zlpYq1pWFn6h52l618tMWNxUMOtV
X-Google-Smtp-Source: APXvYqygCKsyk8fvVRUSzIU3XPE51Tlzj+dpFwjd6DbDTj4Cb2mNHk/IjElijw7rMgVoV58TrJFT5g==
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr28429843qvv.85.1577185561630;
        Tue, 24 Dec 2019 03:06:01 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:06:01 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 16/17] t5520: make test_pull_autostash() accept expect_parent_num
Date:   Tue, 24 Dec 2019 06:05:13 -0500
Message-Id: <c70643ca9fb504509c68b6265e35ea2ab9df99bc.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, test_pull_autostash() was hardcoded to run
`test_cmp_rev HEAD^ copy` to test that a rebase happened. However, in a
future patch, we plan on testing merging as well. Make
test_pull_autostash() accept a parent number as an argument so that, in
the future, we can test if a merge happened in addition to a rebase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 602d996a33..218f469d0a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -10,11 +10,13 @@ modify () {
 }
 
 test_pull_autostash () {
+	expect_parent_num="$1" &&
+	shift &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
 	git pull "$@" . copy &&
-	test_cmp_rev HEAD^ copy &&
+	test_cmp_rev HEAD^"$expect_parent_num" copy &&
 	echo dirty >expect &&
 	test_cmp expect new_file &&
 	echo "modified again" >expect &&
@@ -356,22 +358,22 @@ test_expect_success '--rebase fails with multiple branches' '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase
+	test_pull_autostash 1 --rebase
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
@@ -409,7 +411,7 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
-	test_pull_autostash --autostash
+	test_pull_autostash 1 --autostash
 '
 
 test_expect_success 'pull --no-autostash & pull.rebase=true' '
-- 
2.24.1.810.g65a2f617f4

