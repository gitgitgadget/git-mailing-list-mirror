From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 08/14] submodule.c: Initialise variables to suppress msvc
 warnings
Date: Sat, 04 Dec 2010 19:07:32 +0000
Message-ID: <4CFA9174.6060507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:39:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POyt6-0000Zt-Ub
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab0LDUjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:39:10 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:63384 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753475Ab0LDUjJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:39:09 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1POysu-0005lu-ja; Sat, 04 Dec 2010 20:39:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162904>


The msvc compiler thinks that two variables could be used
while uninitialised and issues the following warnings:

    ...\git\submodule.c(147) : warning C4700: uninitialized local \
        variable 'left' used
    ...\git\submodule.c(147) : warning C4700: uninitialized local \
        variable 'right' used

In order to suppress the warnings, we simply initialise the
pointer variables to NULL.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 91a4758..eef498a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -144,7 +144,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *commit, *left = left, *right = right;
+	struct commit *commit, *left = NULL, *right = NULL;
 	struct commit_list *merge_bases, *list;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
-- 
1.7.3
