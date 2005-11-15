From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Add option --only-use-symrefs to git-init-db
Date: Tue, 15 Nov 2005 22:37:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511152236410.2152@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 15 22:37:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8UU-0006BP-T5
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVKOVhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVKOVhH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:37:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16332 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750985AbVKOVhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:37:06 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5B01A13F730; Tue, 15 Nov 2005 22:37:05 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3DC54B51E6; Tue, 15 Nov 2005 22:37:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1F7CDB51E4; Tue, 15 Nov 2005 22:37:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 112B413F732; Tue, 15 Nov 2005 22:37:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11942>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 init-db.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

applies-to: 5ba4aa2c83265b321ccebc0e4f24707cdd577794
7089086c9c77ac61f1e59d3382eda7b65a5dc687
diff --git a/init-db.c b/init-db.c
index b62ee72..7019109 100644
--- a/init-db.c
+++ b/init-db.c
@@ -215,7 +215,7 @@ static void create_default_files(const c
 }
 
 static const char init_db_usage[] =
-"git-init-db [--template=<template-directory>]";
+"git-init-db [--template=<template-directory>] [--only-use-symrefs]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -236,6 +236,8 @@ int main(int argc, char **argv)
 			break;
 		else if (!strncmp(arg, "--template=", 11))
 			template_dir = arg+11;
+		else if (!strcmp(arg, "--only-use-symrefs"))
+			only_use_symrefs = 1;
 		else
 			die(init_db_usage);
 	}
@@ -264,5 +266,9 @@ int main(int argc, char **argv)
 	safe_create_dir(path);
 	strcpy(path+len, "/info");
 	safe_create_dir(path);
+
+	if (only_use_symrefs)
+		git_config_set("core.SymrefsOnly", "true");
+
 	return 0;
 }
---
0.99.9.GIT
