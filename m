Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853201F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfEHLOM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46499 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so5824009pgb.13
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsAlZiDVZWlmNbwDJY8sDxCYHVLxjKQI2Qtck0cocTU=;
        b=s6COS5whirxashaCKYRvMDArWwzTlZyL4lBIBQ0LNRHZNNbb5Hvplj4Bus5CoTAtGC
         qvFc5i3JKA9JN83Y+ARr3DEqPUq7Pe1iwSMZn45jfZ71erVhalqgXMAgwGC3NowmGMG+
         2KyMPtJlgUkBvKxTicWo1TXabN/42cUY94y6+J40OkYmRIx6Nz+Bei4v7qpe1JdSN2s2
         jMfy4wHFOvMFKhHMi2jQn6yReBDKJcS8iYGovqNGhRDAiIy14g8hN3OR9ohGbDDsj86A
         TPBBTYN2FQs0s9TAubVScnyhr5+XhNNxFd0vkxMqzgmKolGgkOamLsnQ0pP34xRki6kp
         WUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsAlZiDVZWlmNbwDJY8sDxCYHVLxjKQI2Qtck0cocTU=;
        b=bYyHhiY3GCSW+Af7ilDYd9lcTu09q4iJbf+6EgvGsl0Pj5YRIjZNAsz3zKnmj91eV8
         7ZQ8X0trMwAvMHXRCWMLjXNSraHnSbXZFGGsgzkkL+HjVIGtCc/YSjvKmlmphxF8NGUu
         9krMFpKsVTbhIO8sjQFnoB8s0fgROBX4OAikHOs+jK9A4J2umsv2ug63jP+6lzer4i2s
         aw6ZK+zonaHYv7Xdl8g9qPdWC+ZIaMGYfY1QxsBhzI+UHn+1sWdbo/gi2dzby5Vup38H
         mqZI996yNxRn7b5SoVmN7SLR1HF5pEJ/+kjQVMu2livBKPbZ7Mo1GXH+TlNHb6i8/DOZ
         Xkkg==
X-Gm-Message-State: APjAAAUI82IYKop1TnL+v9c7vD3kMfhYDELIaqc1vgmuQkSh3qhtbr8c
        IbOsx8CnAph6DRUYfrw/uQYxv6xK
X-Google-Smtp-Source: APXvYqwtNhCrxJI4UPJx94N+l/OTGjvMkDZmeB7jrmtlrVOCDIa5g83cWeQLR2JJ+cnVKx7J55658w==
X-Received: by 2002:aa7:820c:: with SMTP id k12mr47798820pfi.177.1557314051569;
        Wed, 08 May 2019 04:14:11 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id i1sm6824659pgj.70.2019.05.08.04.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/19] rev-parseopt: convert --reflog
Date:   Wed,  8 May 2019 18:12:41 +0700
Message-Id: <20190508111249.15262-12-pclouds@gmail.com>
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
index d34e17984d..6efa9bee1e 100644
--- a/revision.c
+++ b/revision.c
@@ -2452,6 +2452,18 @@ static int rev_opt_glob(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_reflog(const struct option *opt,
+			  const char *arg, int unset)
+{
+	struct rev_info *revs  = opt->value;
+	int flags = *revs->pseudo_flags;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	add_reflogs_to_pending(revs, flags);
+	return 0;
+}
+
 static int rev_opt_remotes(const struct option *opt,
 			   const char *arg, int unset)
 {
@@ -2528,6 +2540,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV(0, "exclude", N_("<pattern>"),
 			N_("exclude refs matching glob pattern"),
 			rev_opt_exclude),
+		OPT_REV_NOARG(0, "reflog",
+			      N_("include all refs from reflog"),
+			      rev_opt_reflog),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2567,9 +2582,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--reflog")) {
-		add_reflogs_to_pending(revs, *flags);
-	} else if (!strcmp(arg, "--indexed-objects")) {
+	if (!strcmp(arg, "--indexed-objects")) {
 		add_index_objects_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
-- 
2.21.0.1141.gd54ac2cb17

