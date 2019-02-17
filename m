Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE27D1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfBQKJq (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:46 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:40013 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:46 -0500
Received: by mail-pf1-f171.google.com with SMTP id h1so7070727pfo.7
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6c0YYaTiSCvynTUcNcOYJQDu8wL3n9xBsL373pmPOC4=;
        b=f0TxTIyUMlyvnxtCKb1kNrhFSp2XerjGnXQwe0N+HFAu800W9I4OWoRJx/j5Xi4QNp
         w8T9jnlzGF5P5WqA0+Bqxkqwng0HV6TCJbBMTGaGlDX8iH+I9yowZjZPYE9cdVolCXdm
         PEf+Cp7ekFOujkiZmTQxBqKSYGexm4eaiWokhoi93DklUi5dChPC//z20kSVkCUAu+rS
         uUHxNNJuQMEigMehlt1RBjGBv2ltoZl8Ltt8Nd+/HfzZ6mUYiA26n7VtRaIg07BLAUgI
         9NBEBbVWvQLNgjO+SLhuEeX3G1Px2O4qjT3OjegRg8SasBDyGiRLI5+w30XFJxFCrh9U
         vCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6c0YYaTiSCvynTUcNcOYJQDu8wL3n9xBsL373pmPOC4=;
        b=QSjqUPEVVdd6a5/oZK/pXfy01WleeZbxnWKcQZ0uFRHkM8nFhw8Mta3IUu6nF5FJ4a
         FRPZJiRfUpn+ImCLUW8b3q2SEIPrA/tin7GE9kY1rmAnksFyDYkjUO6kCy5anEAAqNtq
         K+lpB5mbcX/MbzWzQTDByaR48Gix4wc0vdr0Q+XYz/16VvnH4szJzPPwwepHl9INJSiR
         ek3yB8UA3kdwzeqR06YwrnFvyjNxZnUzPC7oBxWm5A1quTl01loq6MdXXL5eVQheKZ1r
         pfqsZniBPkCD7KBsQ362ZCCEUGpxjybpCp/E2N9CJxwyqTBszdLOWuJ6JqJPw14SKn2Z
         7BTg==
X-Gm-Message-State: AHQUAuYctsHD+XxO2e0yo+EXFj2MFPU4CMNliVHsQUt3uVeINndxVgmq
        /UcLMPX03qpqn8vVRQGu/j8/aCQB
X-Google-Smtp-Source: AHgI3IZ8zLqcvPVJdM3xfu2PSjG+knXOObYHy0l/eiXZRCF/wwPfUHiZ6gS6Q7crpYrpmwnrzO9Y9g==
X-Received: by 2002:a63:e74e:: with SMTP id j14mr13730148pgk.449.1550398185225;
        Sun, 17 Feb 2019 02:09:45 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c13sm18353125pfe.93.2019.02.17.02.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/31] refs.c: add repo_dwim_ref()
Date:   Sun, 17 Feb 2019 17:08:48 +0700
Message-Id: <20190217100913.4127-7-pclouds@gmail.com>
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
 refs.c | 12 +++++++++---
 refs.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1f5864aa36..bd0fec5776 100644
--- a/refs.c
+++ b/refs.c
@@ -555,14 +555,20 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+int repo_dwim_ref(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **ref)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
+	char *last_branch = substitute_branch_name(r, &str, &len);
+	int   refs_found  = expand_ref(r, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
+int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+{
+	return repo_dwim_ref(the_repository, str, len, oid, ref);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index b630d5bde7..fd3dc1d0f4 100644
--- a/refs.h
+++ b/refs.h
@@ -149,6 +149,7 @@ struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.rc0.328.g0e39304f8d

