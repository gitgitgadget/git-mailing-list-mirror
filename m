Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7021F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJVLAi (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:00:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51748 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbeJVLAi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Oct 2018 07:00:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:65d4:dc3c:f6f5:933b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A09DB61B73;
        Mon, 22 Oct 2018 02:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540176244;
        bh=IVpe+0tMiZrDXXOWLcQmdP7lPOUcFQ8bTzgTDCGq2Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EVj2YN+sRGwGa1u1+Pa/8UuzXSvavLITOYIvsNKV94htQsqxiQpCWTSoX6W9ShdPl
         s03Qmjt2ptaIcSlNMktsTUjkgjnPjbRcp8Ao99vIcX4SSH12CcrtibulZ3AkeanknK
         WPC/7mVE0ptKy0IEoXKJMNouBjn+pO4oWoFa4jXqsqAQEqjR/gq8Ejxs1o6xD98XfZ
         R+IsHg3G6/ieGdJmugOwaj5Cwz1Mk6fcGxsJO7aqcmtwunGQCy/KkDdTyOb1Fg1MIg
         v8hhh6GLvUe9+fcimHFI9kU3ARVqFER5LNkYiBGQ7DcwO2DSCBPylkomGm9qc8DSlS
         HQ1oLBpZegTPCIWIM5ttL6Oz0TpfT3pPNAs5XI2vIvftW5ACzCDr4hbNA3KQsX0g88
         hl2yptg6aO9oxh+gBszGgCPRcCOU8VVaKRnxNoWtLCvH8o2mySRVqiouHeUmZV/0Ct
         lwrRukVdDf7042OaW6C6eGHnj87VZCeLb8afiqOLvEifZvBt3gs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 01/12] sha1-file: rename algorithm to "sha1"
Date:   Mon, 22 Oct 2018 02:43:31 +0000
Message-Id: <20181022024342.489564-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181022024342.489564-1-sandals@crustytoothpaste.net>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transition plan anticipates us using a syntax such as "^{sha1}" for
disambiguation.  Since this is a syntax some people will be typing a
lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
the dash doesn't create any ambiguity; however, it does make the syntax
shorter and easier to type, especially for touch typists.  In addition,
the transition plan already uses "sha1" in this context.

Rename the name of SHA-1 implementation to "sha1".

Note that this change creates no backwards compatibility concerns, since
we haven't yet used this field in any configuration settings.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..91311ebb3d 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -97,7 +97,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		NULL,
 	},
 	{
-		"sha-1",
+		"sha1",
 		/* "sha1", big-endian */
 		0x73686131,
 		GIT_SHA1_RAWSZ,
