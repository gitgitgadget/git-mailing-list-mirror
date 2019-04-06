Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7439C20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDFLfx (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44193 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfDFLfx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so4466388pll.11
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLHFfdnN0jx4Qdk7kWZsPEECXBZdnTGBSUUpleGoRQ8=;
        b=R+f1LUxh6/OkipydSvFsPyF1VP5KFZ1SNKuRuUQdExd1cBsUVh1ygoeA1w7SiMqB4Q
         cAUW5KH5FK4/odNzuCCx2EVkr8ylsVlGhR7drgAMP6h5Kqy+RY0nGDZMtje2PfASUxUX
         hTWFmxUDpF+kWAn64AtwgrxSm56F5cq67SwpXu8FAgMFseA1A8HMo9NNJz6thRRJVQ5x
         GAl8cZ8Kdatwod+SXr37C9y++7Otrr3lYFtg1rDJjhX7hGK0hRK/IK5WCXFxHusRsCMD
         AcDg8MPV9y1ui+AE9uSggTIVi2+ptBDFVg3g0ILz92DoiJDUoGFuh7CYR2txApAnNFy6
         /ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLHFfdnN0jx4Qdk7kWZsPEECXBZdnTGBSUUpleGoRQ8=;
        b=YsC8Vv2a+0VIlhi3mh0/XUNPxYVU2fmLxhKTb+fnzcxdirEDudyoM7kKMeV+hw8sCv
         6lJs4vbHaUJxr/mgBVht5op8AJB8UqBYXywF1XXvxmAku3wenuqJdzCjxRSwdjOVYuJs
         VHQNJMc6ir5r4gn0bol+qs1QI6mb8YJwmFayYfsDUJDdomILWUR3FJBmbfvXFcvuPUNe
         DJOcFC/wJEuHE/QHMKpfa5xoWUFMnnGQS2cYh+9QzCKUDByhK13OdFaHL3KYAafJW3LR
         i80PeOiWh8V0vK9RdI4gpfDFn0yITVCyN+JhUY3Fp4jMh6+CKT05fJhCy6p5H8qWwrmT
         Vu5A==
X-Gm-Message-State: APjAAAUJ/UEJ5GMxxw/eJkJ4ZSco/l8bSc3Q/Z7oPQiAPrscqxH/Cqrr
        mvh0T8zFvWhxAALfo/aqCek=
X-Google-Smtp-Source: APXvYqzvrkJyVNa4f9oh7cjTkgp3diZWc7uqQP0TJ4onjV7fGb0FljjpbWYtyQsghsK0oEa3hraYlQ==
X-Received: by 2002:a17:902:7589:: with SMTP id j9mr18791533pll.287.1554550552710;
        Sat, 06 Apr 2019 04:35:52 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id x16sm49847360pge.27.2019.04.06.04.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 07/33] refs.c: remove the_repo from expand_ref()
Date:   Sat,  6 Apr 2019 18:34:27 +0700
Message-Id: <20190406113453.5149-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c        | 10 ++++++----
 refs.h        |  2 +-
 upload-pack.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 44df049796..1f5864aa36 100644
--- a/refs.c
+++ b/refs.c
@@ -558,12 +558,13 @@ static char *substitute_branch_name(struct repository *r,
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
 	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(str, len, oid, ref);
+	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
-int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
+int expand_ref(struct repository *repo, const char *str, int len,
+	       struct object_id *oid, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
@@ -578,8 +579,9 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
-				       this_result, &flag);
+		r = refs_resolve_ref_unsafe(get_main_ref_store(repo),
+					    fullref.buf, RESOLVE_REF_READING,
+					    this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
diff --git a/refs.h b/refs.h
index 5627570241..b630d5bde7 100644
--- a/refs.h
+++ b/refs.h
@@ -148,7 +148,7 @@ int refname_match(const char *abbrev_name, const char *full_name);
 struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
-int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
+int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..56505d60c3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -834,7 +834,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
-		if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
+		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
 		string_list_append(deepen_not, ref);
 		free(ref);
-- 
2.21.0.479.g47ac719cd3

