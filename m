From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/9] sparse: Fix an "symbol 'format_subject' not declared"
 warning
Date: Thu, 07 Apr 2011 19:26:23 +0100
Message-ID: <4D9E01CF.5060903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:53:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uKY-0004uC-8E
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab1DGSxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:53:12 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48570 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756655Ab1DGSxK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:53:10 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKL-0001Qt-nB; Thu, 07 Apr 2011 18:53:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171072>


In order to fix the warning, we add an extern declaration for this
function to the "commit.h" header file, along with all other non-
static functions defined in pretty.c. Also, we remove the function
declaration from builtin/shortlog.c, since it is no longer needed.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/shortlog.c |    3 ---
 commit.h           |    2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f5efc67..b6f4b0e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -29,9 +29,6 @@ static int compare_by_number(const void *a1, const void *a2)
 		return -1;
 }
 
-const char *format_subject(struct strbuf *sb, const char *msg,
-			   const char *line_separator);
-
 static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
diff --git a/commit.h b/commit.h
index 4198513..b3c3bb7 100644
--- a/commit.h
+++ b/commit.h
@@ -90,6 +90,8 @@ extern char *logmsg_reencode(const struct commit *commit,
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern const char *format_subject(struct strbuf *sb, const char *msg,
+				  const char *line_separator);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
-- 
1.7.4
