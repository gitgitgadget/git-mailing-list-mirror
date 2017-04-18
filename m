Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077881FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbdDRON1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 10:13:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36374 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdDRONZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 10:13:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id o21so25037512wrb.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BM+palKet897ujUQ2AWGFn6oNf0RuhI9nuFDW2fcHT8=;
        b=V0POWraRtTiU6WwpH4hqmvF1Flw+xwuFDanTN9fk+HcqApKR6FzZVc3dkGQE0T8ITD
         lTnu+SOZ4CjVZ4G2N8s/kC7cCqbGrHMGR/iQ1l/+Eud34AsexcJJb3sLnZyCDLguISAD
         +dac4M5BlN/Pou51Zcf/7o3UvDf1cr2LfKKo0GAHEywI08JHgAPQ6mV8ql7XtL8AZHLv
         ItzdighQO2leNV8TaeqlaIyCD9QytLMZvTJc4OuKB/XEKYGebzqUwFbCUQIrhdxD6nc9
         tHH+4h9lEnsCOfL2eda0+6BZ9TpHYL3gTbITb7t/x94AjFuLpNWd/X3PZZRALWY+Qg2M
         wuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BM+palKet897ujUQ2AWGFn6oNf0RuhI9nuFDW2fcHT8=;
        b=Mjp0Cg6PXAHDckipmpxvs8tk3aXdvUVGzyzT4QFYDlmfqxZo4ijLwN395VSzvRgNUt
         itfZ3FYRNoWDfKnfJfh4cpAkUJN34uvwcwSdBYWl5eB+vBgbUr3lseCt+VOV3wD1lku/
         bV4FAHk0snMuTGr5b1duDM7HFC+Ctss+v8BU5P5FlqfWahZSf3oDMctZFrex51rhpJvs
         HnPKVEDkO3tx/iOlTNcBmudGYmVa4CGKDjRMgyCYiyZQkum5cAXVBDkxjICaOZNgCu+e
         j6d30hF7EpDLq2fTVYhJ+ddQ477ciECmJe3Aaq29h3FPvx+IUzKjcLPswkjK8c0nzgq2
         2QUA==
X-Gm-Message-State: AN3rC/4kn1ZfWydms9vLmvStYl7OCk5i6YYEldga+fhLUWLeJjcEQu52
        y/SU/Dbtj3sQ7A==
X-Received: by 10.223.178.131 with SMTP id g3mr22324924wrd.12.1492524804389;
        Tue, 18 Apr 2017 07:13:24 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id n45sm18775960wrn.30.2017.04.18.07.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 07:13:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] p3400: add perf tests for rebasing many changes
Date:   Tue, 18 Apr 2017 16:13:09 +0200
Message-Id: <20170418141309.20381-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.2.635.gf331bb6d3a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebasing onto many changes is interesting, but it's also
interesting to see what happens when rebasing many changes.

And while at it, let's also look at the impact of using a
split index.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/p3400-rebase.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index b3e7d525d2..ce271ca4c1 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -5,7 +5,7 @@ test_description='Tests rebase performance'
 
 test_perf_default_repo
 
-test_expect_success 'setup' '
+test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -b base &&
 	git checkout -b to-rebase &&
 	git checkout -b upstream &&
@@ -33,4 +33,24 @@ test_perf 'rebase on top of a lot of unrelated changes' '
 	git rebase --onto base HEAD^
 '
 
+test_expect_success 'setup rebasing many changes without split-index' '
+	git config core.splitIndex false &&
+	git checkout -b upstream2 to-rebase &&
+	git checkout -b to-rebase2 upstream
+'
+
+test_perf 'rebase a lot of unrelated changes without split-index' '
+	git rebase --onto upstream2 base &&
+	git rebase --onto base upstream2
+'
+
+test_expect_success 'setup rebasing many changes with split-index' '
+	git config core.splitIndex true
+'
+
+test_perf 'rebase a lot of unrelated changes with split-index' '
+	git rebase --onto upstream2 base &&
+	git rebase --onto base upstream2
+'
+
 test_done
-- 
2.12.2.635.gf331bb6d3a.dirty

