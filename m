From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] cherry-pick -x: add newline before pick note
Date: Tue, 16 Nov 2010 16:11:17 +0100
Message-ID: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
Cc: Martin Svensson <martin.k.svensson@netinsight.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 16:13:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PINDz-0001SJ-G0
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 16:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335Ab0KPPNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 10:13:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34092 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759279Ab0KPPNU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 10:13:20 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9FA8B70E;
	Tue, 16 Nov 2010 10:13:19 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 16 Nov 2010 10:13:19 -0500
X-Sasl-enc: FzCriuqSQHQtxVBXf5DM185ds/EytXCmvzvDsi8+K5Yh 1289920399
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 22A1540C2AD;
	Tue, 16 Nov 2010 10:13:19 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161563>

Currently, cherry-pick -x sticks the pick note immediately after the
existing commit message. This

* is bad for commits with 1 line subject (it makes a 2 line subject)
* is different from git-svn, e.g., which leaves an empty line before.

Make cherry-pick always insert an empty line before the pick note.

Reported-by: Martin Svensson <martin.k.svensson@netinsight.se>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 57b51e4..9251257 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -485,7 +485,7 @@ static int do_pick_commit(void)
 		set_author_ident_env(msg.message);
 		add_message_to_msg(&msgbuf, msg.message);
 		if (no_replay) {
-			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, "\n(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-- 
1.7.3.2.193.g78bbb
