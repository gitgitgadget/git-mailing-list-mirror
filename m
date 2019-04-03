Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB0720248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCLh4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35954 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so7001784pfn.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4UsmkkHNE/w67i9pZNTRUVeoBYpvfa1184swHxAb98=;
        b=DzouFIVJ+KpfZIQijvvRCtgteSsosNNE1m7TAphDbLGg4Ja/bNClsCGN3addHuNl/U
         rjKLDTRMKGO89Z8oxaFnNj/6wH7EoXRR36OlV6jMEsXSD555hx3vYU62euaDBMn51PIU
         r00+C7I5nKPKm433pbOfZpeOIbdmSEDRiOgBGsdaKeHHvhUDjCLBNt5lo+4fH69U7OMW
         e5no6/X3dLwv1uy+GaC+JMLIvPuo+ZMM2HthaLmvkQ1i5FbhmVKPGg7OyI1EBRVFvVVl
         2eoEvQjWS+10uVEXb9azC3mAhEoWg8ZCEaGYMcPNho2ttJhp0Qoi2cVUDdWNpPlSlDOV
         iP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4UsmkkHNE/w67i9pZNTRUVeoBYpvfa1184swHxAb98=;
        b=YRDdBXUkLPXeljnWjRF77rEcTTz7NpyDPjgZ9TZe4+it7iYaC8v07/aV6Rra6qrywb
         qbXx0KB6jH783S13rm2zYxFwMz/8bvgJH9Y7GiJQvCS60n2plA5SjLPjCjilEc3tAbvr
         rVnyyIEGb39PTU3IHl3nbtEOKrsWlSoQLqQTyUot6NEkg0wIdtmKNWOkXBV5lL8gUgeY
         gH9HeK399yIZCrFJUu3siiq+2Hf9cw9aOY5fsmJjhFhJ0xV4B8M1EPlCbCVoWwgPmQJ4
         vLWG1Tfx0qJze72gm/1Lp3LNDYDHEptXflx+siLO0iilJ6CQw1+bOFv+25bFqjdXFDRY
         KxbQ==
X-Gm-Message-State: APjAAAUAIHJipGa0DLJHpN/WPpZDE3azqIvkfIdHVk2q2ZMryaUMKQXw
        X2+HMaSBRH5axa00U9NqeUQ=
X-Google-Smtp-Source: APXvYqxZnf7wuvsYx6rc7n9LV+ak+Y5ZgJ6tGFna3vUyQJDsA0U1kdpxoRZG+Ga+NTvx5PN9JuwfgA==
X-Received: by 2002:a65:6259:: with SMTP id q25mr44651901pgv.103.1554291475107;
        Wed, 03 Apr 2019 04:37:55 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id t5sm17360276pfh.141.2019.04.03.04.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 31/32] sha1-name.c: remove the_repo from other get_oid_*
Date:   Wed,  3 Apr 2019 18:34:56 +0700
Message-Id: <20190403113457.20399-32-pclouds@gmail.com>
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
 cache.h     | 18 ++++++++++++------
 sha1-name.c | 35 ++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 3718b3db8a..871a167bf8 100644
--- a/cache.h
+++ b/cache.h
@@ -1381,12 +1381,11 @@ enum get_oid_result {
 };
 
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
-#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
-extern int get_oid_commit(const char *str, struct object_id *oid);
-extern int get_oid_committish(const char *str, struct object_id *oid);
-extern int get_oid_tree(const char *str, struct object_id *oid);
-extern int get_oid_treeish(const char *str, struct object_id *oid);
-extern int get_oid_blob(const char *str, struct object_id *oid);
+int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
@@ -1394,6 +1393,13 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
 
+#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
+#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, str, oid)
+#define get_oid_committish(str, oid)	repo_get_oid_committish(the_repository, str, oid)
+#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
+#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
+#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
+
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
 #define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
diff --git a/sha1-name.c b/sha1-name.c
index b94d381bef..d49496397d 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1590,43 +1590,48 @@ int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
  * commit-ish. It is merely to give a hint to the disambiguation
  * machinery.
  */
-int get_oid_committish(const char *name, struct object_id *oid)
+int repo_get_oid_committish(struct repository *r,
+			    const char *name,
+			    struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_COMMITTISH,
+	return get_oid_with_context(r, name, GET_OID_COMMITTISH,
 				    oid, &unused);
 }
 
-int get_oid_treeish(const char *name, struct object_id *oid)
+int repo_get_oid_treeish(struct repository *r,
+			 const char *name,
+			 struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_TREEISH,
+	return get_oid_with_context(r, name, GET_OID_TREEISH,
 				    oid, &unused);
 }
 
-int get_oid_commit(const char *name, struct object_id *oid)
+int repo_get_oid_commit(struct repository *r,
+			const char *name,
+			struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_COMMIT,
+	return get_oid_with_context(r, name, GET_OID_COMMIT,
 				    oid, &unused);
 }
 
-int get_oid_tree(const char *name, struct object_id *oid)
+int repo_get_oid_tree(struct repository *r,
+		      const char *name,
+		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_TREE,
+	return get_oid_with_context(r, name, GET_OID_TREE,
 				    oid, &unused);
 }
 
-int get_oid_blob(const char *name, struct object_id *oid)
+int repo_get_oid_blob(struct repository *r,
+		      const char *name,
+		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_BLOB,
+	return get_oid_with_context(r, name, GET_OID_BLOB,
 				    oid, &unused);
 }
 
-- 
2.21.0.479.g47ac719cd3

