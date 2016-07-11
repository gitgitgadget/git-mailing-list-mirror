Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871EC1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbcGKUvj (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:51:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33728 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586AbcGKUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:51:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4332018F;
	Mon, 11 Jul 2016 20:51:35 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Eric Wong <e@80x24.org>
Subject: [PATCH 1/3] http-walker: remove unused parameter from fetch_object
Date:	Mon, 11 Jul 2016 20:51:29 +0000
Message-Id: <20160711205131.1291-2-e@80x24.org>
In-Reply-To: <20160711205131.1291-1-e@80x24.org>
References: <20160711205131.1291-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This parameter has not been used since commit 1d389ab65dc6
("Add support for parallel HTTP transfers") back in 2005

Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 2c721f0..9f28523 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -447,7 +447,7 @@ static void abort_object_request(struct object_request *obj_req)
 	release_object_request(obj_req);
 }
 
-static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+static int fetch_object(struct walker *walker, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	int ret = 0;
@@ -518,7 +518,7 @@ static int fetch(struct walker *walker, unsigned char *sha1)
 	struct walker_data *data = walker->data;
 	struct alt_base *altbase = data->alt;
 
-	if (!fetch_object(walker, altbase, sha1))
+	if (!fetch_object(walker, sha1))
 		return 0;
 	while (altbase) {
 		if (!http_fetch_pack(walker, altbase, sha1))
-- 
EW

