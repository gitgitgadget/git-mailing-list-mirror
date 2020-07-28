Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C9C43464
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557032075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L93xdWQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgG1Xfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40982 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730428AbgG1Xfk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9AD5A6101A;
        Tue, 28 Jul 2020 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979307;
        bh=09rgrcCD/TLi0jQrtn9n+YVsuADBEadhXt5jrJbIyoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=L93xdWQYf1d4CGzQFJXYkOeXwpnsc50O+sYi+KlF0aoGesBNm2YKnZ0ORilX2ZeAY
         CpImiqG2aX/KT5ATGUxRoY8tdrMEP+X4b5QXKnb53SgA4lzt77sYNHG1ETZ/Twvmz8
         83O9AaF+vua8PULFd5fa/DOu1DrBPJ6xtk3jnEYkmcOtPIICDY8IIZ4AoeU1Jykf6Y
         mToVv8s1t/sdhwAI0N1Vg6FR07lrVD05yivTY97o4a602EtHkcCaSfeSqw4Z8ynVKS
         nuKMcq6JeUStuY6gVqoj3SFJWAAbI/rO2QuLLqtEcfqBxljzR0JiIJ6xeUuXnzDq2u
         Nhp9NA7aVja7KpsjEehgJ6WJXk0JszSpbLfNvjoIjvD0ilxWtH6pUIN91eqpjj1Swf
         ERf+cgaQD2r7lV+FIX+sE8rsyUp8m3v0Szl+IYj8vinFPOPdC0kc6IcBWFtZLXukmB
         7nrcXL8IpQ+/g66saXjVGxWgTcV7F7SrMkK6JSOJ6tKcmO45ys+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 28/39] t0410: mark test with SHA1 prerequisite
Date:   Tue, 28 Jul 2020 23:34:35 +0000
Message-Id: <20200728233446.3066485-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
