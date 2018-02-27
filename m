Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632311F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeB0VTy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:19:54 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:34408 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751518AbeB0VTx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Feb 2018 16:19:53 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1RLETbi017068;
        Tue, 27 Feb 2018 13:18:37 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2gb6sn490t-1;
        Tue, 27 Feb 2018 13:18:37 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0A5B52212884;
        Tue, 27 Feb 2018 13:18:37 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id F40AE2CDEB1;
        Tue, 27 Feb 2018 13:18:36 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 30/29] fixup! merge-recursive: apply necessary modifications for directory renames
Date:   Tue, 27 Feb 2018 13:18:36 -0800
Message-Id: <20180227211836.20889-1-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.gbf538760f8
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=507 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802270263
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use is_null_oid() instead of is_null_sha1()
---
This is just a fixup to patch 23/29 in my v8 series for detecting directo=
ry renames;
should squash cleanly.

 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ffe1d0d117..6e6ec90e9e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -667,9 +667,9 @@ static int update_stages_for_stage_data(struct merge_=
options *opt,
 	oidcpy(&b.oid, &stage_data->stages[3].oid);
=20
 	return update_stages(opt, path,
-			     is_null_sha1(o.oid.hash) ? NULL : &o,
-			     is_null_sha1(a.oid.hash) ? NULL : &a,
-			     is_null_sha1(b.oid.hash) ? NULL : &b);
+			     is_null_oid(&o.oid) ? NULL : &o,
+			     is_null_oid(&a.oid) ? NULL : &a,
+			     is_null_oid(&b.oid) ? NULL : &b);
 }
=20
 static void update_entry(struct stage_data *entry,
--=20
2.16.1.232.gbf538760f8

