From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] run_command(): respect GIT_TRACE
Date: Mon, 7 Jul 2008 14:41:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071441190.18205@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 07 15:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFr1A-0006FX-Jq
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 15:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYGGNnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 09:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYGGNna
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 09:43:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:39684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751922AbYGGNna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 09:43:30 -0400
Received: (qmail invoked by alias); 07 Jul 2008 13:43:28 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp052) with SMTP; 07 Jul 2008 15:43:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dpD1pXwPdFBvNplHiOch9Ka3aGs2IsZlm9sXVMZ
	erpB8UiLxdTUbo
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87606>


When GIT_TRACE is set, the user is most likely wanting to see an external
command that is about to be executed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2ce8c2b..6e29fdf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -65,6 +65,8 @@ int start_command(struct child_process *cmd)
 		cmd->err = fderr[0];
 	}
 
+	trace_argv_printf(cmd->argv, "trace: run_command:");
+
 #ifndef __MINGW32__
 	cmd->pid = fork();
 	if (!cmd->pid) {
-- 
1.5.6.2.402.g95b5ab.dirty
