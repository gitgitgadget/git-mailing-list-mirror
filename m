Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D062C684
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142429; cv=none; b=nyps9YRLylE2orJ53fATdNco3Nv/YIR9FElEetBC3hlMy3HNqn9EMEgbiqb7qazCBw9tw2uvaaJAaVLx1J8PgxTHi6Yj0XOEzosuAB9HkbKwbPQ/7bJOT3Hd3U/tnTtzRv1pmXpTkhcoSjZbj1WeVPxdJcEAjvBwiYI9MCROgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142429; c=relaxed/simple;
	bh=vYXd3RzIsHGA0pzpoJWrs4gdmOJDFtHomWA85G6vSIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkLLlmanmD84SMrSAqbrrxalE/q62qlSPzeFGuh02/F8HoXLNnVj660oVF48SyWJNT5ExrTgU3/NqjVLNLewYl9eh1u86/mXLvMEthkwyk6ipUHlZHFl299STHfP/XTdWOjiFF9siByKvfmZ/nhlWRe+np/n4enf/J6NWy5NUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Er/BuXPA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Er/BuXPA"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DVp84023701;
	Mon, 5 Feb 2024 14:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=bsRNun+SNF2ZbktBLclxD2/HSOp3N+H0/tBmfEEd2M4=;
 b=Er/BuXPA5cwqtqlWLBdZnMyULM+yP8tYHe0nbdIscNi3Mko8WMpSnjOFWfCb3TXhMFfm
 chWW+zJ9r3G4lm5c/ZScbseK6Mmsnzb5OYrVn3d2TPgLP/5a64VdTDxXaDcz5QxGJWso
 WGhQbGEy87eWLpBi4uUnN7/+23StHXbZ7Ps0+E15yx2EeF4ntiriJ7y1atKmHBjattmW
 XPdpm5kxSBIz6cVHSmFo1B6jXwFG2BfZLDWCAH/1M61HUr0QSLW9LLU5cZtlxwfRLhaX
 UEnyEOLcMI5btqhRLKr7RQWurVeL1dtqI4wL1C0tkRj9gQ30eyIwe/ExL/WIn1+nHoGe IA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3uc0cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 14:13:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415DDwq4036765;
	Mon, 5 Feb 2024 14:13:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5r89w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 14:13:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415EDgHg035661;
	Mon, 5 Feb 2024 14:13:42 GMT
Received: from localhost.localdomain (dhcp-10-175-57-13.vpn.oracle.com [10.175.57.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx5r88k-1;
	Mon, 05 Feb 2024 14:13:42 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands
Date: Mon,  5 Feb 2024 15:13:35 +0100
Message-Id: <20240205141335.762947-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050108
X-Proofpoint-ORIG-GUID: WSjd_hI_TAWuIvhw0p_Y1a0CmditIuAk
X-Proofpoint-GUID: WSjd_hI_TAWuIvhw0p_Y1a0CmditIuAk

Running "git cherry-pick" as an x-command in the rebase plan loses the
original authorship information.

To fix this, unset GIT_CHERRY_PICK_HELP for 'exec' commands.

Link: https://lore.kernel.org/git/0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com/
Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 sequencer.c                   | 1 +
 t/t3515-cherry-pick-rebase.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 91de546b32..f49a871ac0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3641,6 +3641,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	fprintf(stderr, _("Executing: %s\n"), command_line);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
+	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
 	status = run_command(&cmd);
 
 	/* force re-reading of the cache */
diff --git a/t/t3515-cherry-pick-rebase.sh b/t/t3515-cherry-pick-rebase.sh
index ffe6f5fe2a..5cb2b96f66 100755
--- a/t/t3515-cherry-pick-rebase.sh
+++ b/t/t3515-cherry-pick-rebase.sh
@@ -23,7 +23,7 @@ test_expect_success 'cherry-pick preserves authorship information' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'cherry-pick inside rebase preserves authorship information' '
+test_expect_success 'cherry-pick inside rebase preserves authorship information' '
 	git checkout -B tmp feature &&
 	echo "x git cherry-pick -x foo" >rebase-plan &&
 	test_must_fail env GIT_SEQUENCE_EDITOR="cp rebase-plan" git rebase -i feature &&
-- 
2.34.1

