Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA7BC7619D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A8F2064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf3X2zIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgBQIla (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgBQIla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so16211680wmh.3
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auj2PpN7jw/nCeMzZ55W8zrFR3AQWT85aqwAv1NJUPg=;
        b=Vf3X2zIJLzCoLk2MaxwZIiCQi6Oo1GP312QcWznM6rMADsR3Ux9jvZtTnbXOYq5Unq
         ZwC5WY7QsvXtPxs9Yb1dj0ETp5PkzYHMOMp1VNH64Cbd8Nabs/tobRI15gXxq4ZhlVdl
         il9UQY1ubIGf+KoX22w+/zm8bIcUX4d2a+Uh/nUxuBsE/J4cTOhm3/rJj0m3fm5tufvq
         VoyOBaF4J1zIp+GJn8qLFtkYcBbfihVE3jTtxKjvROarKy4muFKrkhy3FGpYC4JM/P5N
         oFw0+QXzE6DlZ8PsL0/QHIFMU7Whmn98wulICgHdGp7mxhrpANlw2tDFSn4pIbCqwDpA
         /wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auj2PpN7jw/nCeMzZ55W8zrFR3AQWT85aqwAv1NJUPg=;
        b=iXErm6dO1SGb2d8qlk9kwuTElnMnfvaFYRLrFM32dAu2CXlXqROW0LuMRswb/CkTNE
         0cm+YYQvvoyclXVj0Ql+Af/5soMrw6VDD3/8vYa5HfK97Ht17RJbjVCEQ4ddVIlAPEpF
         kOp/fBYL2bPjBmR7ngwVVhv6qIJ53eZSp7Jkf4pMNlSyk98aay19y3A/w4R0XiV5f3Uy
         RctkNiIGLc65BSaNa3hqTTk665Lmp3eRQbtTnvKRAPU2HvlZIzQkyBbedR+IXslxGOhX
         xIiv3MNlUD+BtCqXd8zpcVs/SRI8kaJ/k1jclR1Z4BIpAUKzMzDb9/vPJoxfhlSlFoiQ
         yuUQ==
X-Gm-Message-State: APjAAAWMviDyWglygd48fX+zL1iJcvHIqRfC6TnerZyMF+jg6UdJpVPA
        p7LT9CLWQnZ7b9geBRd/BiTHgTb1
X-Google-Smtp-Source: APXvYqyfyGnzFdi/Vcul55ktf8+pS4Q6eUrq5PrUm5EowusGn2wDbt3UwWveBRVVEuDBJeBykWYgOQ==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr20862534wmg.39.1581928886841;
        Mon, 17 Feb 2020 00:41:26 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:26 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 07/12] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
Date:   Mon, 17 Feb 2020 09:40:34 +0100
Message-Id: <20200217084039.78215-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh, it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Update all callers to handle the error returns.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 17 +++++++++++------
 bisect.h |  5 ++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index e4573c7ba1..85bda3500b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -661,11 +661,11 @@ static void bisect_common(struct rev_info *revs)
 		mark_edges_uninteresting(revs, NULL, 0);
 }
 
-static void exit_if_skipped_commits(struct commit_list *tried,
+static enum bisect_error error_if_skipped_commits(struct commit_list *tried,
 				    const struct object_id *bad)
 {
 	if (!tried)
-		return;
+		return BISECT_OK;
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
@@ -676,7 +676,8 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf(_("We cannot bisect more!\n"));
-	exit(2);
+
+	return BISECT_ONLY_SKIPPED_LEFT;
 }
 
 static int is_expected_rev(const struct object_id *oid)
@@ -950,6 +951,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	struct rev_info revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
+	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -972,8 +974,9 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		 * We should exit here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
-		exit_if_skipped_commits(tried, NULL);
-
+		res = error_if_skipped_commits(tried, NULL);
+		if (res < 0)
+			exit(-res);
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
@@ -990,7 +993,9 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	bisect_rev = &revs.commits->item->object.oid;
 
 	if (oideq(bisect_rev, current_bad_oid)) {
-		exit_if_skipped_commits(tried, current_bad_oid);
+		res = error_if_skipped_commits(tried, current_bad_oid);
+		if (res)
+			exit(-res);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(r, prefix, revs.commits->item);
diff --git a/bisect.h b/bisect.h
index c921ead02c..19d90e4870 100644
--- a/bisect.h
+++ b/bisect.h
@@ -37,10 +37,13 @@ struct rev_list_info {
  * commit has been found (and possibly checked out) and it
  * should be tested.
  * BISECT_FAILED error code: default error code.
+ * BISECT_ONLY_SKIPPED_LEFT error code: only skipped
+ * commits left to be tested.
  */
 enum bisect_error {
 	BISECT_OK = 0,
-	BISECT_FAILED = -1
+	BISECT_FAILED = -1,
+	BISECT_ONLY_SKIPPED_LEFT = -2
 };
 
 enum bisect_error bisect_next_all(struct repository *r,
-- 
2.25.0

