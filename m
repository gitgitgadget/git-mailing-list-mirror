From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] alias.c: use git_config_string() to get alias_val
Date: Sat, 5 Apr 2008 14:18:35 +0200
Message-ID: <20080405121834.GB14565@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 14:19:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji7N2-0008Re-Kx
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 14:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYDEMSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 08:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbYDEMSs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 08:18:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:58253 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751527AbYDEMSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 08:18:48 -0400
Received: (qmail invoked by alias); 05 Apr 2008 12:18:46 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp029) with SMTP; 05 Apr 2008 14:18:46 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19mntJ0vfBmBp469GQGW9Y4II+x15SxS5K/TEaNfX
	luoa+AX4Wo7zKN
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Ji7Lv-0006mJ-1S
	for git@vger.kernel.org; Sat, 05 Apr 2008 14:18:35 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78845>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

This is a `Janitor patch' to get involved ;-)
See
	http://git.or.cz/gitwiki/Janitor

It does not (at least, should not) change any functionality and
it has been tested using some aliases.

Regards,
Stephan

 alias.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/alias.c b/alias.c
index 116cac8..ac88d38 100644
--- a/alias.c
+++ b/alias.c
@@ -4,12 +4,8 @@ static const char *alias_key;
 static char *alias_val;
 static int alias_lookup_cb(const char *k, const char *v)
 {
-	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
-		if (!v)
-			return config_error_nonbool(k);
-		alias_val = xstrdup(v);
-		return 0;
-	}
+	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key))
+		return git_config_string((const char**)&alias_val, k, v);
 	return 0;
 }
 
-- 
1.5.4.4
