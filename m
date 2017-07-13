Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CEC2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbdGMXuE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:50:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59712 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752944AbdGMXtj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6F10F280B8;
        Thu, 13 Jul 2017 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989777;
        bh=dBe6yXCfMYit0OXTPUsm6scxY/Qvix4g1j8S+dWgZrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lb5/reWSFNzTjzIFP6dhvJj50/0fhAgZtb0VC/pCTaSl0dW3E163D5EDP2EFYHsaw
         cdBKVcSd1TKH9stcSgOtLJxydsmKyEZ7AGTvjSMBvQab1dLQD9sDDGdk0AcCUblTfU
         enRHDJHyl35PIDzr1L7X6EHIdZS7txMMCLdaYvfBJ5oC1DIobphXPts+M9lYvruW0U
         YNoEQ3ihtg+24xZWEB6Brbb35/KzqCWLvc/tJRupmviU0aevFYwxQWGk7t6ZVwSHAX
         I8BwJimuaj6nEi0SiFHjoKrcvpc+qGY/pV9FlqG1Olfu+Ru07LXsZFTS2j2rltTIdC
         7f8V7U6fYYBjKfMWMxFRtyErgL4AP3v9oOK2muxrtG/vNUKwn6lYZCu3Egw41magTJ
         ngPIJP6DEHU1dWeFXZdS6IwFaS0OJUNqqYv/TEUEJcI0wl1WHV+NdwUkZa9qR9KJNU
         /HOmYJGrEIm7noBZxNDbCKZHQiGshO34GTTX0iOEu6PWIGVbAsR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 13/13] sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ
Date:   Thu, 13 Jul 2017 23:49:30 +0000
Message-Id: <20170713234930.949612-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several uses of the constant 40 in find_unique_abbrev_r.
Convert them to GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b49303271e..8b7fd7e134 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -501,10 +501,10 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	}
 
 	sha1_to_hex_r(hex, sha1);
-	if (len == 40 || !len)
-		return 40;
+	if (len == GIT_SHA1_HEXSZ || !len)
+		return GIT_SHA1_HEXSZ;
 	exists = has_sha1_file(sha1);
-	while (len < 40) {
+	while (len < GIT_SHA1_HEXSZ) {
 		struct object_id oid_ret;
 		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
 		if (exists
