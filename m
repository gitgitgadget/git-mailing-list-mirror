Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23FCC56202
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF942078B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiAA2Jby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKMMKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgKMMKu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D38CC0617A7
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a65so8262862wme.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XF1TFkYKb09IuVXVkVvH6iskGxmP9cD0WNFS1Kly3iE=;
        b=GiAA2JbyRN0hcRNsuGlKnWZbv/IGfDbSdOHG750lfUYRNmxP486gwJuY/e61736qA9
         D/5PKebIGb+Vh+l11xKLWT4B4DrjrVHD30Rpdd/7rJv+DTUhQhUBMJSj0Shrm3O2x7je
         fK5ov/j/cRHsXdwY+gGGtKOILDg6+XEVW65gEbZyfuAba5tGRgrIiItmu+iqpsvn79+o
         hTiUyXBUYJR1bIlcf5lc0+pimQXU2MhHZZFKYV3JPrna+U6IHO2ueshANHSGDFJrjRMQ
         MQAxK0X/i5hcK5JaFtBRMxJY6Ll/kBlc7W3ICu9603wHxfmTgWD0Segp+ySiqqBfsqUb
         xcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XF1TFkYKb09IuVXVkVvH6iskGxmP9cD0WNFS1Kly3iE=;
        b=QUA7HOb7fhjoeSWXQ9eB0NSjof9xXZccul2FNwNZ+ynqxX+arE3Z8UR1nd+Qk9i5D8
         mcG15wX3SSMn6ZDrrOqeQxfm6KpGX6P8ETSHeE/Bax+qksm8pROadp7tSnqBfG0yJPeK
         Cd46Qpq94xFkUDoRF3+gzijVDGI+JZhJbNBThYnQwe1yU6w1U+kTrcE4D1JBJH3FJLNC
         CKBM9SvNOh9WbMALJAJE0FfhDidewg6FULSCaYaMkQL8MU7wxDGkosS/WJJe33K0qCTV
         O5B5E+DxrD3DmjK9BRxpTR2NrLaWAibFQ3HuRr6/os6hsnz3zLnzFmOI4uVwwxK1xaXk
         IxnQ==
X-Gm-Message-State: AOAM5323T6mxsiRdcNFe8OyvUfj9qMmjHoAUt1gAZNrF8obpMIB6JZF7
        BtQzHoGUaeLC/VM6UezZfxKIgH0+kB0=
X-Google-Smtp-Source: ABdhPJyKc/qT+ujq/G9PeohxQFBi7oVLGJZijI287Xj5DknEtfGDSjRXGCSSwjNaJKJ/hMs5r4/1+Q==
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr2239930wmd.73.1605269448593;
        Fri, 13 Nov 2020 04:10:48 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:48 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 02/12] update-index: move add_cacheinfo() to read-cache.c
Date:   Fri, 13 Nov 2020 12:04:18 +0100
Message-Id: <20201113110428.21265-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
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
2.20.1

