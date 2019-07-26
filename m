Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EFC1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 04:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfGZE5I (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 00:57:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41669 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGZE5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 00:57:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so23886827pff.8
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEe/VDBkh7P3QXR8vgqkPB630JGrDQ+Rfr2P1/nBFgs=;
        b=Q1ss/HYFnvBdhU+TPbwH76S5IMH7cHUhraWZvl0GgFjVFkAffC5U+nWfqd64eKNAIE
         iQATI7mDOZo+Jj8kysViZiBtsaYmg/yCrvNGREIkGwO9sXLGUrh4xWfb+f1zHl/U7Sat
         QXA6uFcHNTjcI2+BETdA0b2fjoAQvOuo6sQfjBQUQ1RgpLD8kAfXlMmPoa55TAHg/pnd
         JyubI9hix4uboFq0QAWEHM4ByHYaMiSxX77fi8m3rdAOOahz5AMEFZxwj5pMf7I3V275
         JbxmmSbXbx/0CUO5q9bumpBlmjWl3nYtDkYvAvd7fgddPCsItkA6iWy3jlqoh6m4q1wX
         QEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEe/VDBkh7P3QXR8vgqkPB630JGrDQ+Rfr2P1/nBFgs=;
        b=FF5LbjvtVnO8WIiBWKRDhIgHo3yyvi3TNmxambI4ds4/Cd2tKXMizdCotb5uQbqNCq
         v0LA62BCK/1qrA/0wDeBpUvtEwCsW6P/wa4zuzo68slIKJmNscBKESVlpzdlvu+dhz4P
         gcC/SL4F18SH2T5BpC6SX+KquMakjmKvm0CLPNOUZAQbLQzkEsStGRYJG3Cg/qhUZuCA
         bP+Vj8oW2PJZyrCV2nbVyIs4d9xMZmG2C/2WF2dqAKR4M7UEMlMSQw+mitrn7GT2vgq8
         j2lEFvjAfBBZMgm/lCTb/096pUsVDGE9aWo8mc2WsUWg1iOyJjBIBoW2LqRG3j/tIHre
         GoeA==
X-Gm-Message-State: APjAAAXe0JHj0XojeepZkaUH5M53tN2J5muQIQ1alBFbuW4d+r59BBss
        3fELeyWg9JFEnUGBoYddwZM=
X-Google-Smtp-Source: APXvYqxD4LnLhdsd6ijOahWHZXpRKjRnz5mOj8HHMWqTtwgyQ46yE3pvqiaP1EA/Or/6WqjMLbdXzw==
X-Received: by 2002:a62:d0:: with SMTP id 199mr19411534pfa.253.1564117027654;
        Thu, 25 Jul 2019 21:57:07 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id l1sm66430734pfl.9.2019.07.25.21.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 21:57:07 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH] checkout.c: unstage empty deleted ita files
Date:   Thu, 25 Jul 2019 21:56:45 -0700
Message-Id: <20190726045645.2437-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. After `git checkout HEAD` or `git restore --staged`,
the file should be identical in the index and HEAD. This patch provides
the desired behavior even when the file is empty in the index.

Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
CC Jeff because you wrote the code that I am changing now.

checkout.c:update_some() discards the newly created cache entry when its
mode and oid match those of the old entry. Since an ita file has the
same oid as an empty file, an empty deleted ita file passes both of
these checks, and the new entry is discarded. In this case, the file
should be added to the cache instead.

This change should not affect newly added ita files. For those, inside
tree.c:read_tree_1(), tree_entry_interesting() returns
entry_not_interesting, so fn (which points to update_some()) is never
called.

To the best of my understanding, the only other command that makes
changes to the index differently for nonempty vs empty deleted ita files
is "reset", which I am fixing in [0]. I am separating the two changes
because this change affects "restore", which has not reached maint yet.

[0]: https://public-inbox.org/git/20190726044806.2216-1-vcnaik94@gmail.com/

 builtin/checkout.c        |  1 +
 t/t2022-checkout-paths.sh | 11 +++++++++++
 t/t2070-restore.sh        | 11 +++++++++++
 3 files changed, 23 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 91f8509f85..27daa09c3c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -126,6 +126,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	if (pos >= 0) {
 		struct cache_entry *old = active_cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
+		    !ce_intent_to_add(old) &&
 		    oideq(&ce->oid, &old->oid)) {
 			old->ce_flags |= CE_UPDATE;
 			discard_cache_entry(ce);
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index fc3eb43b89..74add853fd 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -78,4 +78,15 @@ test_expect_success 'do not touch files that are already up-to-date' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checkout HEAD adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git checkout HEAD nonempty empty &&
+	git diff --staged --exit-code
+'
+
 test_done
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 2650df1966..09b1543a5b 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -95,4 +95,15 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 	)
 '
 
+test_expect_success 'restore --staged adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git restore --staged nonempty empty &&
+	git diff --staged --exit-code
+'
+
 test_done
-- 
2.22.0

