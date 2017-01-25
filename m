Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591FD1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 12:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdAYMvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:51:47 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32786 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdAYMvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:51:45 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so19672499pgd.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 04:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoRpVD1eJ34odZS1c8qFZL0mfX/ObjTyX0DOioxuof8=;
        b=gQopobuxVAA3NQTO8Ai4sU9j98Anru3UVXjrY8Faj5hnYAkBApLAXenC+aLvrp2BqN
         fZ5dWSpClW+GKNkT1BWtlCUFUPBTrv998UlZS8cF+LYXitA0W21+hb1pMCOVyJJJpUcS
         MZZCh61XU/TRR+cknaTgDVbabDPczY0XxhkJ0VYVqZnwPS1kIOcCYPFSpiaXgJf0sfVd
         m3mkOWJDl2F18rE3KmoMmeto4zzxzeGH2OKjoML9dDKJXNUbLRuPjEluNF3Q8wMmsMoI
         e/JNqTr2/k0+Ch9tRmO7uizCTof8wmGNXj4nej3bTId/f4wqDogbAWlYS6roZRo3aHFt
         XWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoRpVD1eJ34odZS1c8qFZL0mfX/ObjTyX0DOioxuof8=;
        b=oLFuwhhsi/T4UhVXwI33iSdFZoNCqcSvsdNhwhgR7d0qliNg4AQGtv2Dj0DoA0CwSp
         Gg29VGSKzFZ9i3dtBfFXQPRpzP4WBpNxRZbQXOWIv9LtUvrcLIut8sG7Xasroq93V+KK
         gXXAwWsw2EI1LmwbP9kriR4coFlH3w87u55HxlJ8Gtzu7nyDTOzEdueRwBW8imUdG1hY
         cZ5CMbdjMnXOdaFmAgRteafJVenTMl+F20aG0NxDTLbdS0U6RoFJh2xkPwu1EdUlHm1a
         sfMp+EBD21uFis0wnRWGScNKD8//hG8iwwVSbbDx1evHSHV9CH1IWWzZEHuvSUnxfwHk
         BHKA==
X-Gm-Message-State: AIkVDXJKqQLwApV+2JqtmEFJoItNaJ2ev9gO0nBdT0QcGoHTEauBvyXgnu8gRqa85RW4Og==
X-Received: by 10.98.51.70 with SMTP id z67mr39165042pfz.68.1485348705189;
        Wed, 25 Jan 2017 04:51:45 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id n70sm1100528pfg.34.2017.01.25.04.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 04:51:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 25 Jan 2017 19:51:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/5] revision.c: add --decorate-reflog
Date:   Wed, 25 Jan 2017 19:50:54 +0700
Message-Id: <20170125125054.7422-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170125125054.7422-1-pclouds@gmail.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/revision.c b/revision.c
index 45cffcab44..b77face513 100644
--- a/revision.c
+++ b/revision.c
@@ -2157,6 +2157,49 @@ static int handle_refs_pseudo_opt(const char *submodule,
 
 static int handle_revision_pseudo_opt(const char *, struct rev_info *, int, const char **, int *);
 
+static int handle_revision_pseudo_opt_after_decorate_reflog(
+	const char *submodule, struct rev_info *revs,
+	int argc, const char **argv, int *flags)
+{
+	struct all_refs_cb cb;
+	const char *optarg = NULL;
+	int argcount;
+	enum ref_selector selector;
+
+	selector = parse_ref_selector_option(argc, argv, &optarg, &argcount);
+
+	if (optarg)
+		init_all_refs_cb(&cb, revs, *flags);
+
+	switch (selector) {
+	case REF_SELECT_ALL:
+		/* keep the info for load_ref_decorations() later */
+		return 1;
+
+	case REF_SELECT_BRANCHES:
+		/* keep the info for load_ref_decorations() later */
+		return 1;
+
+	case REF_SELECT_TAGS:
+		/* keep the info for load_ref_decorations() later */
+		return 1;
+
+	case REF_SELECT_REMOTES:
+		/* keep the info for load_ref_decorations() later */
+		return 1;
+
+	case REF_SELECT_BY_GLOB:
+		/* keep the info for load_ref_decorations() later */
+		return 1;
+
+	case REF_SELECT_NONE:
+		break;
+	}
+
+	revs->handle_pseudo_opt = NULL;
+	return handle_revision_pseudo_opt(submodule, revs, argc, argv, flags);
+}
+
 static int handle_revision_pseudo_opt_after_exclude(const char *submodule,
 						    struct rev_info *revs,
 						    int argc, const char **argv,
@@ -2200,6 +2243,9 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		revs->handle_pseudo_opt = handle_revision_pseudo_opt_after_exclude;
 		return argcount;
+	} else if ((argcount = parse_long_opt("decorate-reflog", argv, &optarg))) {
+		revs->handle_pseudo_opt = handle_revision_pseudo_opt_after_decorate_reflog;
+		return argcount;
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
-- 
2.11.0.157.gd943d85

