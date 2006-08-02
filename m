From: Jeff King <peff@peff.net>
Subject: [PATCH] git-push: allow -f as an alias for --force
Date: Wed, 2 Aug 2006 11:28:16 -0400
Message-ID: <20060802152816.GA3923@coredump.intra.peff.net>
References: <cc723f590608020133o3c960cf0v1546c59319253dc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 02 17:28:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Idy-00079k-CJ
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 17:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHBP2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 11:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHBP2T
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 11:28:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:33236 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751199AbWHBP2S (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 11:28:18 -0400
Received: (qmail 31842 invoked from network); 2 Aug 2006 11:27:42 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Aug 2006 11:27:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 11:28:16 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <cc723f590608020133o3c960cf0v1546c59319253dc0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24649>

This was already documented in the options section of the manpage. This
patch implements it, adds it to the usage message, and mentions it at the
top of the manpage.

Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Aug 02, 2006 at 02:03:12PM +0530, Aneesh Kumar wrote:
> The man page says -f is same as --force.  But the script doesn't seems
> to handle this.

 Documentation/git-push.txt |    2 +-
 builtin-push.c             |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 56afd64..d4ae99f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with
 
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--force] <repository> <refspec>...
+'git-push' [--all] [--tags] [-f | --force] <repository> <refspec>...
 
 DESCRIPTION
 -----------
diff --git a/builtin-push.c b/builtin-push.c
index a824171..c39dd1e 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,7 +8,7 @@ #include "builtin.h"
 
 #define MAX_URI (16)
 
-static const char push_usage[] = "git push [--all] [--tags] [--force] <repository> [<refspec>...]";
+static const char push_usage[] = "git push [--all] [--tags] [-f | --force] <repository> [<refspec>...]";
 
 static int all = 0, tags = 0, force = 0, thin = 1;
 static const char *execute = NULL;
@@ -291,7 +291,7 @@ int cmd_push(int argc, const char **argv
 			tags = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--force")) {
+		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
 			force = 1;
 			continue;
 		}
-- 
1.4.2.rc2.g822a-dirty
