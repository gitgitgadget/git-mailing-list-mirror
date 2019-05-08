Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2BA1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfEHLOm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEHLOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi2so9769229plb.13
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcZSW69vX7CUbudGRc7pW3Y3ePNi9rALz48CQlhitKI=;
        b=PLQAIUSGLTrStcXRUiEc8hgB+q9+wL9ayCh6oLKEHrowxn0uWEVGf+82kbxDxZmgzX
         gm+kpisYLo8JT2JgO4tQODP9rZBycV4MbKKs4ZkUrV6qklJR15KjRTULvd6MUK/XbTxh
         2CNVG4DnU81MveMxNH/CF8ziEwvZLENCan3WhPSo9EOlbfkNrROgNL2oTIw+5mNULrTS
         nSGyKuEOwIu3SB5uEmQomu65XOAw0Qfg68TzEeRDCJQgjQGflOo4prYsG5qS683VS1i6
         ebCO45djJDEUbm2ysSXz4hooxPfHWpEoWz54Xtk3dbF/Zdc/vu0Q03jf5Z1UyaEJY8Kc
         0GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcZSW69vX7CUbudGRc7pW3Y3ePNi9rALz48CQlhitKI=;
        b=IXQS1NVgXAdfNDzWQY+oNY1NT8KMUolV8rrsgFMV661ngXTV1MT0mgSt9+bvS/LO6e
         GbncYl4RXyxdV4uhZGF/WKqKrA5AeVl6aG6iNvWS74V98jdS9chdvvsprDmE5/aTimif
         39iwYwuQ+RpcfIrVON3ZPD9kShQ32nfYbGwn9czIjQn7sp3/x2dvvvf4fjhv9+Cbsyha
         sWN2D/Z26GvftKv4sNSvz3gF16Xi8lCh8cmVNChSz0noDQX74W2jFu7yNIHXItBDz8bb
         cfvLmjcEco5zTITpfRt+ZjDjMWdR6rRecQKvI+4Lg2LDKdLaDC4fo/gQ3bphKYeQHgwL
         oddg==
X-Gm-Message-State: APjAAAXsCFm+M05ElvxVLwAu2kHYsldz4XZPbErR9MA2UgSIQdEpd1z8
        TrLRwDMrOjL9eMYK9Q79s1a7wmpy
X-Google-Smtp-Source: APXvYqzT2sYHTdzyKuHmS/S33goIhOQ1Bl/nwfvGO0iVFCm9Si1yhyKNvYntOQsPWmDaKx809Au1Yg==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr44838830plb.6.1557314081643;
        Wed, 08 May 2019 04:14:41 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id j12sm20506393pff.148.2019.05.08.04.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/19] rev-parseopt: convert --skip
Date:   Wed,  8 May 2019 18:12:48 +0700
Message-Id: <20190508111249.15262-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index c53347d362..42d466cd08 100644
--- a/revision.c
+++ b/revision.c
@@ -1996,6 +1996,9 @@ static void make_rev_options(struct rev_info *revs)
 		OPT_REV('n', "max-count", N_("<n>"),
 			N_("limit the number of commis to stdout"),
 			rev_opt_max_count),
+		OPT_INTEGER_F(0, "skip", &revs->skip_count,
+			      N_("skip a number of commits before starting to show"),
+			      PARSE_OPT_NONEG),
 		OPT_END(),
 	};
 	revs->options = parse_options_concat(options, revs->diffopt.parseopts);
@@ -2036,10 +2039,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	if (argc)
 		return argc;
 
-	if ((argcount = parse_long_opt("skip", argv, &optarg))) {
-		revs->skip_count = atoi(optarg);
-		return argcount;
-	} else if ((*arg == '-') && isdigit(arg[1])) {
+	if ((*arg == '-') && isdigit(arg[1])) {
 		/* accept -<digit>, like traditional "head" */
 		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
 		    revs->max_count < 0)
-- 
2.21.0.1141.gd54ac2cb17

