Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809441F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbeAGSPR (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:17 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44189 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeAGSPO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:14 -0500
Received: by mail-qt0-f196.google.com with SMTP id m59so11276828qte.11
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qBK0V3XJ9HxbpNKwRVvdC/htyq47T3fumxC6gV9mDy8=;
        b=aOnisOCrniamEtil7x2VHCTiem0YQ+oNTDOVK8phbZ48YcdexbIzjbjbHGiOlXClOT
         EooxuRoVe5N00WAUvomcwgbhKQEwnRQjjeqqt8fePD5eD9xSmjM1y9HaO6xOKIiYD23T
         kVuM/3yO0Ujd7Q7uhxexyrqZHM56sqkhmR8n209XM95iWt2/Ge1WugDBrOWsnvXdO4iT
         9aI3QPuTtCE1GYlOYinOjAR5nyz/S5VD12Et3RdO3pPAK0uGqZpSlFPOxKS0iUdPiefa
         nzYPxBAkhpvHdneNxJeH7dO3mM1cZYMRjX276l+Ch6oHxFjj7oNraCKWL3QbqyJY1+OF
         u0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qBK0V3XJ9HxbpNKwRVvdC/htyq47T3fumxC6gV9mDy8=;
        b=ESH98/8e3QjrgsP5vgPHQCYWmCt181mlemvm69eF+0wuwDWAEqpbLVrR3KeFCfV70y
         rUJOuC6kbFLRp7sd5ApHY45gS4rlALJcTKrNXNIKNiOSdwkBeEuCUh+SRCP3roWTTxSJ
         RdaRyJre5pUpk9fjly4AhFOyo/oTtlZvMjFYHyhxOsRhiGFBdb/gB7HZWUXNgOTXmRfh
         xgE+bATObK8ftIoQjVW7UkM98n37X4DDeCXAD5RdGZPD1obkrddQsIvJtx1D+pBIQhz9
         wBt9YHkFoAhjD4v6kt+AUAL7CiFDAvJ2jjxRvqz+aFJCukUp01PKtObEdqLzoA+wWWrk
         aV8Q==
X-Gm-Message-State: AKwxyte+fCA2J51Ot0YPqnnEai2el/ckb+cvqI0hjHxpNT15OgMf/dmi
        owxUThr2IGfjDNd4zkLzYk7XwS2UWWY=
X-Google-Smtp-Source: ACJfBouutke9d+9MTQJMtwWwslqUedB0GhfuPM8qfUxAYLSGuihN3ZwEQftxrkyazuxUGGbMkFdn0g==
X-Received: by 10.237.44.226 with SMTP id g89mr12517723qtd.108.1515348913318;
        Sun, 07 Jan 2018 10:15:13 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:11 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 06/18] midx: add t5318-midx.sh test script
Date:   Sun,  7 Jan 2018 13:14:47 -0500
Message-Id: <20180107181459.222909-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test interactions between the midx builtin and other Git operations.

Use both a full repo and a bare repo to ensure the pack directory
redirection works correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-midx.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100755 t/t5318-midx.sh

diff --git a/t/t5318-midx.sh b/t/t5318-midx.sh
new file mode 100755
index 0000000000..869bbea29c
--- /dev/null
+++ b/t/t5318-midx.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='multi-pack indexes'
+. ./test-lib.sh
+
+test_expect_success 'config' \
+    'rm -rf .git &&
+     mkdir full &&
+     cd full &&
+     git init &&
+     git config core.midx true &&
+     git config pack.threads 1 &&
+     packdir=.git/objects/pack'
+
+test_expect_success 'write-midx with no packs' \
+    'midx0=$(git midx --write) &&
+     test "a$midx0" = "a"'
+
+test_expect_success 'create objects' \
+    'for i in $(test_seq 100)
+     do
+         echo $i >file-1-$i
+     done &&
+     git add file-* &&
+     test_tick &&
+     git commit -m "test data 1" &&
+     git branch commit1 HEAD'
+
+test_expect_success 'write-midx from index version 1' \
+    'pack1=$(git rev-list --all --objects | git pack-objects --index-version=1 ${packdir}/test-1) &&
+     midx1=$(git midx --write) &&
+     test_path_is_file ${packdir}/midx-${midx1}.midx'
+
+test_expect_success 'write-midx from index version 2' \
+    'rm "${packdir}/test-1-${pack1}.pack" &&
+     pack2=$(git rev-list --all --objects | git pack-objects --index-version=2 ${packdir}/test-2) &&
+     midx2=$(git midx --write) &&
+     test_path_is_file ${packdir}/midx-${midx2}.midx'
+
+test_expect_success 'Create more objects' \
+    'for i in $(test_seq 100)
+     do
+         echo $i >file-2-$i
+     done &&
+     git add file-* &&
+     test_tick &&
+     git commit -m "test data 2" &&
+     git branch commit2 HEAD'
+
+test_expect_success 'write-midx with two packs' \
+    'pack3=$(git rev-list --objects commit2 ^commit1 | git pack-objects --index-version=2 ${packdir}/test-3) &&
+     midx3=$(git midx --write) &&
+     test_path_is_file ${packdir}/midx-${midx3}.midx'
+
+test_expect_success 'Add more packs' \
+    'for j in $(test_seq 10)
+     do
+         jjj=$(printf '%03i' $j)
+         test-genrandom "bar" 200 > wide_delta_$jjj &&
+         test-genrandom "baz $jjj" 50 >> wide_delta_$jjj &&
+         test-genrandom "foo"$j 100 > deep_delta_$jjj &&
+         test-genrandom "foo"$(expr $j + 1) 100 >> deep_delta_$jjj &&
+         test-genrandom "foo"$(expr $j + 2) 100 >> deep_delta_$jjj &&
+         echo $jjj >file_$jjj &&
+         test-genrandom "$jjj" 8192 >>file_$jjj &&
+         git update-index --add file_$jjj deep_delta_$jjj wide_delta_$jjj &&
+         { echo 101 && test-genrandom 100 8192; } >file_101 &&
+         git update-index --add file_101 &&
+         commit=$(git commit-tree $EMPTY_TREE -p HEAD</dev/null) && {
+         echo $EMPTY_TREE &&
+         git ls-tree $EMPTY_TREE | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+         } >obj-list &&
+         echo commit_packs_$j = $commit &&
+	 git branch commit_packs_$j $commit &&
+         git update-ref HEAD $commit &&
+         git pack-objects --index-version=2 ${packdir}/test-pack <obj-list
+     done'
+
+test_expect_success 'write-midx with twelve packs' \
+    'midx4=$(git midx --write) &&
+     test_path_is_file ${packdir}/midx-${midx4}.midx'
+
+test_expect_success 'write-midx with no new packs' \
+    'midx5=$(git midx --write) &&
+     test_path_is_file ${packdir}/midx-${midx5}.midx &&
+     test "a$midx4" = "a$midx5"'
+
+test_expect_success 'create bare repo' \
+    'cd .. &&
+     git clone --bare full bare &&
+     cd bare &&
+     git config core.midx true &&
+     git config pack.threads 1 &&
+     baredir=objects/pack'
+
+test_expect_success 'write-midx in bare repo' \
+    'midxbare=$(git midx --write) &&
+     test_path_is_file ${baredir}/midx-${midxbare}.midx'
+
+test_done
-- 
2.15.0

