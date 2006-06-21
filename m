From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 2/3] Add a parameter to specify the repository path
Date: Wed, 21 Jun 2006 15:08:03 +0200
Message-ID: <20060621130802.G53392da4@leonov.stosberg.net>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 15:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2RH-0000Iu-Rv
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWFUNIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWFUNIH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:08:07 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:56547 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751341AbWFUNIG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 09:08:06 -0400
Received: from leonov.stosberg.net (p213.54.85.218.tisdip.tiscali.de [213.54.85.218])
	by ncs.stosberg.net (Postfix) with ESMTP id 2A911AEBA065;
	Wed, 21 Jun 2006 15:07:58 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 2866A10E056; Wed, 21 Jun 2006 15:08:03 +0200 (CEST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060621130535.G2b34d382@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22268>

---
 builtin-help.c |    2 +-
 git.c          |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 7470faa..db233eb 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -10,7 +10,7 @@ #include "exec_cmd.h"
 #include "common-cmds.h"
 
 static const char git_usage[] =
-	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
+	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--git-dir=GIT_DIR] [--help] COMMAND [ ARGS ]";
 
 /* most gui terms set COLUMNS (although some don't export it) */
 static int term_columns(void)
diff --git a/git.c b/git.c
index 94e9a4a..d49f626 100644
--- a/git.c
+++ b/git.c
@@ -277,6 +277,12 @@ int main(int argc, const char **argv, ch
 			puts(git_exec_path());
 			exit(0);
 		}
+
+		if (!strncmp(cmd, "git-dir=", 8)) {
+			setenv("GIT_DIR", cmd + 8, 1);
+			continue;
+		}
+
 		cmd_usage(0, NULL, NULL);
 	}
 	argv[0] = cmd;
-- 
1.4.0
