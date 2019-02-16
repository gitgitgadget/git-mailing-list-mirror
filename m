Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833121F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfBPLin (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34964 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLin (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so6304431plo.2
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnK3BWlLapvtxZt19q2j6NAGKixQw64MvhmtACFNv40=;
        b=TOlmJ5lGnaC2q79Thu4TrqglIRHvlq7+2tACqF1AqCzJguo1qnCXXNZzQ83SSX+cvA
         BP6GwrM5KisVKNR/pw+ZldLQlM5YBLQG9A6GB2whPFlmH4IH6KkL+UeMCU/X43QffHMk
         MUw5mr8ESaU8WjLCXm+vAopHYhwHOghWGexEsYuYSJdqkXIJ1VqGfTO7YKYms6NKou4L
         nGlQT2iQ8Ek71WSz57myWRKXhQv4fpLYcmbbnpdkqlykc0MnbSrGZ3jleBBo22L4qeKZ
         fj4pYE4c6bD4gZC3vP9gduffoFcA6WLem4vlnbtqMjiPv3cJGFK9mjhKIJN8tLcxyleK
         ehpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnK3BWlLapvtxZt19q2j6NAGKixQw64MvhmtACFNv40=;
        b=rMU6Myu9Aqtxg/6HtYd5/1FkFOXYW/nJiyj4JAFXh4gm7/32+u39NYERF80cMBMKoJ
         P0VhcR44gKbHh6P2gl1RVT2ZFo/bN7f6+a3MK6Y9M0QN7R9t365rZyXd0AqJgSy9MVKr
         iIY8Ua3wP6EcLWG8mc/A3+b3Kt468TYXIEmw03i/5OQpUHJUiiiRKnYuOX5JcJv53PAO
         vwVO+A8tubiHs7BZR4FbPpLD9Z7V8r+QOQ6iKjZg9tewF9y0OJCcy+MzRPgC3wwDRcYt
         vg8SdJM4sYhQ7Za6aLy4hfh8ayOIlVVlQnpGsuJwf4nvJVjMrouqFm8eQfutWGO888j/
         sYkw==
X-Gm-Message-State: AHQUAuZsn01DtXQbIQK8xPJA2e65KXMPggunMREpOGdQwmt8+BnU6BxY
        CHIvArjQXUxNoK3I9G6G3YM=
X-Google-Smtp-Source: AHgI3IZrxtBPAIfVVoyV5DXHvb9GvJAm9qshTyHph+yRRcWAjAC+g82HlqSUFnXiw7U5gdVcPkhVBg==
X-Received: by 2002:a17:902:e789:: with SMTP id cp9mr3423838plb.127.1550317122554;
        Sat, 16 Feb 2019 03:38:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d3sm26436347pfj.54.2019.02.16.03.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 19/21] diff-parseopt: convert --relative
Date:   Sat, 16 Feb 2019 18:36:53 +0700
Message-Id: <20190216113655.25728-20-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index d423a06b41..b9c267a199 100644
--- a/diff.c
+++ b/diff.c
@@ -4960,6 +4960,18 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int diff_opt_relative(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->flags.relative_name = 1;
+	if (arg)
+		options->prefix = arg;
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5094,6 +5106,10 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
+		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
+			       N_("when run from subdir, exclude changes outside and show relative paths"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_relative),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5125,15 +5141,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* renames options */
-	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
-		options->flags.relative_name = 1;
-		if (arg)
-			options->prefix = arg;
-	}
-
 	/* xdiff options */
-	else if (!strcmp(arg, "--minimal"))
+	if (!strcmp(arg, "--minimal"))
 		DIFF_XDL_SET(options, NEED_MINIMAL);
 	else if (!strcmp(arg, "--no-minimal"))
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
-- 
2.21.0.rc0.328.g0e39304f8d

