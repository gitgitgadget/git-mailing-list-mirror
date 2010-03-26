From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 03/12] git rm: display a warning for every unremovable file
Date: Fri, 26 Mar 2010 15:25:31 +0000
Message-ID: <1269617140-7827-4-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQd-0005ou-Ti
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab0CZP0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:02 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55553 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab0CZPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:58 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o4-4D; Fri, 26 Mar 2010 15:25:54 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023A-1T; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143244>

This patch causes git-rm to display a warning if it was unable to
remove a file other than the first one, rather than silently ignoring
the error, which was the previous behaviour.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 builtin/rm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index f3772c8..05a5158 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -259,6 +259,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			}
 			if (!removed)
 				die_errno("git rm: '%s'", path);
+			else
+				warning("git rm: '%s': %s", path, strerror(errno));
 		}
 	}
 
-- 
1.6.5
