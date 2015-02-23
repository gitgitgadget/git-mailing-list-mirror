From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/4] OPT_{FILENAME,PATH}
Date: Mon, 23 Feb 2015 17:17:42 +0100
Message-ID: <cover.1424707497.git.git@drmicha.warpmail.net>
References: <20150223144214.GA31624@peff.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvhj-0003ia-P2
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbbBWQRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:17:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60941 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752145AbbBWQRs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 11:17:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6795520833
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 11:17:47 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 23 Feb 2015 11:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=Hths6cGT+CbGbx
	XY9wkjKDIpWDo=; b=n/0YFc55VK7Be5IfDp5JgAUaL96CdZUWgv/SbETGz2+u0c
	8EQ+krc0qRyYc3XxecG60RFlFzMMZHqQTVGTY0JV5Y7RjSpQ6yFJNGQKxEmxO1M8
	bb6vpFLMbhi9/qvoJG2uUuyjPYOqarb9uP5JTJxfB+S1vnKEejp3SyH7HaDfU=
X-Sasl-enc: c9RjoMooWyRjVihoDZ0xFrDqVYeNbKqBVjDE2oKuzGox 1424708267
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B724668017E;
	Mon, 23 Feb 2015 11:17:47 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
In-Reply-To: <20150223144214.GA31624@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264270>

Here's a "mini-war" on file-type arguments being specified as OPT_STRING
(in order to repent for doing so myself).

1/4 introduces OPT_PATH which is like OPT_FILENAME, but takes an additional
argument which names the option argument.
2/4 converts OPT_STRING to OPT_FILENAME where it makes sense
3/4 converts OPT_STRING to OPT_PATH where it makes sense
4/4 converts OPT_FILENAME to OPT_PATH for "checkout --to"

1/4, 2/4 should apply on top of origin/next independently.
3/4 needs 1/4.
4/4 needs 1/4 and is on top of nd/multiple-worktrees.

Michael J Gruber (4):
  parse-options: introduce OPT_PATH
  option-strings: use OPT_FILENAME
  option-strings: use OPT_PATH
  checkout: --to requires directory

 Documentation/technical/api-parse-options.txt | 5 +++++
 archive.c                                     | 2 +-
 builtin/archive.c                             | 2 +-
 builtin/blame.c                               | 4 ++--
 builtin/checkout.c                            | 2 +-
 builtin/clone.c                               | 4 ++--
 builtin/config.c                              | 2 +-
 builtin/fast-export.c                         | 4 ++--
 builtin/hash-object.c                         | 2 +-
 builtin/init-db.c                             | 4 ++--
 builtin/ls-files.c                            | 2 +-
 parse-options.h                               | 2 ++
 12 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.3.0.296.g32c87e1
