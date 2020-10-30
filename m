Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD1C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1E21582
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDMOI/RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgJ3DnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB7C0613D9
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id f7so5396780oib.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lyLUi9f36c5DAcnWpd3TGmdiXq/99VXer78xLZtz3w=;
        b=gDMOI/RKrfEJRqsk1yWmR8ziZ4nDSRKTOR93pIdBQIqo2+y56QK/ExO2ns0whftDjC
         bLWKt/Yk5UXxfEpkdBRq3RsCDX3mx9C81iBnhZqYZb47FWx9D5hz9kXnNj4WeJ+VumKj
         fYQFOPWdb6/QdVa07xDvnGeRFvDfo46gqTNG5zPIbOCvQ8XxjnhFb4oG28Hrf/cS8reM
         88hCR5JB9L6XaK2MYoHd3iAMfWtSTR+l2BzbdT1qn0Op9UjzJ/7/jY6g3NghTPHJhpM5
         cXyxANii/eZANyVfJCDuFqqraU5G5wIuDKGvLQlGWPR15CpenpgVdfy+zjFe7TPY6xe/
         5lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lyLUi9f36c5DAcnWpd3TGmdiXq/99VXer78xLZtz3w=;
        b=lbrTqPNwn7NQowON9waxFCYhZtvT5cYtR9BcMhfQQumVimr6xxZK1vYJaY0DJ00EUo
         HRqF8AA1C3Qj8ruiE36iIWlq63zaQ0CgWE3QYlew2puzwWiYGC3m/8Qgd/oPzjeISj4x
         TwJjckl+JsTR+uJpsKtSWA020OQ4PgRzkVzVNciY8+HE+sm2dwNVf9fxeSrQAXmBYSxI
         8ZZJtyJQY2CqSRTswkYQ1IFk+KaqaUB0ChXbjfF5f1j+fNaM+CApxijxBGmoK8P+e/Ua
         WAaY2mP5U5tEE61hiKqvMNAmZG1iIixDwTPDq7sZMqggX7dKqEWEzJv4CtAArYrSrWDe
         dlUg==
X-Gm-Message-State: AOAM533Nb6QJ0HgkzDjidiPkiIM0Ppy4KokD997p31Ow/FTpZJMUOztp
        Fe/wAFcUkmaHwxYPymECkUl6JaF5DMkThQ==
X-Google-Smtp-Source: ABdhPJxJRGvB6kE15fsiKEUtmDR1KYXpKvY7gEnj3XjQsJwMYSLVbGyK0aX44QicfRpJezEVTT9Ncw==
X-Received: by 2002:aca:1803:: with SMTP id h3mr271785oih.148.1604029311004;
        Thu, 29 Oct 2020 20:41:51 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 08/20] merge-ort: compute a few more useful fields for collect_merge_info
Date:   Thu, 29 Oct 2020 20:41:19 -0700
Message-Id: <20201030034131.1479968-9-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 7083388a47..86d9b87cb9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -96,6 +96,7 @@ static int collect_merge_info_callback(int n,
 	size_t len;
 	char *fullpath;
 	unsigned filemask = mask & ~dirmask;
+	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
@@ -108,6 +109,13 @@ static int collect_merge_info_callback(int n,
 	unsigned sides_match = (!side1_null && !side2_null &&
 				names[1].mode == names[2].mode &&
 				oideq(&names[1].oid, &names[2].oid));
+	/*
+	 * Note: We only label files with df_conflict, not directories.
+	 * Since directories stay where they are, and files move out of the
+	 * way to make room for a directory, we don't care if there was a
+	 * directory/file conflict for a parent directory of the current path.
+	 */
+	unsigned df_conflict = (filemask != 0) && (dirmask != 0);
 
 	/* n = 3 is a fundamental assumption. */
 	if (n != 3)
@@ -127,6 +135,14 @@ static int collect_merge_info_callback(int n,
 	/* Other invariant checks, mostly for documentation purposes. */
 	assert(mask == (dirmask | filemask));
 
+	/* Determine match_mask */
+	if (side1_matches_mbase)
+		match_mask = (side2_matches_mbase ? 7 : 3);
+	else if (side2_matches_mbase)
+		match_mask = 5;
+	else if (sides_match)
+		match_mask = 6;
+
 	/*
 	 * Get the name of the relevant filepath, which we'll pass to
 	 * setup_path_info() for tracking.
@@ -145,6 +161,8 @@ static int collect_merge_info_callback(int n,
 	 * so we can resolve later in process_entries.
 	 */
 	ci = xcalloc(1, sizeof(struct conflict_info));
+	ci->df_conflict = df_conflict;
+	ci->match_mask = match_mask;
 	strmap_put(&opti->paths, fullpath, ci);
 
 	/* If dirmask, recurse into subdirectories */
@@ -161,6 +179,13 @@ static int collect_merge_info_callback(int n,
 		newinfo.name = p->path;
 		newinfo.namelen = p->pathlen;
 		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
+		/*
+		 * If we did care about parent directories having a D/F
+		 * conflict, then we'd include
+		 *    newinfo.df_conflicts |= (mask & ~dirmask);
+		 * here.  But we don't.  (See comment near setting of local
+		 * df_conflict variable near the beginning of this function).
+		 */
 
 		for (i = 0; i < 3; i++, dirmask >>= 1) {
 			if (i == 1 && side1_matches_mbase)
-- 
2.29.1.56.ga287c268e6.dirty

