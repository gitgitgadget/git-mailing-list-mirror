Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E3C35254
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FD3217BA
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv6Qr3nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBHJIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55699 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgBHJIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so4812072wmj.5
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLSG+Q77AdLVaFVMIARi/gl7xzQBzBo857i0VLL2p5k=;
        b=iv6Qr3ncmvoJBTUowvG8yWWWretOBzxI6FkSlZqbWhSdhGZV6alem/fkmY9ps88PBp
         Fi1teJ43PLaji8xIa6v1B1YNWsv2dOM3OGiL/RPEtVQ3QFkwP7Xhaxl5hFdgpOsFGCPa
         8ZArDyhhtlcdF77LHYVCy/yDyjZUXBKWS6N0QSAJrjX9GBcbGW05ndit5mlWVVtOjqpV
         Jc1+BcjpCK8Yg3Wa/lyjeBAdfSoiE+7AB/7SuAmUC+z9GZFyzvQ18nmZmzQ3d/Yp0e6r
         +18UfMPC4/14K6K21Zll3dmJUzdkk4219U8PAbfOWcqKs4PPuxe2HlZLLP4Td5RAF/iG
         NmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLSG+Q77AdLVaFVMIARi/gl7xzQBzBo857i0VLL2p5k=;
        b=dKc3CC1sQJOE3eakhoioqM5poDSYdXGuuliJfbPoqikCQpH5dSZNX03AQozoN4UESL
         odmYVD/txp6Y9KnClYKSd7THPvnu1La8x8gPCqXSvuWrgr/R9oLvoWbwqFb+OWbJbecd
         /Ffz821Qaah9vKCPkk/1RZbEeDe1+Ku7xn0dQvkK6KmWKFAaU4UbevBAy1X3PBye7DoM
         ii8JGtkUvJEZXYo386ohlulvaBZEsJ/mh/UquUi/fGOy7srCdzQBeHOZuEnwgzE4LH30
         sTxWkjCSZYp7aspPVhSAYFKKmHhA3I1TW4mShosImJclX6/goXxsW51RAkHEscdAuKoQ
         FVJQ==
X-Gm-Message-State: APjAAAUgq4/XBcWmrROvejUIYRoivXYz6FQ+Fg4Oonw1NhBPf6Mnubwq
        pkEGjow5idJHh/vd4o1J0ZO78ZUC
X-Google-Smtp-Source: APXvYqwsBbUf1T3nnEkEdQe3pAIQXVdMdQC9ziI9frkMk6/SmNDBBzw4+tvttrGm4eXbezr51aFPZQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr3535571wmb.0.1581152915984;
        Sat, 08 Feb 2020 01:08:35 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:35 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 10/13] bisect: libify `check_merge_bases` and its dependents
Date:   Sat,  8 Feb 2020 10:07:01 +0100
Message-Id: <20200208090704.26506-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
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

In `check_merge_bases()` there is an early success special case,
so we have introduced special error code
BISECT_INTERNAL_SUCCESS_MERGE_BASE (-11) which indicates early
success. This BISECT_INTERNAL_SUCCESS_MERGE_BASE is converted back
to BISECT_OK (0) in `check_good_are_ancestors_of_bad()`.

Update all callers to handle the error returns.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 22 ++++++++++++++++++----
 bisect.h |  7 ++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6582ddfed..382e0b471f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -811,13 +811,18 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * "check_merge_bases" checks that merge bases are not "bad" (or "new").
  *
  * - If one is "bad" (or "new"), it means the user assumed something wrong
- * and we must exit with a non 0 error code.
+ * and we must return error with a non 0 error code.
  * - If one is "good" (or "old"), that's good, we have nothing to do.
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
+ * - If a merge base must be tested, on success return
+ * BISECT_INTERNAL_SUCCESS_MERGE_BASE (-11) a special condition
+ * for early success, this will be converted back to 0 in
+ * check_good_are_ancestors_of_bad().
  */
-static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
+static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
+	enum bisect_error res = BISECT_OK;
 	struct commit_list *result;
 
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
@@ -832,11 +837,16 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb, no_checkout));
+			res = bisect_checkout(mb, no_checkout);
+			if (!res)
+				/* indicate early success */
+				res = BISECT_INTERNAL_SUCCESS_MERGE_BASE;
+			break;
 		}
 	}
 
 	free_commit_list(result);
+	return res;
 }
 
 static int check_ancestors(struct repository *r, int rev_nr,
@@ -871,6 +881,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
 	int fd, rev_nr;
+	enum bisect_error res = BISECT_OK;
 	struct commit **rev;
 
 	if (!current_bad_oid)
@@ -885,10 +896,13 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
+
 	rev = get_bad_and_good_commits(r, &rev_nr);
 	if (check_ancestors(r, rev_nr, rev, prefix))
-		check_merge_bases(rev_nr, rev, no_checkout);
+		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
+	if (res)
+		exit(res == BISECT_INTERNAL_SUCCESS_MERGE_BASE ? BISECT_OK : -res);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
diff --git a/bisect.h b/bisect.h
index 19d90e4870..f68ae85376 100644
--- a/bisect.h
+++ b/bisect.h
@@ -39,11 +39,16 @@ struct rev_list_info {
  * BISECT_FAILED error code: default error code.
  * BISECT_ONLY_SKIPPED_LEFT error code: only skipped
  * commits left to be tested.
+ * BISECT_INTERNAL_SUCCESS_MERGE_BASE early success
+ * code: found merge base that should be tested.
+ * Early success code BISECT_INTERNAL_SUCCESS_MERGE_BASE
+ * should be only an internal code.
  */
 enum bisect_error {
 	BISECT_OK = 0,
 	BISECT_FAILED = -1,
-	BISECT_ONLY_SKIPPED_LEFT = -2
+	BISECT_ONLY_SKIPPED_LEFT = -2,
+	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
 enum bisect_error bisect_next_all(struct repository *r,
-- 
2.25.0

