Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF816C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04FD20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hmK0x6u4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJCs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40362 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgGJCsZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 86EB360A5C;
        Fri, 10 Jul 2020 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349304;
        bh=kzD44krolsMhdpvZfmNLjC7VTRRu/RTNvK14D0Rz7Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hmK0x6u44/iFg8qcAHNhyB2xHVFzf4QZzjz1metqRVfX3t4J30dquOnJ2DzdK+x0F
         awCQM3ECA0KLs7OsOwcfCuQJm+ey5lxTs1jS+hTjFPHyWnQM5dqJfCPsQXGfihC706
         EQ3kLjeTuWm11OKX5CMwZsv5/gOP65vDmDZ2fUEWMgrMxdduyyJAiFVLcf6pKi0rvx
         qV46IjfOnsNuyep+S+rvCxp5vrASfpIWfvpKaxtlmjw6H1nOfQDP1NPRuBhg7An7LD
         kqG9mZ/l8j2hrXhog757iMTyYUARo7Hm7SpZmrZNmoooRyl5yBPrVSrWuyo3+GLATy
         INfqj7mjEfz7o7kkUf8VKnjdP9Tu7XYb0yIfYwUIwm8nkTRCBHJyOBhENDKB+w4+fa
         kg7ui03oTPTK96gGmMptM2t2vpWcaGhDlRZ0f20shGEPq3v9tJdRfaESowDE+l13dK
         x9QmEfyjDcEeL1j9BYL8604iGaRfN9qS7A1xvUDvbkwzDl5C23M
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 02/38] t1001: use $ZERO_OID
Date:   Fri, 10 Jul 2020 02:46:52 +0000
Message-Id: <20200710024728.3100527-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID to make the test hash independent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1091-sparse-checkout-builtin.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 7cd45fc139..84acfc48b6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -369,7 +369,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git clone repo unmerged &&
 
 	cat >input <<-EOF &&
-	0 0000000000000000000000000000000000000000	folder1/a
+	0 $ZERO_OID	folder1/a
 	100644 $(git -C unmerged rev-parse HEAD:folder1/a) 1	folder1/a
 	EOF
 	git -C unmerged update-index --index-info <input &&
@@ -396,7 +396,7 @@ test_expect_success 'sparse-checkout reapply' '
 	echo dirty >tweak/deep/deeper2/a &&
 
 	cat >input <<-EOF &&
-	0 0000000000000000000000000000000000000000	folder1/a
+	0 $ZERO_OID	folder1/a
 	100644 $(git -C tweak rev-parse HEAD:folder1/a) 1	folder1/a
 	EOF
 	git -C tweak update-index --index-info <input &&
