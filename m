Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C451F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbeI1E3J (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:29:09 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35390 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1E3J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:29:09 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 5eSfgWmYfjlDz5eSgg7Y4c; Thu, 27 Sep 2018 23:08:42 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Opu8PJzoBCI_TsNDnt4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fetch: fix compilation warning
Message-ID: <4d868114-a7a5-a39b-d6d4-5a436419f105@ramsayjones.plus.com>
Date:   Thu, 27 Sep 2018 23:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPzeEHXAFzCSLZyFEDREZ8Il9CU1Qf2+AuCx8Rpe58PoTO0BLd7q3fF/k6c7qaKJ2WW1kxD/fdTn+ahRvYXKFE9VIQscOQ3DWBMiugdxtSo/xKXQbiJ2
 MApREOE1UgWj0kfHttKTrdbsYt040Lb66aT/b3fdi0Z+Ga/JOkbgSZVZ961WNdFPJps4gJZz2SBceg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


commit 440fc7c0729 ("fetch: replace string-list used as a look-up
table with a hashmap", 2018-09-25) renamed a string-list variable
(while adding a hashmap of the same name) and forgot to rename the
string-list variable in a call to string_list_clear().

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

You probably already know, but I had to add this on top of the 'pu'
branch to get a clean compile tonight (your 'jc/war-on-string-list'
branch).

Thanks!

ATB,
Ramsay Jones

 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0a71953bc5..aea2e10364 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -391,7 +391,7 @@ static void find_non_local_tags(const struct ref *refs,
 		}
 	}
 	hashmap_free(&remote_refs, 1);
-	string_list_clear(&remote_refs, 0);
+	string_list_clear(&remote_refs_list, 0);
 }
 
 static struct ref *get_ref_map(struct remote *remote,
-- 
2.19.0
