Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F2720248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCHJ7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43020 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCHJ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so13758813pgq.10
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Q5G1kg60+BPx/I0mMQibAvUzW3G054OAC6xxnlnGLg=;
        b=oVLhDVyZdZGqw+wL5rypjR2KVGh0qHijWjhhI9XLRsDDdxJsHIb420fih26gQVWh5B
         X5aRUgBVYvhBEysQrIIhz2cvA0G6cFkaffK2fYXgPJyna+JknSmuenzJc4R+/8aOisTl
         6wpfVnPqlh4hr4/+DbRca+ozVUC80fn5a3KZht9iRvqsQgFxrCFwbKCxLsxwvjUQ7veB
         79UK15JNSHYDMXtCuM6ZVONrc20LqVhorGz5T/AIuPpmIGZsI+v5ViU34iuWSb+z+6a2
         3meSOt9nLvglklI4Owbq9sUlxBufr1m34XhW0yQ+uF++GdOPdxjm9fZtP3pY0sUAslLB
         eUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Q5G1kg60+BPx/I0mMQibAvUzW3G054OAC6xxnlnGLg=;
        b=NDPsJdRnARZc99lBp7PRxBjDCjwtBIDVNMqbk3C/u/3E/rskSdX1j+/lC6bfArrHdf
         JUZdOQ0gIz4AtWlApPh2FzCbwjIuDo3o1JwokJbIEApYSa8/UBfzw7rkLUt57ZvmNxeo
         ktt2u+FfWxndvYOsRQDvxxN2cuYTWnki0PgGEq1a12UNLKbO0H8cPJ18FTEIjLarWU6M
         z43qzT5hNqqeQ+zfEX8kVxdsvtR3q4HXjg6oXRA7PrzcVcgsvR0vB1vxVWBeWKuS9ZcI
         nCBPdH0eo4rR2xsGlN8Y1QvclH0n7iPs9NX7EeHe6CNOMcheUxsncrN859gl09SMBlBg
         t8bA==
X-Gm-Message-State: APjAAAXMXHGfOD3dMamObdaQCIY7FGAc/vaXDPLRJ+Sxqo2Y3UVFO75A
        hdbgP6UQYqndMjVRoUusTM0=
X-Google-Smtp-Source: APXvYqypdoCqsTPLAJBKlsZZRHjDcrRbJ4AjgKIPaMpd9EIuZ5o7FhqQU0uIYjIsneZ63Cu3xpQrAQ==
X-Received: by 2002:a62:3681:: with SMTP id d123mr17698096pfa.242.1552039147864;
        Fri, 08 Mar 2019 01:59:07 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id j9sm13966892pfc.67.2019.03.08.01.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 13/21] switch: stop accepting pathspec
Date:   Fri,  8 Mar 2019 16:57:44 +0700
Message-Id: <20190308095752.8574-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is about switching branch (or creating a new one) and
should not accept pathspec. This helps simplify ambiguation
handling. The other two ("git checkout" and "git restore") of
course do accept pathspec as before.
---
 builtin/checkout.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a731f983c4..1b1181b220 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,6 +53,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int no_dwim_new_local_branch;
+	int accept_pathspec;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1175,10 +1176,16 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!argc)
 		return 0;
 
+	if (!opts->accept_pathspec) {
+		if (argc > 1)
+			die(_("only one reference expected"));
+		has_dash_dash = 1; /* helps disambiguate */
+	}
+
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
@@ -1212,11 +1219,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		/*
-		 * Accept "git checkout foo" and "git checkout foo --"
-		 * as candidates for dwim.
+		 * Accept "git checkout foo", "git checkout foo --"
+		 * and "git switch foo" as candidates for dwim.
 		 */
 		if (!(argc == 1 && !has_dash_dash) &&
-		    !(argc == 2 && has_dash_dash))
+		    !(argc == 2 && has_dash_dash) &&
+		    opts->accept_pathspec)
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
@@ -1261,7 +1269,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		if (argc)
 			verify_non_filename(opts->prefix, arg);
-	} else {
+	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
 		argc--;
@@ -1579,6 +1587,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1606,6 +1615,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.rc1.337.gdf7f8d0522

