From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 17:47:08 -0700
Message-ID: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:47:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dak3J-0005ST-HD
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVEYArz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVEYArz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:47:55 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21921 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262211AbVEYArK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 20:47:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525004708.IBYS16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 20:47:08 -0400
To: torvalds@osdl.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It advertises the path restriction in documentation and usage
string, but the argument parsing code was not updated and was
causing it to refuse to run.  One liner fix is here.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - linus: git-update-cache: allow dot-files
# + (working tree)
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -164,7 +164,7 @@ int main(int argc, const char **argv)
 	int ret;
 
 	read_cache();
-	while (argc > 2) {
+	while (1 < argc && argv[1][0] == '-') {
 		const char *arg = argv[1];
 		argv++;
 		argc--;


