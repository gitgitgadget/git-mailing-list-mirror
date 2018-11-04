Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F521F454
	for <e@80x24.org>; Sun,  4 Nov 2018 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeKEJBx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:01:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729402AbeKEJBx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 04:01:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 071D261B74;
        Sun,  4 Nov 2018 23:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541375106;
        bh=IVpe+0tMiZrDXXOWLcQmdP7lPOUcFQ8bTzgTDCGq2Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pub2h1BWHZExUHr4G3zUxDOAYsyfcSInbXBLfnEM3MB6xvofwWbC9vS67CrV9iIbj
         /q2oupjebGaf4R02OH39fQs7jrv8NEnP8zq7HMLEe2q9vEL6mY5t10YQCXjLY+jemZ
         8398prOdgVi+Z1l2eyX8V54u1rzdGqx9yoU73RSwvhptLPA68xzkeBZpfCj7NkBZsI
         ew77i98AQesQIASIRlOWgDwVoVZ5L70aZ5P5Q5jJaayhRkxlXwrUeLbJs4BFW6qzqO
         SOIaaH4smz+ojBF7mhSPM0HkgDfTcXwALtV38UngmkACqrEvdNf4Y3WPI7BGt453XS
         l0/F2QpmwHWhg/aWkqsqPnKNK+OvkZe+fzm9v69upM5fIuceuJw9nbDFvyLnbmyqtx
         HhK5LzyAn3GAbsesGmILV/tXM1eha3PeL9NPkEEdtKKyutRTkrpgQS6vGM09Piw3gF
         eUwpxCglQemQwVJ8izfAVomy/4qiMwTeFgILO79fsJFezyBnNz8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 01/12] sha1-file: rename algorithm to "sha1"
Date:   Sun,  4 Nov 2018 23:44:47 +0000
Message-Id: <20181104234458.139223-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181104234458.139223-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
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
