Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89DC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ED824683
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ZQ80Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgA1OlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgA1OlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so16294116wrm.11
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydJB0pf8KIMaV+lmWCZ/JJIyrrUlm8Wy40gNencbC4w=;
        b=M3ZQ80MvByx+lkqLVzgNIbRCXsHL7JQcZuXC5D1zb7mzXUz6ZVw4332leI5ePTnvDv
         yDS0Si4Iek7Tv2Tz74vRUm9HxCICrnLjy4dKh45xtSaH6fYhdYmjPftsFSU0PgreWcVb
         cSgxfYgkRrm6MBdIbvPrIR3Aua9sgH/sC6PQWTwlBKkowdW+mbGfXcoSC20NV8zWSM3g
         6kefLyNyVFcGPPzuopMxUL4ag3n7LycwuiOoVxBFImiSXXFDlpqLHMZrpn2jUstr8hS4
         FNdpqgzV2PWj9C94EAwOqhmFQU5AtBvEIZUdnqGFlsPW2jMuq8uCXUaYsliTFxOqDZnA
         y5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydJB0pf8KIMaV+lmWCZ/JJIyrrUlm8Wy40gNencbC4w=;
        b=Lj9u2k/c+mH12fZttBXf9/QgCZoCDJtMXECvPAc6ZFuZdpLJN7W/ne3XWQWJ7Cb4G3
         Fekf0KExInIkzxTY8mrJ2VN4CFJOuVop20ibQ0OttW52I2ljiXtVr1ki50qLvJKsWoPj
         3s5G9TeKtd0sDjgmTB6/KC/SQ4migp9mAImp7MYmQ8lZpwb2XgflZZylFDYZ9Z7LtFsQ
         vCXMFRcoyz5GNr0kHUQ4FgHHAERR3ndbDajkAcNquhT+CLd8agBVPpInHODfgW1anJoi
         fcx6bSf2XR9Nbsw3OwzWZ56yqXu2oBrW6jiuSaITu+45nhN6jyfwjSpWjtozthq7lBtz
         k5iA==
X-Gm-Message-State: APjAAAVxd/FAB75W9VEiqCD+xs8NJ6mjp+VqgNY8vsrGTD92zFHzqWax
        Z3uQspThF2GsO36A1FkZYDVzu8lwVAY=
X-Google-Smtp-Source: APXvYqy7r32zslNMP69JpjJzjWMANgebzdfZMkbNt97UQHBCygFKiRof55K8aFpld6U2/6PYilVj8g==
X-Received: by 2002:adf:d183:: with SMTP id v3mr30384978wrc.180.1580222479642;
        Tue, 28 Jan 2020 06:41:19 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:19 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 06/11] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
Date:   Tue, 28 Jan 2020 15:40:21 +0100
Message-Id: <20200128144026.53128-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Handle this return in dependent function `bisect_next_all()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index 83cb5b3a98..a7a5d158e6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -661,11 +661,11 @@ static void bisect_common(struct rev_info *revs)
 		mark_edges_uninteresting(revs, NULL, 0);
 }
 
-static void exit_if_skipped_commits(struct commit_list *tried,
+static int error_if_skipped_commits(struct commit_list *tried,
 				    const struct object_id *bad)
 {
 	if (!tried)
-		return;
+		return 0;
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
@@ -676,7 +676,13 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf(_("We cannot bisect more!\n"));
-	exit(2);
+
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
+	return -2;
 }
 
 static int is_expected_rev(const struct object_id *oid)
@@ -949,7 +955,7 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int reaches = 0, all = 0, nr, steps, res;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -972,8 +978,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
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
@@ -990,7 +997,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 	bisect_rev = &revs.commits->item->object.oid;
 
 	if (oideq(bisect_rev, current_bad_oid)) {
-		exit_if_skipped_commits(tried, current_bad_oid);
+		res = error_if_skipped_commits(tried, current_bad_oid);
+		if (res)
+			exit(-res);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(r, prefix, revs.commits->item);
-- 
2.21.1 (Apple Git-122.3)

