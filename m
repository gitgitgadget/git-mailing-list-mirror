Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7168320D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdFAAbT (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:31:19 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33234 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdFAAbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:31:18 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so21631095pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nPIn/AMc/9gGpQj8il00alm1F9Bq+rgC4l6VwR/28I=;
        b=fP3oxVIkHBw/4JtBDKRySOvduJypmOCxZhAmKzDu0Ln6gE8Vm70X3cbUb3p/oAvciW
         vh+c8+wMTKHt0ZrV1zeIxTxTc/WaUXDCvnlUs2aFkp5v4Wn7yELumKJq+IZWkG/cC3GZ
         5HwECfioZGicmLJdyN8iO+mg8Ey+JGMKLz5cRRfmiR/pbaJAVbfOKY1rKHJbLma0CbZd
         292GVLKlQlaqqqvVM/IUoUgdMLC8TJZQsJ1KFYW/mFnABX87KKo22I6eXhFgSbyP8VKV
         8q0lvimWt/m9u+yQxMzTEch6hAMJzVlNbUSP/3EbVO1WTys7q8gHjriqxpcoT7jedQiP
         x+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nPIn/AMc/9gGpQj8il00alm1F9Bq+rgC4l6VwR/28I=;
        b=GLNiZ2AlNMxplgYRfHImAHSAfJhJMkuOG4/iAKnGaPEH0uHPKGsvqPrOOt+s71r0M6
         mQDfg4TEeg9rMKzFVUbVxzV5TQ3Cx36l3t6IGksomjfJe/bHXKCKwvsx0zJTB1M2fai3
         x8S3SGHdmZQ/O/ksiEhccA1UYc9K5wV583YLoqhyU1pwbxIHNVZ2sJIceHIje1AuzsmA
         TA6umz1j0I5RgpOy3yrTRv8D9TjKTSVHHRs5RgZkcJ2ncLRJqZdxAvrBKLNPwXtdRPBc
         5hCZIu3BjYGE4dzJoqdFdR6eea5zu0273GiZ2deZOU5UxonFTF03hJcbJwqex8F8YqCe
         vUAQ==
X-Gm-Message-State: AODbwcBDW3nuEyJsOdwwxt3AXhPt/VdVun/lO9RV4wSoCIaSfz8ZN7xU
        qW3BMaWQJKEzy14e
X-Received: by 10.99.103.7 with SMTP id b7mr36226189pgc.2.1496277062666;
        Wed, 31 May 2017 17:31:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7872:b8ac:87ee:2203])
        by smtp.gmail.com with ESMTPSA id 15sm28936516pfj.59.2017.05.31.17.31.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:31:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv3 4/4] builtin/fetch.c: respect 'submodule.recurse' option
Date:   Wed, 31 May 2017 17:30:50 -0700
Message-Id: <20170601003050.4221-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <20170601003050.4221-1-sbeller@google.com>
References: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
 <20170601003050.4221-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c             |  7 +++++++
 t/t5526-fetch-submodules.sh | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f2c2ab23e..c1ec3b03c3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -73,6 +73,13 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		fetch_prune_config = git_config_bool(k, v);
 		return 0;
 	}
+
+	if (!strcmp(k, "submodule.recurse")) {
+		int r = git_config_bool(k, v) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		recurse_submodules = r;
+	}
+
 	return git_default_config(k, v, cb);
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index f3b0a8d30a..162baf101f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "submodule.recurse option triggers recursive fetch" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git -c submodule.recurse fetch >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
 	add_upstream_commit &&
 	(
-- 
2.13.0.17.gab62347cd9

