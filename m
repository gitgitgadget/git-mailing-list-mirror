Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947512049B
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbcLZKX3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35767 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbcLZKWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:41 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so26995381wml.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1fne3igilwrQxmzY/R5q5Y8l+JjPDIfJDwcHXD2+lk=;
        b=Jo4rppU+y14ip5ZqamTQpDPJaTY5OpZ0UU4WJaetRFhTglvUZCxCxTc79JDpPRCWYQ
         ZwMloQEcyA/yjELv/rMyO3V9LSa2U3mbgr7tfA+Jf2izTqKqnIhKnTskFt9LLAbEe/Qi
         eL4ChdMsQoS5PsX0k8QTs8q2yQtODVd3FB8nT8GrDUo+CKYd1mQ9FQ2VMQyjvodKQGth
         +yHsMxOVp23QxeZQD1hR33ptPR4YELJckDSCAim+cxv0jsw3XYOV9RmaW6aqHO6yDKuA
         CsDeSiuKUbQD7gNmzSmkkJD5BFmxf7D2xYQvFJfsr1XISoZawRKna3pLh9eW2a8QAiBd
         19OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1fne3igilwrQxmzY/R5q5Y8l+JjPDIfJDwcHXD2+lk=;
        b=RTed3ggd2xWViJhYwoGxSDNDOXG00/1kD+/tY3QjjBNXefzN+bMNkIbIPTq8W8BxHb
         scWFAoXURtfu/257jo8e8e0HTFSnNSA3BxW3ZoVTkqVvGimvOCZ3eOixyFs2phmJpCFX
         VKJP7ukLVfK4A8W18mAxgh/643ztvovGBinT3cWkOj52GlLkTT0LyUunnT00Lq4gvV6u
         ehJJG7Pt0/bqNCrRXDKvze/D1ZT2zQBRz7MlnslHg1v2uuKX4BrB4bcxUnxjfxhrWmqg
         xM/q+rCHh5445HDHCoCPfPrb8SvXw8FrS0fyXPIoctTgmXYz2SRgZp3RUh8fUO9v9gwC
         rNYg==
X-Gm-Message-State: AIkVDXLychQI3tpg263oCQF3OlnObKR3nH1Mrb5IXL3NgyoBTQ8qjwQDA2Nz/GKtXudscQ==
X-Received: by 10.28.88.11 with SMTP id m11mr24191756wmb.45.1482747760230;
        Mon, 26 Dec 2016 02:22:40 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:39 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 06/21] t1700: add tests for core.splitIndex
Date:   Mon, 26 Dec 2016 11:22:07 +0100
Message-Id: <20161226102222.17150-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 292a0720fc..db8c39f446 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,4 +200,41 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set core.splitIndex config variable to false' '
+	git config core.splitIndex false &&
+	git update-index --force-remove three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<EOF &&
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+not a split index
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.209.gda91e66374.dirty

