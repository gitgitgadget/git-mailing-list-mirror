Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B5A1F42D
	for <e@80x24.org>; Wed, 23 May 2018 20:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbeEWUqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 16:46:23 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40562 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933518AbeEWUqW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 May 2018 16:46:22 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4NKcRfu019197;
        Wed, 23 May 2018 13:46:16 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j2hsk61qe-1;
        Wed, 23 May 2018 13:46:16 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8BB38239165B;
        Wed, 23 May 2018 13:46:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 80EE82CDE7B;
        Wed, 23 May 2018 13:46:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, B.Steinbrink@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t6101: add a test for rev-parse $garbage^@
Date:   Wed, 23 May 2018 13:46:12 -0700
Message-Id: <20180523204613.11333-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1025.g36b5c64692
In-Reply-To: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
References: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=794 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805230202
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Florian Weimer and Todd Zullinger.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 8c617981a3..7b1b2dbdf2 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -214,4 +214,8 @@ test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
 	test_must_fail git rev-list merge^-1x
 '
 
+test_expect_failure 'rev-parse $garbage^@ should not segfault' '
+	git rev-parse ffffffffffffffffffffffffffffffffffffffff^@
+'
+
 test_done
-- 
2.17.0.1025.g36b5c64692

