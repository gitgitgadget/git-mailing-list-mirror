From: Arnout Engelen <arnouten@bzzt.net>
Subject: [PATCH] log which temporary file could not be created
Date: Sat, 9 Oct 2010 22:17:51 +0200
Message-ID: <20101009201751.GK9348@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 09 22:39:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gCW-0001v3-GI
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760539Ab0JIUjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:39:21 -0400
Received: from smtp-4.concepts.nl ([213.197.30.111]:43205 "EHLO
	smtp-4.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab0JIUjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:39:20 -0400
X-Greylist: delayed 1284 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Oct 2010 16:39:20 EDT
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P4frb-00009Q-86; Sat, 09 Oct 2010 22:17:51 +0200
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P4frb-000307-LX; Sat, 09 Oct 2010 22:17:51 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1P4frb-00009Q-86
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158607>

When creating a temporary file, log the template. Useful for making debugging 
problems like file permission mistakes easier.

Signed-off-by: Arnout Engelen <arnouten@bzzt.net>

---
 wrapper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index fd8ead3..68053cd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -215,7 +215,7 @@ int xmkstemp(char *template)
 
 	fd = mkstemp(template);
 	if (fd < 0)
-		die_errno("Unable to create temporary file");
+		die_errno("Unable to create temporary file '%s'", template);
 	return fd;
 }
 
@@ -225,7 +225,7 @@ int xmkstemp_mode(char *template, int mode)
 
 	fd = git_mkstemp_mode(template, mode);
 	if (fd < 0)
-		die_errno("Unable to create temporary file");
+		die_errno("Unable to create temporary file '%s'", template);
 	return fd;
 }
 
-- 
1.7.2.3
