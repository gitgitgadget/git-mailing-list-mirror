From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 0/5] "diff --check" and whitespace enhancements
Date: Thu, 13 Dec 2007 14:32:26 +0100
Message-ID: <1197552751-53480-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oBf-0003lF-S9
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbXLMNcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbXLMNcw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:32:52 -0500
Received: from wincent.com ([72.3.236.74]:47240 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbXLMNcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:32:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDDWZ4X019847;
	Thu, 13 Dec 2007 07:32:36 -0600
X-Mailer: git-send-email 1.5.4.rc0.4.g50348
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68145>

This is a repost of the topic I posted yesterday, rebased on top
of master and omitting the changes already applied to it.

Of the series the most interesting is [3/5], where I implement
Junio's suggestion of further refactoring to get rid of
emit_line_with_ws().

[1/5] "diff --check" should affect exit status
[2/5] New version of pre-commit hook
[3/5] Unify whitespace checking
[4/5] Make "diff --check" output match "git apply"
[5/5] Add tests for "git diff --check" with core.whitespace options

I think there are still some opportunities for further refactoring
and clean-up, but this is a good start.

Overall the refactoring saves duplication and reduces the line
count (apart from the tests, of course, where line count goes
unequivocally up).

 Documentation/diff-options.txt |    4 +-
 builtin-apply.c                |   56 +++----------
 builtin-diff-files.c           |    2 +
 builtin-diff-index.c           |    2 +
 builtin-diff-tree.c            |   28 +++---
 builtin-diff.c                 |    3 +-
 cache.h                        |    4 +
 diff.c                         |  172 +++++++++---------------------------
 diff.h                         |    1 +
 t/t4015-diff-whitespace.sh     |  189 +++++++++++++++++++++++++++++++++++++++-
 templates/hooks--pre-commit    |   67 ++-------------
 ws.c                           |  105 ++++++++++++++++++++++
 12 files changed, 379 insertions(+), 254 deletions(-)

Cheers,
Wincent
