Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D558120248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDCLhu (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42679 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so8005308pfn.9
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiTcqjXHjS0GDmkL0Ayotb8v1V1CzkGfFwAIuM5mr9Q=;
        b=rRZ7WEGpiG4gEpbx85OphNAYR1I0V+WoF6J5IE57zcEGkYMhlxo3oA9YYmNtwC2hmf
         fk4waJ+hk/eX0D/mylHkbTRLkYMf5U0ikdNmbcEm19SUZJ8SvGOc1T9qTL0c8GTRWgRm
         eSczc9azZzHSAgiCItvc0aO0+BxnBdOi+PnVY67HLdhl+aOBstIThyuglFo6TaygC6n7
         ksPzXEWXAsXYlnb2CHAJxcQ0NeQSw4yAEOwr7+L4ldvOrLYFyvis2J59gIJia88E1SQR
         5YR6pyWYcu2ZnEw0tx/Iyi9LVJ1Ijt1flbNUk5/vl4gQZ4kh5ZwKyWi6zr7YFH/HQHd5
         HeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiTcqjXHjS0GDmkL0Ayotb8v1V1CzkGfFwAIuM5mr9Q=;
        b=kJSX9/yRshxZ7gDGlt9XI1EC7rauEInwic1Lr/o5qR6jke+mDQ8zFl3GeZozI3RL46
         aiNekdIpiLOa6Z6wMDmA3O2MEwDsp5XC0C2J2TiTodg3t+1wNaGs4jMo/CKrQRJABS77
         IbvIWzAuRZKUyFPziVHhQLh4TrCLfkleDd+wIR7FbRGdcehbw3aHw0ALLFyxodgg5On6
         LwL2CppoRB8SSPjaWKgqlvAtPX7NIAzs7Fgh3TH55lrQ0RPGsxcolcDTMCGpiZkGsKlh
         CSGjLDIVhW9uvVWtNJYNJbksouurClQI4WQwjSORVsQ9vFoZfgfb6fcr6riobGTQy9c5
         xO4A==
X-Gm-Message-State: APjAAAUqsNYiDWQc/kdokz615xqCBaIXak8IVqWlcELwPNzlCgN0qvYI
        zgp+wJK5qgW7immXbJTgEVY=
X-Google-Smtp-Source: APXvYqxYAGZl5LVM6hGVWMjENzHR2hlpwjGoljgteMBU+WFMF3yI1lOJbzBSb84WlCFg2shygJAMxg==
X-Received: by 2002:aa7:91d5:: with SMTP id z21mr43314056pfa.222.1554291469541;
        Wed, 03 Apr 2019 04:37:49 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id u26sm22756423pfn.5.2019.04.03.04.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 30/32] sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
Date:   Wed,  3 Apr 2019 18:34:55 +0700
Message-Id: <20190403113457.20399-31-pclouds@gmail.com>
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
 cache.h     | 4 +++-
 setup.c     | 7 ++++---
 sha1-name.c | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index f6e87194d0..3718b3db8a 100644
--- a/cache.h
+++ b/cache.h
@@ -1387,7 +1387,9 @@ extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
 extern int get_oid_treeish(const char *str, struct object_id *oid);
 extern int get_oid_blob(const char *str, struct object_id *oid);
-extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
+void maybe_die_on_misspelt_object_name(struct repository *repo,
+				       const char *name,
+				       const char *prefix);
 extern enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
diff --git a/setup.c b/setup.c
index d0c958c3b2..8dcb4631f7 100644
--- a/setup.c
+++ b/setup.c
@@ -164,7 +164,8 @@ int check_filename(const char *prefix, const char *arg)
 	die_errno(_("failed to stat '%s'"), arg);
 }
 
-static void NORETURN die_verify_filename(const char *prefix,
+static void NORETURN die_verify_filename(struct repository *r,
+					 const char *prefix,
 					 const char *arg,
 					 int diagnose_misspelt_rev)
 {
@@ -179,7 +180,7 @@ static void NORETURN die_verify_filename(const char *prefix,
 	 * let maybe_die_on_misspelt_object_name() even trigger.
 	 */
 	if (!(arg[0] == ':' && !isalnum(arg[1])))
-		maybe_die_on_misspelt_object_name(arg, prefix);
+		maybe_die_on_misspelt_object_name(r, arg, prefix);
 
 	/* ... or fall back the most general message. */
 	die(_("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
@@ -234,7 +235,7 @@ void verify_filename(const char *prefix,
 		die(_("option '%s' must come before non-option arguments"), arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
-	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
+	die_verify_filename(the_repository, prefix, arg, diagnose_misspelt_rev);
 }
 
 /*
diff --git a/sha1-name.c b/sha1-name.c
index 953df0d692..b94d381bef 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1885,11 +1885,13 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
  * exist in 'HEAD'" when given "HEAD:doc", or it may return in which case
  * you have a chance to diagnose the error further.
  */
-void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
+void maybe_die_on_misspelt_object_name(struct repository *r,
+				       const char *name,
+				       const char *prefix)
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(the_repository, name, GET_OID_ONLY_TO_DIE,
+	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE,
 			       prefix, &oid, &oc);
 }
 
-- 
2.21.0.479.g47ac719cd3

