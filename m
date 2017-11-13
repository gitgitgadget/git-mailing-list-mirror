Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20E41F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 20:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755277AbdKMUQJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 15:16:09 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59616 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755241AbdKMUQI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2017 15:16:08 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADKDvPD011912;
        Mon, 13 Nov 2017 12:16:06 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e5yxp31b7-1;
        Mon, 13 Nov 2017 12:16:06 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 5D4072265D2A;
        Mon, 13 Nov 2017 12:16:06 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 522FD2CDE60;
        Mon, 13 Nov 2017 12:16:06 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/4] Fix issues with rename detection limits
Date:   Mon, 13 Nov 2017 12:15:56 -0800
Message-Id: <20171113201600.24878-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.44.gf995e411c7
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711130279
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset fixes some issues around rename detection limits.  Changes
since the original submission[1]:
  * Patches 2 and 3 are swapped in order so as to not temporarily introduce
    any bugs (even if only cosmetic)
  * Commit message fixups
  * Using uint64_t instead of double for holding multiplication of integers
  * Corrected format specifier for printing 64-bit ints.

[1] https://public-inbox.org/git/20171110173956.25105-1-newren@gmail.com/

Elijah Newren (4):
  sequencer: warn when internal merge may be suboptimal due to
    renameLimit
  progress: fix progress meters when dealing with lots of work
  Remove silent clamp of renameLimit
  sequencer: show rename progress during cherry picks

 diff.c            |  2 +-
 diffcore-rename.c | 15 ++++++---------
 progress.c        | 22 +++++++++++-----------
 progress.h        |  8 ++++----
 sequencer.c       |  2 ++
 5 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.15.0.44.gf995e411c7

