Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF7C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A1A20707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is1mpXUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgFOLxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:53:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68BC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so15376509qkg.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7erxqw+fYt82xG3y8+1MwtEWJ2sFUA4eanFtKu+CSx4=;
        b=is1mpXULwOQm66S+jBZAAmDBGNkyHWIq+oVVWDp1gbyCAN83tB6qBiVJ64Ad39/5cX
         AgIXkejULDFXmSNoDmKMGCfHN0ujU3vQODjP7wtAkFPDvsJ2S9tKdf+bUwUQNn+YAYMk
         EZRnSHT2L2F1faDjf1Ps+RocC8uoBihva/cI7K+3FmxhYdFmng3F5NLzzqLwxzTiLhxg
         dXGoLj0GQtHGaMG4jtfIi3fJJmRv8vI024GNkh7GydZR6OgFh1iVdZrqFISO4wwqV0/X
         /fYro0h6o2I9/kCP4VlQollkviziCXDIXzMd4rEpuTmfDPeCI1O2Sjj+yKJf77q7V/Uq
         OHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7erxqw+fYt82xG3y8+1MwtEWJ2sFUA4eanFtKu+CSx4=;
        b=kb+RAniLXV8F/L2wrB3W2DCq+b/Kz+pWoQE1MwL3CwMvEnqpELcKKJesUhYyXRxCYC
         5Ly3lVBy4nFm+7Xp7VyfCCI96Wy/UAMe0Yk9SNKXoDxQLOVDG3agnxvX8AlUMFkxqWeY
         PPwT4T2ZEWy8sF27tCegtOlm6vuZD2Ipzp5e06u64hhjNBJwt05Bi7C603c5sjFY1yDV
         HF7NzdEhxFan1dyquD27PWPpL0W0O9oCdIm3xMJhKXjaGX1Uy2zrgiAvpTRcWCdg7CG5
         JAtIj+dPM8U1tjhtMBoJMrIZfi6DR5ecGlVe/94k3VxkysNbZ2Hc0IpuNYaWdhFEneEg
         aQeg==
X-Gm-Message-State: AOAM531G0wXmwG4262uGvIb4XXzSCy9hl2oAVAgygdPd97+XjyaSnE/G
        W0e86I+nvOLQsaD75ImAmi3MAK6etSU=
X-Google-Smtp-Source: ABdhPJw/eYNvths8apVLdS6TvbVppJ3tR+dFsI50WIWj4cdEXnuR1ylVAPKx17WkGVcf17f9CdjYSA==
X-Received: by 2002:a37:b547:: with SMTP id e68mr14465229qkf.127.1592222008854;
        Mon, 15 Jun 2020 04:53:28 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f43sm12543781qte.58.2020.06.15.04.53.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:53:28 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] t3200: rename "expected" to "expect"
Date:   Mon, 15 Jun 2020 07:53:18 -0400
Message-Id: <5fa405d7e1672ef18442cdcd514698c92e139a8e.1592221875.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592221875.git.liu.denton@gmail.com>
References: <cover.1592221875.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up style of test by changing some filenames from "expected" to
"expect", which follows typical test convention.

Also, change a space-indent into a tab-indent.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3200-branch.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..da3659c3d3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -323,11 +323,11 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
   a/b/c     bam       foo       l       * master    mb        o/o       q
   abc       bar       j/k       m/m       master2   n         o/p       r
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch --column with an extremely long branch name' '
@@ -336,7 +336,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
 	test_when_finished "git branch -d $long" &&
 	git branch $long &&
 	COLUMNS=80 git branch --column=column >actual &&
-	cat >expected <<EOF &&
+	cat >expect <<EOF &&
   a/b/c
   abc
   bam
@@ -355,7 +355,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   r
   $long
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch with column.*' '
@@ -364,11 +364,11 @@ test_expect_success 'git branch with column.*' '
 	COLUMNS=80 git branch >actual &&
 	git config --unset column.branch &&
 	git config --unset column.ui &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
   a/b/c   bam   foo   l   * master    mb   o/o   q
   abc     bar   j/k   m/m   master2   n    o/p   r
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git branch --column -v should fail' '
@@ -379,7 +379,7 @@ test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -10 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
   a/b/c
   abc
   bam
@@ -397,7 +397,7 @@ test_expect_success 'git branch -v with column.ui ignored' '
   q
   r
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 mv .git/config .git/config-saved
@@ -922,17 +922,17 @@ test_expect_success 'test --unset-upstream on a particular branch' '
 '
 
 test_expect_success 'disabled option --set-upstream fails' '
-    test_must_fail git branch --set-upstream origin/master
+	test_must_fail git branch --set-upstream origin/master
 '
 
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
 	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	warning: Not setting branch my13 as its own upstream.
 	EOF
 	test_expect_code 1 git config branch.my13.remote &&
 	test_expect_code 1 git config branch.my13.merge &&
-	test_i18ncmp expected actual
+	test_i18ncmp expect actual
 '
 
 # Keep this test last, as it changes the current branch
-- 
2.27.0.132.g321788e831

