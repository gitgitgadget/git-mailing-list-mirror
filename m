Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6646B208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 14:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbdIGOCr (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:02:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:64742 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755397AbdIGOCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:02:41 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MUhql-1dyzuY1RX1-00RFMi; Thu, 07
 Sep 2017 16:02:29 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Test name-rev with small stack
Date:   Thu,  7 Sep 2017 16:02:19 +0200
Message-Id: <cover.1504792601.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.603.gf58147c36e
In-Reply-To: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
X-Provags-ID: V03:K0:PxYUyAh5/SwD8EFCLBFBOM0buOg0x6CZJOPSd+1MCd4aTf53UFd
 ubGZLoXjIOZdDyhPmMVVwkOrPTThUjBPjB6PQzbovn9aPf3PyId5xf6StWJXLGN43CW9zQA
 6LKMtG5QGQ50TH+Wogo/Ft5UXLwUPkAhfoiAVbgmXRKORlqXd9ffAISD7lO+rkdfeLs+tC+
 1G15RVOooi3OpKCdektsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YNiV7swpLcs=:zeINozAPXuR6rRyBstwh7l
 W9CCm2oirTXL7etOPa7TdYIsZHsAdOSWPGdVruGI+RkKGngCww7mJskko1cfnrxzGdbQAmooD
 4BnKjJin2q2Zr6V8FGh1hPi/khTVkjisedJCUZS6bgScbCkXdN5HhxthOeo2nqvK2CcGi6jAV
 bO+MaI3V9rIdizw5WePfTwqAqc0xZRqCcifRMsG7BCmPFS4WGTH1aq8KTifBTVJG/xb3745Ie
 rQNsPvZL2ivSGtjPiQ1OzbuC4R4h4T2W37L5yrOAixaIGTMNP4PKBbzbYdFR6c9TXmqTUcs4K
 UXP3euRIGD4v04uZ+lak5AZWkkpFk/MukTzOHnff+ywGfG4GVdgA8Fema2RvNUgsyjONlRS7d
 LitlaQtdcYNsaKKDG2lSYdVukU5jYQ7DbUozCbWWidExtuDj4eSS3FPylGj2yTNXYFkfQ/oC1
 Ivhv2p+S5u8JMHs0g/CV4Bo3j30wWIyqgKjYk2pPIcYkFL+vTd30USG0xSyzotwbxNH6yCOK8
 YZ6CI1+IgOuqIi37omh1uIKZufRcuVTaQh5o+08M7f0Gdxjz7I/4DHvX8hU1yaNseDbIAsybD
 UlPt0I99/GTV843f8UdMIFRxNutJBFqWLDCeKn/2ItDN6plXiqAijk4SnHRUe5/WVn5j389hf
 YSpLyAAfTU7bhYvp7CD42qrw2EnaCrAluX4wq5AS9n43Bla7uQwGQD191ADIDuCe8BDRYRSHF
 cHLwibHIjHegE/y2VXx743xrIfoKx8KKOc10lQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

name-rev segfaults for me in emacs.git with the typical 8102 stack size.
The reason is the recursive walk that name-rev uses.

This series adds a test to mark this as known failure, after some
clean-ups.

Michael J Gruber (4):
  t7004: move limited stack prereq to test-lib
  t6120: test name-rev --all and --stdin
  t6120: clean up state after breaking repo
  t6120: test describe and name-rev with deep repos

 t/t6120-describe.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t7004-tag.sh      |  6 ------
 t/test-lib.sh       |  6 ++++++
 3 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.14.1.603.gf58147c36e

