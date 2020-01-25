Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF78C35246
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2F92071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J8LkCw0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAYXAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46804 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgAYXAn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:43 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DB93A60FBF;
        Sat, 25 Jan 2020 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993242;
        bh=wDdgFDb9VWvdgagIdzPUn+hIzxkzZ6XOKodpxFeqlqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=J8LkCw0HzkWKcAxRHzn2SoljM/fSA368vWySwBpWuG7HhAnV3yW1bLPqVvRGsKbZM
         42Ia00UuksuJe66Gtnlhos/TJ0pUjxY/rHYVn7O6pafE2J7uymsLcKcbSZATR5H/Dz
         2fUMgb0hYESX1NMs6rCX/5MnuVIpKOup4ZjQMf/6pZ9oCex5QJv06hUru35h8K28/b
         vpI/KFjRfXfQKH/lW0gHsWVbFlwtHCd1dxJX1su1wGxSqSbNZPngyHiE+R+5AFRuqR
         fe1Gx5w4vGiZjHG+w6G6IduEWhfx+7rkIrDS70aKooxEMyPjoCgF/lufD7X7S4ffNc
         Vq/1xsKSmEIsvGUDg9fg6k3+ZmpWGfWaBENJLRsK9G/Gi9sk1MsP61aOxis+wy1LGK
         QtL0wqZbXWw2l8f9Um284pefki87m7Geow0gbRp/nSx5nkr/mf3cHLi+ThR1cgc7+t
         kwpEmlhWOMpdldGRbqph3AgmzUX54tGyHXXcSiV4Etldid75jmz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
Date:   Sat, 25 Jan 2020 23:00:09 +0000
Message-Id: <20200125230035.136348-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test relies on a roughly equal distribution of hashes for notes in
order to ensure that fanouts are compressed.  If there are subtrees with
only one item left after removing notes, they'll end up still with one
level of fanout, causing the test to fail.  The test happens to pass
with SHA-1, but doesn't necessarily with other hash algorithms, so
annotate it with the SHA1 prerequisite.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3305-notes-fanout.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 831f83d211..3520402bb8 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -67,7 +67,7 @@ test_expect_success 'most notes deleted correctly with git-notes' '
 	test_cmp expect output
 '
 
-test_expect_success 'deleting most notes triggers fanout consolidation' '
+test_expect_success SHA1 'deleting most notes triggers fanout consolidation' '
 	# Expect entire notes tree to have a fanout == 0
 	git ls-tree -r --name-only refs/notes/commits |
 	while read path
