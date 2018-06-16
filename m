Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95931F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeFPFmN (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:13 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:37741 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756541AbeFPFmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:07 -0400
Received: by mail-lf0-f54.google.com with SMTP id g21-v6so17535847lfb.4
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcurkgfU4EadlLLnSOG15L6XNhdSvknd0wOPdqL76qM=;
        b=XXkgj6FhkKNUHhZIkkw1yYyb5Ks2CyfM5Pb4njNbIvU+/TMrfoa90RqeSd25OfyoUV
         HDLihHQYDKQnS5WF+UT3xYZ2J3ajxzsOBSDXJ4wvK0kGBazHcBHLwXqeJkF/NkYWBbTc
         4QG2Q98IfTtufK28sP34oRSuvLrqweHoeddCMua3XHuaOePSjkdzmveqc1jupgQ6Pg0/
         uiT+4ycK74bXGxjPSobgv1I47f41iyP/vZlpQ8tA1TnEoyKxD4eZ4TShGGAgTUG3V2vt
         g3NZ7UW/CAN9soCulXAsWQGk5RTaEh0Utq0qlVDfxAQf7uWnlTtPFQhz9xyMGc6D+ykO
         Htnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcurkgfU4EadlLLnSOG15L6XNhdSvknd0wOPdqL76qM=;
        b=SCAv/XU/77dC6DC3jESaXtHBO7pl1oG7uEY1B5IMz2VH31O1+QEIy+oZg6AZ9XT6NX
         SlEG46HYr93cAIAbrxRMODsMRSESumHPkHn1FdkRllhq4e1CyU1eQjQp/ViGycWOZDL8
         yhuBb6lYqtrHICEUpQIG0cAa6nMdPR3vvzGC4xLLrKQSns9iJ4qxUK+Otymv9nglk6F2
         Ea5gt7EGYt6eloNe7sBSjRZEydtcspCVtwGd1LgkSTuMjHZKp7/rAJrBzMXKDZ+yvebK
         7t2EWiwEIhjlSw0WO0ewGWenUyr79B40LC4QChfREvv3UvHeRfgKHRsQg9sTY2o0aI1k
         fkFg==
X-Gm-Message-State: APt69E1Dg/WaJmIF/anP6EEYL0wzLDI1cZRqzOpK4L+eY885VT4Ka71R
        AsjEs1A5ltXG7ZQ8AyGf2szAUg==
X-Google-Smtp-Source: ADUXVKK2Z97UAo38/LU+88E12dGJ6AOypexjVhu9EiPasoPUZLhhPYprTkwbhUMYH1DwmwEEtcZzCQ==
X-Received: by 2002:a2e:594d:: with SMTP id n74-v6mr3182723ljb.128.1529127726036;
        Fri, 15 Jun 2018 22:42:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/15] diff-lib.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:47 +0200
Message-Id: <20180616054157.32433-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff-lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 104f954a25..56387e1f63 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -70,7 +70,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     struct stat *st, unsigned ce_option,
 				     unsigned *dirty_submodule)
 {
-	int changed = ce_match_stat(ce, st, ce_option);
+	int changed = ie_match_stat(&the_index, ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
 		if (!diffopt->flags.override_submodule_config)
@@ -98,10 +98,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
-	entries = active_nr;
+	entries = the_index.cache_nr;
 	for (i = 0; i < entries; i++) {
 		unsigned int oldmode, newmode;
-		struct cache_entry *ce = active_cache[i];
+		struct cache_entry *ce = the_index.cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
 		const struct object_id *old_oid, *new_oid;
@@ -145,7 +145,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->mode = wt_mode;
 
 			while (i < entries) {
-				struct cache_entry *nce = active_cache[i];
+				struct cache_entry *nce = the_index.cache[i];
 				int stage;
 
 				if (strcmp(ce->name, nce->name))
-- 
2.18.0.rc0.333.g22e6ee6cdf

