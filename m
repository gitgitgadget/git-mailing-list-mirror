Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D0720189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbcFVVJe (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:09:34 -0400
Received: from kitenet.net ([66.228.36.95]:59218 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbcFVVJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:09:33 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=GOrrPFmv;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466629760; bh=0EHaQOswIQPX62VQkJ5GPNf9RjVQs6U7jFoax0xVsu8=;
	h=From:To:Cc:Subject:Date:From;
	b=GOrrPFmvIwqXHkJ2XheQTw2zQXtP1S24DAsv3vLg0Sg7g7PK46LjT/4rrit08aYq0
	 ao27JNtArOgIwWNI88dwUV+3DOP9DaIYxzNfruBDoQuzg45FXMqLUXj2lEv+2xdPTK
	 G3yTRWRmCww6VinyayqJrjnAqTBh9fligl3H6ggo=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v4 0/8] extend smudge/clean filters with direct file access (for pu)
Date:	Wed, 22 Jun 2016 17:09:10 -0400
Message-Id: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the same as v3, except rebased on top of tb/convert-peek-in-index
to fix a build failure in pu.

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
 convert.c                       | 147 +++++++++++++++++++++++++++++++++++-----
 convert.h                       |  11 +++
 entry.c                         |  53 +++++++++++----
 merge-recursive.c               |  42 +++++++++---
 sha1_file.c                     |  44 ++++++++++--
 t/t0021-conversion.sh           | 115 +++++++++++++++++++++++++++++++
 9 files changed, 441 insertions(+), 47 deletions(-)

-- 
2.9.0.587.ga3bedf2

