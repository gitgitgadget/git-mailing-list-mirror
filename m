From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 1/2] clone: Fix error message for reference repository
Date: Sun,  7 Apr 2013 19:17:08 -0400
Message-ID: <1365376629-16054-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:50:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5qQ-0000sy-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934489Ab3DGXXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 19:23:25 -0400
Received: from pug.qqx.org ([50.116.43.67]:33189 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934475Ab3DGXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 19:23:23 -0400
Received: from frak.qqx.org (frak.qqx.org [IPv6:2001:470:8:86c:21f:3bff:feaa:6c05])
	by pug.qqx.org (Postfix) with ESMTPSA id 779F51D0AA
	for <git@vger.kernel.org>; Sun,  7 Apr 2013 19:17:16 -0400 (EDT)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 456a1
	by frak.qqx.org (DragonFly Mail Agent);
	Sun, 07 Apr 2013 19:17:15 -0400
X-Mailer: git-send-email 1.8.2.677.g7422c62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220397>

Do not report an argument to clone's --reference option is not a local
directory.  Nothing checks for the actual directory so we have no way to
know if whether or not exists.  Telling the user that a directory doesn't
exist when that isn't actually known may lead him or her on the wrong
path to finding the problem.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f9c380e..0a1e0bf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -241,7 +241,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 		free(ref_git);
 		ref_git = ref_git_git;
 	} else if (!is_directory(mkpath("%s/objects", ref_git)))
-		die(_("reference repository '%s' is not a local directory."),
+		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
 
 	strbuf_addf(&alternate, "%s/objects", ref_git);
-- 
1.8.2.677.g7422c62
