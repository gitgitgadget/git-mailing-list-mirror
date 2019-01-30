Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE861F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfA3Jtb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45759 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3Jtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so10102044pgc.12
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOTyypMQPI0w5imDkHSw/siD/KvMdcntBDq34rgcnrs=;
        b=T9bs1PAdKZnO2iRsSWlpUsVb45lk35wU5DItc1pFPL9uKgs04NzhooEnKlxw+Nzz4I
         6184KOzh3v1NTdJ24xldJ61T//hZg7sui39Ma/2m5TNAXP+sKATxHZ7vmpyfWosPnSCc
         hEzPysIKaZx3yi7K7237W6ijwcHeGIPAUhDdZG3lb35m44Ps6VRuMz4JIfn5lYKquTcS
         WpgML0c4+tauKAgx2z4x6uyMJ7/WiNgNyHYu4d9xZ3osrSSE94ouaNc7J4WK4F/8hGaE
         4cT59mcwpyCBDgVSzd1BsydCGg0tc7Zw41DxxxurWgRQ/r9krYszZq4wyibtC6IHFmzV
         DHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOTyypMQPI0w5imDkHSw/siD/KvMdcntBDq34rgcnrs=;
        b=tHs4+7akJ+w0D4fP1zQDljL5gImxEzmK0ZNkeV1EpfPDQXTSWuDPV3KN1fibU5Elnu
         dYW0lV2zR7Qr1uK5vO9bLO7V6zDDO+VvN77D+8rYpWlYx/S2wKfcyQu4pRSLbGt1DOIh
         +KTCesJwA+4hxfof5Ip1JvV/XSkGMWHQARxfBDxahD7t8Yzx/+aE4oyAw5n7aqJ0gV1z
         r5rXnEbBTwMUPqCgwOYx21ZtwhPNoAspLn9jGRQ5FAzCMQg1Nh6esWL0JuVjfyGssnAC
         dxCz54NlnG3dYe2Nedhd/AgFRgHQSEEn3l/Xap7tVRsGRdlcnc0OJDdBbsf1pBgd+nJs
         A/EA==
X-Gm-Message-State: AJcUukd7bAn2AnGnxd4jleZkqtfk/XrJ8Avc623DHOW/Hz2nqHsSPjla
        nFqJPJdXmGJ5U8U6CZBTs4EKCJoB
X-Google-Smtp-Source: ALg8bN5C1uP2VnHHMXhP3M130bEIDzVhXkvRMIuzUbNxjSOhVffOgsQTPt+4NP83nSATuhAsXWcHLg==
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr30088977pfc.201.1548841770038;
        Wed, 30 Jan 2019 01:49:30 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m9sm5781737pgd.32.2019.01.30.01.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/19] switch: stop accepting pathspec
Date:   Wed, 30 Jan 2019 16:48:23 +0700
Message-Id: <20190130094831.10420-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is about switching branch (or creating a new one) and
should not accept pathspec. This helps simplify ambiguation
handling. The other two ("git checkout" and "git restore") of
course do accept pathspec as before.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index db9a2692db..7906e07352 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -52,6 +52,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int no_dwim_new_local_branch;
+	int accept_pathspec;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1162,10 +1163,16 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1199,11 +1206,12 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1248,7 +1256,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		if (argc)
 			verify_non_filename(opts->prefix, arg);
-	} else {
+	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
 		argc--;
@@ -1564,6 +1572,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1591,6 +1600,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.1.682.gd5861c6d90

