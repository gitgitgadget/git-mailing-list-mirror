From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] builtin-mailsplit.c: remove read_line_with_nul() since it is no longer used
Date: Tue,  4 Aug 2009 22:31:58 -0500
Message-ID: <r3l_p2g-BpVHWKE-kMWIR-hbNfTwGmUrXhM-lhoS9dZKPidslwcauSWyJW7X27JpF_HWaZz1tHI@cipher.nrlssc.navy.mil>
References: <7vmy6fdxst.fsf@alter.siamese.dyndns.org> <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil> <r3l_p2g-BpVHWKE-kMWIRydJaW0FHLKBpE497REXzOgqPjLUFjPkJ-YKp1tkrIs3CwcppURiH8o@cipher.nrlssc.navy.mil> <r3l_p2g-BpVHWKE-kMWIR9UKBn9dqjBL2asOE11gruEtEyCyQOOh37zkh5F2bJkihtkN8WUp4d0@cipher.nrlssc.navy.mil>
Cc: nanako3@lavabit.com, raa.lkml@gmail.com, hpa@zytor.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 05:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXFd-0001ap-F7
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933852AbZHEDcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 23:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933845AbZHEDcy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:32:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59682 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933444AbZHEDcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 23:32:53 -0400
Received: by mail.nrlssc.navy.mil id n753WmmD015232; Tue, 4 Aug 2009 22:32:50 -0500
In-Reply-To: <r3l_p2g-BpVHWKE-kMWIR9UKBn9dqjBL2asOE11gruEtEyCyQOOh37zkh5F2bJkihtkN8WUp4d0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Aug 2009 03:32:49.0038 (UTC) FILETIME=[67D1D2E0:01CA157D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124844>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Squash this with the previous one if you like.

-brandon


 builtin-mailsplit.c |   18 ------------------
 builtin.h           |    1 -
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index c2ec6ea..d288fde 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -45,24 +45,6 @@ static int is_from_line(const char *line, int len)
 
 static struct strbuf buf = STRBUF_INIT;
 
-/* We cannot use fgets() because our lines can contain NULs */
-int read_line_with_nul(char *buf, int size, FILE *in)
-{
-	int len = 0, c;
-
-	for (;;) {
-		c = getc(in);
-		if (c == EOF)
-			break;
-		buf[len++] = c;
-		if (c == '\n' || len + 1 >= size)
-			break;
-	}
-	buf[len] = '\0';
-
-	return len;
-}
-
 /* Called with the first line (potentially partial)
  * already in buf[] -- normally that should begin with
  * the Unix "From " line.  Write it into the specified
diff --git a/builtin.h b/builtin.h
index 20427d2..9993dfc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -13,7 +13,6 @@ extern const char git_more_info_string[];
 extern void list_common_cmds_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
-extern int read_line_with_nul(char *buf, int size, FILE *file);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
 extern int commit_tree(const char *msg, unsigned char *tree,
-- 
1.6.4
