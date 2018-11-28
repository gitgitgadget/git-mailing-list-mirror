Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC98A1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK2Izu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 03:55:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Izu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:55:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so10817338pfk.10
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ucCY9qrEN9WKY9iPyZ8T/2pNVm+tAxugDv6DJWMUAdU=;
        b=nNK6WV7HupxVE09f8t48CT6oHcE1EyQlBiwCeIe0xrnmN4PYEVzBHFW/NVSaFfX93w
         nfCFtGmsx/zBkouQqhnelj1Hg7e76KDcIUSVgaqxYO4G5jCbmiSO02agiR19sHhvWUaL
         BwUgBuwEqTylnaUKIBGf7bhu9PHz4rHoKStYCXoznevS4Q6NnYS24shbAX9vO4I8+wBq
         cDq/V03GwlKWe/NzmP692AjFph/vCoCmvn7+2+Cxd039/Jr8KbpIqvornFVX21YOj3g9
         QsEzS4pwyOazKH8WTbaIfAiNCtyZpgIw82dGfXZ1OKEK+lMI/u49oK1XXccu6mlJngKC
         YY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ucCY9qrEN9WKY9iPyZ8T/2pNVm+tAxugDv6DJWMUAdU=;
        b=eOepxyhhbcrbvyauh4jIJv4sKRgHhLY9221JmeKOEYnPAXcjaV21aZeD3JtV/qPud2
         X3Gl4VImCk/kuzey1lgAUpKAkDkJfRIEcwjioDijXY0uP2fDhHcNPtKkBvlY19nndBgN
         G7IgK1M9eDYN8TfbXLX651/H6OG718+zrxP0CRN5o0nHHzWU6Hl9KYN6p3kjjNDdMRaV
         lGDUFGoyfbxLMn3WidtK016x8VC+j0as1VBjf19Spz7MCINXU6oQwjcFpNxNJ7gxvz38
         xAfUgfFTGtvxEILwAmXnBGFPa35nXmbNgC0wrW/lntbavfswBvHehF1ejdCBASPyFt+Y
         b94Q==
X-Gm-Message-State: AGRZ1gKP0aYemtt5hDMwbjaEIL75LBle7GtA+HAVAaIa5uM87ypFUylO
        8lZZgPsuEXENSNKpuh4Bi64OOxt4
X-Google-Smtp-Source: AJdET5fq1mJmSqeMI5myQmcVgbymxNognOSDN3O297RymPfMm43qS3ZZyoTWz/BuaJbAhHjHUipHbA==
X-Received: by 2002:a62:7687:: with SMTP id r129mr38897015pfc.17.1543441966329;
        Wed, 28 Nov 2018 13:52:46 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 186sm15933456pga.36.2018.11.28.13.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:52:45 -0800 (PST)
Date:   Wed, 28 Nov 2018 13:52:45 -0800 (PST)
X-Google-Original-Date: Wed, 28 Nov 2018 21:52:37 GMT
Message-Id: <9d6b8f6d0602e85652b2a748c58eeed4cbf4359e.1543441960.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] pack-objects: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a '--sparse' option flag to the pack-objects builtin. This
allows the user to specify that they want to use the new logic
for walking trees. This logic currently does not differ from the
existing output, but will in a later change.

Create a new test script, t5322-pack-objects-sparse.sh, to ensure
the object list that is selected matches what we expect. When we
update the logic to walk in a sparse fashion, the final test will
be updated to show the extra objects that are added.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-pack-objects.txt |   9 ++-
 builtin/pack-objects.c             |   5 +-
 t/t5322-pack-objects-sparse.sh     | 115 +++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 40c825c381..ced2630eb3 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] < object-list
+	[--shallow] [--keep-true-parents] [--sparse] < object-list
 
 
 DESCRIPTION
@@ -196,6 +196,13 @@ depth is 4095.
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--sparse::
+	Use the "sparse" algorithm to determine which objects to include in
+	the pack. This can have significant performance benefits when computing
+	a pack to send a small change. However, it is possible that extra
+	objects are added to the pack-file if the included commits contain
+	certain types of direct renames.
+
 --thin::
 	Create a "thin" pack by omitting the common objects between a
 	sender and a receiver in order to reduce network transfer. This
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5f70d840a7..7d5b0735e3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -84,6 +84,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int sparse;
 static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
@@ -3135,7 +3136,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge, 0);
+	mark_edges_uninteresting(&revs, show_edge, sparse);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
@@ -3292,6 +3293,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
new file mode 100755
index 0000000000..81f6805bc3
--- /dev/null
+++ b/t/t5322-pack-objects-sparse.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+
+test_description='pack-objects object selection using sparse algorithm'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	test_commit initial &&
+	for i in $(test_seq 1 3)
+	do
+		mkdir f$i &&
+		for j in $(test_seq 1 3)
+		do
+			mkdir f$i/f$j &&
+			echo $j >f$i/f$j/data.txt
+		done
+	done &&
+	git add . &&
+	git commit -m "Initialized trees" &&
+	for i in $(test_seq 1 3)
+	do
+		git checkout -b topic$i master &&
+		echo change-$i >f$i/f$i/data.txt &&
+		git commit -a -m "Changed f$i/f$i/data.txt"
+	done &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic2
+	^topic3
+	EOF
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+# Demonstrate that both algorithms send "extra" objects because
+# they are not in the frontier.
+
+test_expect_success 'duplicate a folder from f3 and commit to topic1' '
+	git checkout topic1 &&
+	echo change-3 >f3/f3/data.txt &&
+	git commit -a -m "Changed f3/f3/data.txt" &&
+	git rev-parse			\
+		topic1~1		\
+		topic1~1^{tree}		\
+		topic1^{tree}		\
+		topic1			\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt	\
+		topic1:f3		\
+		topic1:f3/f3		\
+		topic1:f3/f3/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_expect_success 'duplicate a folder from f1 into f3' '
+	mkdir f3/f4 &&
+	cp -r f1/f1/* f3/f4 &&
+	git add f3/f4 &&
+	git commit -m "Copied f1/f1 to f3/f4" &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic1~1
+	EOF
+	git rev-parse		\
+		topic1		\
+		topic1^{tree}	\
+		topic1:f3 | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_done
-- 
gitgitgadget

