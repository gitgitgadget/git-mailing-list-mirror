Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039971F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeKAWti (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43420 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbeKAWth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id r71so12265516qkr.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfOpbrH3Foli8dcwKpuNHg3WgKDlWxb4bmL4ZzG2yiU=;
        b=AF14dEIS7zrIlbZIgSGt/XmoGR4jPCq+eGtC9p3LpE1eI820mY98Tf7CVH60Ku70mX
         CwXmDD30u3yvM3bnYvfw2WAtFJnLy4AxctZuNv8MIHuT+bWdsEIA5N4SWf7RjLeVvrOJ
         BW1Fm2PDT0zqUkyrLE0tfGDAGSzisW9cjYB1Y9edmLARFKSC9P7+iwc7HSkB9MA23u3i
         6k35IvAZc264p8l5+9340NYKzN8Cw6Y6WUVFRbiWvo/Y0jk9bKXE6xrM9e6AmgzZEeZI
         V4YAHyNgLaAM4P0PAMmMezi5/EtE2+InvGzKiU9A9h6ejexsObYc64M+oMGlO+e3pr2i
         v+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfOpbrH3Foli8dcwKpuNHg3WgKDlWxb4bmL4ZzG2yiU=;
        b=Kbzc7t55ylWb8sshSI1qJyNeAd2DyzRkItFMoCrhQK1Id7e2V8tIR1SW5kwbLyQ75F
         0TN+rc3UYXLQaNguXTni5CcAP7/oAhS0N02l6etSP8UTDIwlogXL/GB9HHLmusgFuJm6
         jl8fzprGZto3mQVFnlts4iHKltiSOdmVt1XDh0lKxHmPTCiXD3FVAoT9gjxNGr2UoSaS
         KH0GqrQd3tYCsD0XG7HQBx4TIIPtiY7yeRmjdLQzYZ+C+GLR/dqNZYG28oa5fOO6vJOU
         Z+qM8AyzvwKAML8dEv/VYni2eZTfe1sshEdP3rcmOrukhSFrCaBx3lPn0V8w2QISVRgG
         TOEg==
X-Gm-Message-State: AGRZ1gIV+0jUOMFWYomkr/tF3r8vhJIxIl8330kdfxeopfpjtqNgbO1Z
        wSvW3BKyUTD4irjfk/Jfu/bjcN5K
X-Google-Smtp-Source: AJdET5cxeTq0bi3e0cWrmntEjWgkCccs4SsP5c1FrAnq+K5pm5mVvN36pCjUL9biZNs80E6vS+G/Og==
X-Received: by 2002:a37:4c41:: with SMTP id z62mr6467957qka.206.1541079994590;
        Thu, 01 Nov 2018 06:46:34 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:33 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 7/7] t6012: make rev-list tests more interesting
Date:   Thu,  1 Nov 2018 13:46:23 +0000
Message-Id: <20181101134623.84055-8-dstolee@microsoft.com>
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

As we are working to rewrite some of the revision-walk machinery,
there could easily be some interesting interactions between the
options that force topological constraints (--topo-order,
--date-order, and --author-date-order) along with specifying a
path.

Add extra tests to t6012-rev-list-simplify.sh to add coverage of
these interactions. To ensure interesting things occur, alter the
repo data shape to have different orders depending on topo-, date-,
or author-date-order.

When testing using GIT_TEST_COMMIT_GRAPH, this assists in covering
the new logic for topo-order walks using generation numbers. The
extra tests can be added indepently.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6012-rev-list-simplify.sh | 45 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b5a1190ffe..a10f0df02b 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -12,6 +12,22 @@ unnote () {
 	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
 }
 
+#
+# Create a test repo with interesting commit graph:
+#
+# A--B----------G--H--I--K--L
+#  \  \           /     /
+#   \  \         /     /
+#    C------E---F     J
+#        \_/
+#
+# The commits are laid out from left-to-right starting with
+# the root commit A and terminating at the tip commit L.
+#
+# There are a few places where we adjust the commit date or
+# author date to make the --topo-order, --date-order, and
+# --author-date-order flags produce different output.
+
 test_expect_success setup '
 	echo "Hi there" >file &&
 	echo "initial" >lost &&
@@ -21,10 +37,18 @@ test_expect_success setup '
 
 	git branch other-branch &&
 
+	git symbolic-ref HEAD refs/heads/unrelated &&
+	git rm -f "*" &&
+	echo "Unrelated branch" >side &&
+	git add side &&
+	test_tick && git commit -m "Side root" &&
+	note J &&
+	git checkout master &&
+
 	echo "Hello" >file &&
 	echo "second" >lost &&
 	git add file lost &&
-	test_tick && git commit -m "Modified file and lost" &&
+	test_tick && GIT_AUTHOR_DATE=$(($test_tick + 120)) git commit -m "Modified file and lost" &&
 	note B &&
 
 	git checkout other-branch &&
@@ -63,13 +87,6 @@ test_expect_success setup '
 	test_tick && git commit -a -m "Final change" &&
 	note I &&
 
-	git symbolic-ref HEAD refs/heads/unrelated &&
-	git rm -f "*" &&
-	echo "Unrelated branch" >side &&
-	git add side &&
-	test_tick && git commit -m "Side root" &&
-	note J &&
-
 	git checkout master &&
 	test_tick && git merge --allow-unrelated-histories -m "Coolest" unrelated &&
 	note K &&
@@ -103,14 +120,24 @@ check_result () {
 	check_outcome success "$@"
 }
 
-check_result 'L K J I H G F E D C B A' --full-history
+check_result 'L K J I H F E D C G B A' --full-history --topo-order
+check_result 'L K I H G F E D C B J A' --full-history
+check_result 'L K I H G F E D C B J A' --full-history --date-order
+check_result 'L K I H G F E D B C J A' --full-history --author-date-order
 check_result 'K I H E C B A' --full-history -- file
 check_result 'K I H E C B A' --full-history --topo-order -- file
 check_result 'K I H E C B A' --full-history --date-order -- file
+check_result 'K I H E B C A' --full-history --author-date-order -- file
 check_result 'I E C B A' --simplify-merges -- file
+check_result 'I E C B A' --simplify-merges --topo-order -- file
+check_result 'I E C B A' --simplify-merges --date-order -- file
+check_result 'I E B C A' --simplify-merges --author-date-order -- file
 check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
+check_result 'I B A' --date-order -- file
+check_result 'I B A' --author-date-order -- file
 check_result 'H' --first-parent -- another-file
+check_result 'H' --first-parent --topo-order -- another-file
 
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
-- 
2.19.1.542.gc4df23f792

