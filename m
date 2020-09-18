Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC334C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52DA21D7B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glr7iBMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgIRLTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIRLTf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33BC06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q4so2997886pjh.5
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHsWF7dJdbWokH4rE+MBlWYCUaAGHLxaSJocNbDCLBw=;
        b=glr7iBMj5pnGcvpBzfa4uGpresCA9EaXpSn1M4cLn/A+GYOhcW8Rb7DylycyvaJsZ7
         jchLt2EgkcCbrL0eBpJjZRvPmAZtKj4C6/DGkMB7lpW87IZT9HeqDFY24uvhHa/L8T8q
         Hj0p26HeLO1wDQxoL1xitAW6ZMwR5rW0ctpVjfUWMQ6HyBfcdiJut/rwx0591a05H2Z1
         0hR+UipdWx/+xFu6LsaAA4MV5e1h0jsj+CT21PalzjpqulT35krTjwD8ZQ+lIahwddmZ
         SXPVCto+rJz97axL/27Ah/d/bTwZR77AIkbtaig9kpSou7X3R+byKsQXZoDafIxNBrX+
         lgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHsWF7dJdbWokH4rE+MBlWYCUaAGHLxaSJocNbDCLBw=;
        b=SxO+CDlT4Iymkst4gteh4riNOT0hRNTUP/NRRN+xaOWMmkB9P6cQfxbuh4lfqlN35Y
         bmM9sgLs/olkEXWHkVzna2XuABttgDNnkkqwRxpe2JSVESwcEiV4cjMce2EfskLQT4Vc
         MmAYs+41CqspT/SIn+CfKkRvQLJpCBd5ueczJtFE6LFljmsbnII5ufbjrtMaVful96yn
         qhe16yZcojqBZ0wMe63beGATesbu7gX8MeWyq15Wi7zvdQ8rX08/pIhzAThnVhfqCHXc
         zDyP2Vs0/uSgAKXJgGJG4ngTbTjAhlV7+XM4XW6Xz122RFG6G8LFK9nThlA8CD2Mj/GX
         dHqg==
X-Gm-Message-State: AOAM530cbR7zN2tmBUklh2ZXcM5cxZpHecxDAY0X2jFNdp2L3ls0oilD
        /5BKx5Qg9+nMI3vBNLHa7wasP9sr6kM=
X-Google-Smtp-Source: ABdhPJwDyqRyZuJYmJFk+siUkohir/wv3JrCsXtBQqcWn0oHk7EiYsjUe1JudLJE5oZNp5ShgTd6sw==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr12403704pju.142.1600427974651;
        Fri, 18 Sep 2020 04:19:34 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id x4sm3034120pff.57.2020.09.18.04.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 04:19:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Date:   Fri, 18 Sep 2020 04:19:03 -0700
Message-Id: <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600427894.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user needed the null OID for scripting purposes, it used to be
very easy: hardcode 40 zeros. However, since Git started supporting
SHA-256, this assumption became false which may break some scripts.
Allow users to fix their broken scripts by providing users with a
hash-agnostic method of obtaining the null OID.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-rev-parse.txt | 4 ++++
 builtin/rev-parse.c             | 4 ++++
 t/t1500-rev-parse.sh            | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 19b12b6d43..b370d425d7 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -285,6 +285,10 @@ print a message to stderr and exit with nonzero status.
 Other Options
 ~~~~~~~~~~~~~
 
+--null-oid::
+	Print the null OID (the OID containing all zeros). This OID is
+	used to represent a non-existent object.
+
 --since=datestring::
 --after=datestring::
 	Parse the date string, and output the corresponding
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ed200c8af1..4e4ca99775 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -910,6 +910,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				}
 				continue;
 			}
+			if (!strcmp(arg, "--null-oid")) {
+				puts(oid_to_hex(&null_oid));
+				continue;
+			}
 			if (skip_prefix(arg, "--since=", &arg)) {
 				show_datestring("--max-age=", arg);
 				continue;
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 408b97d5af..8c1bd543ef 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -185,4 +185,10 @@ test_expect_success 'showing the superproject correctly' '
 	test_cmp expect out
 '
 
+test_expect_success 'rev-parse --null-oid' '
+	echo "$(test_oid zero)" >expect &&
+	git rev-parse --null-oid >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0.618.gf4bc123cb7

