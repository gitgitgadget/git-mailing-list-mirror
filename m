From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 05/14] run-command.c: Initialise variable to suppress msvc
 warnings
Date: Sat, 04 Dec 2010 19:01:56 +0000
Message-ID: <4CFA9024.3030505@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzA5-0007De-Ct
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab0LDU4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:56:49 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:42171 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0LDU4s (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:56:48 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1POysm-0001rx-ny; Sat, 04 Dec 2010 20:39:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162910>


The msvc compiler thinks the 'failed_errno' variable could be used
while uninitialised and issues 26 warnings thus:

    ...\git\run-command.c(142) : warning C4700: uninitialized local \
        variable 'failed_errno' used

In order to suppress the warnings, we simply initialise the variable
to zero.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2a1041e..0dad4da 100644
--- a/run-command.c
+++ b/run-command.c
@@ -139,7 +139,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno = failed_errno;
+	int failed_errno = 0;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
-- 
1.7.3
