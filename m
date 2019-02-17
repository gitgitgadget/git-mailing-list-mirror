Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E861F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBQKL1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:27 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35472 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:27 -0500
Received: by mail-pg1-f170.google.com with SMTP id s198so7008877pgs.2
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/Cj9bOgniwdLrXYD/VonptaCkLGW8sxgM0HLPyTfIw=;
        b=N4jEmX0uTmsizTctMMZc6mB0hL2YIo4H0vY1bTTMhDYScykQGkgtLz5Ldi2WRLcSXT
         JbETDWbySnswGF7cEJFVdHhJzLwkmYXUhgD64neirplQI1b1OEo4/W8lGiSd8cq2JW7s
         fyerTpFBB217mhgTlyJ+r4bR5C67Szrc6FvndMN2p6Tq+vJqgSytvQ2KQDHV2TJhh2CL
         TNnt3WbJWXn/+scaJHPOgQieNcTcdnPhjJzrjEMGEx4EQ3JfYDmVMXTjHPvGHEeEsh5q
         gZ/MbwdnMVu2FpdDyJqblEgCh/aTYeo1Zn2JhCdCY8ym6A9VU+iHlpzNSRfKghWW2pl4
         +kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/Cj9bOgniwdLrXYD/VonptaCkLGW8sxgM0HLPyTfIw=;
        b=oYQJP9rhF4BWmcUFiwJQqQKYotmO3CwJe3wjKMTSDS3mYusaK0qmofdW0xfykJ6hmT
         aRYFFnXLSbere9sRSGxf9d2tkF7LdhLKSSCIuABWmcEICGCF+rq4XIogKMb8j7kHTRLT
         +Z+zgAzF6Whk+w6veCB3J2jUG8Fr2+p3Q/bsFBHKEu5jv+CFHuZkbs0ADpjjaGvNbqAs
         Xsk5yJbg1irM6RmQP8dwp5hQvc9J/5gKp0M2Zl2U3JMr5K9ETUgJbc0YT5tXXQU79Bmn
         knJgP6YkjiNhJulilmH5auMwTBCAHh7VJtE6/GSXc+dcsOMxnZH5ooGLO8wVy8ISGLzt
         hODA==
X-Gm-Message-State: AHQUAuagt9WIIBnFNTrX8tB0JqyfpnxyHid0M3jHx9acn8SAeMVfpkMc
        tCNaot9wi5ZB2nvduV6eJtn93Ann
X-Google-Smtp-Source: AHgI3IaanZlsGDbQ19F3rK3er0BWwvserQnzMEVSka7RzfViQc2gXADWewk0Qh/9AW+XImzqL3qtlw==
X-Received: by 2002:a62:57dd:: with SMTP id i90mr18639802pfj.154.1550398286123;
        Sun, 17 Feb 2019 02:11:26 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m67sm19682027pfm.73.2019.02.17.02.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/31] sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
Date:   Sun, 17 Feb 2019 17:09:11 +0700
Message-Id: <20190217100913.4127-30-pclouds@gmail.com>
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
 cache.h     | 4 +++-
 setup.c     | 7 ++++---
 sha1-name.c | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 942d9912a2..da7035c261 100644
--- a/cache.h
+++ b/cache.h
@@ -1361,7 +1361,9 @@ extern int get_oid_committish(const char *str, struct object_id *oid);
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
index ca9e8a949e..a56df63d1e 100644
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
2.21.0.rc0.328.g0e39304f8d

