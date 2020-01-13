Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89EC33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779EF20678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xk8Ex8qK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMMkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37620 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgAMMke (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3BB17607F9;
        Mon, 13 Jan 2020 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919233;
        bh=wDdgFDb9VWvdgagIdzPUn+hIzxkzZ6XOKodpxFeqlqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xk8Ex8qKLlSV51icDMCqxkM8rvT3KaJphaB2cQGH4I0I1Y3Ye+J2nkI38mSeDXoID
         e8hPrqaawLP8g+UkXvMfvNeG+Vzg/nHKP3mZJrOfTbcYFwQBzl+oVyzyWjHyQ4eaLr
         DD+o5ML4xOQiVyPPjscg/kQI81W+QI/mwAD1tiHxHMZ1YgdjZNA6pdFqrJeX5HCmQe
         HJecIBDrQmmGN0KPDcEljtTbykg+6M2zhUinTOC0XgEK0OFRBnvbmWiEl1JbfBOuuh
         rseaNkUXfvkYM6imOxTcsAUPzTKMZe+HjIBRi8/jgi6IwZvz3Oj+XxRHsD8qjHwvlq
         H0dO1/+uEd4rHOUGIJ99dnlQpXXlUId5ChgYBtRmIzMnS2ljhjbq2IPc2R7DEpvkZS
         4iZxED0d+PkKy5LuNxkiUT3WEYGMC0kibM2omg7+IKG5jJsLHXdVHOO+SBcPRQGs9t
         GJBXAjUgOj0gaEmxEm3MfXeSIigufPDbzZf25sHxC+z2rFhBUW2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 03/24] t3305: annotate with SHA1 prerequisite
Date:   Mon, 13 Jan 2020 12:38:36 +0000
Message-Id: <20200113123857.3684632-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
