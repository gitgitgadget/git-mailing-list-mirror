Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C641F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeKNOLh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54390 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbeKNOLh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 32CC460B16;
        Wed, 14 Nov 2018 04:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168607;
        bh=hj635Xkehf2jMRP5w7idvEsNeFOMdUMvEpon7U/a3/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LDXsDz2QY0oSVEhvGrCz+OpvmMsM7IndwnVo7Fue7cJ8wQ1jNIYSse3hYWiOYyE+C
         YdbPZ1u8HQqJj9cYRQkoIt8/3YotxSMHAS5XVE2iUn2J6tVVnVLIv/WBlURv2S23SV
         7T8OM1pDH7e52t5yPiEfJBDbNyAC6qrIQL2rrVsibGpP++Bzl5nOv3FmECmdf2yWcE
         KbCVth5CCM9JilyOlbE6xXwAWv3kxWDW/KlhB7ifTH2Gf592SZ8WZmXbkdF5CXfXPl
         enRFx5i5eHq4H7RA9xqfnacTPhI7ByWe4lRD7stkvQIVoxnJU4FHUqGmTEaiAA627x
         XeIMvwvMUBm667fv+pNcVaQddaGMPp4zIvzHEdtMeD3bdEWXEqP/oDK5cGeWE7wpl0
         0Ipz99XVR2bDkn719vw5iS1DAfvXYaDHn4oWBar27tUSZPgPPxW+7beeBL6wu+yfbW
         K+3CYq9hth0jCscoH3eduKSR9N+Uxa7ir4bXMeAjIWG+FdM+NSS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 01/12] sha1-file: rename algorithm to "sha1"
Date:   Wed, 14 Nov 2018 04:09:27 +0000
Message-Id: <20181114040938.517289-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181114040938.517289-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181114040938.517289-1-sandals@crustytoothpaste.net>
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
index 2daf7d9935..3b9c042691 100644
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
