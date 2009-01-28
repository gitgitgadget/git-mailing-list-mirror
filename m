From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/4] git: s/run_command/run_builtin/
Date: Wed, 28 Jan 2009 02:33:53 -0500
Message-ID: <20090128073353.GA31884@coredump.intra.peff.net>
References: <20090128073059.GD19165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4xE-0007K2-P2
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZA1Hd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbZA1Hd4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:33:56 -0500
Received: from peff.net ([208.65.91.99]:57639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbZA1Hdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:33:55 -0500
Received: (qmail 19519 invoked by uid 107); 28 Jan 2009 07:34:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:34:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:33:53 -0500
Content-Disposition: inline
In-Reply-To: <20090128073059.GD19165@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107491>

There is a static function called run_command which
conflicts with the library function in run-command.c; this
isn't a problem currently, but prevents including
run-command.h in git.c.

This patch just renames the static function to something
more specific and non-conflicting.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before.

 git.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index ecc8fad..45e493d 100644
--- a/git.c
+++ b/git.c
@@ -219,7 +219,7 @@ struct cmd_struct {
 	int option;
 };
 
-static int run_command(struct cmd_struct *p, int argc, const char **argv)
+static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
 	struct stat st;
@@ -384,7 +384,7 @@ static void handle_internal_command(int argc, const char **argv)
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
-		exit(run_command(p, argc, argv));
+		exit(run_builtin(p, argc, argv));
 	}
 }
 
-- 
1.6.1.1.367.g30b36
