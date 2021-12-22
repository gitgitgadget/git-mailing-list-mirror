Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A1C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhLVENT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbhLVENM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64628C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so724804wmc.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjdJgqIUFRTUGDi16t21ACoMJsjsOXd9hjsNFWXUjKo=;
        b=S80xSQRRgCC5V15LphJ6Pv5Zl7KhW+pECj0JVC8VktTnKSsxie008UzGEBHSUQd0U5
         x4YktDG0T8/z6CwexVwRjEWQ9A2Pp2uutiV8Db7ysNp0bROmhBjvbWgDaK9s0TNb9NB0
         ENe/3rtY8gIJ4WEvPNqiW7Z7Rax/q+27dKyFqrwjk2B879tjYjgey1yJc8Be25z4ClVI
         dXPzNQa5OTP1lL7jdVj/DD25OAuYEShkeTQNSJLRFL5gboFOp2UaE1WkdGVRLWhY6ozE
         NUcZ8jBv9wE7IUw02zbnU927K6qXK5/swMwROLuJOqN7QhW8Bp3+qfE8uqnMK75XWpjG
         2ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjdJgqIUFRTUGDi16t21ACoMJsjsOXd9hjsNFWXUjKo=;
        b=Jx4i9E6hdXF6UjxxiAkLqQ/VQKOA0xPgZsba4xP7qVhvFCOEcFvCiwATbKrlPgCL7M
         534+IbXJNaHThlGRnWCii5ijBR7piehZO7EVpZE6x8+QJ4jN9/eafegxr1SDYyX8ZEDB
         s7QsHTolP9yGitQDWQKjSZ72l+sQo2fDBNUVEB6288PikAW7Qgsk1nV6llMfLDkn+WDm
         n/BFbgfVSxpy46Zq7leWIDNeKNWjt/8aXzBVIz05B4dHYozS43rXCSQjZi6EoonooBOe
         RbUoW+eEDDfCRule1rUJiRqIMSKG1JfA/kAnzggphfjasvvatDe8PlL3l4X3+4rtX0+5
         VU1w==
X-Gm-Message-State: AOAM531mG7GwdXqhULG9bjWTAgu59eCzDeee3yku7ZqF9xfGsQ0kBsms
        vXVl7AkFjvXW9PDwJuHvsoFY/d8YRxyicg==
X-Google-Smtp-Source: ABdhPJwJNH+E8rDZo9YLRW7auojubYxtAZfkFD2hSwRo5MUQj2x7W6T/hWakPbRqLCJzFPECt1wENQ==
X-Received: by 2002:a05:600c:600c:: with SMTP id az12mr790198wmb.86.1640146390799;
        Tue, 21 Dec 2021 20:13:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/10] cat-file: move "usage" variable to cmd_cat_file()
Date:   Wed, 22 Dec 2021 05:12:58 +0100
Message-Id: <patch-v5-05.10-2d90c12fe7b-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no benefit to defining this at a distance, and it makes the
code harder to read as you've got to scroll up to see the usage that
corresponds to the options.

In subsequent commits I'll make use of usage_msg_opt(), which will be
quite noisy if I have to use the long "cat_file_usage" variable,
there's no other command being defined in this file, so let's rename
it to just "usage".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1df7f797cb6..6d0f645301b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -618,18 +618,6 @@ static int batch_objects(struct batch_options *opt)
 	return retval;
 }
 
-static const char * const cat_file_usage[] = {
-	N_("git cat-file <type> <object>"),
-	N_("git cat-file (-e | -p) <object>"),
-	N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
-	N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
-	   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-	   "             [--textconv | --filters]"),
-	N_("git cat-file (--textconv | --filters )\n"
-	   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
-	NULL
-};
-
 static int git_cat_file_config(const char *var, const char *value, void *cb)
 {
 	if (userdiff_config(var, value) < 0)
@@ -664,6 +652,17 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	struct batch_options batch = {0};
 	int unknown_type = 0;
 
+	const char * const usage[] = {
+		N_("git cat-file <type> <object>"),
+		N_("git cat-file (-e | -p) <object>"),
+		N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
+		N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
+		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
+		   "             [--textconv | --filters]"),
+		N_("git cat-file (--textconv | --filters )\n"
+		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
+		NULL
+	};
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
 		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
@@ -700,7 +699,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
-	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (opt) {
 		if (batch.enabled && (opt == 'c' || opt == 'w'))
@@ -708,35 +707,35 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 	}
 	if (!opt && !batch.enabled) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 	}
 	if (batch.enabled) {
 		if (batch.cmdmode != opt || argc)
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 		if (batch.cmdmode && batch.all_objects)
 			die("--batch-all-objects cannot be combined with "
 			    "--textconv nor with --filters");
 	}
 
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (force_path && opt != 'c' && opt != 'w') {
 		error("--path=<path> needs --textconv or --filters");
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (force_path && batch.enabled) {
 		error("--path=<path> incompatible with --batch");
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (batch.buffer_output < 0)
-- 
2.34.1.1146.gb52885e7c44

