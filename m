Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5431A1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfBUWiM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33257 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUWiL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so7644531wmb.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTWf9fgq0IVoaqDvBCDZIcD4IyIi0gQEXrxB/1PSfpU=;
        b=nA6g6yaMGiKWJayunggmRiZaEUWYJzQdnsG2mUFRqIU2Yj3p5BzKmOpwYbD4ynml68
         kSU61vHu8iJ20/IjozT9Gq5jGUgAbL9ihMTSJ1WvOD9JgKAiqIP6yNjNMZ2nsQVdBvIw
         UpSSPiUGv0S/QwJbZHnCDu6X6UoSakLD5aQik8t6Y5asWlOPQ+QWf9mtbwFZhlOlgX0M
         korIN3VR7AG99dbA5sTR6e+yuOXc2atc8VjsZjRQYNiA1ii+4O4/5esbRe6LSwLChGGL
         75LvoNoxIOsGWBPnIy8niDgfBnnvfbVMauCikuAvYGK2CNR+LBkJpmpCZza3FQpwguDt
         KvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTWf9fgq0IVoaqDvBCDZIcD4IyIi0gQEXrxB/1PSfpU=;
        b=JhAiEOdRiUZCK6JVRXNdiQAq+SLK9tzAPhZkshlODE9MIIwczm3GLZB4kMROOKU2Dq
         BZI6SRX66ICEa1jsr6QqCuu9DHzu4Hhuy4eCMiHcLaXIe+3R1+zVPb53tFdc5NoNgxo/
         FARnpVl1j2jvJvsNgtPAaNpsuFCvd+qVcBfiVpot12kM2bMEr/wrdNQCcOMVbtwI0m0E
         VLbME6pyuBABFSY9GhlOVaQiczTdwmSmXRQrDipXeNzeyz70/V8+1SGVAkCqBYB+5Hm0
         TD8WgkmVBZ9z9Iv0cAZC9sBBg+0aRc5IUmygfmMNd4+QiDH1z8E42hZwBxhtsTU6aVV6
         tprw==
X-Gm-Message-State: AHQUAuZs76OV6pKS75K++KS9xOAzYNg31KDMqqZOEPkAHgSscRTkVJJV
        32wevnOxb9L7kWv/n78lDBpwXzLQwdY=
X-Google-Smtp-Source: AHgI3Ib0XkCrKuc9pM9ch7TkZ1eGHJnJ2JdBFhZnRvks9Pn+mOIVo/YOvCJSJZ7EiDxhNJ8fKep3+w==
X-Received: by 2002:a1c:a4c4:: with SMTP id n187mr455874wme.15.1550788689654;
        Thu, 21 Feb 2019 14:38:09 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] commit-graph tests: split up corrupt_graph_and_verify()
Date:   Thu, 21 Feb 2019 23:37:46 +0100
Message-Id: <20190221223753.20070-2-avarab@gmail.com>
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

Split up the corrupt_graph_and_verify() function added in
d9b9f8a6fd ("commit-graph: verify catches corrupt signature",
2018-06-27) into its logical components of setting up the test itself,
doing the corruption in a particular way with "dd", and then finally
testing that stderr is what we expect.

This allows for re-using everything except the now slimmer
corrupt_graph_and_verify() to corrupt the graph in a way that doesn't
involve inserting a given byte sequence at a given position,
e.g. truncating it entirely to a custom value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d4bd1522fe..725b7ce51f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -366,6 +366,19 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
 GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 
+corrupt_graph_setup() {
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	cp $objdir/info/commit-graph commit-graph-backup
+}
+
+corrupt_graph_verify() {
+	grepstr=$1
+	test_must_fail git commit-graph verify 2>test_err &&
+	grep -v "^+" test_err >err &&
+	test_i18ngrep "$grepstr" err
+}
+
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
 # Manipulates the commit-graph file at the position
 # by inserting the data, optionally zeroing the file
@@ -376,17 +389,14 @@ corrupt_graph_and_verify() {
 	pos=$1
 	data="${2:-\0}"
 	grepstr=$3
-	cd "$TRASH_DIRECTORY/full" &&
+	corrupt_graph_setup &&
 	orig_size=$(wc -c < $objdir/info/commit-graph) &&
 	zero_pos=${4:-${orig_size}} &&
-	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
 	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
-	test_must_fail git commit-graph verify 2>test_err &&
-	grep -v "^+" test_err >err &&
-	test_i18ngrep "$grepstr" err
+	corrupt_graph_verify "$grepstr"
+
 }
 
 test_expect_success 'detect bad signature' '
-- 
2.21.0.rc0.258.g878e2cd30e

