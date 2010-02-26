From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Having keywords without value is not a global error.
Date: Fri, 26 Feb 2010 17:00:20 +1300
Message-ID: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 05:08:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkrV6-0001PF-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 05:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935161Ab0BZEIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 23:08:22 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:46580 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935150Ab0BZEIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 23:08:22 -0500
Received: from localhost.localdomain (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id A226E17081F
	for <git@vger.kernel.org>; Fri, 26 Feb 2010 17:08:20 +1300 (NZDT)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141100>

It is not a good Idea to give a config_error for _any_ keyword without a
value as it means that

	[section]
		keyword

sytle can not be using for setting bool type keyword.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 builtin/init-db.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9273942..edc40ff 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -170,8 +170,6 @@ static void copy_templates(const char *template_dir)
 
 static int git_init_db_config(const char *k, const char *v, void *cb)
 {
-	if (!v)
-		return config_error_nonbool(k);
 	if (!strcmp(k, "init.templatedir"))
 		return git_config_pathname(&init_db_template_dir, k, v);
 
-- 
1.6.6
