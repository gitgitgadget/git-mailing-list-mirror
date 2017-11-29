Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4849020954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbdK2Bqk (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:46:40 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55824 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753396AbdK2Bqj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:46:39 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT1huJG007423;
        Tue, 28 Nov 2017 17:46:00 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ef78pmm43-1;
        Tue, 28 Nov 2017 17:46:00 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 825FB2214FDA;
        Tue, 28 Nov 2017 17:46:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 772B52CDE74;
        Tue, 28 Nov 2017 17:45:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] strbuf: Remove unused stripspace function alias
Date:   Tue, 28 Nov 2017 17:45:59 -0800
Message-Id: <20171129014559.32755-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g850bc54b15
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711290021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 63af4a8446 ("strbuf: make stripspace() part of strbuf",
2015-10-16), stripspace() was moved to strbuf and renamed to
strbuf_stripspace().  A "temporary" alias was added for the old name unti=
l
all topic branches had time to switch over.  They have had time, so remov=
e
the old alias.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strbuf.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 0a74acb236..14c8c10d66 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -480,15 +480,6 @@ extern int strbuf_normalize_path(struct strbuf *sb);
  */
 extern void strbuf_stripspace(struct strbuf *buf, int skip_comments);
=20
-/**
- * Temporary alias until all topic branches have switched to use
- * strbuf_stripspace directly.
- */
-static inline void stripspace(struct strbuf *buf, int skip_comments)
-{
-	strbuf_stripspace(buf, skip_comments);
-}
-
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suf=
fix)
 {
 	if (strip_suffix_mem(sb->buf, &sb->len, suffix)) {
--=20
2.15.0.408.g850bc54b15

