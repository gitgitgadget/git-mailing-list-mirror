Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959091F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeKAWtb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42510 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKAWtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id z20-v6so21060027qti.9
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nnlYnor2jca28BytU8+iX6lJi/U1iwWUVEVAahWFOA=;
        b=bJhwPRoMYXsLZrNNL0EJb01MIt0rt1bjosakIJE/f8/rA8R7BMa1j619xtr3JHgtTk
         fNnUfJ/0TF1qJiSY2aa6aQhHE6qO94EsuJRD+R5Qhl6hsodDnydVRG3YwN7vh19Ijwjg
         SrXuXYsAnpQpeEc6Us+dy2CzwafuIqRQkyG96ajtVSpdHcUJYw7xg+q8mULT7KCZCb1d
         pcCONmuEd4spe9kZEPJEGZV9oJiDT/gtURSyLjiZmcPs39jMxVOZRXu6CX2Akeh6Z4GS
         HG/vMV5BuuJHikRuY3UT1zNOilKPRvMw037oIRTwJLsGKdoWf3Dt+UYph9UTY6qfQ6y8
         zCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nnlYnor2jca28BytU8+iX6lJi/U1iwWUVEVAahWFOA=;
        b=Pc5pIp+Ehh0Mez9vXLbI9SaWaz8C32vjaH+Z0RVlRh39hzHhdpn0j0IjJwZBNUoKT9
         gzX2N0VH+X781Hn15oGX5di7SFZPIbYNXC44HcdlsR6g5Nt4jbjuMTQT7w7RBjW8j3dh
         DqioFvnOw9RJjiVqhSlM3/khRLlDKmES97LFFHVXt+8wrd7wxur2/83oPv3CdZRekOVh
         baizKnj2MlucO5OHbq8Er/tcl9tVIo6IBQc2QtiMgbx33vElNeTvwsfFP0B83RR2oWFG
         NaXZYdiPiaaDOGegwpuYi8kgMNgomOsnpJRCmhVtMU81Hb1mSbZmNE9bRX1Z6EmA78AA
         9++w==
X-Gm-Message-State: AGRZ1gIo9Cy64FbYg/XuVi+ihuEJOezsVOM//VxUQR+JOnTDoOHAP5xC
        dDZLw5x4ZjbRDi7UoxMlWz1kYSFh
X-Google-Smtp-Source: AJdET5f9fPRiQ1B92ikv9PAizFFTN20WJiXkZsZLhR5Ttmu1GZ5kvzHpW0IjCdI2NQr71xzuB0Ziug==
X-Received: by 2002:a0c:98d1:: with SMTP id g17-v6mr6770449qvd.13.1541079988862;
        Thu, 01 Nov 2018 06:46:28 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:28 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 2/7] test-reach: add run_three_modes method
Date:   Thu,  1 Nov 2018 13:46:18 +0000
Message-Id: <20181101134623.84055-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181101134623.84055-1-dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'test_three_modes' method assumes we are using the 'test-tool
reach' command for our test. However, we may want to use the data
shape of our commit graph and the three modes (no commit-graph,
full commit-graph, partial commit-graph) for other git commands.

Split test_three_modes to be a simple translation on a more general
run_three_modes method that executes the given command and tests
the actual output to the expected output.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..9d65b8b946 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -53,18 +53,22 @@ test_expect_success 'setup' '
 	git config core.commitGraph true
 '
 
-test_three_modes () {
+run_three_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual
 }
 
+test_three_modes () {
+	run_three_modes test-tool reach "$@"
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
-- 
2.19.1.542.gc4df23f792

