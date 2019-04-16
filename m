Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DD820248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfDPJhp (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfDPJhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so10125818pfn.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va64poPpWA16JtjiXIMrc3aVLhyLbIhGt6IpUiZ9XVM=;
        b=frLlv+f7JT87fbRn19Unyq4pKIQGdhT8Vl45JXqlxSsYAtq6SCQFY5g7f+4U+Icv6J
         lU8gc/4qrHfZ1usdAge3X1bMfIWhTcR4q2FGEVmjIg5zGrxjebTZVLs5n8k8SVMwE9Dc
         hJYpTUgOzAHZE+YCAnBBvKvT+g6uxw9TWZkYOLJ71mBauv2EH+W14djo7Qquf5ywlbqF
         9b2CEeRKXYwyeTU6URZugYpwgmYhDU5+oYpxtyHvPYatmiVnYVK+TiYxV1oxPVSiZ7wK
         hSCLo1GlPQaSBJC78dIM3yxMGuXet6Do1XmhtOq3uvJdig7ULY1Eaw4G2H7qyGxOgCOB
         Zgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va64poPpWA16JtjiXIMrc3aVLhyLbIhGt6IpUiZ9XVM=;
        b=isvKVJckD5pJIkqST45UGUg/lrIkRa98NG7TKWyCJqpYoJzhSff4/uMhYsQYzgh3Al
         hNHVX1jJLWw37RKs9s9F9MhkpAXouyjpMnZYrG6cuRusdxukV3ekcL9oAxq7HNlveqoB
         3bnR1yD+EJ4A5PtFM6PkCSRSW5N7NpbohneT3jaZkyGsV5IYcu0OvEcg/8rw8wH3i+CH
         VcmNNd10kYOHVFzw9ZZsPuBZHC/5Z0TqWtBmaBdiXXQgu6eeLw2n6SPr9dneeVIVl8ul
         J/DItqKFYTs0SuLH0gP/69s8sPaCRnHZMs1dL2rHS5iZvMf1r0e+JxNBIENGkpH+nXAy
         djqQ==
X-Gm-Message-State: APjAAAVqpUoB77J3ckFUAe+KGob5USAhg2zKfw6aJFczPmIx5n7rxXP5
        JRhaIiO/0DunW1EdUdaz0po=
X-Google-Smtp-Source: APXvYqz7hbtvLw+zKiKAdgnwLFIfKVpq5bOt/PAakUvpIG1iPJXLje8Rps/C3ZPuWQqEfvuHFuHgcQ==
X-Received: by 2002:a62:ab12:: with SMTP id p18mr80710075pff.216.1555407464903;
        Tue, 16 Apr 2019 02:37:44 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id c25sm73940890pfo.69.2019.04.16.02.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 32/34] sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
Date:   Tue, 16 Apr 2019 16:33:39 +0700
Message-Id: <20190416093341.17079-33-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

