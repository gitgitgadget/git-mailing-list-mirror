Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508E620189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbcFVUVu (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:21:50 -0400
Received: from kitenet.net ([66.228.36.95]:57408 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbcFVUVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:21:49 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Dgynavu0;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466626899; bh=IY1WZhi63ySqxCGb+WkuyFShUADvnj/opDnPhofiz00=;
	h=From:To:Cc:Subject:Date:From;
	b=Dgynavu0c/TFoNnO4bvMJIHqPcFIAp7S/duAZCMM+HgAu6+s8xVsysjBOybe2EU4m
	 TeyHbv0+Ft/P8lsRD8l0+vIzSqe95hC3ps8BdEQTAdW5c7ocU4+6q22o5NT+ZmY9it
	 FSGFv10amyOBNSIWnd2IXyxvgBAHoLTPUNXJLYzY=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v3 0/8] extend smudge/clean filters with direct file access
Date:	Wed, 22 Jun 2016 16:21:25 -0400
Message-Id: <20160622202133.23565-1-joeyh@joeyh.name>
X-Mailer: git-send-email 2.9.0.8.gf959b2a
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reroll of this patch set with changes:

* Added additional smudgeToFile calls in git am and recursive merge.
* Improved behavior when smudgeToFile filter fails.
* Some small improvements to the test cases.

I hope this will be the final version.

Joey Hess (8):
  clarify %f documentation
  add smudgeToFile and cleanFromFile filter configs
  use cleanFromFile in git add
  use smudgeToFile in git checkout etc
  warn on unusable smudgeToFile/cleanFromFile config
  better recovery from failure of smudgeToFile filter
  use smudgeToFile filter in git am
  use smudgeToFile filter in recursive merge

 Documentation/config.txt        |  18 ++++-
 Documentation/gitattributes.txt |  42 ++++++++++++
 builtin/apply.c                 |  16 +++++
 convert.c                       | 141 ++++++++++++++++++++++++++++++++++++----
 convert.h                       |  10 +++
 entry.c                         |  53 +++++++++++----
 merge-recursive.c               |  42 +++++++++---
 sha1_file.c                     |  42 ++++++++++--
 t/t0021-conversion.sh           | 115 ++++++++++++++++++++++++++++++++
 9 files changed, 434 insertions(+), 45 deletions(-)

-- 
2.9.0.8.g973eabb.dirty

