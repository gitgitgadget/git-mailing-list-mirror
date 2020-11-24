Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA543C6379D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7682620782
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McueNFA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbgKXLzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733077AbgKXLzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:00 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99380C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z7so6202627wrn.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJvTCeg71Po7LLPeAOBt6p9sIzAl69qzR6MCLRtxFrY=;
        b=McueNFA55Z+B/k7gewXdV8OFjnTg3I/CZpV064oGlGjx3SPXG3vRY+tRxkZin5qjnm
         AIrsWqKdHjW3IWJ5M90fD8Nxnxj3dvkDBPxOdyl0wqjX7Co6O7ij4rxS20oyYb/nbrSw
         K/EpSN+GFUBlPZV9aQkEKV7pM4NXMQkZWgqW3aUDAec8q8BWntmjiuUsw5nmUw9J5zK6
         cJei0azBmJP9MQfiph+B4ZAQPVXEakyEhSRYfWbHxf8J2sC8wuyCyCXVuNiXt8b9p7jV
         B7C0Y+6/7SV+EsdeABejQBjAAzQkTwGYL5rBxT/gqId/yrPA9KFjfIPHw9CyL+r6TJ46
         4Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJvTCeg71Po7LLPeAOBt6p9sIzAl69qzR6MCLRtxFrY=;
        b=iMQanY1jmLZ8gaIvoo1438oOOPWjSo6PDnlPQd2rucX33+wxxAVqavtDIK+TyQy4PW
         m2eSzbQ5/SPFfb+u5s5Z5Rfjv932PuSYPjDRnc+c+1jln15U2e/K8J+GN7r0FwiXN1q4
         Vc2XLxdzd7FqASLk5tlVYYTO484hfIcEBza7GVi8At88Ev0t58TRRBhsh7lRBLpc+Wfs
         e/hC6WI5CuMqQy+wPIX4Qkf+7sj5c6cd2dA4rb8c4PtucluW4GZ/ABwSI/SSZZe9dYL6
         71YWL2CQPoOAgxdoFDDqmihqKEZVPnlo+50Z+Cdzg2Zs3tv73p9CjFq0mHWxaVmHekk9
         P3vw==
X-Gm-Message-State: AOAM532+3Sagi7kCt90+pTHntVIwbftI469RT05fCHTzrJrEpv64qxOe
        K4+4MLMpcr2dxhUeG4/deEFr/y+F4es=
X-Google-Smtp-Source: ABdhPJwb8jfcLqltDamwXq87BvSbPMvrV5KQcen7S3x5VGh/QcvW2ugmxEqqQgaLXsLDX52y3wuPCA==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr4982645wru.68.1606218899081;
        Tue, 24 Nov 2020 03:54:59 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:54:58 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 03/13] update-index: move add_cacheinfo() to read-cache.c
Date:   Tue, 24 Nov 2020 12:53:05 +0100
Message-Id: <20201124115315.13311-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the function add_cacheinfo() that already exists in
update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
and adds an `istate' parameter.  The new cache entry is returned through
a pointer passed in the parameters.  The return value is either 0
(success), -1 (invalid path), or -2 (failed to add the file in the
index).

This will become useful in the next commit, when the three-way merge
will need to call this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/update-index.c | 25 +++++++------------------
 cache.h                |  5 +++++
 read-cache.c           | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea..44862f5e1d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -404,27 +404,16 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage)
 {
-	int len, option;
-	struct cache_entry *ce;
+	int res;
 
-	if (!verify_path(path, mode))
-		return error("Invalid path '%s'", path);
-
-	len = strlen(path);
-	ce = make_empty_cache_entry(&the_index, len);
-
-	oidcpy(&ce->oid, oid);
-	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(stage);
-	ce->ce_namelen = len;
-	ce->ce_mode = create_ce_mode(mode);
-	if (assume_unchanged)
-		ce->ce_flags |= CE_VALID;
-	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
-	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	res = add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
+				     allow_add, allow_replace, NULL);
+	if (res == -1)
+		return res;
+	if (res == -2)
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
+
 	report("add '%s'", path);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index c0072d43b1..be16ab3215 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,11 @@ int remove_file_from_index(struct index_state *, const char *path);
 int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 int add_file_to_index(struct index_state *, const char *path, int flags);
 
+int add_to_index_cacheinfo(struct index_state *, unsigned int mode,
+			   const struct object_id *oid, const char *path,
+			   int stage, int allow_add, int allow_replace,
+			   struct cache_entry **pce);
+
 int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
diff --git a/read-cache.c b/read-cache.c
index ecf6f68994..c25f951db4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1350,6 +1350,41 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	return 0;
 }
 
+int add_to_index_cacheinfo(struct index_state *istate, unsigned int mode,
+			   const struct object_id *oid, const char *path,
+			   int stage, int allow_add, int allow_replace,
+			   struct cache_entry **pce)
+{
+	int len, option;
+	struct cache_entry *ce = NULL;
+
+	if (!verify_path(path, mode))
+		return error(_("Invalid path '%s'"), path);
+
+	len = strlen(path);
+	ce = make_empty_cache_entry(istate, len);
+
+	oidcpy(&ce->oid, oid);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = len;
+	ce->ce_mode = create_ce_mode(mode);
+	if (assume_unchanged)
+		ce->ce_flags |= CE_VALID;
+	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
+	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
+
+	if (add_index_entry(istate, ce, option)) {
+		discard_cache_entry(ce);
+		return -2;
+	}
+
+	if (pce)
+		*pce = ce;
+
+	return 0;
+}
+
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
-- 
2.29.2.260.ge31aba42fb

