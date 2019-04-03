Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59AAA20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDCLiB (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:38:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34106 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:38:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so8209852pgq.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHihulZqB9t7pgfq8tjomSTv/8DEfubw/edGbtbh7Pk=;
        b=lMeUAY81DfcCU6fIUyriJQyQrvs3U6GvtDaefrnyXBimYlodSt6FpX6+VdhXBjimVc
         UK+fdoazW/jfw9h/0KBqWzB+dtqNxgxZz7yCRNfpsEjayZ96w28OJGtA7A5kPawMEy+Z
         WDWbRN/tlyfPW3CJ+OrmKW85NjtF+fxOCnE+8fQdVwruD7phnCvQyg6O3hE+c9djH67W
         nl1ARvIzVhQjedEAcoRHGpM58HGf5SfAVz6YFEcAPbSLYnjx3WM2B/mm0GuzJ1wUYu99
         Ubfb4F6+Kl/EdlI61tSNFhzN4v404kI+wHeyOYb3vmT/LQZ7HZRwivpSN9LizlihtTDn
         8FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHihulZqB9t7pgfq8tjomSTv/8DEfubw/edGbtbh7Pk=;
        b=qZHBWaeG1Hv70fR7SH8ysamEgPNx93Ba9NhTL7+K1wqjUf1ypxloMVAf0cgoKIKVXu
         UZS9CgSOvFnGFB+17oCYJ3tYDDf1frBaZFmUFROLHaA9fKzc0CtJf5Pr8jmS233OvXdn
         mVSslFJn7Sl7XVJzySoTrpCcVw9PQ6le4O0PSvH6pZmjuuEJSmJojn0vEtebPX26XIRr
         86WwiGPGVoO/k+WhTpbYVFTiydwHqy2af2tpKZbD5/LQ6a07ZlMU83N+Iw956cYte658
         +kDofml6470vf1qPF98eEv9QkrQI9XSIKxppd7A5AUz6eoYuRMY25uLdu7QaeTGZFQwx
         ltqA==
X-Gm-Message-State: APjAAAW+/Hl91wboQ7q9dpyyKt5zLd+NM14NauA9U5TmRz1vxrxbde5D
        jspebqxYUonSV9A796NxQwDYF019
X-Google-Smtp-Source: APXvYqxtD3QzF99nj59kfzCW7phd9XMjtlHcZ1tBjdlbxFgRSgeZ37BWCK1H02UWOikkcB/xf9Lgsg==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr12640544pgv.159.1554291480551;
        Wed, 03 Apr 2019 04:38:00 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id s85sm17768687pfa.23.2019.04.03.04.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 32/32] sha1-name.c: remove the_repo from get_oid_mb()
Date:   Wed,  3 Apr 2019 18:34:57 +0700
Message-Id: <20190403113457.20399-33-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

