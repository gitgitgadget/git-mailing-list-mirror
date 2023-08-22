Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88AEE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 13:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjHVNDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHVND3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 09:03:29 -0400
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [88.99.235.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D3D7
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 06:03:28 -0700 (PDT)
Received: from leda.eworm.de (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id C879F22F553;
        Tue, 22 Aug 2023 15:03:26 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id A54C6181285; Tue, 22 Aug 2023 15:03:26 +0200 (CEST)
From:   Christian Hesse <list@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Hesse <mail@eworm.de>
Subject: [PATCH 2/2] t/t6300: drop magic filtering
Date:   Tue, 22 Aug 2023 15:03:15 +0200
Message-ID: <20230822130315.71259-2-list@eworm.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230822130315.71259-1-list@eworm.de>
References: <20230822150149.541ccb35@leda.eworm.net>
 <20230822130315.71259-1-list@eworm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

Now that we ran a trustdb check forcibly it does no longer pullute the
output. Filtering is no longer required...

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 t/t6300-for-each-ref.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5b434ab451..aa3c7c03c4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1763,10 +1763,7 @@ test_expect_success GPGSSH 'setup for signature atom using ssh' '
 '
 
 test_expect_success GPG2 'bare signature atom' '
-	git verify-commit first-signed 2>out.raw &&
-	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
-	head -3 out >expect &&
-	tail -1 out >>expect &&
+	git verify-commit first-signed 2>expect &&
 	echo  >>expect &&
 	git for-each-ref refs/tags/first-signed \
 		--format="%(signature)" >actual &&
-- 
2.42.0

