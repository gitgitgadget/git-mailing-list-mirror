Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411451F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEHLNu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39309 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id w22so8635361pgi.6
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xu8Lrzqw4E2szh815J5hVKeDDiGe2DhwUBv3wllVcVU=;
        b=Ei1fW5JSHtUitXD+zesLHhU83ZGxc0OzKEoM+J0U9oDaNQKbDEqCsKFFhVVer6iI7G
         eT9fzk16U3pIxptwkmfUEsptkmevF8WRoXeMTsq8zj3Ll1CKi7e2kwrtQqaRePOBol5C
         6RPXVHgrJxVSlRxboRxTNEPII3Eypt1bT6DMChSy3SqwzuvK6D6Dg+NXxF0y+RriWC75
         TgIKYgs7agN70ZyRVOJ6LWW570e/Yb28FjDACgScWWBLcJ37pdx1LBSjIVCUy6xw+TA1
         9rj3qfrMjm6jA4ASiPALEE5NNR2UB5BZE/9FbIZRTND53NeE37rgOsk2G1tddjn2ht9G
         BiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xu8Lrzqw4E2szh815J5hVKeDDiGe2DhwUBv3wllVcVU=;
        b=snVQJ9xTcxC1B5I/0geWjAPhrwOBk8WaLJfWCU9Aa+eyScilnRt9BIs2mFehLJ1uxa
         bgXtUowc06jJaVjRTqRkd19rD6XXOASUgMlXZJ/YADr0mkOLZUxrZwUgCnfdmYQK0cey
         m/H6tjF6HwEgS+V2F+tY9PIbwM+rlthiwVPxxnqd4auanLEDeLOVDmKJCM9QQzTkDAiS
         VcVWXQDM+vDy7J37KmPmsk856GoW7kpWIs9V/iN7hnczZ0c06rh4BZSimXUND0riD4gj
         ly2nQ1NgvLE5VwdYd25UpdTOmj5hRMyrNIPCZFO0/1soP7r9RmotAt8Lqt9WRExdbs/V
         XgeQ==
X-Gm-Message-State: APjAAAVzbgkKJl5KamwkX6RenJh/SpPLiMk/vdSfoI6sRX7GC3tBtpZD
        R1HDKbwT74prcklaUMWCBrW1FTX+
X-Google-Smtp-Source: APXvYqxhgkesaWpGfd3ZnPuSRrFJmTcxCsfO6Gued/oZfChtdiY8S8r6gbZBwZwfj+Hbcawkg1snNg==
X-Received: by 2002:a62:56c3:: with SMTP id h64mr11901137pfj.163.1557314029271;
        Wed, 08 May 2019 04:13:49 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id f6sm17561468pgq.11.2019.05.08.04.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/19] rev-parseopt: convert --bisect
Date:   Wed,  8 May 2019 18:12:36 +0700
Message-Id: <20190508111249.15262-7-pclouds@gmail.com>
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
 revision.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 7db1109b57..0d34f81716 100644
--- a/revision.c
+++ b/revision.c
@@ -2387,6 +2387,23 @@ static int rev_opt_all(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int rev_opt_bisect(const struct option *opt,
+			  const char *arg, int unset)
+{
+	struct rev_info		*revs  = opt->value;
+	int			 flags = *revs->pseudo_flags;
+	struct ref_store	*refs  = revs->pseudo_refs;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	read_bisect_terms(&term_bad, &term_good);
+	handle_refs(refs, revs, flags, for_each_bad_bisect_ref);
+	handle_refs(refs, revs, flags ^ (UNINTERESTING | BOTTOM),
+		    for_each_good_bisect_ref);
+	revs->bisect = 1;
+	return 0;
+}
+
 static int rev_opt_branches(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -2427,6 +2444,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_OPTARG(0, "branches", N_("<pattern>"),
 			       N_("include all refs in refs/heads (optionally matches pattern)"),
 			       rev_opt_branches),
+		OPT_REV_NOARG(0, "bisect",
+			      N_("synonym to refs/bisect/good-* --not refs/bisect/bad"),
+			      rev_opt_bisect),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2467,13 +2487,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--bisect")) {
-		read_bisect_terms(&term_bad, &term_good);
-		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
-		handle_refs(refs, revs, *flags ^ (UNINTERESTING | BOTTOM),
-			    for_each_good_bisect_ref);
-		revs->bisect = 1;
-	} else if (!strcmp(arg, "--tags")) {
+	if (!strcmp(arg, "--tags")) {
 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
-- 
2.21.0.1141.gd54ac2cb17

