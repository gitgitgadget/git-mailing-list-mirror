From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Don't require working tree for git-rm
Date: Sat,  3 Nov 2007 11:08:41 +0100
Message-ID: <1194084521-12962-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 11:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFxT-0005Ur-4q
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 11:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760AbXKCKJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 06:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbXKCKJj
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 06:09:39 -0400
Received: from vawad.err.no ([85.19.200.177]:42759 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568AbXKCKJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 06:09:38 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoFwb-0000sJ-9g; Sat, 03 Nov 2007 11:09:35 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoFvl-0003PV-Ir; Sat, 03 Nov 2007 11:08:41 +0100
X-Mailer: git-send-email 1.5.3.5
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63227>

This allows to do git rm --cached -r directory, instead of
git ls-files -z directory | git update-index --remove -z --stdin.
This can be particularly useful for git-filter-branch users.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 4e10581..01dcb6a 100644
--- a/git.c
+++ b/git.c
@@ -345,7 +345,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
+		{ "rm", cmd_rm, RUN_SETUP },
 		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
-- 
1.5.3.5
