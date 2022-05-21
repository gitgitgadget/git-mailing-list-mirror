Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72729C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiEURPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiEURPA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 13:15:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A7666A9
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:14:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t6so15274276wra.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfMaqs+mdenlCZqp0pUfm1dnTpxAkJje7vISaf94uro=;
        b=CdLFgKrlJywiKlTftHgpAFQKBVZ0NPNi62yIY5GCKGCKuZMLejQ7/HV2PZhi1dM/38
         axxHME0/D15mv5wtR799IiS3ECrInaS1+hlsQZ7LubKdpNCX9U3g7W14usqoEsCdXS9m
         AMdq9AVDdWfyMY8kDHr7zIDtmurY5Dn4HX75PdVk1idnGqH7ur1tU/SPrRp9u6a+PybS
         Lswu1xn0DMmclAwmLj5RH28Rl8/JE1McCO58uFH5ovH5mzichYBkuSY2YZDxyTt30rJp
         abl6C+CZsG8xEt7nnytVVV93miCdcbvs1Ue+azAAk09BgqSRbKeEc5eHpgu5kwp0KGAb
         ZBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfMaqs+mdenlCZqp0pUfm1dnTpxAkJje7vISaf94uro=;
        b=S94eQ+PAASF5QW+Xe2HGYL3fMzuIRhCGkl2hPA91UnPeTBrZnIfi4WRwUOjx+5ss+E
         gYVBmDfwrcFpfp++PyUolrbNPBBTtm4o27FV2NZ8kbKXVmBcA44GAGIudclFIWBLvSH2
         BBXc9iHxY3F40+dZJzKkdb0dY2igCmo25wUMTNw79KsQ8vjPpPV/7i7yFRXRwugHS7de
         SKnatLy0ogCydrGgaGTkYHa8TVCxL/R81TsRh0r3oy+U1LsXTPky8b6V/XLKo9Ner7yW
         kQc+edMcBjf/J7AtWjFKAng2qC3J1pNcJvUnz9ZBsXTzKijkCcxUIw9PpVOVJDVDs8s1
         2SoA==
X-Gm-Message-State: AOAM532xfFwBy3zPdqDmCbQWZ/G5vLFk8MZKulgaN19OXHmtgvtef32H
        3whV4LBYOcRc4h+USH+M2flT7yDmqwodkA==
X-Google-Smtp-Source: ABdhPJy15uYCoDgQuLQpYgDRnERYXhguftGJwIwQuQQPcoFqGm8dKLUcA/ShxE0ccXsVcG77zSGWVQ==
X-Received: by 2002:adf:e444:0:b0:20d:1329:76ca with SMTP id t4-20020adfe444000000b0020d132976camr12548804wrm.553.1653153296897;
        Sat, 21 May 2022 10:14:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm4964685wmj.27.2022.05.21.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:14:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] parse-options.c: use new bug() API for optbug()
Date:   Sat, 21 May 2022 19:14:39 +0200
Message-Id: <patch-2.5-a599cd015a3-20220521T170939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run into bugs in parse-options.c usage it's good to be able to
note all the issues we ran into before dying. This use-case is why we
have the optbug() function introduced in 1e5ce570ca3 (parse-options:
clearer reporting of API misuse, 2010-12-02)

Let's change this code to use the new bug() API introduced in the
preceding commit, which cuts down on the verbosity of
parse_options_check().

There are existing uses of BUG() in adjacent code that should have
been using optbug() that aren't being changed here. That'll be done in
a subsequent commit. This only changes the optbug() callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6e57744fd22..7fff588a45f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -14,15 +14,15 @@ enum opt_parsed {
 	OPT_UNSET = 1<<1,
 };
 
-static int optbug(const struct option *opt, const char *reason)
+static void optbug(const struct option *opt, const char *reason)
 {
-	if (opt->long_name) {
-		if (opt->short_name)
-			return error("BUG: switch '%c' (--%s) %s",
-				     opt->short_name, opt->long_name, reason);
-		return error("BUG: option '%s' %s", opt->long_name, reason);
-	}
-	return error("BUG: switch '%c' %s", opt->short_name, reason);
+	if (opt->long_name && opt->short_name)
+		bug("switch '%c' (--%s) %s", opt->short_name,
+		    opt->long_name, reason);
+	else if (opt->long_name)
+		bug("option '%s' %s", opt->long_name, reason);
+	else
+		bug("switch '%c' %s", opt->short_name, reason);
 }
 
 static const char *optname(const struct option *opt, enum opt_parsed flags)
@@ -441,28 +441,27 @@ static void check_typos(const char *arg, const struct option *options)
 
 static void parse_options_check(const struct option *opts)
 {
-	int err = 0;
 	char short_opts[128];
 
 	memset(short_opts, '\0', sizeof(short_opts));
 	for (; opts->type != OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
-			err |= optbug(opts, "uses incompatible flags "
-					"LASTARG_DEFAULT and OPTARG");
+			optbug(opts, "uses incompatible flags "
+			       "LASTARG_DEFAULT and OPTARG");
 		if (opts->short_name) {
 			if (0x7F <= opts->short_name)
-				err |= optbug(opts, "invalid short name");
+				optbug(opts, "invalid short name");
 			else if (short_opts[opts->short_name]++)
-				err |= optbug(opts, "short name already used");
+				optbug(opts, "short name already used");
 		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
 		     !(opts->flags & PARSE_OPT_NONEG) ||
 		     opts->long_name))
-			err |= optbug(opts, "uses feature "
-					"not supported for dashless options");
+			optbug(opts, "uses feature "
+			       "not supported for dashless options");
 		switch (opts->type) {
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
@@ -471,7 +470,7 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
-				err |= optbug(opts, "should not accept an argument");
+				optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
 			if (!opts->callback && !opts->ll_callback)
@@ -494,10 +493,9 @@ static void parse_options_check(const struct option *opts)
 		}
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
-			err |= optbug(opts, "multi-word argh should use dash to separate words");
+			optbug(opts, "multi-word argh should use dash to separate words");
 	}
-	if (err)
-		exit(128);
+	BUG_if_bug();
 }
 
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
-- 
2.36.1.960.g7a4e2fc85c9

