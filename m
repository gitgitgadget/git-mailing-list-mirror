From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] Make grafts versionable
Date: Mon, 21 Nov 2005 21:54:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511212152110.4611@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 21 21:56:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeIgj-0002K4-H7
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 21:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVKUUyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 15:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVKUUyy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 15:54:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34720 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932459AbVKUUyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 15:54:53 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 19DF51401D6
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 21:54:52 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id ECD29B529A
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 21:54:51 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id C9EF8B528E
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 21:54:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id B2F1C1401D6
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 21:54:51 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12480>


... by moving the location from .git/info/grafts to .gitgrafts. This 
allows checking it in like .gitignore, and sure enough also pulling it (as 
well as knowing who the heck added that particular graft anyway).

Totally untested.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This would make half the discussion about rewriting history
	obsolete, methinks.

	Of course, to take advantage of it, you have to move the file 
	.git/info/grafts (if it exists) into the correct place yourself:

		mv -i .git/info/grafts .gitgrafts

 environment.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 20259f7c4418392e0e0c2f3a867811f657498afe
a1756142e3be780ed7992cd6a3f5e64b53c42253
diff --git a/environment.c b/environment.c
index b5026f1..b0c2f79 100644
--- a/environment.c
+++ b/environment.c
@@ -35,7 +35,7 @@ static void setup_git_env(void)
 	}
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
-		git_graft_file = strdup(git_path("info/grafts"));
+		git_graft_file = strdup(git_path("../.gitgrafts"));
 }
 
 char *get_git_dir(void)
---
0.99.9.GIT
