Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF11C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E65122226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssq0iTLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKBUoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKBUoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:00 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3FC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:58 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k3so2040780otp.12
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mWRIEU0Qv3qlpQzuYPqaIeRWEAHl7jXxJNMbW6oVSE=;
        b=Ssq0iTLPkJiFo88gerNBJbCbRitpd5i/kMWqhdbNsG0Wd6QuuGWQviU5Pajk6vwCoS
         z3xOpQad7NGISdoIIUQlOzyYoqLHEGmqpfaoElRC4aYuZYHLTPj/3QN5fwu5+STWAAtf
         vEG/znElX1/fMyxheOZ1IF/IGY4nd5XVJsYurmd6G4i4ZhfVBQ6TskweYmHE3qJceE99
         TUQ5XbLCooa6wGDjMDmdA/TDAYQeFqmkTgG9TQlAGHDIpHsg+XlJyuuqmWfNifICut3V
         cIpv096WdKHk+Kz9pn8uWB+f8uV7Rh/QGZr8KjrzgfsjULSM+fjY4uub3UvQstyLcrZl
         mWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mWRIEU0Qv3qlpQzuYPqaIeRWEAHl7jXxJNMbW6oVSE=;
        b=brYPqFzKMyltzLB+DTu6vIN1+1xK1pYtdcv8C6yF7dizYc9sGrdP6oItBuY3Mtgaf0
         +jdhv0JisGgsI9x73H9nmDFultIthmHkv0mRGdrJ0hfP06/MefjDNAkUz2EE79hvgee9
         EoS4h9G8bkGelD87/7+8SZtMa0zye9g593g8h0LOLto+jCvehUfo0Hy4UsxIlHzaPXNZ
         0KsojT2kpfRF4eqm+xKL7ojVsdRzntKZ3YPpiGc9V9zS3JJgVrDSQhL3YYaJP+yEZKyq
         KulY7IP4c/WZtsaBhOh/j5GX0SIVe397JSoi3D8S0wYl66WBGBPmnmbNxxRvJUoa0ujR
         zZcA==
X-Gm-Message-State: AOAM5338lrL15j4OpaBG+yjixawtHQdHBttqseJZCSv44Y7TH8VTIbRi
        Eh8NLd+PSCQGEHTh3qCjSU8vDUIDH78LFQ==
X-Google-Smtp-Source: ABdhPJwnTpK+p+oVfoi0wahr1daOa2viyukeGTf7n0zU+7/FrhRsOGQKwgwP4vVYe8bmICOwbPRX3Q==
X-Received: by 2002:a05:6830:309a:: with SMTP id f26mr7445287ots.2.1604349837790;
        Mon, 02 Nov 2020 12:43:57 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:57 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 08/20] merge-ort: compute a few more useful fields for collect_merge_info
Date:   Mon,  2 Nov 2020 12:43:32 -0800
Message-Id: <20201102204344.342633-9-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
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
index d3c1d00fc6..0ff90981cf 100644
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
2.29.0.471.ga4f56089c0

