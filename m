Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3AC1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbdKJRtY (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:49:24 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38776 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752625AbdKJRtY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 12:49:24 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAHcefq009800
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e536317d5-1
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6DCB322F444C
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 66DF12CDE6A
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] sequencer: Show rename progress during cherry picks
Date:   Fri, 10 Nov 2017 09:39:56 -0800
Message-Id: <20171110173956.25105-5-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110173956.25105-1-newren@gmail.com>
References: <20171110173956.25105-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100246
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trying to cherry-pick a change that has lots of renames, it is
somewhat unsettling to wait a really long time without any feedback.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 2b4cecb617..247d93f363 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -448,6 +448,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	o.branch2 = next ? next_label : "(empty tree)";
 	if (is_rebase_i(opts))
 		o.buffer_output = 2;
+	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
-- 
2.15.0.5.g9567be9905

