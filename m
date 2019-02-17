Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4511F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfBQKJv (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36639 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so7079821pfa.3
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmzmbOQr+x8JD3nuqSqYAs7w9IFlhHYu9lEWpDCsgfo=;
        b=fFsvFFlbGykspFNrckzIcpk8MHwWvBSZ2Q1YgXJ5nlLMzzy/VgI6C9GBfXA8BrIX7q
         /mYS5ZyIW6CdlFUIHr13xCYMolah6hwU/IaDF/iljTgLPoamslRAIBP+0t0XcNNb3ucY
         wHCiGCS+yiCdFC73pUCe7B61OqXdvqkUWlu8rFtS95sYD6TEWSjVkVdHZeIe3YTA7Uwk
         Vt+wwtUyHEALSKzzOJd8sRtpZEP++aE5796FDHGAguoDCdJmNek9EqVduRqg/quER22f
         mjqTWTv7DXWLME/wR072X1ACCOl988qhrHI6w8Sv5nlgRiVJitwZRjRPkLrFu5cbYINb
         CbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmzmbOQr+x8JD3nuqSqYAs7w9IFlhHYu9lEWpDCsgfo=;
        b=gwTue04Gukqhzzc7JxAfbRZz7Fk4jN0jFMfH2yVfX4YtXp8xUxrd2mG4Ozf5OGvoCc
         lNndiLvAA2DBXQDEXYXIyI70vwEgGJbELWETx2itn2v7uPvxfpnzISxDCoZ+1g+G9oJ3
         50CbTLYKhfJ7WByzKc0/QHR6b+0uDmOHHdFNz4qh4pl3Qt+GISyO1aW+hANybqm2axx8
         A6FNnMEG6ZaUYZcmmTCqe0Xu2yBZaj5xYz60C7ccg8s8epDQS6IcfUFQwPA5p26Rj91Y
         Ozekdlv01yOHsHWHRxHIBnQMSfSiZJ8G8wNY7zWcASKIcHMbtrK2tVcr+ykZp3aJNVT9
         0ZXQ==
X-Gm-Message-State: AHQUAuY9igDyXyKyFSJYC32pv85dnH75dQmbExOSit9JmfkQhXkxGgoy
        cAKeHtqRi0XkFZNtj7BUEGRWJjWG
X-Google-Smtp-Source: AHgI3IaBGfc5uV67IY2X9FB76OcHC53w65lMFXgMICQxAVc6Cj0n8bSI1MtA2CJadAF4i0u4tgzasA==
X-Received: by 2002:a63:fa48:: with SMTP id g8mr13643917pgk.203.1550398189601;
        Sun, 17 Feb 2019 02:09:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c4sm11001796pgq.85.2019.02.17.02.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/31] refs.c: add repo_dwim_log()
Date:   Sun, 17 Feb 2019 17:08:49 +0700
Message-Id: <20190217100913.4127-8-pclouds@gmail.com>
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
 refs.c | 21 +++++++++++++++------
 refs.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index bd0fec5776..edea001446 100644
--- a/refs.c
+++ b/refs.c
@@ -603,9 +603,11 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	return refs_found;
 }
 
-int dwim_log(const char *str, int len, struct object_id *oid, char **log)
+int repo_dwim_log(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **log)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
+	struct ref_store *refs = get_main_ref_store(r);
+	char *last_branch = substitute_branch_name(r, &str, &len);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
@@ -617,13 +619,15 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
-					 &hash, NULL);
+		ref = refs_resolve_ref_unsafe(refs, path.buf,
+					      RESOLVE_REF_READING,
+					      &hash, NULL);
 		if (!ref)
 			continue;
-		if (reflog_exists(path.buf))
+		if (refs_reflog_exists(refs, path.buf))
 			it = path.buf;
-		else if (strcmp(ref, path.buf) && reflog_exists(ref))
+		else if (strcmp(ref, path.buf) &&
+			 refs_reflog_exists(refs, ref))
 			it = ref;
 		else
 			continue;
@@ -639,6 +643,11 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 	return logs_found;
 }
 
+int dwim_log(const char *str, int len, struct object_id *oid, char **log)
+{
+	return repo_dwim_log(the_repository, str, len, oid, log);
+}
+
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
diff --git a/refs.h b/refs.h
index fd3dc1d0f4..859dffe691 100644
--- a/refs.h
+++ b/refs.h
@@ -150,6 +150,7 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.rc0.328.g0e39304f8d

