Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1605A207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755570AbcIKKad (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:30:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36086 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbcIKKaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:30:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id d7so1659237wmi.3
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ropdQviLij5ULgb3tADRelkVhWGba+25u4dsATKomy4=;
        b=cwjs+UxGb1CR1HUCwUzuiKnyyXmfzTdBqiXZWdzrAcxe3tqohwwJHHRIquaz1wI5cJ
         dPzeRl/8n0xEZyG8HS/3RXLZzcgA/Inb28aRkFvqjcec5OExEz/8RKHgF++8UC1VcHTk
         sVtT6eu2F+CIV8yOzm02wpphzD6ymwmPcrA/yTd/W3NOZHqqK4y0I4U7UGM5qrbuNMeF
         Zc7Ciy66bX9CMm2TcCfPwhmXbF6HqmtEt5GyV4KKhApE5ttCfSLAOuzlIlLmp60bPYAv
         yL5fnQkHDJ8jMxBPGIqAtySWVqPLiKNBRUZFPCOGcyBAW8qMTssm5+bId4xJoJECn765
         k/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ropdQviLij5ULgb3tADRelkVhWGba+25u4dsATKomy4=;
        b=CSCYlYu4D4nc+ViVtMtrZ4iGxqs04FdRRpC6B5EgfJic9cMSaxqdGD6+XdfDiwNc8m
         Bk2MnDyIrgbEDQHOmKRTbZ1ZPpAfRGgLwUaEHDT7J7Xl/RCEDZKxJB/9qGEVoBXHgCTs
         LGpBSjp4QSDZENCv6HV2sVuAsdqhH4Ek1NexSB+rpN94oolAbssve3UJUSHpX6crE4/s
         +hnKCNHmb32f1gz/3YT4ceTgIOo/L4D2VzOJXgg3HGYyES2p4UNlttmachbnhV2HTal/
         UKzQUqUILWXCwQarBdBXQ/YOje1p42yuSmU5WepTe6cfnV6iVZqCxcK9K928cEFuhYSW
         Iy7A==
X-Gm-Message-State: AE9vXwOCJJeNsQRUu7EyPxH0uZqDI+jGzAIzA+HQSdBL+UrIRCF/NkRgMrQcqzYwf7V7zw==
X-Received: by 10.28.111.4 with SMTP id k4mr6377276wmc.94.1473589828259;
        Sun, 11 Sep 2016 03:30:28 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b188sm12269478wmg.24.2016.09.11.03.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Sep 2016 03:30:27 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/4] update-index: use the same structure for chmod as add
Date:   Sun, 11 Sep 2016 11:30:26 +0100
Message-Id: <20160911103028.5492-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160911103028.5492-1-t.gummerer@gmail.com>
References: <20160904113954.21697-1-t.gummerer@gmail.com>
 <20160911103028.5492-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the chmod options for update-index and the add have the same
functionality, they are using different ways to parse and handle the
option internally.  Unify these modes in order to make further
refactoring simpler.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba04b19..85a57db 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -419,11 +419,12 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	return 0;
 }
 
-static void chmod_path(int flip, const char *path)
+static void chmod_path(int force_mode, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
 	unsigned int mode;
+	char flip = force_mode == 0777 ? '+' : '-';
 
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
@@ -432,17 +433,11 @@ static void chmod_path(int flip, const char *path)
 	mode = ce->ce_mode;
 	if (!S_ISREG(mode))
 		goto fail;
-	switch (flip) {
-	case '+':
-		ce->ce_mode |= 0111; break;
-	case '-':
-		ce->ce_mode &= ~0111; break;
-	default:
-		goto fail;
-	}
+	ce->ce_mode = create_ce_mode(force_mode);
 	cache_tree_invalidate_path(&the_index, path);
 	ce->ce_flags |= CE_UPDATE_IN_BASE;
 	active_cache_changed |= CE_ENTRY_CHANGED;
+
 	report("chmod %cx '%s'", flip, path);
 	return;
  fail:
@@ -788,16 +783,6 @@ static int really_refresh_callback(const struct option *opt,
 	return refresh(opt->value, REFRESH_REALLY);
 }
 
-static int chmod_callback(const struct option *opt,
-				const char *arg, int unset)
-{
-	char *flip = opt->value;
-	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
-		return error("option 'chmod' expects \"+x\" or \"-x\"");
-	*flip = arg[0];
-	return 0;
-}
-
 static int resolve_undo_clear_callback(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -917,7 +902,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
-	char set_executable_bit = 0;
+	char *chmod_arg = 0;
+	int force_mode = 0;
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
@@ -955,10 +941,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			(parse_opt_cb *) cacheinfo_callback},
-		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
-			N_("override the executable bit of the listed files"),
-			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
-			chmod_callback},
+		OPT_STRING( 0, "chmod", &chmod_arg, N_("(+/-)x"),
+			N_("override the executable bit of the listed files")),
 		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
 			N_("mark files as \"not changing\""),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
@@ -1018,6 +1002,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(update_index_usage, options);
 
+	if (!chmod_arg)
+		force_mode = 0;
+	else if (!strcmp(chmod_arg, "-x"))
+		force_mode = 0666;
+	else if (!strcmp(chmod_arg, "+x"))
+		force_mode = 0777;
+	else
+		die(_("option 'chmod' expects \"+x\" or \"-x\""));
+
 	git_config(git_default_config, NULL);
 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
@@ -1055,8 +1048,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
 			update_one(p);
-			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+			if (force_mode)
+				chmod_path(force_mode, p);
 			free(p);
 			ctx.argc--;
 			ctx.argv++;
@@ -1100,8 +1093,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
 			update_one(p);
-			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
+			if (force_mode)
+				chmod_path(force_mode, p);
 			free(p);
 		}
 		strbuf_release(&unquoted);
-- 
2.10.0.304.gf2ff484

