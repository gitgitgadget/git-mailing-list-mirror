Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF6DEE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 13:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjHVND2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHVND1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 09:03:27 -0400
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:10b:ddb::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60162CC6
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 06:03:25 -0700 (PDT)
Received: from leda.eworm.de (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id CBD2922F599;
        Tue, 22 Aug 2023 15:03:23 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 539EA181285; Tue, 22 Aug 2023 15:03:23 +0200 (CEST)
From:   Christian Hesse <list@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/2] t/lib-gpg: forcibly run a trustdb update
Date:   Tue, 22 Aug 2023 15:03:14 +0200
Message-ID: <20230822130315.71259-1-list@eworm.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230822150149.541ccb35@leda.eworm.net>
References: <20230822150149.541ccb35@leda.eworm.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

We want to compare output later, so randomly popping up 'gpg: checking
the trustdb' breaks the tests. Run the trustdb update forcibly.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 4eebd9c2b5..83b83c9abb 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -45,6 +45,7 @@ test_lazy_prereq GPG '
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
+		gpg --homedir "${GNUPGHOME}" --update-trustdb &&
 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null \
 			--sign -u committer@example.com
 		;;
-- 
2.42.0

