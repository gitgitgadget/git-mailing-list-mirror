Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C56C46467
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiK0Jho (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiK0Jhi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:37:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6369FEC
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u27so2129520lfc.9
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Fgc+YoLF0b/LpR5Ofg/128bJacrMlzfnaw/bNKWcvI=;
        b=M3mtmCtcc1FEVMHlE8sVj7cVJDtnX7WVFkOOsHxtoCCtsf66rVFWRGY6VeEvFbzOXF
         MhdhD5ipRa0BdaGCGujn/A1/sRFxCAKFaqGk7DBcAEaWW6d8L/6m5ZeAcyBt7VLRJd9j
         zgiGTrZMqZAjoP4dT0sxshi8yrScZbtq/hMxaypp9vAINDua7MB2m0NY8jBLBSdjjdEO
         BT058dOtQ2k5enwbJ9gHkLSg3FRPB/csX0hgYwmbObYteWn2+iaCV0lLTJySGOvlBoTE
         gOAN0gnsGFDo+UYJ7VKcsGc+5mTuH7E+i+pm92GRpoCQ9PYT4HlXmAWJQtQfh9pjsXtn
         S88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Fgc+YoLF0b/LpR5Ofg/128bJacrMlzfnaw/bNKWcvI=;
        b=o0X+qwqLRy72BVVX0C3aNiSXp6X/QmMULCe8S+XXqEpZAIchKs9UPoJo92Sg5F6TVi
         tHb1lHp0LCe2MOVd/7EMWalX2yldEPcmmHqBDPZSFVbJZ3+UTLUqcP2Wzp+NccbTNw60
         6QNMrwIdUVYlXr30rhnCQ07jcbANH/z7Y+BVSD6Ml2r/7eKnLZ+pJZvchDTN8OBJTv3s
         z+NpNWrIEAS/u7C2ezSAAuk0WKgGwvZDpu4HzavY3itqV8zmGYVm3MnDtLq5quATxqir
         cmGId9BRSqB8n0MS1SOpD/frfRqG14zKAY3PG0yCBmhdQV411JW4EB3q98eqo0mZiRcI
         FvMw==
X-Gm-Message-State: ANoB5pnJEcHVXONgkI77s2J5mprT2Cn4cSZ71O+Sn8ZVGOKlL6WJ5e2l
        VCXt+gxRBzIofktBnQABoq8=
X-Google-Smtp-Source: AA0mqf7a+7vMf5bBKK/v7ICxPiNhHuXfBHio0rqRb4bhD66thHinD+q/xH0bLVm8GLJUdWKlwWgGBg==
X-Received: by 2002:ac2:5921:0:b0:4b3:cdf5:93f3 with SMTP id v1-20020ac25921000000b004b3cdf593f3mr15010788lfi.99.1669541854545;
        Sun, 27 Nov 2022 01:37:34 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05651c168300b002770a48fd12sm835615ljb.102.2022.11.27.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 01:37:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 4/5] diff-merges: support list of values for --diff-merges
Date:   Sun, 27 Nov 2022 12:37:20 +0300
Message-Id: <20221127093721.31012-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127093721.31012-1-sorganov@gmail.com>
References: <20221127093721.31012-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support comma-separated list of options in --diff-merges=. This allows
for shorter:

  --diff-merges=on,hide

instead of:

  --diff-merges=on --diff-merges=hide

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt |  5 +++--
 diff-merges.c                  | 22 ++++++++++++++++++----
 t/t4013-diff-various.sh        |  8 ++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e64066af8d96..46c98c87e24f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -38,7 +38,8 @@ ifdef::git-log[]
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
-	`first-parent` is the default.
+	`first-parent` is the default. Comma-separated list of
+	supported values is accepted as well.
 +
 --diff-merges=(off|none):::
 --no-diff-merges:::
@@ -53,7 +54,7 @@ ifdef::git-log[]
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
 +
-	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'.
+	`-m` is a shortcut for '--diff-merges=on,hide'.
 	In addition it implies `-p` when `log.diffMerges-m-imply-p` is
 	active.
 +
diff --git a/diff-merges.c b/diff-merges.c
index cedd7652bf42..ddf9a411c49c 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -1,6 +1,7 @@
 #include "diff-merges.h"
 
 #include "revision.h"
+#include "strbuf.h"
 
 typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
@@ -110,12 +111,25 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 
 static void set_diff_merges(struct rev_info *revs, const char *optarg)
 {
-	diff_merges_setup_func_t func = func_by_opt(optarg);
+	char const delim = ',';
+	struct strbuf **opts = strbuf_split_str(optarg, delim, -1);
+	struct strbuf **p;
 
-	if (!func)
-		die(_("invalid value for '%s': '%s'"), "--diff-merges", optarg);
+	for (p = opts; *p; p++) {
+		diff_merges_setup_func_t func;
+		char *opt = (*p)->buf;
+		int len = (*p)->len;
 
-	func(revs);
+		if (opt[len - 1] == delim)
+			opt[len - 1] = '\0';
+		func = func_by_opt(opt);
+		if (!func) {
+			strbuf_list_free(opts);
+			die(_("invalid value for '%s': '%s'"), "--diff-merges", opt);
+		}
+		func(revs);
+	}
+	strbuf_list_free(opts);
 }
 
 /*
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8a90d2dac360..2c68d06074ed 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -485,6 +485,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'log --diff-merges=<V1>,<V2>' '
+	git log --diff-merges=1,hide master >result &&
+	process_diffs result >expected &&
+	git log --diff-merges=1 --diff-merges=hide master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'deny wrong log.diffMerges config' '
 	test_config log.diffMerges wrong-value &&
 	test_expect_code 128 git log
-- 
2.37.3.526.g5f84746cb16b

