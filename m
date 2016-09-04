Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0755020193
	for <e@80x24.org>; Sun,  4 Sep 2016 11:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbcIDLkP (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 07:40:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34522 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbcIDLkM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 07:40:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id v143so9135898wmv.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ropdQviLij5ULgb3tADRelkVhWGba+25u4dsATKomy4=;
        b=BltPgXlMGATCr3oIiOvEI2op90F2rotrCT4+FEmYajYqHWENEiTSDNta3mmCaA45Jq
         XYC3z7DauWLZDW+dvhQufevk0Jmgg7d6n9lZbkuYq8UsZ6Z4TzWhXmme9B3yGPVsaKN3
         NdHqzn0JlkYYRauXIjeykkVBbIP8zrVqUnXxDlawze1vioAVgc0MDjT92PUq3F8Qd/he
         py0+joBQsFmatKXEKZs3A+bljqmr4e3eUp4ul+0kjrzpDlzx29OG2zLw8I4N54tQJK2r
         g2pT8/2gZaw9DB6xgdUHHq6SwA2I1o6SEiQVk0iEzsjlFN//pFOAUpnQ/j+d/a6itMRm
         js8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ropdQviLij5ULgb3tADRelkVhWGba+25u4dsATKomy4=;
        b=ZaDOi/v8qe1keBqVMEw9/EHpVy8jGm0w7xobnQnbW/naw2U2QOCGZshSPxZ0bFJoeb
         T/FHY124507t7oe/pf49rAR99Xy7n7qNkEVLjnZOSUYsu+aey2AdsaVbM98WlDNrI96d
         /mQV/hhSwcIpUGKC8zcoQ019sCq/EKXYXpsTBc1gEoGNJXjWMtmsKy2vCrh7hOYfUjvu
         xutWWzG2SJ/xXNuZN1Y/sCghIgf9oIhYBKlBKxyBx2QOiUAFo5p41E040STNwCzXiBqZ
         lZuQT7mM/IDKfy4lUH5UvgJvKfRj7niQEbUmfkcYr+xr4Wze724uIucBYXBMHmdMMmUF
         hcqQ==
X-Gm-Message-State: AE9vXwOi+5XFNq9EL3OfMZg0qKbjsD5C/uHerzA3TvjpG+Cm4XwyfVdEezzVjmXw+5S3XQ==
X-Received: by 10.28.198.142 with SMTP id w136mr11205968wmf.30.1472989211064;
        Sun, 04 Sep 2016 04:40:11 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id t202sm13819512wmt.22.2016.09.04.04.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Sep 2016 04:40:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/4] update-index: use the same structure for chmod as add
Date:   Sun,  4 Sep 2016 12:39:52 +0100
Message-Id: <20160904113954.21697-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160904113954.21697-1-t.gummerer@gmail.com>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
 <20160904113954.21697-1-t.gummerer@gmail.com>
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

