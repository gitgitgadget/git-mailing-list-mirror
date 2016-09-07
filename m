Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB89F1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbcIGPNP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:13:15 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48024 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933183AbcIGPNP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:13:15 -0400
Received: from x590d6d43.dyn.telefonica.de ([89.13.109.67] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bheXB-0006Yc-22; Wed, 07 Sep 2016 17:13:08 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 0/5] Fix version sort prerelease reordering bug
Date:   Wed,  7 Sep 2016 17:12:46 +0200
Message-Id: <20160907151251.30978-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473261188.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry for double post, forgot to Cc: the mailing list...)

This series fixes a bug, where version sort with prerelease reordering
puts tagnames in the wrong order, when the common part of two compared
tagnames ends with the leading character(s) of one or more configured
prerelease suffixes.  More details in the final patch.

The first two patches are test cleanups, the first is an independent
"while at it", but the second one touches tests that are modified by
later patches of this series.  The rest is rather straightforward: add
failing tests, do some refactoring, and finally fix the bug.

SZEDER Gábor (5):
  t7004-tag: delete unnecessary tags with test_when_finished
  t7004-tag: use test_config helper
  t7004-tag: add version sort tests to show prerelease reordering issues
  versioncmp: pass full tagnames to swap_prereleases()
  versioncmp: cope with common leading parts in
    versionsort.prereleaseSuffix

 t/t7004-tag.sh | 83 ++++++++++++++++++++++++++++++++++++++++------------------
 versioncmp.c   | 46 +++++++++++++++++++++-----------
 2 files changed, 87 insertions(+), 42 deletions(-)

-- 
2.10.0.74.g6632b1b

