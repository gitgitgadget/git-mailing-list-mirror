Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301052036B
	for <e@80x24.org>; Tue,  3 Oct 2017 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdJCVvJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 17:51:09 -0400
Received: from avasout07.plus.net ([84.93.230.235]:56667 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdJCVvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 17:51:09 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id H9r31w00B0M91Ur019r5ze; Tue, 03 Oct 2017 22:51:05 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=M_GiEyNkICeghournMkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     dstolee@microsoft.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] test-list-objects: mark file-local symbols as static
Message-ID: <5b3d8899-d4c5-c145-7128-21c8aaa4f38f@ramsayjones.plus.com>
Date:   Tue, 3 Oct 2017 22:51:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Derrick,

If you need to re-roll your 'ds/find-unique-abbrev-optim' branch,
could you please squash this into the relevant patch (commit 3792c78ba0,
"test-list-objects: list a subset of object ids", 01-10-2017).

Thanks!

ATB,
Ramsay Jones

 t/helper/test-list-objects.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/helper/test-list-objects.c b/t/helper/test-list-objects.c
index 22bc9b4e6..5c5d3c03f 100644
--- a/t/helper/test-list-objects.c
+++ b/t/helper/test-list-objects.c
@@ -6,43 +6,43 @@ struct count {
 	int select_mod;
 };
 
-int count_loose(const struct object_id *oid,
-		const char *path,
-		void *data)
+static int count_loose(const struct object_id *oid,
+		       const char *path,
+		       void *data)
 {
 	((struct count*)data)->total++;
 	return 0;
 }
 
-int count_packed(const struct object_id *oid,
-		 struct packed_git *pack,
-		 uint32_t pos,
-		 void* data)
+static int count_packed(const struct object_id *oid,
+			struct packed_git *pack,
+			uint32_t pos,
+			void* data)
 {
 	((struct count*)data)->total++;
 	return 0;
 }
 
-void output(const struct object_id *oid,
-	    struct count *c)
+static void output(const struct object_id *oid,
+		   struct count *c)
 {
 	if (!(c->total % c->select_mod))
 		printf("%s\n", oid_to_hex(oid));
 	c->total--;
 }
 
-int output_loose(const struct object_id *oid,
-		 const char *path,
-		 void *data)
+static int output_loose(const struct object_id *oid,
+			const char *path,
+			void *data)
 {
 	output(oid, (struct count*)data);
 	return 0;
 }
 
-int output_packed(const struct object_id *oid,
-		  struct packed_git *pack,
-		  uint32_t pos,
-		  void* data)
+static int output_packed(const struct object_id *oid,
+			 struct packed_git *pack,
+			 uint32_t pos,
+			 void* data)
 {
 	output(oid, (struct count*)data);
 	return 0;
-- 
2.14.0
