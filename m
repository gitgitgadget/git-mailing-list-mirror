Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEE91F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKLKis (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35667 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKLKiq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so2397029wmo.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwz9seY6ydl8LCUkBENexJrsht3CXOCEdyWSV+zSBZ0=;
        b=PGisO+XTRg87fJd7agU878F9AIMQdZJdQAtOhwDmg7Vbu9hN2UyUMcFKxqJKyGJtZj
         6BD/QPmS0F6HaoUno3DNVbcySmHvEGq04pkChZGovwHj+G2mMrPvF4KJgXq8R6Sk/F4g
         Ypfn4uja5ix0QaBnLBJilSwvTx/fkIszi+D/7PJ7xWYZdW1KUcMqIstL9kHTVSuNxU9K
         jxXdWRnqDGlqrnrHPsPfhRWW3Cl8P0VCT8iU3V2epTKEL4HI7bIqBJ4bnz10qaZGDiuh
         EWyVjrrGuVg8L3yd1h/qlmy5pSPbNkNptlYu0q+IGSLkFYXCnaYJTCHDJYCxRAwlJx1z
         CXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwz9seY6ydl8LCUkBENexJrsht3CXOCEdyWSV+zSBZ0=;
        b=V0ZjwTumV8omaH2RadgMcm4qhwbVzaWXYJMDMa/ogn5iNXqq1e/WAMthPrY1hsl6ra
         2d6FsuIod+NOIEgEUHzns0O4r805fJD91u8LSXBp7E0u7XaxtSa8FaLA6qFvkntcM7fa
         4qtg0AjeiL0/co220QKAnZc5FLhIM7lfG7AEmXUyRIb1a754M9FoX15WwlyZcPfMWZBN
         R8tXGxnW11H04YrpYG992jDKXdTnVXuEHxNe1FYpa8xjZqcKYAhskIYqKfMnYgPb/iYn
         3Qvc98hjsLePeUASMW92RzOHtt6y+FPhU31Qd4pR0fEbVCJ3OMZ8yUpvYonOBrTQqDWy
         qULg==
X-Gm-Message-State: APjAAAXAcUL/l7pOrZ+ubKdHQ7Pa/1L6PMNWmo9I8eEuukLOeQDw+T4g
        DoXj89QaKZKo72FK9Crf+Fk=
X-Google-Smtp-Source: APXvYqzvuidmEbbOOnB22VNXyFf2MaamKl2kKlXTs628msnHKQS7+E6ZiJn9tL/3sMWAJTuqS41c/g==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr3397932wmc.130.1573555124621;
        Tue, 12 Nov 2019 02:38:44 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:44 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 13/13] name-rev: cleanup name_ref()
Date:   Tue, 12 Nov 2019 11:38:21 +0100
Message-Id: <20191112103821.30265-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier patches in this series moved a couple of conditions from the
recursive name_rev() function into its caller name_ref(), for no other
reason than to make eliminating the recursion a bit easier to follow.

Since the previous patch name_rev() is not recursive anymore, so let's
move all those conditions back into name_rev().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a3b796eac4..cc488ee319 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -107,12 +107,26 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int from_tag)
+		int from_tag, int deref)
 {
 	struct prio_queue queue;
 	struct commit *commit;
 	struct commit **parents_to_queue = NULL;
 	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
+	char *to_free = NULL;
+
+	parse_commit(start_commit);
+	if (start_commit->date < cutoff)
+		return;
+
+	if (deref)
+		tip_name = to_free = xstrfmt("%s^0", tip_name);
+
+	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
+				   from_tag)) {
+		free(to_free);
+		return;
+	}
 
 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
 	prio_queue_put(&queue, start_commit);
@@ -309,20 +323,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		if (commit->date >= cutoff) {
-			const char *tip_name;
-			char *to_free = NULL;
-			if (deref)
-				tip_name = to_free = xstrfmt("%s^0", path);
-			else
-				tip_name = xstrdup(path);
-			if (create_or_update_name(commit, tip_name, taggerdate,
-						  0, 0, from_tag))
-				name_rev(commit, tip_name, taggerdate,
-					 from_tag);
-			else
-				free(to_free);
-		}
+		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
 	}
 	return 0;
 }
-- 
2.24.0.388.gde53c094ea

