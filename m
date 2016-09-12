Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A815C207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755824AbcILVIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:08:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35103 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932429AbcILVIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:08:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id c131so70324wmh.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kRecPACs+S8lDUZ0uTjqzMUdSwkXfT5g+E/J74aoaYA=;
        b=oolZDu2o7DcAHDfM3OOWp3BCZMRKhrXH+uJoVamFLTk/dgBh/pAcRuVOEvkIClqjsj
         hOZfykoplJMIFJvSjp3Q6DQTekbwjx65rOr7q86ad7T64pfWWsyHgWqa35Y4XVEzH+jy
         3rOemH3gqshoOEBOciPwONeAL2WjspimPJmrsNxxkleWVPq0eqZBcV2egKuIf1uRhi/z
         Zf7Lxi2cF8sjUr/4buDQ3VUK1DLFBPD4ctuHrvfWHXUjkd+H7KuUesOENm6Gqvt4xgLP
         5NXD3uMfLsjKNu+J6W25ESiJYajUovYRd2Jlo6zoNOcSSjMccmx/wHEzHC2G9NeEvCIc
         Ysvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kRecPACs+S8lDUZ0uTjqzMUdSwkXfT5g+E/J74aoaYA=;
        b=VgAq2oRDBfLB+cemD9wIsDqGSGMB+mmuo9fvP8a1LPRmaKtLFq6TPi0R4nYLTQfG4L
         iS9lweIvJ23EtbpJtgROgKroyX6V5X0UTvTlXzqkn2Fr0Qm+ZAHC0PNQ6WLGq4u3ypgK
         ml09ypWPCq0Tw0qdJFeDJ4gEf1l46JgzycRtZebVDfVn0gxQUpFXiYIk9vO9BvPhegX4
         jV7iqI2KLizGb+YtgJ7vcWiT764ziWN9J9WOsETLSLrYnqZ/LnOEjMXw4JlWhb7BT50C
         z7SqLSRYA5h0cmRtYbHI5ZLmfbjaXfkgq6fPKmu/w+3pkdJFPep4+cuuRVkBkcFnh+X1
         v4+w==
X-Gm-Message-State: AE9vXwMobapDCZVTmkNKbslv5gET5ecw4KoigvNxvJ3A7q+zwJ8kdmJV9FnKgoiUpV2IqA==
X-Received: by 10.28.46.134 with SMTP id u128mr13296288wmu.41.1473714527980;
        Mon, 12 Sep 2016 14:08:47 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id vh6sm19657814wjb.0.2016.09.12.14.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2016 14:08:46 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/4] update-index: use the same structure for chmod as add
Date:   Mon, 12 Sep 2016 22:08:16 +0100
Message-Id: <20160912210818.26282-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160912210818.26282-1-t.gummerer@gmail.com>
References: <20160911103028.5492-1-t.gummerer@gmail.com>
 <20160912210818.26282-1-t.gummerer@gmail.com>
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
 builtin/update-index.c        | 39 +++++++++++++++++++--------------------
 t/t2107-update-index-basic.sh | 13 +++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba04b19..6d6cddd 100644
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
@@ -789,12 +784,16 @@ static int really_refresh_callback(const struct option *opt,
 }
 
 static int chmod_callback(const struct option *opt,
-				const char *arg, int unset)
+			  const char *arg, int unset)
 {
-	char *flip = opt->value;
-	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
-		return error("option 'chmod' expects \"+x\" or \"-x\"");
-	*flip = arg[0];
+	int *force_mode = opt->value;
+	if (!strcmp(arg, "-x"))
+		*force_mode = 0666;
+	else if (!strcmp(arg, "+x"))
+		*force_mode = 0777;
+	else
+		die(_("option 'chmod' expects \"+x\" or \"-x\""));
+
 	return 0;
 }
 
@@ -917,7 +916,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
-	char set_executable_bit = 0;
+	int force_mode = 0;
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
@@ -955,7 +954,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			(parse_opt_cb *) cacheinfo_callback},
-		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
+		{OPTION_CALLBACK, 0, "chmod", &force_mode, N_("(+/-)x"),
 			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			chmod_callback},
@@ -1055,8 +1054,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
@@ -1100,8 +1099,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index dfe02f4..32ac6e0 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -80,4 +80,17 @@ test_expect_success '.lock files cleaned up' '
 	)
 '
 
+test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
+	>A &&
+	>B &&
+	git add A B &&
+	git update-index --chmod=+x A --chmod=-x B &&
+	cat >expect <<-\EOF &&
+	100755 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	A
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	B
+	EOF
+	git ls-files --stage A B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.0.304.gf2ff484

