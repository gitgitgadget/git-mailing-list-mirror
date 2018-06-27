Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880211F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeF0HqI (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:46:08 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39088 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932911AbeF0HqG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:46:06 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7gRNb007077;
        Wed, 27 Jun 2018 00:46:03 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mtha9-1;
        Wed, 27 Jun 2018 00:46:02 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E446D228A02B;
        Wed, 27 Jun 2018 00:46:02 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id DAADF2CDE65;
        Wed, 27 Jun 2018 00:46:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] git-rebase--merge: modernize "git-$cmd" to "git $cmd"
Date:   Wed, 27 Jun 2018 00:46:00 -0700
Message-Id: <20180627074600.32149-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180607050615.19598-1-newren@gmail.com>
References: <20180607050615.19598-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=634 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---

Changes since v1:
  - Fixed up commit message (move below comment to below diffstat as
    originally intended)

Long term I just want to make git-rebase--merge go away, so this patch
will eventually be obsoleted.  But since I'm waiting for multiple
topics to merge down before re-submitting that series, and since that
series has some open questions as well, I figure it's worth
(re-)submitting this simple fix in the mean time.

 git-rebase--merge.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index cf4c042214..aa2f2f0872 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -71,7 +71,7 @@ call_merge () {
 	test -z "$strategy" && strategy=recursive
 	# If cmt doesn't have a parent, don't include it as a base
 	base=$(git rev-parse --verify --quiet $cmt^)
-	eval 'git-merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
+	eval 'git merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
 	0)
@@ -88,7 +88,7 @@ call_merge () {
 		;;
 	*)
 		die "Unknown exit code ($rv) from command:" \
-			"git-merge-$strategy $cmt^ -- HEAD $cmt"
+			"git merge-$strategy $cmt^ -- HEAD $cmt"
 		;;
 	esac
 }
-- 
2.18.0.9.g431b2c36d5
