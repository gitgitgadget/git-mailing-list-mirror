Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472C221847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeEBA0Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37608 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753343AbeEBA0W (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0153D609A0;
        Wed,  2 May 2018 00:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220781;
        bh=xyJVJlTJrF0jFwhl+DwOgMRL8F2rbQ6KioMBePPIv1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AGj4KiAHUiEGCojLLjAYQ5DDB/XjKyaccbY5eLdj3u7YnH51T3/ilTqXuY17sV+4t
         k8bho2z5XfvPaA/hwp+mGBBuAO/J6V5IPnjNanw+aV22IbRFd40b2XVm80rJzdKO+f
         Xy2nux1KszKr2rtFzNUMBa82u3GCWRVewxUzTdZ7WKJX8DwWVd55Mj/MQLd9E4tzZU
         oOLdrd4VoZNz0GW26PMZf8+937XYEJ9PooEVKbvHV9fIlVkoZrxDVp0cGTvWQjx5ie
         fYafUwPCQdq1y7q6BW/IztpPtbCXTf+lu7PxwQ4Xhp6mFA1D+ph9bT830a8gBFo48y
         RZuqV6d0Nw4S5cif/k9tCc1/5lsW/HROaCqrfmcE06/d5GrUzPs96zAJ/8i0YWjXl0
         h5TeKvd792gdrTUQOlXhUY6zN4PleuaGR3CV5UGR1DO0zld5ORjwS/IveA5ADFG8sV
         DenpMa0nrUB/V6x8YmZvQmJGwrpI7kBod8izEbng7Srn7RIzysh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/42] server-info: remove unused members from struct pack_info
Date:   Wed,  2 May 2018 00:25:30 +0000
Message-Id: <20180502002610.915892-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The head member of struct pack_info is completely unused and the
nr_heads member is used only in one place, which is an assignment.  This
member was last usefully used in 3e15c67c90 (server-info: throw away T
computation as well, 2005-12-04).

Since this structure member is not useful, remove it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 server-info.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/server-info.c b/server-info.c
index 83460ec0d6..7ce6dcd67b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -92,8 +92,6 @@ static struct pack_info {
 	int old_num;
 	int new_num;
 	int nr_alloc;
-	int nr_heads;
-	unsigned char (*head)[20];
 } **info;
 static int num_pack;
 static const char *objdir;
@@ -225,12 +223,9 @@ static void init_pack_info(const char *infofile, int force)
 	else
 		stale = 1;
 
-	for (i = 0; i < num_pack; i++) {
-		if (stale) {
+	for (i = 0; i < num_pack; i++)
+		if (stale)
 			info[i]->old_num = -1;
-			info[i]->nr_heads = 0;
-		}
-	}
 
 	/* renumber them */
 	QSORT(info, num_pack, compare_info);
