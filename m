Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E7B1F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBULQt (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:16:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35277 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBULQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:16:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so13653174pgs.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKtFaj/7qrmko2KxgPeNx8BlYd+XqJ5Xd1/U7NqoTJ4=;
        b=RMwYI1vhtAOYMc8BKGhjrze4VomtHs55yPSg9B735KHOSYO9qPnpQD+ScV+U30DcCy
         wyXI2IvQIoyK13uOhZ9kfhda5ZOpt7SHRjXAKuDSpbQwEAObKjC4OmLBBGVpw1z0qMdh
         et8s/H7MNIh6ktzOaziae3EakPiWMh39QRpXcRoElJ8/m4SWiFLkivlFxWs6VCrTPT8m
         hmpXFfDUW55DMPi4phgreGhnH0gTV8SQAVxqQsmLdyLve94rou5PHubukTBsEDymKq1b
         vNIM/n1sikthl5US7rRrmpM8LUcMb2Qp895Zic3SDUF1ZOmKbGCLbZB4Mhox/Ji+AubG
         ZPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKtFaj/7qrmko2KxgPeNx8BlYd+XqJ5Xd1/U7NqoTJ4=;
        b=koIibB06htLZnUDE7h1cmWRhRIgopxoZ/NjbZifY8AQzwahbCCdGKNJ5ld3U/VlQ4i
         a/JA9VqATFe/wmJlWxaqtodNkxPFGlLyO4QDd9/LCXFWeVxOG0CPHeNHG3mzWt33qh+E
         555Jenojr4j59DNLBby2md2nr0o/ChFtUtvq3gHWf69lqiS6NoDyz5zLz0ghGozzY4JI
         f+6/M6CJU+JwwZ5c77jWhlxSuEVRyaD2Qo3ZqhhF8isLebDX3FKpq8+f2OHNpqNLdjMh
         keJWuwIa8s0fyMhJQElDH4gaMeTNNgc/IgRzSa8X3CZVwnZesvCGsIVOZpwQgWOQT7Dd
         33lw==
X-Gm-Message-State: AHQUAuYPqD/NBgSAHorAxLpqbF1Z9h0zsab+GznXgGUx45Pe1rSZSzK8
        0EG4rj+qEZJlprCZYzJh2R+166Gq
X-Google-Smtp-Source: AHgI3IbCy3DsvUKrSWucr6WC9PTQRVXSyIW86KsXC83J1gaDSTCeQLmETXe/2S7QieArZnTNKBRdfg==
X-Received: by 2002:a62:a504:: with SMTP id v4mr5990477pfm.22.1550747807712;
        Thu, 21 Feb 2019 03:16:47 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v9sm32339743pfg.144.2019.02.21.03.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:16:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 03/21] diff-parseopt: convert --dirstat and friends
Date:   Thu, 21 Feb 2019 18:16:03 +0700
Message-Id: <20190221111621.27180-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221111621.27180-1-pclouds@gmail.com>
References: <20190216113655.25728-1-pclouds@gmail.com>
 <20190221111621.27180-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt |  7 ++++++
 diff.c                         | 39 +++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0711734b12..7b81b852ca 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -148,6 +148,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	number of modified files, as well as number of added and deleted
 	lines.
 
+-X[<param1,param2,...>]::
 --dirstat[=<param1,param2,...>]::
 	Output the distribution of relative amount of changes for each
 	sub-directory. The behavior of `--dirstat` can be customized by
@@ -192,6 +193,12 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `--dirstat=files,10,cumulative`.
 
+--cumulative::
+	Synonym for --dirstat=cumulative
+
+--dirstat-by-file[=<param1,param2>...]::
+	Synonym for --dirstat=files,param1,param2...
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.c b/diff.c
index 419b6ac4ae..1cdbe8e688 100644
--- a/diff.c
+++ b/diff.c
@@ -4867,6 +4867,22 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_dirstat(const struct option *opt,
+			    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!strcmp(opt->long_name, "cumulative")) {
+		if (arg)
+			BUG("how come --cumulative take a value?");
+		arg = "cumulative";
+	} else if (!strcmp(opt->long_name, "dirstat-by-file"))
+		parse_dirstat_opt(options, "files");
+	parse_dirstat_opt(options, arg ? arg : "");
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4911,6 +4927,18 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
 			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
+			       N_("output the distribution of relative amount of changes for each sub-directory"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_dirstat),
+		OPT_CALLBACK_F(0, "cumulative", options, NULL,
+			       N_("synonym for --dirstat=cumulative"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_dirstat),
+		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
+			       N_("synonym for --dirstat=files,param1,param2..."),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_dirstat),
 		OPT_END()
 	};
 
@@ -4939,16 +4967,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (skip_prefix(arg, "-X", &arg) ||
-		 skip_to_optional_arg(arg, "--dirstat", &arg))
-		return parse_dirstat_opt(options, arg);
-	else if (!strcmp(arg, "--cumulative"))
-		return parse_dirstat_opt(options, "cumulative");
-	else if (skip_to_optional_arg(arg, "--dirstat-by-file", &arg)) {
-		parse_dirstat_opt(options, "files");
-		return parse_dirstat_opt(options, arg);
-	}
-	else if (!strcmp(arg, "--check"))
+	if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
-- 
2.21.0.rc1.337.gdf7f8d0522

