From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: make callback functions static
Date: Thu, 21 May 2009 00:05:22 +0200
Message-ID: <4A147EA2.7050203@lsrfire.ath.cx>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain> <1241725608.4772.11.camel@ubuntu.ubuntu-domain> <4A0E8AEF.3000704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 00:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6tum-00006K-In
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 00:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbZETWFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZETWFY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 18:05:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:39627 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbZETWFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 18:05:23 -0400
Received: from [10.0.1.101] (p57B7BC6E.dip.t-dialin.net [87.183.188.110])
	by india601.server4you.de (Postfix) with ESMTPSA id 5FCDD2F8044;
	Thu, 21 May 2009 00:05:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A0E8AEF.3000704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119636>

Suggested by Stephen Boyd: make the callback functions used for option
parsing static.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Patch applies to next.

 builtin-grep.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 169a91c..5308b34 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -565,7 +565,8 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
 
-int context_callback(const struct option *opt, const char *arg, int unset)
+static int context_callback(const struct option *opt, const char *arg,
+			    int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	int value;
@@ -584,7 +585,7 @@ int context_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int file_callback(const struct option *opt, const char *arg, int unset)
+static int file_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	FILE *patterns;
@@ -606,42 +607,43 @@ int file_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int not_callback(const struct option *opt, const char *arg, int unset)
+static int not_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	append_grep_pattern(grep_opt, "--not", "command line", 0, GREP_NOT);
 	return 0;
 }
 
-int and_callback(const struct option *opt, const char *arg, int unset)
+static int and_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	append_grep_pattern(grep_opt, "--and", "command line", 0, GREP_AND);
 	return 0;
 }
 
-int open_callback(const struct option *opt, const char *arg, int unset)
+static int open_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	append_grep_pattern(grep_opt, "(", "command line", 0, GREP_OPEN_PAREN);
 	return 0;
 }
 
-int close_callback(const struct option *opt, const char *arg, int unset)
+static int close_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	append_grep_pattern(grep_opt, ")", "command line", 0, GREP_CLOSE_PAREN);
 	return 0;
 }
 
-int pattern_callback(const struct option *opt, const char *arg, int unset)
+static int pattern_callback(const struct option *opt, const char *arg,
+			    int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	append_grep_pattern(grep_opt, arg, "-e option", 0, GREP_PATTERN);
 	return 0;
 }
 
-int help_callback(const struct option *opt, const char *arg, int unset)
+static int help_callback(const struct option *opt, const char *arg, int unset)
 {
 	return -1;
 }
-- 
1.6.3.1
