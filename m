From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 3/7] cleanups: Remove unused vars from combine-diff.c
Date: Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
Message-ID: <20060417151447.EC97F19B8FD@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRK-0006b0-Ci
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWDQPOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDQPOu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60617 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751088AbWDQPOt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 11:14:49 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEm7d010984
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFEmx0119826
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEm9v017237
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmj1017225
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id EC97F19B8FD; Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18829>

Mod_type in particular sure looks like it wants to be used, but isn't.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 combine-diff.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

5a7c4023402dd2420a4596cdd92a1a46fd3e5c14
diff --git a/combine-diff.c b/combine-diff.c
index 9bd27f8..9445e86 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -589,7 +589,7 @@ static int show_patch_diff(struct combin
 			   struct diff_options *opt)
 {
 	unsigned long result_size, cnt, lno;
-	char *result, *cp, *ep;
+	char *result, *cp;
 	struct sline *sline; /* survived lines */
 	int mode_differs = 0;
 	int i, show_hunks, shown_header = 0;
@@ -641,7 +641,6 @@ static int show_patch_diff(struct combin
 		cnt++; /* incomplete line */
 
 	sline = xcalloc(cnt+2, sizeof(*sline));
-	ep = result;
 	sline[0].bol = result;
 	for (lno = 0; lno <= cnt + 1; lno++) {
 		sline[lno].lost_tail = &sline[lno].lost_head;
@@ -752,7 +751,7 @@ static int show_patch_diff(struct combin
 
 static void show_raw_diff(struct combine_diff_path *p, int num_parent, const char *header, struct diff_options *opt)
 {
-	int i, offset, mod_type = 'A';
+	int i, offset;
 	const char *prefix;
 	int line_termination, inter_name_termination;
 
@@ -764,13 +763,6 @@ static void show_raw_diff(struct combine
 	if (header)
 		printf("%s%c", header, line_termination);
 
-	for (i = 0; i < num_parent; i++) {
-		if (p->parent[i].mode)
-			mod_type = 'M';
-	}
-	if (!p->mode)
-		mod_type = 'D';
-
 	if (opt->output_format == DIFF_FORMAT_RAW) {
 		offset = strlen(COLONS) - num_parent;
 		if (offset < 0)
-- 
1.2.5
