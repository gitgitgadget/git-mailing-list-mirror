Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4DC1FE4E
	for <e@80x24.org>; Wed,  6 Jul 2016 01:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbcGFB5L (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 21:57:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33072 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcGFB5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 21:57:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B2D1FE4E;
	Wed,  6 Jul 2016 01:57:08 +0000 (UTC)
Date:	Wed, 6 Jul 2016 01:57:08 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] http-walker: remove unused parameter from fetch_object
Message-ID: <20160706015708.GA18690@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This parameter has not been used since commit 1d389ab65dc6
("Add support for parallel HTTP transfers") back in 2005

Signed-off-by: Eric Wong <e@80x24.org>
---
 I might followup in a few days/weeks with further updates in
 this area, but at least should be trivially correct :)

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
