Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9F61F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfBUWiO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33879 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUWiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so276418wrg.1
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYwhCnigIGvuKzgeqzXxmU3okoSOlqsYdlNMuROM5yA=;
        b=SWXoPqV1y6AyQHW4uuRDxEtrMn8VJEjw0bFWCzdHLZ6byj49KJT5oMbxGk4SYZlhOj
         /543WOiGInIpwfMU2dzXSljTGO6qA8P2+0sNGHlQAyhijNb46cclNIGuqBE0lyDJ21j1
         0uN92lBri2sAtopwjw401F7Crl5PvFviicCnFYX99wQ9X8sidLVmP2D6MwdyuB8qJCEg
         w2R9F2JHSYLnyg1EvonpexmFWvSn4h4rlQhPID/RcdgpmgzX/GoQx1NII0THe6PO7JhH
         SGjqT/qOb3KT7e1QjVYaUZEILufzIfSW49sbSZA2At2p8/OiD/XYARwjvjMF302o44Hc
         7P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYwhCnigIGvuKzgeqzXxmU3okoSOlqsYdlNMuROM5yA=;
        b=YQyrYwGKjJC9mvsYBa6t88ordAjpRmxw7OoJv5g8rShBM+tpb30yMKL1u9yS3bm6Ut
         1Smr/0NwqbI+zWGWYYOTAF3+fO+tBgTC9TgLaHL4jPyxCbVaDEbY7aNA3Vquf7FlY+tq
         m64RNCJUXQ7/rVdEnkMKL45tGdrAk/VqbZWb9ogLBX1rPrQyxvbdcGNJYnd1zy13Pz/Z
         /07xDQw+JbuiIfzcE5sv8lo0FCK2XOndddGBnSQIvAK5B6hwOrRkWEOA+HEBBnsk4fua
         JY6Yix2Z22qkwBnK0TaP81GxlY+Hor09lU5hPahqCViUSrWdjFiwhwqpwC1rMcenyzjZ
         2rDA==
X-Gm-Message-State: AHQUAuaFKQRNcoe0OdTDVpJdHeVBdCI9I6eaDaQbTc7VgWAU+sxK8dmp
        ytVDpS3B+o/U0oj9ezpoolreBYNJ3Do=
X-Google-Smtp-Source: AHgI3IY3PX0mPFVxB2+102Tfdc0svANQUDIguqF/XYABJ75VQNLuIXWqmx71Xn77vqKvXGr/D6Bpjg==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr588713wrp.164.1550788691801;
        Thu, 21 Feb 2019 14:38:11 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] commit-graph tests: test a graph that's too small
Date:   Thu, 21 Feb 2019 23:37:47 +0100
Message-Id: <20190221223753.20070-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the recently split-up components of the corrupt_graph_and_verify()
function to assert that we error on graphs that are too small. The
error was added in 2a2e32bdc5 ("commit-graph: implement git
commit-graph read", 2018-04-10), but there was no test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 725b7ce51f..733be2ed30 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -399,6 +399,12 @@ corrupt_graph_and_verify() {
 
 }
 
+test_expect_success 'detect too small' '
+	corrupt_graph_setup &&
+	echo "a small graph" >$objdir/info/commit-graph &&
+	corrupt_graph_verify "too small"
+'
+
 test_expect_success 'detect bad signature' '
 	corrupt_graph_and_verify 0 "\0" \
 		"graph signature"
-- 
2.21.0.rc0.258.g878e2cd30e

