Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDE9207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbcJCUeO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:34:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:51422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbcJCUeM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:34:12 -0400
Received: (qmail 17213 invoked by uid 109); 3 Oct 2016 20:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:34:07 +0000
Received: (qmail 29674 invoked by uid 111); 3 Oct 2016 20:34:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:34:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:34:05 -0400
Date:   Mon, 3 Oct 2016 16:34:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 04/18] t5613: whitespace/style cleanups
Message-ID: <20161003203405.nzijl552nlqg63ab@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our normal test style these days puts the opening quote of
the body on the description line, and indents the body with
a single tab. This ancient test did not follow this.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5613-info-alternate.sh | 114 +++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 65074dd..1f283a5 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -8,88 +8,98 @@ test_description='test transitive info/alternate entries'
 
 base_dir=$(pwd)
 
-test_expect_success 'preparing first repository' \
-'test_create_repo A && cd A &&
-echo "Hello World" > file1 &&
-git add file1 &&
-git commit -m "Initial commit" file1 &&
-git repack -a -d &&
-git prune'
+test_expect_success 'preparing first repository' '
+	test_create_repo A &&
+	cd A &&
+	echo "Hello World" > file1 &&
+	git add file1 &&
+	git commit -m "Initial commit" file1 &&
+	git repack -a -d &&
+	git prune
+'
 
 cd "$base_dir"
 
-test_expect_success 'preparing second repository' \
-'git clone -l -s A B && cd B &&
-echo "foo bar" > file2 &&
-git add file2 &&
-git commit -m "next commit" file2 &&
-git repack -a -d -l &&
-git prune'
+test_expect_success 'preparing second repository' '
+	git clone -l -s A B &&
+	cd B &&
+	echo "foo bar" > file2 &&
+	git add file2 &&
+	git commit -m "next commit" file2 &&
+	git repack -a -d -l &&
+	git prune
+'
 
 cd "$base_dir"
 
-test_expect_success 'preparing third repository' \
-'git clone -l -s B C && cd C &&
-echo "Goodbye, cruel world" > file3 &&
-git add file3 &&
-git commit -m "one more" file3 &&
-git repack -a -d -l &&
-git prune'
+test_expect_success 'preparing third repository' '
+	git clone -l -s B C &&
+	cd C &&
+	echo "Goodbye, cruel world" > file3 &&
+	git add file3 &&
+	git commit -m "one more" file3 &&
+	git repack -a -d -l &&
+	git prune
+'
 
 cd "$base_dir"
 
-test_expect_success 'creating too deep nesting' \
-'git clone -l -s C D &&
-git clone -l -s D E &&
-git clone -l -s E F &&
-git clone -l -s F G &&
-git clone --bare -l -s G H'
+test_expect_success 'creating too deep nesting' '
+	git clone -l -s C D &&
+	git clone -l -s D E &&
+	git clone -l -s E F &&
+	git clone -l -s F G &&
+	git clone --bare -l -s G H
+'
 
-test_expect_success 'invalidity of deepest repository' \
-'cd H &&
-test_must_fail git fsck
+test_expect_success 'invalidity of deepest repository' '
+	cd H &&
+	test_must_fail git fsck
 '
 
 cd "$base_dir"
 
-test_expect_success 'validity of third repository' \
-'cd C &&
-git fsck'
+test_expect_success 'validity of third repository' '
+	cd C &&
+	git fsck
+'
 
 cd "$base_dir"
 
-test_expect_success 'validity of fourth repository' \
-'cd D &&
-git fsck'
+test_expect_success 'validity of fourth repository' '
+	cd D &&
+	git fsck
+'
 
 cd "$base_dir"
 
-test_expect_success 'breaking of loops' \
-'echo "$base_dir"/B/.git/objects >> "$base_dir"/A/.git/objects/info/alternates&&
-cd C &&
-git fsck'
+test_expect_success 'breaking of loops' '
+	echo "$base_dir"/B/.git/objects >>"$base_dir"/A/.git/objects/info/alternatesi &&
+	cd C &&
+	git fsck
+'
 
 cd "$base_dir"
 
-test_expect_success 'that info/alternates is necessary' \
-'cd C &&
-rm -f .git/objects/info/alternates &&
-test_must_fail git fsck
+test_expect_success 'that info/alternates is necessary' '
+	cd C &&
+	rm -f .git/objects/info/alternates &&
+	test_must_fail git fsck
 '
 
 cd "$base_dir"
 
-test_expect_success 'that relative alternate is possible for current dir' \
-'cd C &&
-echo "../../../B/.git/objects" > .git/objects/info/alternates &&
-git fsck'
+test_expect_success 'that relative alternate is possible for current dir' '
+	cd C &&
+	echo "../../../B/.git/objects" > .git/objects/info/alternates &&
+	git fsck
+'
 
 cd "$base_dir"
 
-test_expect_success \
-    'that relative alternate is only possible for current dir' '
-    cd D &&
-    test_must_fail git fsck
+test_expect_success 'that relative alternate is only possible for current dir' '
+	cd D &&
+	test_must_fail git fsck
 '
 
 cd "$base_dir"
-- 
2.10.0.618.g82cc264

