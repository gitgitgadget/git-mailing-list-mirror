Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F2C433E1
	for <git@archiver.kernel.org>; Wed, 20 May 2020 23:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F5A20759
	for <git@archiver.kernel.org>; Wed, 20 May 2020 23:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuL7gFxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgETX0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgETX0j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 19:26:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B45C061A0F
        for <git@vger.kernel.org>; Wed, 20 May 2020 16:26:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so2103851pjd.0
        for <git@vger.kernel.org>; Wed, 20 May 2020 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlZsiSpRajM5o2Jf761d8qbbYJS+T6E8+ndSaQZVcvE=;
        b=QuL7gFxIOoq15J3GduxiHSf4QXtCXnkPif7cD9Gbc3F30IfFmys/L0NueLN3YDCva6
         b9P7lttwGjAmTcVRRc3DIhPJdPNTRq9D4XM/DQbH3stBNZZ/0711r4yAQ0w7F8jL8Zir
         NW+EKXfyflPBHvWz/JlTP0v3MUZy1CtsqSaWCZ/u8r7TaXNvpdaVoi1VMW9sLf4wwui5
         Cur4Rwb3fFC9Jduyx5VLJ6aByC7TPRJArpAL4+92pyhcQjbSsCa5BQxMWwxEkhIXG3/R
         rrAg4cbxQuF3bUwFMzNcAGCb/XcaUuVvWoAzFr0YSk7hLGX5tz7Iguj9uOfFquT6awYG
         ztWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlZsiSpRajM5o2Jf761d8qbbYJS+T6E8+ndSaQZVcvE=;
        b=S/aP3YfxQk2+PF9NJEeOU1bpcmF7qkkf8Prq876j4jVzFklmJMQFyGqSEuuxJHsGrH
         3u04mTCZm05epw1e57V/R8zQrKWkMsAa8syo4/hsPRu4WkQqOt2p0/P4N8xt6r0JUL3l
         dhkz+QdJDEsUBIb+zTh0r/8BGTeTS6KxL/3a4Qr0sfXl2vi6jAcD6UjKdQUVYZFpS6no
         StUAECJGPVN9DYGY6twWclu3w2YHuNaHgg5jimwzhcSAX0j4UFw897tMzeo0oRgfNCgb
         KJtioI+uXQSyHqTd0SMNvJnYzk41YgIdU4iEFRn3fkbTR2PdWEbkRozgILRLG7KR4J3B
         10Qg==
X-Gm-Message-State: AOAM5317VcHZsIaMCsXk0PkvLbZZbe3m+0rte5Io9GUAB4/BVk2ItpRG
        kwfi9uI2sGesJFovk2XFLFZWO9rN
X-Google-Smtp-Source: ABdhPJxyw9F8m0/qWFonidNsG70Dx6ERzjN1YAuH44var5/RQtKo/+lybNqhOELY09MydI0bcz7SUw==
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr7719787pjb.93.1590017198128;
        Wed, 20 May 2020 16:26:38 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id s206sm3057849pfc.31.2020.05.20.16.26.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 16:26:37 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pranit.bauva@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] bisect--helper: avoid segfault with bad syntax in `start --term-*`
Date:   Wed, 20 May 2020 16:26:27 -0700
Message-Id: <20200520232627.30901-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.181.g8d5cacc8d1
In-Reply-To: <20200520195214.62655-1-carenas@gmail.com>
References: <20200520195214.62655-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

06f5608c14 (bisect--helper: `bisect_start` shell function partially in C,
2019-01-02) adds a lax parser for `git bisect start` which could result
in a segfault under a bad syntax call for start with custom terms.

Detect if there are enough arguments left in the command line to use for
--term-{old,good,new,bad} and abort with the same syntax error the original
implementation will show if not.

While at it, remove an unnecessary (and incomplete) check for unknown
arguments and make sure to add a test to avoid regressions.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* nicer implementation (per Junio) and description (per Eric)
* add test cases

 builtin/bisect--helper.c    | 13 +++++++++----
 t/t6030-bisect-porcelain.sh |  2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1c40b516d..ec4996282e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -455,9 +455,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
+			i++;
+			if (argc <= i)
+				return error(_("'' is not a valid term"));
 			must_write_terms = 1;
 			free((void *) terms->term_good);
-			terms->term_good = xstrdup(argv[++i]);
+			terms->term_good = xstrdup(argv[i]);
 		} else if (skip_prefix(arg, "--term-good=", &arg) ||
 			   skip_prefix(arg, "--term-old=", &arg)) {
 			must_write_terms = 1;
@@ -465,16 +468,18 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			terms->term_good = xstrdup(arg);
 		} else if (!strcmp(arg, "--term-bad") ||
 			 !strcmp(arg, "--term-new")) {
+			i++;
+			if (argc <= i)
+				return error(_("'' is not a valid term"));
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
-			terms->term_bad = xstrdup(argv[++i]);
+			terms->term_bad = xstrdup(argv[i]);
 		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
 			   skip_prefix(arg, "--term-new=", &arg)) {
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
 			terms->term_bad = xstrdup(arg);
-		} else if (starts_with(arg, "--") &&
-			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
+		} else if (starts_with(arg, "--")) {
 			return error(_("unrecognized option: '%s'"), arg);
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 821a0c88cf..f7ef15a384 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -859,7 +859,9 @@ test_expect_success 'bisect cannot mix terms' '
 
 test_expect_success 'bisect terms rejects invalid terms' '
 	git bisect reset &&
+	test_must_fail git bisect start --term-good &&
 	test_must_fail git bisect start --term-good invalid..term &&
+	test_must_fail git bisect start --term-bad &&
 	test_must_fail git bisect terms --term-bad invalid..term &&
 	test_must_fail git bisect terms --term-good bad &&
 	test_must_fail git bisect terms --term-good old &&
-- 
2.27.0.rc1.181.g8d5cacc8d1

