From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] pre-merge-hook
Date: Wed,  5 Sep 2012 15:39:08 +0200
Message-ID: <cover.1346851863.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 15:39:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9FpD-0008Eq-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab2IENjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:39:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58069 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501Ab2IENjO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 09:39:14 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 839CC20E00
	for <git@vger.kernel.org>; Wed,  5 Sep 2012 09:39:13 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 05 Sep 2012 09:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=ebt+CDiiM3r58WhUv4covqluCBc=; b=TkSQjUDpcYNqZ2wPizTa
	76e9n9irJ/1MHi3kPFUuffyvmSST9CTRr7v2NdAcIou8P8rSjkrq9GqGzlysRxQJ
	xOWM7w452GgxM+7EPP1wvmlml4F+P87AQT0lBFIplKgKLDY61vcmX7djlXbBi0Jf
	EhIkNYwMUQGeHUunvctSOW4=
X-Sasl-enc: O/yYSokFAH8pfb8xeA9hhGPBcU8m57YQYhMJSKNf0hFB 1346852353
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 215B08E03D6;
	Wed,  5 Sep 2012 09:39:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204825>

The pre-commit hook is often used to ensure certain properties of each
comitted tree like formatting or coding standards, validity (lint/make)
or code quality (make test). But merges introduce new commits unless
they are fast forwards, and therefore they can break these properties
because the pre-commit hook is not run by "git merge".

Introduce a pre-merge hook which works for (non ff, automatic) merges
like pre-commit does for commits. Typically this will just call the
pre-commit hook (like in the sample hook), but it does not need to.

Michael J Gruber (3):
  git-merge: Honor pre-merge hook
  merge: --no-verify to bypass pre-merge hook
  t7503: add tests for pre-merge-hook

 Documentation/git-merge.txt       |  2 +-
 Documentation/githooks.txt        |  7 +++++
 Documentation/merge-options.txt   |  4 +++
 builtin/merge.c                   | 15 ++++++++-
 t/t7503-pre-commit-hook.sh        | 66 ++++++++++++++++++++++++++++++++++++++-
 templates/hooks--pre-merge.sample | 13 ++++++++
 6 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100755 templates/hooks--pre-merge.sample

-- 
1.7.12.406.gafd3f81
