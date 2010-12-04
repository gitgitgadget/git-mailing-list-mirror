From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 06/14] match-trees.c: Initialise variables to suppress msvc
 warnings
Date: Sat, 04 Dec 2010 19:05:47 +0000
Message-ID: <4CFA910B.6040708@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzZa-0001Tm-5G
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab0LDVXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:23:09 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:44720 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755843Ab0LDVXI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:23:08 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1POyso-0001PA-iU; Sat, 04 Dec 2010 20:39:03 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162921>


The msvc compiler thinks that several variables could be used
while uninitialised and issues 12 warnings like:

    ...\git\match-trees.c(75) : warning C4700: uninitialized local \
        variable 'elem1' used
    ...\git\match-trees.c(76) : warning C4700: uninitialized local \
        variable 'elem2' used
    ...\git\match-trees.c(77) : warning C4700: uninitialized local \
        variable 'path1' used
    ...\git\match-trees.c(78) : warning C4700: uninitialized local \
        variable 'path2' used
    ...\git\match-trees.c(79) : warning C4700: uninitialized local \
        variable 'mode1' used
    ...\git\match-trees.c(80) : warning C4700: uninitialized local \
        variable 'mode2' used

In order to suppress the warnings, we simply initialise the char
pointer variables to NULL and the int variables to zero.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 match-trees.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 26f7ed1..de050d0 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -72,12 +72,12 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
 	while (one.size | two.size) {
-		const unsigned char *elem1 = elem1;
-		const unsigned char *elem2 = elem2;
-		const char *path1 = path1;
-		const char *path2 = path2;
-		unsigned mode1 = mode1;
-		unsigned mode2 = mode2;
+		const unsigned char *elem1 = NULL;
+		const unsigned char *elem2 = NULL;
+		const char *path1 = NULL;
+		const char *path2 = NULL;
+		unsigned mode1 = 0;
+		unsigned mode2 = 0;
 		int cmp;
 
 		if (one.size)
-- 
1.7.3
