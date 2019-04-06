Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A61620248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDFLiE (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:38:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40121 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:38:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so4759333pfc.7
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiTcqjXHjS0GDmkL0Ayotb8v1V1CzkGfFwAIuM5mr9Q=;
        b=CtgFRSTBvpMaXovJwzJ8yhUcDFMW3mXFISNw8v+ZNBLWK5YSusZxwTPIIMy+zjiHlJ
         vqAyVzWwz2L5Gww9I5DOCKMvew7KehLyHaCBVwoypT2FdSDo4YL3XpLJyQ16+frTPxvb
         8yknCscuTm7qPcY4a3oBv5orSP9Cn7NoISTrs6IaH2Dm3iwMFSB8f9OmmXlt6hS/jkeh
         hwD07tJ7ChUBV8rNGcWtkqiyuU6gJ5jaZ1fig0NFBaWa8WdQI/etEefYwQTDvHDIRrhU
         VxOsPGY9eUv6i/lW4ZeSPEJ3cu8K4zmjGh5eiZb0opmw/O5bGp8Ypmbzq5sZGMiuCgsk
         vv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiTcqjXHjS0GDmkL0Ayotb8v1V1CzkGfFwAIuM5mr9Q=;
        b=aWw2nnCruBBXVtPrTj3g3QAZxWts94uWUYZhDX/lJSuBWDNAB+tlfYH2uX2jOSa+z8
         zKGEErYRJ2dDsnetunKQCtqfFxOAIFOfPp3ckgwtcrxjzeSYwk/Jcu68qlLuKxb4WfLk
         g4JzwlRe2kj1WrFGMDvG/CtJ57JdULF4gQrLEUDh432CDKPgVEWe4vWXbcKEyk6xoGjs
         wBYP2JSAHQEoYz9wuW2DmvL91Ip7DSfqqZtbLonY1xnpT3kSmXpUKLKgkFA500MVzxPZ
         BaaNOSJfZNhbM5Z/4F0haF+teWsYJJ9S7gHYpHvv7eS/63kwd90SlinP2TLbtMVNtSHO
         ne/g==
X-Gm-Message-State: APjAAAVIcsBBpyEOJF7okQdwTPQpSbHaEkXfHFdjhJ1ywmNS3V8Helzc
        fHYoNlCxpfY6zE8prW2lJfI=
X-Google-Smtp-Source: APXvYqwSUty6FLsSWoRWYUi8cz6rdGsHCpv6dz0NDZVPshsEyuBlz357sUjSfPxlAVYiFGvhRnZ14Q==
X-Received: by 2002:a62:2687:: with SMTP id m129mr18001873pfm.204.1554550683395;
        Sat, 06 Apr 2019 04:38:03 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id m16sm60924750pfi.29.2019.04.06.04.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:38:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 31/33] sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
Date:   Sat,  6 Apr 2019 18:34:51 +0700
Message-Id: <20190406113453.5149-32-pclouds@gmail.com>
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

