Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECEC43465
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1992053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Qoho+VFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgGWBKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40542 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387659AbgGWBKd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D52C661013
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466602;
        bh=09rgrcCD/TLi0jQrtn9n+YVsuADBEadhXt5jrJbIyoU=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=Qoho+VFePkqmbtoHK1Jg4aT9unw13CmoD1TIVOEt9r0OIPNNx72kBPza6ZjD18OTk
         la08ZWxxwTykx366AoTwDOhY+2SCpZNsVE6CYiOgI6bfM/vwHkhZkwp3fDnuC5VFi8
         LmvAcwqtTtiPNzpok7sxneZR0kbwYnw2DXcj4kYuMZfX7fLk/MfIZRU97toFQlIs26
         1JqiUbdrkB1bThhRd8x2QYOdzFPdJGFMNxKwvzQfc8IaEKwRmQeiJ7z9+iuZMOZZ8k
         yNpCZ2qxH3gUEOEr8MrIU2pD76Pg43YclvCFYWttkST3zKsDFfQYQ0VMOBCj3OLw4L
         zTujpIJ+VBocV+1ETsBevRcNAhGj8DOnarRvSxg6iA5CzMGPuNrnmgU+KxOKdhCNNK
         BnHzVJyzZFbvNxVOJg5fKTyJ16vT+w2oP5msxih8SWA4gI5W03Ih87Nu4BoHUvZqR+
         QFIeIcVXKceFdqcwzoAXLw1uxt29LmlNCrlRPXyAzHsECt4vOK6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 28/39] t0410: mark test with SHA1 prerequisite
Date:   Thu, 23 Jul 2020 01:09:32 +0000
Message-Id: <20200723010943.2329634-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests try to check that we behave properly if we encounter a
repository with version 0 but an extension.  This is a laudable goal,
but the test cannot work with SHA-256, since SHA-256 repositories always
have an existing extension and are never version 0.

Add a SHA1 prerequisite to these tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0410-partial-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6aa0f313bd..a5ebdf9ff3 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert to partial clone with noop extension' '
+test_expect_success SHA1 'convert to partial clone with noop extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -53,7 +53,7 @@ test_expect_success 'convert to partial clone with noop extension' '
 	git -C client fetch --unshallow --filter="blob:none"
 '
 
-test_expect_success 'converting to partial clone fails with unrecognized extension' '
+test_expect_success SHA1 'converting to partial clone fails with unrecognized extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
