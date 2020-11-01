Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978FC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A3520B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUDBwpIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgKATeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgKATeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:13 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F749C061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:11 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id f9so14662997lfq.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pCBzPS8bIv9Loi9jdaZq5GcWqyP3eTWThTaodtOZtY=;
        b=aUDBwpIgZnVJRiX+1fDO5eNTnT6u6ICLK24AI3j1TRbIcvkZVVjA2VOtYByvbhshEV
         H2izbjGVg4eRIk6vJqZwvQzxzZp64D5137g1d/UX8cbB/92pLDoUPwBqLGwv/KSOJsW8
         WL5+UfBZxQbqJw/XafIrBin/8OO3BZlV3/SC49RHExvl6csJ5dvoLXzjDDBwr4NDLpQg
         hvmJuRHMGt9DKxPnWXt1EzRNv0kgRnFDLbXgZb299BR7YHwYm71YQupLUMB3lQEc1qtP
         Jq7RND6Ua1fWpa3IyJWh6dOtMZ9/rTmA1pSed3cX3A0mM3Wi59H7kOGsYC8TJZx61rvF
         Y+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pCBzPS8bIv9Loi9jdaZq5GcWqyP3eTWThTaodtOZtY=;
        b=rm3xYHaWc+LPy9kzCXHI8V9Ec2Dy/V6oLXKBx0z4uNUrd0gT1jNqwW3J0BTZF5uVYD
         fR/RWFi14FTamTLlXPyqgIBZkBAX8Js/QCIHS7lrfNjyHIjBAOOtC2fdBNVZDYqY8JeP
         carlBI3pv99ZzTTQ+Jh/M61Qmsh5FPTFgaVqHQCiYdJHJcXTrKc7HMyoNr70mz2TLDgW
         s5dZsVS0LQj/0+cY2Eyp/AeyF6pVfrhmOuQLYxkNionokRpohYizWu9Jp1dyJikeF534
         mfxYUTA3Qtu4+shH0R/HnSxaWBUU+pFgDb7nMVvpfU04ITwmNNl4Rc3TQKhGb71bmnbe
         82Ug==
X-Gm-Message-State: AOAM530byBbddj05u59wnqw4qb41F+rl09sYUiOqS4nITEWeVgqfTd0T
        nN2mmElIfb0lAy5+QaB7VYsjO4In+RM=
X-Google-Smtp-Source: ABdhPJw/1Eg0NNZ2OpUdeoq1dSA6v2V/Amwqj1Jp+JuO2LYHVfr84Yf860goZStWWWZykUHZ8Xjeyg==
X-Received: by 2002:ac2:5f09:: with SMTP id 9mr4275488lfq.407.1604259249817;
        Sun, 01 Nov 2020 11:34:09 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:09 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 07/26] diff-merges: move checks for first_parent_only out of the module
Date:   Sun,  1 Nov 2020 22:33:11 +0300
Message-Id: <20201101193330.24775-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checks for first_parent_only don't in fact belong to this module,
as the primary purpose of this flag is history traversal limiting, so
get it out of this module and rename the

diff_merges_first_parent_defaults_to_enable()

to

diff_merges_default_to_enable()

to match new semantics.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c |  8 ++++++--
 diff-merges.c | 10 ++++------
 diff-merges.h |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 77a7bba543ad..a7791c003c91 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,7 +599,10 @@ static int show_tree_object(const struct object_id *oid,
 static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
-	diff_merges_default_to_dense_combined(rev);
+	if (rev->first_parent_only)
+		diff_merges_default_to_enable(rev);
+	else
+		diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
@@ -724,7 +727,8 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	diff_merges_first_parent_defaults_to_enable(rev);
+	if (rev->first_parent_only)
+		diff_merges_default_to_enable(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index 85bf0b6d1d1d..9dd472803d15 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -54,17 +54,15 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
-	if (revs->first_parent_only && revs->ignore_merges < 0)
+void diff_merges_default_to_enable(struct rev_info *revs) {
+	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs) {
-	if (revs->ignore_merges < 0) {
-		/* There was no "-m" variant on the command line */
+	if (revs->ignore_merges < 0) {		/* No -m */
 		revs->ignore_merges = 0;
-		if (!revs->first_parent_only && !revs->combine_merges) {
-			/* No "--first-parent", "-c", or "--cc" */
+		if (!revs->combine_merges) {	/* No -c/--cc" */
 			revs->combine_merges = 1;
 			revs->dense_combined_merges = 1;
 		}
diff --git a/diff-merges.h b/diff-merges.h
index 648c410497cb..cf411414898d 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,7 +11,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+void diff_merges_default_to_enable(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

