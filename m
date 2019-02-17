Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E097C1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfBQKJz (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:55 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38521 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:55 -0500
Received: by mail-pl1-f175.google.com with SMTP id e5so7267627plb.5
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xB6D+QQcZlqRS33KSlgXZUbS5gL57O6syOSYk3ErfWs=;
        b=WzayiwhIj/btbyXDBHVN5DZYHfKmez+RdX+86zsrIkiaIbJv1fEIJWluaR+h/bSCfE
         3KziCzgNc6hDM62LBrKxCpM6wgdCkeddavSChvJfStLIQ8ggLZy6Ym3a9bS9iImD79QY
         El8+UQseyxuQILoQCflK01OWnsElcEYIC194fg9+XNf4GYr8JIVGNWSWBvSLZ7hVh4tL
         51hbGXEuMGuZayELUFOz9ule0nwktYhqEeEUYzBjfgqRI+gWLHffdy1L+v+X29cDN1Ak
         B4uwug1WC18DD1D0bYNmHOZUFoOi7pDNfRxBwMniZ09GoKt0ljze83BGuOuU+3cXiNJC
         /6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xB6D+QQcZlqRS33KSlgXZUbS5gL57O6syOSYk3ErfWs=;
        b=o2hk8o7M18HxFaQfTYnBNjXLq54l6bSwKG6znvZkaTr3UAiHZrFjvBniy7d4IIyAmI
         fbBQrDPdgagaq4JVkzmFuvuBNF6aWr4mC+sz8YnuPtflZXSDWmgk4Mmyg366StzJaIaP
         5ccjsLHUYVyfoBnkOaTaB/iGWBd2KbKlTv3+zy6vbpT9CXLVOx7JjrDmYWh5QakS4mXg
         GXG2O90A2GiqmRBY0qXM+tGANEvu/4vxSlK3Gi2iNlM31l1j5MiveBsHcNcdI20KuMDp
         ryIIhBcB9YkYxsxb3+fs3SZhvxk/8xMSLHed2aBAbsGc0y8Ts3nziZUEAaEsvFaod3rr
         r7jw==
X-Gm-Message-State: AHQUAuYCz9X0IH0RU2F6B0rxDCes6oIUiggMYpBu+8eG3BeAjZTK46W1
        06oV6RI+O8oiaO7wkAkWKJrBZj8P
X-Google-Smtp-Source: AHgI3Ib8SB6MPzMZzNaY6wTp5IwJKjPislL7VlCMG1koPa/k1Gu39TitZl8snY32Xsk4qG+BM+XINA==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr19845446plo.265.1550398194187;
        Sun, 17 Feb 2019 02:09:54 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w10sm11050541pgr.42.2019.02.17.02.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/31] refs.c: remove the_repo from read_ref_at()
Date:   Sun, 17 Feb 2019 17:08:50 +0700
Message-Id: <20190217100913.4127-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/show-branch.c | 6 ++++--
 refs.c                | 7 ++++---
 refs.h                | 3 ++-
 sha1-name.c           | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 934e514944..082daeac32 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -753,7 +753,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				timestamp_t at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, flags, at, -1, &oid, NULL,
+				read_ref_at(get_main_ref_store(the_repository),
+					    ref, flags, at, -1, &oid, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -765,7 +766,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			timestamp_t timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg,
+			if (read_ref_at(get_main_ref_store(the_repository),
+					ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
diff --git a/refs.c b/refs.c
index edea001446..92d1f6dbdd 100644
--- a/refs.c
+++ b/refs.c
@@ -967,7 +967,8 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
+int read_ref_at(struct ref_store *refs, const char *refname,
+		unsigned int flags, timestamp_t at_time, int cnt,
 		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
@@ -983,7 +984,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
-	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
+	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
 		if (flags & GET_OID_QUIETLY)
@@ -994,7 +995,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	if (cb.found_it)
 		return 0;
 
-	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
+	refs_for_each_reflog_ent(refs, refname, read_ref_at_ent_oldest, &cb);
 
 	return 1;
 }
diff --git a/refs.h b/refs.h
index 859dffe691..8f9cbf8a93 100644
--- a/refs.h
+++ b/refs.h
@@ -388,7 +388,8 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
-int read_ref_at(const char *refname, unsigned int flags,
+int read_ref_at(struct ref_store *refs,
+		const char *refname, unsigned int flags,
 		timestamp_t at_time, int cnt,
 		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
diff --git a/sha1-name.c b/sha1-name.c
index d535bb82f7..15a1107998 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -849,7 +849,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
+		if (read_ref_at(get_main_ref_store(the_repository),
+				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
-- 
2.21.0.rc0.328.g0e39304f8d

