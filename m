Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA27763A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865546; cv=none; b=MXDJP6aeYrFS2sqYXU4bwWIVcZkzpQvwzHsDdlyyakYJIUTD7rZ3Aj91XvsAICRSdn60D1c1SogeuCWePlW7RmTHbG93NRkKH+Jwkev1alcJyGMsaRSZ0v+MrmoNTQIu5Mb1TvBfdhRQvRBIIbR2/8uvDp8NPZJThHYECX2RY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865546; c=relaxed/simple;
	bh=hjZ6g5EupWqYXAgzz/00nC8rGs0ZDnbWVs4IqAeQs5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyvKsQwqDh4E9Xm3PBGM/MTboIlJUvTzu2Cd3cl7bM7RChRh5aUWkieBvV8brJbkpyefj0uWTOPMP2HY4R1WC0apEW9UUT/vUJjgZahtWalcd4u6KEOlUocAdxLWrWY0DEcfSZ39iuSz2OEJOJUlT06Y4vkTRxTpZvoxwg3RIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AdYop5VV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdYop5VV"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4128T2nG028345;
	Fri, 2 Feb 2024 09:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=egPRMxJw3gf2gFgzMdk3EXcxhuppwflHWAm2oFlbgoY=;
 b=AdYop5VVomsBbU7Fqx07Wff8j2EM62TJz/pzO3Nwp0GyLqjsR7yVGnmnu56CeG+KJ/bA
 d4z9AtlKOMba6Soy0hejka1aNCb4VQoCHwalVLub4wJhlsISnWdeTQY8Nlr6Uaw8EDe0
 rUKDasEJAo9n/HvNHcqtB0L171p5SsuGom+1E03L5bwJk+Q5cZt8JflC2D7GagpR0CjQ
 /9JAe4dLzw7Qvdl31aTrlMq0oQ5wgs5Iet5IRxl7tGnIkCPMbQ0i7gN7w/T73y0nYfch
 R7qQtwI+lTt8XlxGgQLRjFUFrjYFmeb4dgxu8E+UjLP44EU1hZrWZ1E0xvFITcEEADlq /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdy20n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:19:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41274RWS028402;
	Fri, 2 Feb 2024 09:19:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bu005-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:19:00 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4129J00f039410;
	Fri, 2 Feb 2024 09:19:00 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-60-116.vpn.oracle.com [10.175.60.116])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9btyx4-1;
	Fri, 02 Feb 2024 09:18:59 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] t/t3515-cherry-pick-rebase.sh: new testcase demonstrating broken behavior
Date: Fri,  2 Feb 2024 10:18:50 +0100
Message-Id: <20240202091850.160203-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020067
X-Proofpoint-ORIG-GUID: GlHpgMxQP_a543j0N4TDT56VrbMDqFhE
X-Proofpoint-GUID: GlHpgMxQP_a543j0N4TDT56VrbMDqFhE

Running "git cherry-pick" as an x-command in the rebase plan loses the
original authorship information.

Write a known-broken test case for this:

    $ (cd t && ./t3515-cherry-pick-rebase.sh)
    ok 1 - setup
    ok 2 - cherry-pick preserves authorship information
    not ok 3 - cherry-pick inside rebase preserves authorship information # TODO known breakage
    # still have 1 known breakage(s)
    # passed all remaining 2 test(s)
    1..3

Running with --verbose we see the diff between expected and actual:

    --- expected    2024-02-02 08:54:48.954753285 +0000
    +++ actual      2024-02-02 08:54:48.966753294 +0000
    @@ -1 +1 @@
    -Original Author
    +A U Thor

As far as I can tell, this is due to the check in print_advice()
which deletes CHERRY_PICK_HEAD when GIT_CHERRY_PICK_HELP is set,
but I'm not sure what a good fix would be.

Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 t/t3515-cherry-pick-rebase.sh | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/t3515-cherry-pick-rebase.sh

diff --git a/t/t3515-cherry-pick-rebase.sh b/t/t3515-cherry-pick-rebase.sh
new file mode 100755
index 0000000000..ffe6f5fe2a
--- /dev/null
+++ b/t/t3515-cherry-pick-rebase.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='test cherry-pick during a rebase'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit --author "Original Author <original.author@example.com>" foo file contents1 &&
+	git checkout -b feature &&
+	test_commit --author "Another Author <another.author@example.com>" bar file contents2
+'
+
+test_expect_success 'cherry-pick preserves authorship information' '
+	git checkout -B tmp feature &&
+	test_must_fail git cherry-pick foo &&
+	git add file &&
+	git commit --no-edit &&
+	git log -1 --format='%an' foo >expected &&
+	git log -1 --format='%an' >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'cherry-pick inside rebase preserves authorship information' '
+	git checkout -B tmp feature &&
+	echo "x git cherry-pick -x foo" >rebase-plan &&
+	test_must_fail env GIT_SEQUENCE_EDITOR="cp rebase-plan" git rebase -i feature &&
+	git add file &&
+	git commit --no-edit &&
+	git log -1 --format='%an' foo >expected &&
+	git log -1 --format='%an' >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.34.1

