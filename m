From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] list_commands: only call git_exec_path if it is needed
Date: Thu, 28 Aug 2008 19:19:42 +0200
Message-ID: <20080828171942.GE6024@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 19:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlGZ-0007aw-ST
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYH1RZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYH1RZO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:25:14 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:42159 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYH1RZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:25:10 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf4EvTSQ==
Received: from tigra.home (Faec3.f.strato-dslnet.de [195.4.174.195])
	by post.webmailer.de (fruni mo54) (RZmta 16.47)
	with ESMTP id N00ebbk7SFT2YE ; Thu, 28 Aug 2008 19:25:07 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 0A4F7277AE;
	Thu, 28 Aug 2008 19:25:06 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id B4FEC36D21; Thu, 28 Aug 2008 19:19:42 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94092>

Even if it always needed

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index ab2c2ba..b278257 100644
--- a/help.c
+++ b/help.c
@@ -212,7 +212,6 @@ void load_command_list(const char *prefix,
 void list_commands(const char *title, struct cmdnames *main_cmds,
 		   struct cmdnames *other_cmds)
 {
-	const char *exec_path = git_exec_path();
 	int i, longest = 0;
 
 	for (i = 0; i < main_cmds->cnt; i++)
@@ -223,6 +222,7 @@ void list_commands(const char *title, struct cmdnames *main_cmds,
 			longest = other_cmds->names[i]->len;
 
 	if (main_cmds->cnt) {
+		const char *exec_path = git_exec_path();
 		printf("available %s in '%s'\n", title, exec_path);
 		printf("----------------");
 		mput_char('-', strlen(title) + strlen(exec_path));
-- 
1.6.0.1.150.g5966
