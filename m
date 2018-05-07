Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4B3200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeEGPpY (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:45:24 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40444 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752491AbeEGPpW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 11:45:22 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w47FgUJ6005890;
        Mon, 7 May 2018 08:45:18 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hs9gktkax-1;
        Mon, 07 May 2018 08:45:17 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DD6F822F488D;
        Mon,  7 May 2018 08:45:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D33DE2CDEEA;
        Mon,  7 May 2018 08:45:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] fixup! merge-recursive: add get_directory_renames()
Date:   Mon,  7 May 2018 08:45:15 -0700
Message-Id: <20180507154515.29543-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.288.g15ba85059a
In-Reply-To: <20180506234137.3414-1-szeder.dev@gmail.com>
References: <20180506234137.3414-1-szeder.dev@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=955 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805070160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5f42c677d5..9b9a4b8213 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1851,7 +1851,7 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 	 * renames, finding out how often each directory rename pair
 	 * possibility occurs.
 	 */
-	dir_renames = xmalloc(sizeof(struct hashmap));
+	dir_renames = xmalloc(sizeof(*dir_renames));
 	dir_rename_init(dir_renames);
 	for (i = 0; i < pairs->nr; ++i) {
 		struct string_list_item *item;
@@ -1871,7 +1871,7 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 
 		entry = dir_rename_find_entry(dir_renames, old_dir);
 		if (!entry) {
-			entry = xmalloc(sizeof(struct dir_rename_entry));
+			entry = xmalloc(sizeof(*entry));
 			dir_rename_entry_init(entry, old_dir);
 			hashmap_put(dir_renames, entry);
 		} else {
-- 
2.16.0.32.gc5b761fb27.dirty

