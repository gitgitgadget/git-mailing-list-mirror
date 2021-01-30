Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F20C433E6
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3FF64E08
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 10:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhA3K06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 05:26:58 -0500
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:58497 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbhA3K0w (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Jan 2021 05:26:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailforward.west.internal (Postfix) with ESMTP id 87A82C76;
        Sat, 30 Jan 2021 05:19:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 05:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=yO8d00qVsYCN1+Yk0k0M9qI/6qNYE
        EiWj6930HyQ5fg=; b=GTW31NE304dfXKLXYkyrB+1y6hVdeOb+tZOikiNycomZN
        OLMWiM6cVN4qlZzFxcR34hTfKlkc4pZNNUK7pe9IibCp1LvR82bF0ANiUW8HsPJB
        L04gYeELySn3kx4uddShNcpHYGeNJLcRnzDm2lWU+SUvv4gCroazaroM2ZBV5y7C
        X6HDzwyyvLkUaNH2dno4uOUkUF/RAiS8mvvtsNNTEB2MY4XckQUUA55Pzk/gkY2Z
        vwKNTgZ/J/8X7jEcLTQ7TZONjZu9zGXYsFV7nWrxxb7RNqoKmZyTeePRWlOG4fvN
        IMNzZwIYuJ18Trvob8IYvXz9suoZM4jYui9nIhvgA==
X-ME-Sender: <xms:qDIVYHVrGxjA_jeiuVZLf11DSh0P_8CQ002-bp3dLbc13n7J5KLvaA>
    <xme:qDIVYPn6CbQ02JKubqt_aZ7QlHx_euf6V3hZRReP1R3AoVb29u22rpd_RjP4ZfHzC
    JVtf5Yxx8ZGsbOG3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgjfhestddtredttddttd
    enucfhrhhomhepfdfmhihlvgculfdrucfotgfmrgihfdcuoehmrggtkhihlhgvsehgmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdejheegtddvffelfeetudefjefhve
    duieetudeilefhgeekfeekkeejgfevvdenucfkphepjeeirddukedruddvvddrvdefvden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrggtkh
    ihlhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qDIVYDbqp-J7NUCdk6FggjrA19q-mHhMOSLpmdzAfO7Nr1cNGBRoig>
    <xmx:qDIVYCWplmAbD7eYSUBl_gNBQgLBR2N1F0Dgte1xwz7aXTWcpc1J3A>
    <xmx:qDIVYBkHfbxF8KvBpnAMx_iiXg13ukdbkisf4vAqu2zNej_N7sayPQ>
    <xmx:qDIVYHjlr-Y-UYUCAZtoIVLbDEXBuMSQRK2mte8cjTwGqMKIfRbzDHCuCSE>
Received: from localhost.localdomain (unknown [76.18.122.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C7A124005B;
        Sat, 30 Jan 2021 05:19:19 -0500 (EST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
Date:   Sat, 30 Jan 2021 03:19:08 -0700
Message-Id: <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c>
In-Reply-To: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git command `git symbolic-ref <refname1> <refname2>` updates
<refname1> to be a "symbolic" pointer to <refname2>.  No matter
what future value <refname2> takes on, <refname1> will continue
to refer to that future value since it's "symbolic".

Since commit 523fa69c36744ae6 ("reflog: cleanse messages in the refs.c
layer", 2020-07-10, v2.29.0), the effect of using the aforementioned
"symbolic-ref" command on ref logs has changed in an unexpected way.

Add a new set of tests to exercise and demonstrate this change
in preparation for correcting it (at which point the failing tests
will be flipped from `test_expect_failure` to `test_expect_success`).

The new test file can be used unchanged to examine this behavior
in much older Git versions (likely to as far back as v2.6.0).

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 t/t1417-reflog-symref.sh | 91 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 t/t1417-reflog-symref.sh

diff --git a/t/t1417-reflog-symref.sh b/t/t1417-reflog-symref.sh
new file mode 100755
index 00000000..6149531f
--- /dev/null
+++ b/t/t1417-reflog-symref.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Kyle J. McKay
+#
+
+test_description='Test symbolic-ref effects on reflogs'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit 'initial' &&
+	git checkout -b unu &&
+	test_commit 'one' &&
+	git checkout -b du &&
+	test_commit 'two' &&
+	git checkout -b tri &&
+	test_commit 'three' &&
+	git checkout du &&
+	test_commit 'twofour' &&
+	git checkout -b KVAR du &&
+	test_commit 'four' &&
+	unu="$(git rev-parse --verify unu)" &&
+	du="$(git rev-parse --verify du)" &&
+	tri="$(git rev-parse --verify tri)" &&
+	kvar="$(git rev-parse --verify KVAR)" &&
+	test -n "$unu" &&
+	test -n "$du" &&
+	test -n "$tri" &&
+	test -n "$kvar" &&
+	test "$unu" != "$du" &&
+	test "$unu" != "$tri" &&
+	test "$unu" != "$kvar" &&
+	test "$du" != "$tri" &&
+	test "$du" != "$kvar" &&
+	test "$tri" != "$kvar" &&
+	git symbolic-ref refs/heads/KVAR refs/heads/du &&
+	kvarsym="$(git rev-parse --verify KVAR)" &&
+	test "$kvarsym" = "$du" &&
+	test "$kvarsym" != "$kvar" &&
+	git reflog exists HEAD &&
+	git reflog exists refs/heads/KVAR &&
+	git symbolic-ref HEAD >/dev/null &&
+	git symbolic-ref refs/heads/KVAR &&
+	git checkout unu &&
+	hcnt=$(git reflog show HEAD | wc -l) &&
+	kcnt=$(git reflog show refs/heads/KVAR | wc -l) &&
+	test -n "$hcnt" &&
+	test -n "$kcnt" &&
+	test $hcnt -gt 1 &&
+	test $kcnt -gt 1 &&
+	test $hcnt -ne $kcnt
+'
+
+test_expect_failure 'HEAD reflog symbolic-ref' '
+	hcnt1=$(git reflog show HEAD | wc -l) &&
+	git symbolic-ref HEAD refs/heads/unu &&
+	git symbolic-ref HEAD refs/heads/du &&
+	git symbolic-ref HEAD refs/heads/tri &&
+	hcnt2=$(git reflog show HEAD | wc -l) &&
+	test $hcnt1 = $hcnt2
+'
+
+test_expect_failure 'refs/heads/KVAR reflog symbolic-ref' '
+	kcnt1=$(git reflog show refs/heads/KVAR | wc -l) &&
+	git symbolic-ref refs/heads/KVAR refs/heads/tri &&
+	git symbolic-ref refs/heads/KVAR refs/heads/du &&
+	git symbolic-ref refs/heads/KVAR refs/heads/unu &&
+	kcnt2=$(git reflog show refs/heads/KVAR | wc -l) &&
+	test $kcnt1 = $kcnt2
+'
+
+test_expect_failure 'double symref reflog symbolic-ref' '
+	hcnt1=$(git reflog show HEAD | wc -l) &&
+	kcnt1=$(git reflog show refs/heads/KVAR | wc -l) &&
+	git symbolic-ref HEAD refs/heads/KVAR &&
+	git symbolic-ref refs/heads/KVAR refs/heads/du &&
+	git symbolic-ref refs/heads/KVAR refs/heads/unu &&
+	git symbolic-ref refs/heads/KVAR refs/heads/tri &&
+	git symbolic-ref HEAD refs/heads/du &&
+	git symbolic-ref HEAD refs/heads/tri &&
+	git symbolic-ref HEAD refs/heads/unu &&
+	hcnt2=$(git reflog show HEAD | wc -l) &&
+	kcnt2=$(git reflog show refs/heads/KVAR | wc -l) &&
+	test $hcnt1 = $hcnt2 &&
+	test $kcnt1 = $kcnt2 &&
+	test $hcnt2 != $kcnt2
+'
+
+test_done
-- 
