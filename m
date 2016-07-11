Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8704E1FE4E
	for <e@80x24.org>; Mon, 11 Jul 2016 11:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbcGKLpQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 07:45:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:57055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbcGKLpP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 07:45:15 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LabZr-1ayYAt1gP1-00mMI8; Mon, 11 Jul 2016 13:45:08
 +0200
Date:	Mon, 11 Jul 2016 13:45:08 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH] Fix running tests with --valgrind
Message-ID: <80e5a1b53844d82c48eb16c88a962d9d693e0491.1468237495.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SRdsVpaIJzAgCLIzL8pB2xBByqA0nSawVxg3rGLwJHWURaFEUA1
 1Za/d6xz63M1oAWhstYJLCJP2TAHZJHgPyyh0Tjdg7sVEz1WrBgGLanI7XWVT3Jv1flUDfh
 khtJqb6i66c/9EEWHHRIDiuZ8SRAuRuOvK5Nhl5LS1AkfTSxZg8IxsucwtpN1bIixOD99QM
 IyKUBvWdga3NVA66FR9Cw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:+CwagFt6ffo=:vdtvYGJftUdDnAfINifZgB
 sfpS3xl6IxdiXQqr0rWUPzFjZReR6iTtLfIF9fI9IVm6INJ95QezE7d1jujfP79e3rA0YrP39
 z1ksJgFgtuG197VlIFBvvk3R9q2dd5L1uy0hQCgFueXVfB8Hw2fKq9CcVmcrbUfFUi1gZun0A
 bTuikf1uSG3dVpyM8YngDENaCav3oRuSw6PT9+lF4CZBZk9KsoR5x0qG1TDEtjqxWN3iSjM/z
 WnM11tpSfONPBowioN7+fNOXJ0yih1poGduiGe1cXPRKz7gwxGsUqPzpiIM7GbAXoBlz8lTT4
 3rPv+sOJpg3jYpkWHTzxWekaAOXEcvRPnQPDtTtHlw0HM9zd3Nod8P3+o1D4/PPdfji1aYicu
 THqJf2YEsz4NCOcFdXZhWB9sH+0a96HDf6VfEiP2QKkRtcga8V18WisPDxAw43T+lCqsep3nx
 SASIoWsj8ZKxFCv1Bpvz9c6MONx8DVsCvYTVojtfwUJ3fi3TgYD3X7t4iHKnOZgDVy4Eoy3pV
 a8iLj5yXYeBT+HNOeIkJ1scqS9hUHFuQEdpGwJO0OULj80DEac5cIjB2MCALTkMwpEi7ffdMu
 FZS7/B2AxOqpFF2GcHoDBkreB8c1a3nOdNbKcy4qIadO6U9Wt360E45Z9+AX/E4o3WPLcWNx7
 zt61FZvIPJfw5lY/tJdfgaaxNujH6pvmVmf6D7t9w74UvxcrkCkBnQlx7RKNaKHI057GbMgtx
 lwfaxjJQLPz9oFRUEQ57CJkaqvM1E/+2BwctpcLV9k9L/g67q3PVRxN9EIEcgDF2URyyMsXLw
 0xj9GA4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We forgot to adjust this code path after moving the test helpers to
t/helper/.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/valgrind-and-test-helpers-v1
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..493a92b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -798,7 +798,7 @@ then
 	# override all git executables in TEST_DIRECTORY/..
 	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
 	mkdir -p "$GIT_VALGRIND"/bin
-	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
+	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/t/helper/test-*
 	do
 		make_valgrind_symlink $file
 	done
-- 
2.9.0.278.g1caae67

base-commit: 5c589a73de4394ad125a4effac227b3aec856fa1
