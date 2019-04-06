Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2210A20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDFLiP (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:38:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40255 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:38:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so4487210pgo.7
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHihulZqB9t7pgfq8tjomSTv/8DEfubw/edGbtbh7Pk=;
        b=N4YFveUQhUQzNMxDfFQnhqwDjvkbTcuoSQZfIx2Na9L8T9E1qI34XPp2BCuWOQqrSg
         nusBUkXXJMzQGshFyXnXxEzEF5TVUeimcK3/FExfyHVNmgnVcQT069rsLFUNJsXxaiSf
         h/k2yNPkrc/mdOQG1iEVig9wIv1bLyLoHLTmKu5eckXUfL0CGVMxoVktI6nofvsJYxwO
         THLqpxaWdQ5ykWRlddxI7LtJvspc2bzrt02lP120cR83uGiPBdfXzuyyC4QlQ+qIR9+5
         v9FV2ZCjhLrQEuruTnn7KBofyUiBMJOF9EdDiIkkpqQqhnMYswjM2lh9fRYosmbjmPTz
         g/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHihulZqB9t7pgfq8tjomSTv/8DEfubw/edGbtbh7Pk=;
        b=d3MQuLspNcEiE3Telerfa3FxPhKUZPEB7UZ0NuWCNUoyrZxqDqoCGrStr+gW9arZoh
         hv06FqMdLnsYJzxhwywOHQPp5t5vLmo1byTt8/RglKWzNnFACyLWgO4a0UUynUZwa5ZF
         h1PQPTMcvco/DN2pJ7N5h2KT1qtv5n/kVkJaYVhNFXZqmgMkJcpqZs2i9Y7CXmgpl3tt
         HX7gVAq61FI/eiuaIleIPEJnOn6znfsjw85aIJmJGrdTas7+j1Ny4QNHIOpxxXqCB+Us
         DqYScdOQxb6/r5vNIhV6GsQMpFry3ZtB5MP6OQbB8lWarTjS+G8c53ITyV+c8tgUC5hU
         Plig==
X-Gm-Message-State: APjAAAVjOlu3WbVkRET2yvMvARLi4zUJi29aTOwnV3QvmIWkXniMoNXI
        gX9Ggqq5jLg8wm2OxTL4rMeAXz6Y
X-Google-Smtp-Source: APXvYqw0PetbmPxS+HsR5/PZAvtuKLhzsGe8QQgKjH38Kcz58mma82hB27k0ps383dm2QeotllHIFg==
X-Received: by 2002:a62:b602:: with SMTP id j2mr18526426pff.68.1554550693958;
        Sat, 06 Apr 2019 04:38:13 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id i31sm43192761pgi.36.2019.04.06.04.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:38:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:38:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 33/33] sha1-name.c: remove the_repo from get_oid_mb()
Date:   Sat,  6 Apr 2019 18:34:53 +0700
Message-Id: <20190406113453.5149-34-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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

