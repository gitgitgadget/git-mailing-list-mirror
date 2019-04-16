Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D736820248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDPJh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38339 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfDPJh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so10059929plb.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A26tUyMKsr/fpbymZn6ZEgynzjz4qEGPUXyQIXGFkYU=;
        b=MYxAL4KcTbsQWIynvmbyLXvTSj1d833wN/spj+fUsH2fZDY5xkd4QN8xabeqEpFnDg
         E/0SOzIpLO5jOaPvRWXQEEd0FgfNj0btkMXHS/8tFVwdZjIPNskNoWx07fO9hW5sGQi6
         bmlQYX4uzieS985DTQvGb3vTupkSlsDnTqpaNYBzja+2CyPJieRjj8TYO1Gk/wq1rp32
         Q9IC22X/e2QNt00yjhvf2pJS18UMI16aPUFI63MlaypAqBGGqvlBa8l1O3t7uR8P45We
         e5YPGp1mELAM8D6js1grRGQ1bt97JJat6CqCn1RsMeFLlgrml0/DJvXvAVfIp0g07mnM
         v3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A26tUyMKsr/fpbymZn6ZEgynzjz4qEGPUXyQIXGFkYU=;
        b=mrrOzUr2uPKZ+J2VLJK3buex05kYFAjvepov6s1xOMDlsVS1WGlxELmgbNjMghC5Q3
         3xZKy+DvRxla190MmzYUtJL29IbwglMrWAEjn7uMDFlO+qjAE98TfE2Mdj7UsnLx+Hsy
         y7LC8jzQhFCNAi3n7zOfUQsQA4chC9c+59knHYyFWLQF+z5WUCpAHvfY5jwgbl2UXp7Q
         QgKr+2WGkYr1elXnBsFBiRUpX/UUL2MwKf91cIJXFn/O4DEbM3NMnYCFSnUKWzg3ojtP
         TKApKtqhDohdX4EKMrr/s6wc/VnTtV6jBoa2rj4TaJWALyAV2HHb24xqIYfsjdc9WL2J
         w9nQ==
X-Gm-Message-State: APjAAAXPMMnj8FTn6w41P+ZKojXqNMoheLjvgBOgi4ZBWUBuBKLlXwlL
        2JiKCJk/W6d6JYirqm1L3K0AUMoZ
X-Google-Smtp-Source: APXvYqx9LUJJLDe/JM6ZWSyBZ44RepkzHFIuKGh/6vr0LUZB2iutbt9tW61EgTiLFoFCOQAnBI4k3g==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr27732576plp.294.1555407475867;
        Tue, 16 Apr 2019 02:37:55 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id l4sm35268153pgh.17.2019.04.16.02.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 34/34] sha1-name.c: remove the_repo from get_oid_mb()
Date:   Tue, 16 Apr 2019 16:33:41 +0700
Message-Id: <20190416093341.17079-35-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     |  3 ++-
 sha1-name.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 871a167bf8..9a600a8b50 100644
--- a/cache.h
+++ b/cache.h
@@ -1386,6 +1386,7 @@ int repo_get_oid_committish(struct repository *r, const char *str, struct object
 int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_mb(struct repository *r, const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
@@ -1399,6 +1400,7 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 #define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
 #define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
 #define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
+#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid)
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
@@ -1486,7 +1488,6 @@ int repo_interpret_branch_name(struct repository *r,
 			       unsigned allowed);
 #define interpret_branch_name(str, len, buf, allowed) \
 	repo_interpret_branch_name(the_repository, str, len, buf, allowed)
-extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
 
diff --git a/sha1-name.c b/sha1-name.c
index d49496397d..cf314ebb29 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1338,7 +1338,9 @@ static int interpret_nth_prior_checkout(struct repository *r,
 	return retval;
 }
 
-int get_oid_mb(const char *name, struct object_id *oid)
+int repo_get_oid_mb(struct repository *r,
+		    const char *name,
+		    struct object_id *oid)
 {
 	struct commit *one, *two;
 	struct commit_list *mbs;
@@ -1348,27 +1350,29 @@ int get_oid_mb(const char *name, struct object_id *oid)
 
 	dots = strstr(name, "...");
 	if (!dots)
-		return get_oid(name, oid);
+		return repo_get_oid(r, name, oid);
 	if (dots == name)
-		st = get_oid("HEAD", &oid_tmp);
+		st = repo_get_oid(r, "HEAD", &oid_tmp);
 	else {
 		struct strbuf sb;
 		strbuf_init(&sb, dots - name);
 		strbuf_add(&sb, name, dots - name);
-		st = get_oid_committish(sb.buf, &oid_tmp);
+		st = repo_get_oid_committish(r, sb.buf, &oid_tmp);
 		strbuf_release(&sb);
 	}
 	if (st)
 		return st;
-	one = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
+	one = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!one)
 		return -1;
 
-	if (get_oid_committish(dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
+	if (repo_get_oid_committish(r, dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
 		return -1;
-	two = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
+	two = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!two)
 		return -1;
+	if (r != the_repository)
+		BUG("sorry get_merge_bases() can't take struct repository yet");
 	mbs = get_merge_bases(one, two);
 	if (!mbs || mbs->next)
 		st = -1;
-- 
2.21.0.682.g30d2204636

