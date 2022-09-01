Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C56AECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 07:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiIAHJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiIAHIz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 03:08:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC46122692
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 00:08:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so8386383wrq.10
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=yBOFLcaherWCrpl3l7ZUl5EHvaEiO22gm/7/JrXSbwU=;
        b=oQ1CSBTp+CnNVqV1VJgIbzB/tMS2gqgRPzQxkqXH6M5t5DONl4vpG32jdtR+TaDxRN
         f19JkX+ZnZpV86NF2hJ7dhCpNvqQq7T1yTWq7KMOrdNT62MD6IQqpPV9iisfZWY7CbpJ
         xddq/NvT60ae8Gr11ffOX2/ebp5xMy5Eo4IEONZY4jkTg3E9VhQnT/QsVOlKqBs4s+pS
         hE4lflOoPFYd2q9wOKBGoeYFZrZLwqAjeXtw33ZwyOqlursfqqm/FRippWLupGuUV9SA
         0TS2n+PKQhCA+WKExPpaScWmfUmHWXWqxWtq8I1ZnM40WhYHepIOBENYpYiABRQqPo82
         r7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=yBOFLcaherWCrpl3l7ZUl5EHvaEiO22gm/7/JrXSbwU=;
        b=XgKLG3Wumk3bcCccvvK4YSJW5S5Y4yR6LDXNLLHWjYbRTLjvf1kfaFUkfazc89+LTF
         CV/m9XeTIzlX9UrW9Utz5Uclf0ndh6C1N8ycMxHdjFGn07bdJOc73ghOvDQpfmzlLwJH
         8VjKUHKKeMtYVcKIYdHbPCsTkQ5N6qJnO9rietahdst8ygGt/HcW7dUG1lJ+vUduwFWV
         +uphP7VAWyEHc/D8bGU8DiMzuMIaTPvY207wNDapMfXr9PqJEZO0QAjkwHwTD3KW6YDx
         jSbaY3dh8696Xf7kPZIGvaAov9YC+YcbIPMKgyoMtpdtsLjHHL4YClLehDNA1yFTGUlC
         CFew==
X-Gm-Message-State: ACgBeo2m7ChHF0NXnvLB8Fn99B2TU4kwpClmClF1F//FL+4Ej2TqhP2m
        HgZCdP2CM8b6/ITTFsMSXy6p06fQaRc=
X-Google-Smtp-Source: AA6agR5y9LycCqiuhkoqmL0bxmCDAMG0d5pAqwGQbqKfJ/0abi9QX2wHO8NyquR8Bh26nkN4y4YQOg==
X-Received: by 2002:a5d:47c9:0:b0:226:eb05:ecbc with SMTP id o9-20020a5d47c9000000b00226eb05ecbcmr4055762wrc.74.1662016093299;
        Thu, 01 Sep 2022 00:08:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q185-20020a1c43c2000000b003a5f783abb8sm4252485wma.30.2022.09.01.00.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:08:12 -0700 (PDT)
Message-Id: <3bd622d5b45d05b89de73536ae948ea4e24f9505.1662016088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 07:08:06 +0000
Subject: [PATCH v2 2/3] diff: fix filtering of additional headers under
 --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers.
Because there could be conflicts with no content differences (e.g. a
modify/delete conflict resolved in favor of taking the modified file
as-is), that commit also modified the diff_queue_is_empty() and
diff_flush_patch() logic to ensure these headers were included even if
there was no associated content diff.

However, when the pickaxe is active, we really only want the remerge
conflict headers to be shown when there is an associated content diff.
Adjust the logic in these two functions accordingly.

This also removes the TEST_PASSES_SANITIZE_LEAK=true declaration from
t4069, as there is apparently some kind of memory leak with the pickaxe
code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  |  2 ++
 t/t4069-remerge-diff.sh | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index d672efed7ab..85905261ce4 100644
--- a/diff.c
+++ b/diff.c
@@ -5860,6 +5860,7 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
 	int include_conflict_headers =
 	    (additional_headers(o, p->one->path) &&
+	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
 	/*
@@ -5915,6 +5916,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
+	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
 	if (include_conflict_headers)
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index e3e6fbd97b2..95a16d19aec 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,7 +2,6 @@
 
 test_description='remerge-diff handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
@@ -90,6 +89,22 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	test_cmp expect actual
 '
 
+test_expect_success 'pickaxe still includes additional headers for relevant changes' '
+	# reuses "expect" from the previous testcase
+
+	git log --oneline --remerge-diff -Sacht ab_resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'can filter out additional headers with pickaxe' '
+	git show --remerge-diff --submodule=log --find-object=HEAD ab_resolution >actual &&
+	test_must_be_empty actual &&
+
+	git show --remerge-diff -S"not present" --all >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'setup non-content conflicts' '
 	git switch --orphan base &&
 
-- 
gitgitgadget

