Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B201FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbcLITBj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:01:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:64051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbcLITBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:01:37 -0500
Received: from fermat.fritz.box ([88.70.156.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPlsg-1cJFuh3y0w-004xYB; Fri, 09
 Dec 2016 20:01:34 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/5] Add test that cherry-pick --abort does not unsafely change HEAD
Date:   Fri,  9 Dec 2016 20:01:09 +0100
Message-Id: <20161209190111.9571-3-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g74d6bea
In-Reply-To: <20161209190111.9571-1-s-beyer@gmx.net>
References: <20161209190111.9571-1-s-beyer@gmx.net>
In-Reply-To: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:p2OwOPEtHBjzqQycHOL94Hr1m+DHkgiKQ+myIlipwVb7ccMREq4
 vRz56KAYEdKi5f47BSDN3grwY3l0utC36KSACMA8u8EPGQztmjXtI/tdbcCCGBIv1uOEF3X
 2p4W55M+QVURq/op8MjLyrDSmwgS7f8bYwhxUZ8loHSvafqmFQUdcgzqwXLdPc/hrpqSkH9
 DKdbfbCNW1A4q/WMsGbqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0YXAenxlxRA=:M57xBwn5nDiGpEA+gc86gt
 1mIrDtTzKIymlbYQO7oANwtFkrSGVugxPAXofL6mVTF3ZSt9b3c9v7DQ+z5wjE7IYl1pYzg1j
 KbuZVHixqNKkTNkF1DNnNy6qsQlBNKq4Bnegub/YnQjskWoo/AYzWord2rBBPV+9gODihYg6e
 C//donwFvXGLwR5Fuvax4ose2uy8Ie4AWWdkmGdcR2M1MCa36rjfhw0dpJoSZzapHRDohL2/g
 uOdo4wiAozaIaTyQb2bzMPGGiAiVJKbSbnfyDrgRAb1QO2qERWTbILf+UxJjnSmVXSTkJ+/m1
 wr0C6v+byn9eIM+3L7A1KFS6WIVKcYw9Tk8NSAmycoGDnXZaI7FqC+s7Lv6Aiq2D0UneYHxZY
 lFHo1ZQvcWyy8oOPmTEakQsb5A6W2RQxypO1f1XEhK5pwl0cdMYJtHt4wJVo7YpINOXZOPNsb
 1I5SgRvhXrzUB7ILnK0CVDyH+ImUwmRdjAF03yUAUqyTtSffTdVlV6BTUDGmeV3yeBNlnPJuL
 1LFShXf+WTVNGxRQwFdkuCN9FsFpiXkRmQ01n/1VGku3xfEHm8or70f9bAgqwIFpTCiVkP4jZ
 dLZgEpZ2dZf3pgrBldiTfx7y0iAm1uxEHY08YiIM2lVJcQdeXqflj7m2v6K9aKiLVNZNRwE5M
 WaBbE/r1vVHTD8Zf2TpRIu9L1syEmY9vKcF027uwfH7/u8NtVL7bO/bJRzn6mggjC8NtWf18+
 ZKpe0CCxi3ITUnxtPtl+X7Xs1KLNa1IcxM4bIWfQNsFsVoTR9+G1y3aefKw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test expects failure because it is a current breakage
reported by Junio C Hamano.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89dbd..efcd4fc48 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -147,6 +147,16 @@ test_expect_success '--abort to cancel single cherry-pick' '
 	git diff-index --exit-code HEAD
 '
 
+test_expect_failure '--abort does not unsafely change HEAD' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked anotherpick &&
+	git reset --hard base &&
+	test_must_fail git cherry-pick picked anotherpick &&
+	git cherry-pick --abort 2>actual &&
+	test_i18ngrep "You seem to have moved HEAD" actual &&
+	test_cmp_rev base HEAD
+'
+
 test_expect_success 'cherry-pick --abort to cancel multiple revert' '
 	pristine_detach anotherpick &&
 	test_expect_code 1 git revert base..picked &&
-- 
2.11.0.27.g74d6bea

