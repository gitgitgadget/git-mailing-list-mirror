Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DEA1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 20:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeDXUVJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 16:21:09 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54220 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750815AbeDXUVI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 16:21:08 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3OKEkse013479;
        Tue, 24 Apr 2018 13:21:04 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg35h49xc-1;
        Tue, 24 Apr 2018 13:21:04 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 89F642289FAD;
        Tue, 24 Apr 2018 13:21:04 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7FB6F2CDE67;
        Tue, 24 Apr 2018 13:21:04 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        martin.agren@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 1/2] fixup! merge-recursive: fix was_tracked() to quit lying with some renamed paths
Date:   Tue, 24 Apr 2018 13:20:59 -0700
Message-Id: <20180424202100.23828-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.295.g791b7256b2.dirty
In-Reply-To: <xmqqy3hibms3.fsf@gitster-ct.c.googlers.com>
References: <xmqqy3hibms3.fsf@gitster-ct.c.googlers.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=590 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804240192
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 merge-recursive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1de8dc1c53..f2cbad4f10 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3146,10 +3146,10 @@ int merge_trees(struct merge_options *o,
 
 	/* Free the extra index left from git_merge_trees() */
 	/*
-	 * FIXME: Need to also data allocated by setup_unpack_trees_porcelain()
-	 * tucked away in o->unpack_opts.msgs, but the problem is that only
-	 * half of it refers to dynamically allocated data, while the other
-	 * half points at static strings.
+	 * FIXME: Need to also free data allocated by
+	 * setup_unpack_trees_porcelain() tucked away in o->unpack_opts.msgs,
+	 * but the problem is that only half of it refers to dynamically
+	 * allocated data, while the other half points at static strings.
 	 */
 	discard_index(&o->orig_index);
 
-- 
2.17.0.295.g791b7256b2.dirty

