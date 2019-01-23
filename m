Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699A01F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAWV7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:59:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44678 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWV7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:59:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so2930635edd.11
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEyNyfk8QKwTAdJfBQdQRyBKmNz+9c/mmb3rMHAN2RU=;
        b=nAwsYj0lnMu/7JURGcIvjhMbsVVgcCgRhwxoI8auJS9t0DH2hsT8k0iB6V5UR8xJ0C
         NR30VsIt9NGB2RvjmDs6yfa40kerqKJf+YEbZ8hk87WfqCJqvooVaA6eh0SvvYifwoaz
         NMGee13rkHPt5jh2mWwlVt9saP/RDdDdiHej0lM7hzdiKp7EcpjKjNy3WD/icngeszME
         n2PjiftWLja559yyDwCb8Ha+mwkQva/UKvyH1X8K0Du4TnKT3+XYNMdMekEq/RBypP3f
         Sj0WOKen+d95hYx7fX+rV94Op5NcgEFLf7dZ53fJ9jbaLWEbzekFmvXxaZFRbL/O+i/m
         N09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEyNyfk8QKwTAdJfBQdQRyBKmNz+9c/mmb3rMHAN2RU=;
        b=tr2jZD3smQ9J/Jzz9F4DlUYn8vCgi6LvKSpEAYX+JpHCkJmIavfSu9Mcrq/NYX0Pd+
         4f4W02lKTzCRbCIynqTldaIGPc3X5oq888e4Axm1jCmFVtOJelAai889iRxDiFqPhEN9
         gfcHyPBa/mI7n3JGF36VqNTl/3uB9CVA2X1levRK26+88T3rMEVj/BIRuUITRWBOML52
         1KSii6YuZubJnrPMI4zUp9JNBODqBbylorznk47+WUFBNZrUEKQ+MH8bwUpd3ASv2YUI
         nZNI1dGuVjl76ior678r3vMxsd9pFafSl3aaxQ3wU2ArAGjrTzNzCuT38gtbHlV74Ahx
         4tIQ==
X-Gm-Message-State: AJcUukfclqzA0E6Ruhm7GH1FdgpLDW6TIeLYtp45IIzzAwedt1a9CYN2
        r5EFyKAKdSPnjDasopAZeZMoftdD
X-Google-Smtp-Source: ALg8bN44IgrOv1wDwN5MymTcYVJKPkD7lp3NGbjYnu73y633gL6ypoToIz7ulLhGYR/71y7X0CLyQA==
X-Received: by 2002:a50:e045:: with SMTP id g5mr4358667edl.152.1548280760490;
        Wed, 23 Jan 2019 13:59:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26-v6sm5836358ejb.29.2019.01.23.13.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:59:20 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:59:20 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 21:59:13 GMT
Message-Id: <693900b4c5af9adb98d98549b9340ad9f9d09562.1548280754.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/6] commit-graph: test verifying a corrupt v2 header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph file format v2 changes the v1 data only in the
header information. Add tests that check the 'verify' subcommand
catches corruption in the v2 header.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3ff5e3b48d..be7bbf911a 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -497,6 +497,37 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'rewrite commmit-graph with version 2' '
+	rm -f .git/objects/info/commit-graph &&
+	git commit-graph write --reachable --version=2 &&
+	git commit-graph verify
+'
+
+GRAPH_BYTE_CHUNK_COUNT=5
+GRAPH_BYTE_REACH_INDEX=6
+GRAPH_BYTE_UNUSED=7
+GRAPH_BYTE_HASH=8
+
+test_expect_success 'detect low chunk count (v2)' '
+	corrupt_graph_and_verify $GRAPH_CHUNK_COUNT "\02" \
+		"missing the .* chunk"
+'
+
+test_expect_success 'detect incorrect reachability index' '
+	corrupt_graph_and_verify $GRAPH_REACH_INDEX "\03" \
+		"reachability index version"
+'
+
+test_expect_success 'detect non-zero unused byte' '
+	corrupt_graph_and_verify $GRAPH_BYTE_UNUSED "\01" \
+		"unsupported value"
+'
+
+test_expect_success 'detect bad hash version (v2)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\00" \
+		"hash algorithm"
+'
+
 test_expect_success 'setup non-the_repository tests' '
 	rm -rf repo &&
 	git init repo &&
-- 
gitgitgadget
