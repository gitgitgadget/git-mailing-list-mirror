From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/4] pre-commit hook for merges
Date: Thu,  6 Sep 2012 16:25:54 +0200
Message-ID: <cover.1346939542.git.git@drmicha.warpmail.net>
References: <50487F8A.4050803@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9d24-0001zj-B0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2IFO0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:26:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52003 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645Ab2IFO0A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:26:00 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E80BE20BB8;
	Thu,  6 Sep 2012 10:25:59 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 06 Sep 2012 10:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=DW4BZT8EBU18GGUp5SPxXlPn8
	/4=; b=rG0BkJNLThBrHgtXyMpUtWkxSsF+W/kJP4l08CNSuAD3Wfmw9SZ68PH5H
	SFwDgHovyc4j9IIXOXKZ8+VelpF+OH8p2hZdA+w9H7SIQSDFJnD60ySgT66kotIy
	t2+qeVQtgzXtm0Nx0O4W2mDDqppsIq+AiJxfZ7azw759nV80Yw=
X-Sasl-enc: Agrwm3zLpQluL6ZanymgsIK8iwP9dU3Q+Ffvwo2yRDh2 1346941559
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7CFB28E03D0;
	Thu,  6 Sep 2012 10:25:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <50487F8A.4050803@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204885>

In this second iteration I implement Junio's suggestion: 'git merge' invokes
the pre-commit hook when merge.usePreCommitHook is set to true.

1/4 documents that 'git merge' invokes the prepare-commit-msg hook
unconditionally already.

2-4 are v2 of the previous 1-3.

This leaves aside the issue of commit-msg and post-commit hooks. If we can live
with a bit of incompatibility I would rename the config to merge.useCommitHooks
and call all of them based on that.  This would change the way prepare-commit-msg is
treated now.

We could also introduce 4 config variables, 3 defaulting to false, 1 to true,
of course...

[I had messed up my alias file when adding mhagger, and it seems that tripped up
vger; resending, sorry.]

Michael J Gruber (4):
  merge: document prepare-commit-msg hook usage
  git-merge: Honor pre-commit hook based on config
  merge: --no-verify to bypass pre-commit hook
  t7503: add tests for pre-commit hook (merge)

 Documentation/git-merge.txt     |  7 ++++-
 Documentation/githooks.txt      |  6 ++++
 Documentation/merge-config.txt  |  5 ++++
 Documentation/merge-options.txt |  4 +++
 builtin/merge.c                 | 19 ++++++++++++-
 t/t7503-pre-commit-hook.sh      | 62 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 2 deletions(-)

-- 
1.7.12.406.gafd3f81
