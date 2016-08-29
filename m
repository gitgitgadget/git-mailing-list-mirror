Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBAC1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756731AbcH2IEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:57437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756125AbcH2IEu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MYx2x-1bYyWS33pb-00VjMo; Mon, 29 Aug 2016 10:04:47
 +0200
Date:   Mon, 29 Aug 2016 10:04:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/22] sequencer: remove overzealous assumption
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cbLcxgPmxjsLAxseDd2mBDVhTTfzfsQIs4eF22j4rjO8oCuF+k6
 3DtTKuJVWPt8DZD+sUy3lpUZ9VYoKE2CAMO+19XDs3Gw8j4OHdqTun48Vs9jrqwIi1TdRLS
 L6cIoMFXgbTUu8r0BqpiD0N2vlfu7JEZpFWQnnqSyH2VakCNVd3uMYg7xa9bEH4L8h3jzQn
 h/80XIflr6f0v8AsCnjtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gji4WFVEass=:hiO6dxC77pvPTkQYXPkfI1
 XQd+ENC9JdzfaYRA9lASC36oapBVe0fs+72fuYxm3+n72mrMTSAWxMlVjxjZcN+9t0e9HfNnf
 yg6+QjlRukEbmVQPhHZZ+i/7gO9Bvoe9gEDoewbHRJPo9ufM3D/jVFo8Z1KbzPWiOkqJJ/M/N
 ERkBrgv+Lj9preH2r6rh4gJFdPvHvJggxquxF5hlg1bkqf32iqSJOt5pqXA9MIdejctbMPpCm
 TYNdytEloTm3FzmSdso+60jUqYTtF2n4Jh78tQZX+LaD7aYCDEKTUYgeWuFEruTOcVfgP3zHL
 OBnqKfSxmJDH5KJFPTLS0YSMaX4slKASdl/GUcxJd0GaUJWCg3R5Fc/jvVE4bpjt1B1dPOiDF
 8PPO1ySuA1NQTjaQ/f7nzTm2I1V5pVaueM8OaCjTM17FXsYpWrH3jZ+N92q2Q1vAGPqE8Ou3h
 dpwDej7OTMuyEu516Je/vbpl4YAWBqfmtSHbAJpQgofutirLTaAQec/KfMZ16mbgpmCLYrA3D
 5ZAEQcxKpGL9K/SNn7PCvrDY0QprGRONfobdRAwKxw7Bd50fTa71UsO/GijnzmvTz1bJ+OZIe
 vlfidYutDnQ56lM1pNIR1AISCFSkP6MG1WzhO2hXhI0jgnCcHxVmgZubOtQn5MRklVfHxBl3i
 hpKZuK/wSOPvQva1M7cyt8J6tnC++PzAVwdQ0F0h58Qlr3cUzLyv+RX7e5hKIKM/zXRyjhRa9
 KFQ5R4fv96bVIWKTDo1Q3ZiZ85lEFuOHd0naho+EAmIChZF5d1NdEkKtztP8N1OeqYKPkR9Wc
 dhkxjwh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer was introduced to make the cherry-pick and revert
functionality available as library function, with the original idea
being to extend the sequencer to also implement the rebase -i
functionality.

The test to ensure that all of the commands in the script are identical
to the overall operation does not mesh well with that.

Therefore let's just get rid of the test that wants to verify that this
limitation is still in place, in preparation for the upcoming work to
teach the sequencer to do rebase -i's work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3510-cherry-pick-sequence.sh | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..6465edf 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -459,17 +459,6 @@ test_expect_success 'malformed instruction sheet 1' '
 	test_expect_code 128 git cherry-pick --continue
 '
 
-test_expect_success 'malformed instruction sheet 2' '
-	pristine_detach initial &&
-	test_expect_code 1 git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_expect_code 128 git cherry-pick --continue
-'
-
 test_expect_success 'empty commit set' '
 	pristine_detach initial &&
 	test_expect_code 128 git cherry-pick base..base
-- 
2.10.0.rc1.114.g2bd6b38


