From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 2/2] combine-diff: Honour -z option correctly.
Date: Mon, 27 Feb 2006 12:52:52 +0000
Message-ID: <20060227125252.25144.12278.stgit@metalzone.distorted.org.uk>
References: <20060227124815.25144.83101.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Feb 27 13:53:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDhsF-00076V-4a
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 13:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWB0Mwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 07:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWB0Mwy
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 07:52:54 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:13656 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751109AbWB0Mwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 07:52:54 -0500
Received: (qmail 25588 invoked from network); 27 Feb 2006 12:52:52 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?n9yGm+/XLK3uZ9BIZecO4akSeR/iDWA6?@127.0.0.1)
  by localhost with SMTP; 27 Feb 2006 12:52:52 -0000
To: git@vger.kernel.org
In-Reply-To: <20060227124815.25144.83101.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16839>

From: Mark Wooding <mdw@distorted.org.uk>

Combined diffs don't null terminate things in the same way as standard
diffs.  This is presumably wrong.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 combine-diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 984103e..a23894d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -726,7 +726,7 @@ static int show_patch_diff(struct combin
 
 		if (header) {
 			shown_header++;
-			puts(header);
+			printf("%s%c", header, opt->line_termination);
 		}
 		printf("diff --%s ", dense ? "cc" : "combined");
 		if (quote_c_style(elem->path, NULL, NULL, 0))
@@ -799,7 +799,7 @@ static void show_raw_diff(struct combine
 		inter_name_termination = 0;
 
 	if (header)
-		puts(header);
+		printf("%s%c", header, line_termination);
 
 	for (i = 0; i < num_parent; i++) {
 		if (p->parent[i].mode)
