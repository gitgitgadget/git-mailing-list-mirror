Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCF21F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfEHLOQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42510 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so10023702pfw.9
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7TDkfQTomjtt4utKYLNiSNALkxZKbaqSD3L//NWjMI=;
        b=oZTVcUuZR0Fqj4BDrEgbbF0jmdjI+5eHSCXCXoT+pJctnY/8QuRisbEp9MtvGTRK69
         sPcVX2JZrCLDxhaEyC+zOWy5xO38EdPGgki/RCJ8njRUI9FGxx6lWDIi9YbRsLKOwpNM
         dgt+T05JEWWdANU8smE/Pi2CyXr5ErsXEyj+ckebKdwu1offf9Ee0Pz1K3gP14dexerr
         F/gJ2wWYmaitrqXrL9dSAZ04uiLQVbzegeBIFaIxMZZ4hQ89G/NIACXzRt21m0e0EWZI
         MxrBxXdCtlWBdtbOt9aygcM6ms7tgv843BHxV+8hfYHrOIJEXipM5+xZIvcr+3M7tiNs
         r8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7TDkfQTomjtt4utKYLNiSNALkxZKbaqSD3L//NWjMI=;
        b=Rmq8HAjS0ibmuoblwuymLsulKEXDuLa8gH7saKdZf38PGKJn1ULwJB7QEBllaHdm6t
         XJByX/RUPU4YKOXwqL4zVU+ecB1MtPFlo+h5ZBFiUwSIEHwdhKNZ+pdZVdKWA8pf0lUY
         f4Qlfqvc9X09j4se37x1FTASEAkLfKPVXp5w3Hrp210xtmQ0fQLuLe/GRkETCrHQUKap
         5kvZU84vEKTHszizdwilJXaVHAJ+u43Jec6SBr7ob+CvN+eHX5A1e0Qb9AjeOI4OBl+g
         19CRUdKYv14arO+RdfOiufk8tYB0YIAJCxQGl7KoLIS1xAPUtYFuJ2RbR0tKHPuC3QmN
         y/Rg==
X-Gm-Message-State: APjAAAXGNneARz2lugdL6n4Xn5ZlMi/8bXpqd4/d5MmAMoJpKQiLAf6/
        FH8cSeqPEYMBYyQy/4vcrVxmaRuf
X-Google-Smtp-Source: APXvYqxeeJ6Zppp5PaDPmQ4BmAXLLRJeOtXWtJcEi03v+jv//eXsuc5zwncCVdtcnlzL+FcvjTPG5A==
X-Received: by 2002:a62:200f:: with SMTP id g15mr40136643pfg.7.1557314055900;
        Wed, 08 May 2019 04:14:15 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id m16sm27174593pfi.29.2019.05.08.04.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/19] rev-parseopt: convert --indexed-objects
Date:   Wed,  8 May 2019 18:12:42 +0700
Message-Id: <20190508111249.15262-13-pclouds@gmail.com>
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
 revision.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 6efa9bee1e..9cfa4dc151 100644
--- a/revision.c
+++ b/revision.c
@@ -2438,6 +2438,18 @@ static int rev_opt_exclude(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_indexed_objects(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct rev_info *revs  = opt->value;
+	int flags = *revs->pseudo_flags;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	add_index_objects_to_pending(revs, flags);
+	return 0;
+}
+
 static int rev_opt_glob(const struct option *opt,
 			const char *arg, int unset)
 {
@@ -2543,6 +2555,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_NOARG(0, "reflog",
 			      N_("include all refs from reflog"),
 			      rev_opt_reflog),
+		OPT_REV_NOARG(0, "indexed-objects",
+			      N_("include all trees and blobs used by the index"),
+			      rev_opt_indexed_objects),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2582,9 +2597,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--indexed-objects")) {
-		add_index_objects_to_pending(revs, *flags);
-	} else if (!strcmp(arg, "--not")) {
+	if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-- 
2.21.0.1141.gd54ac2cb17

