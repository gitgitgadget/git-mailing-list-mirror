Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF421F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbcGKWqz (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:46:55 -0400
Received: from kitenet.net ([66.228.36.95]:60938 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbcGKWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:46:53 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=ier2ZdRe;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277197; bh=kOlU+hQ5LyTEz/eutsD10qEeMefFCuV9/88MgBjyH3k=;
	h=From:To:Cc:Subject:Date:From;
	b=ier2ZdReiz3+8cyLyfBhIuFH0zribYdza324RRso423MVVwX5Z5dXjkqHvfVpRxVA
	 SLJCxSfGmOuiiQikb4CcFpmTi8rt+gcLqcgvQGgQMug+ee8CysZVHW76EpSILa8eIN
	 1qIOb5q8Q8fHMaRifEWQvbQiw4XTzTdDJZdyPMIE=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 0/8] extend smudge/clean filters with direct file access (for pu)
Date:	Mon, 11 Jul 2016 18:45:04 -0400
Message-Id: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Back from vacation with a reroll of jh/clean-smudge-annex.

Deals with conflicting changes from cc/apply-am in pu.

Since tb/convert-peek-in-index is not currently in pu, this reroll isn't
based on it, and will conflict if that topic gets added back into pu.
Not sure what the status of tb/convert-peek-in-index is at this point?

Improvements from Junio's review:

	fix build with DEVELOPER=1
	style fixes
	use test_cmp in test cases
	improve robustness of a test case
	clean up some confusing code
	small performance tweak

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
 apply.c                         |  16 +++++
 convert.c                       | 148 ++++++++++++++++++++++++++++++++++++----
 convert.h                       |  10 +++
 entry.c                         |  59 ++++++++++++----
 merge-recursive.c               |  53 +++++++++++---
 sha1_file.c                     |  42 ++++++++++--
 t/t0021-conversion.sh           | 117 +++++++++++++++++++++++++++++++
 9 files changed, 459 insertions(+), 46 deletions(-)

-- 
2.8.1

