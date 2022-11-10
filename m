Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DDCC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKJQhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiKJQhd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD5419B6
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2012872pjk.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyloyLEudE0JXNkpqyEtCAznMnpu3zNf1Z9Z+70tcfU=;
        b=Zh2f8sK8w93yUiSvwUGGxPJrc9lkTLU3yaXyMdE/oAUV8PmW5haaBEBiIqUF4mAurb
         LKiU/i30IWtj/tE7+ehFrdclqR5F+6GA8ts6DytliLRjRoPCwLv5/r7ZduFwD0CRT5oq
         nafi0bzFiKiTQjonxxz330AE6ouVN+ZPmpeGOGqg3RwCCTnT0wfRsmCLVlLf9Uy7srP6
         oDEEutzlYXIeQCfUHMM7BIvy7asgw9yKIFxnzqA1EkMB6sZikUOzycgGSa5qgfFU5hLg
         Y9VexxG73QBSf39emg/QznyywkSOy5JhexiVhlEDuqSyIwvYMzFtN5T79wFI/MJNoLLp
         MxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyloyLEudE0JXNkpqyEtCAznMnpu3zNf1Z9Z+70tcfU=;
        b=B6iNaOuhTxW0oU9tju1VbAU9oykM1Nis4azKYmocQp/gjcMJCXp9VZoPqb4kEobz5p
         B3p4PeVSJsif7Y0d/mbEsi4iO1Q6IcHDPHfjFsE7lvIyXP8Kf0AMzMMacWSqQZ1n8Tws
         /qvW+oGcfXpRiMVt84W3PfYtnHqs4yip44R7/2tN+4y+s2+OcRKYdIrbHGVt/+jT2TcU
         lQjf+flWJkTcDQpZJ/BILia8ugxIrS55WuYTzkUYrFtChVSCjdKmq/cdzOGl8h6fYjAP
         kGGPdgSWb/FF1OKf4f7o9SyquyoRJ7Ol6nQtNv2yUuHxfdbl+GcrV2Aq+NoXxYwMAM33
         xmfQ==
X-Gm-Message-State: ACrzQf1KXyjI4AJrgJVBL3TKdg4fmKHDLGxGCqvNN7cV39E6lTJs56ZH
        glM7gXMD20Pm7P0ZaZY/3GYDwypgdxA=
X-Google-Smtp-Source: AMsMyM7UNZa1hqmi0ObqRTrc9SzRkJYOX6WrGNxyU7ZJ3cQTDgm0qYlyR8BmFLuTjTF7UIe+SagdHA==
X-Received: by 2002:a17:902:d1cd:b0:184:40f5:b88a with SMTP id g13-20020a170902d1cd00b0018440f5b88amr1513989plb.172.1668098238160;
        Thu, 10 Nov 2022 08:37:18 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:17 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] bisect--helper: identify as bisect when report error
Date:   Thu, 10 Nov 2022 23:36:41 +0700
Message-Id: <8039b010c88d35897b3e6eb6ac18672bc5a8f968.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we will convert the bisect--helper to be builtin
bisect. Let's start by self-identifying it's the real bisect when reporting
error.

This change is safe since 'git bisect--helper' is an implementation
detail, users aren't expected to call 'git bisect--helper'.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e214190599..f28bedac6a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1282,7 +1282,8 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
 {
 	if (argc > 1)
-		return error(_("--bisect-reset requires either no argument or a commit"));
+		return error(_("'%s' requires either no argument or a commit"),
+			     "git bisect reset");
 	return bisect_reset(argc ? argv[0] : NULL);
 }
 
@@ -1292,7 +1293,8 @@ static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNU
 	struct bisect_terms terms = { 0 };
 
 	if (argc > 1)
-		return error(_("--bisect-terms requires 0 or 1 argument"));
+		return error(_("'%s' requires 0 or 1 argument"),
+			     "git bisect terms");
 	res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 	free_terms(&terms);
 	return res;
@@ -1315,7 +1317,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	struct bisect_terms terms = { 0 };
 
 	if (argc)
-		return error(_("--bisect-next requires 0 arguments"));
+		return error(_("'%s' requires 0 arguments"),
+			     "git bisect next");
 	get_terms(&terms);
 	res = bisect_next(&terms, prefix);
 	free_terms(&terms);
@@ -1337,7 +1340,7 @@ static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNU
 static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
 {
 	if (argc)
-		return error(_("--bisect-log requires 0 arguments"));
+		return error(_("'%s' requires 0 arguments"), "git bisect log");
 	return bisect_log();
 }
 
@@ -1383,7 +1386,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	struct bisect_terms terms = { 0 };
 
 	if (!argc)
-		return error(_("bisect run failed: no command provided."));
+		return error(_("'%s' failed: no command provided."), "git bisect run");
 	get_terms(&terms);
 	res = bisect_run(&terms, argv, argc);
 	free_terms(&terms);
-- 
2.38.1.157.gedabe22e0a

