Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1451B1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfBPLii (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44821 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLih (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so1254716pls.11
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96BmZKDLDkTkTsNXVRYDSFuD+YjHSWpGmq4aRJAEP4A=;
        b=QMngNw032/GitGTlutsxrW6qUmbz3aC1g6zhy5wS9eQJ8GMh5n4V1mH5eE2A97dEjX
         ihOmQbl+0IOGeq6xxQwsoKEDPvL18jg7n8k8k9w40/HB4eUOSXqOqd7o+D+/44hVRAS1
         pzoy+vgFYRkjtvjw0auvvd1IX35UBd8QESXoyikfSUgwoikbWnifasG8Gyu+5GjmmMgO
         Ya0wt47+iSNcYk2Wk8niCQoB6fhPGBQQsQ8EzOG78BxQW/hEX2JiZ1guoJvmZC0c6OFy
         HY9SuFcVoCv8Cu7YN2lSTCmgdOxU5NLYUlznwDNINiHDN/L9v9ih1tbgrb+7LOpBInZU
         JxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96BmZKDLDkTkTsNXVRYDSFuD+YjHSWpGmq4aRJAEP4A=;
        b=KgRbRvK9T1kQQBkP+F6fQNeYMR5v3y8kZrQpnHMGrDAcFTBK2ka7W0LRD8PfSjDwvq
         Htu7jYDFYssg9/7Grd+e+0cl3T/qDbhpTON0vssb1E7eaqwZGg10rniYl9LK9GY/j9Eh
         9GoLXG+LgVfkc72QYTL7pGhvCUM6+Ft+caoxHv7XDCGc+1WDAELP2iGNk3WsFSQjwp5X
         Z+7CjYQ5E9OtgK264yPHfTM4aphynhHDEUWNYLjQRuh1hC6gqDGx/s8f/qW3eObsLRnq
         Mos2hRBj1S/BGB/a8J7vTtPIzTeuiluzSOVyq27mGohbv9tw9GPIAbLTLe7JdIIGw8YW
         50QA==
X-Gm-Message-State: AHQUAuZlV+YhhWU9MmbrgMfSsBhGpFXBcCW7Wisl6d3feKwokogNf9Ec
        VBEFOXqFX0Q7zXlQsstONpg=
X-Google-Smtp-Source: AHgI3IbHkBtzSpghw/30pFbmeKMr1RtleZLaDsvIP0Xc9TWG9O0AhoGvyXUAQ97tT1HiD3QOi5TlSA==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr15232680pln.285.1550317117357;
        Sat, 16 Feb 2019 03:38:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id n10sm15746512pfj.14.2019.02.16.03.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 18/21] diff-parseopt: convert --no-renames|--[no--rename-empty
Date:   Sat, 16 Feb 2019 18:36:52 +0700
Message-Id: <20190216113655.25728-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For --rename-empty, see 90d43b0768 (teach diffcore-rename to
optionally ignore empty content - 2012-03-22) for more information.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d3e8d634b2..4c0d40881b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -392,6 +392,9 @@ endif::git-format-patch[]
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+--[no-]rename-empty::
+	Whether to use empty blobs as rename source.
+
 ifndef::git-format-patch[]
 --check::
 	Warn if changes introduce conflict markers or whitespace errors.
diff --git a/diff.c b/diff.c
index abb1566f95..d423a06b41 100644
--- a/diff.c
+++ b/diff.c
@@ -5087,6 +5087,11 @@ static void prep_parse_options(struct diff_options *options)
 			       diff_opt_find_copies),
 		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
 			 N_("use unmodified files as source to find copies")),
+		OPT_SET_INT_F(0, "no-renames", &options->detect_rename,
+			      N_("disable rename detection"),
+			      0, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
+			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5121,13 +5126,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "--no-renames"))
-		options->detect_rename = 0;
-	else if (!strcmp(arg, "--rename-empty"))
-		options->flags.rename_empty = 1;
-	else if (!strcmp(arg, "--no-rename-empty"))
-		options->flags.rename_empty = 0;
-	else if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
+	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
 		options->flags.relative_name = 1;
 		if (arg)
 			options->prefix = arg;
-- 
2.21.0.rc0.328.g0e39304f8d

