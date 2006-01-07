From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] ls-files --others --directory: give trailing slash
Date: Sat, 07 Jan 2006 14:31:56 -0800
Message-ID: <7vy81racv7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 07 23:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvMbT-0000dY-RB
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 23:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWAGWcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbWAGWcA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 17:32:00 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2797 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751110AbWAGWb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 17:31:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107223109.ZTZX3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 17:31:09 -0500
To: git@vger.kernel.org, Darrin Thompson <darrint@progeny.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14281>

This adds a trailing slash to directory names in the output
when "--others --directory" option shows only untracked
directories and not their contents, to make them stand out.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Likes, dislikes?  This suits better for *my* purpose of
   calling this from git-status, but it might be undesirable for
   your Porcelain.

 ls-files.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

02e90a13cce6041263ec90da77f2ba929055b448
diff --git a/ls-files.c b/ls-files.c
index cc5b32e..7e2fdea 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -294,8 +294,10 @@ static void read_directory(const char *p
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				if (show_other_directories &&
-				    !dir_exists(fullname, baselen + len + 1))
+				    !dir_exists(fullname, baselen + len + 1)) {
+					len++;
 					break;
+				}
 				read_directory(fullname, fullname,
 					       baselen + len + 1);
 				continue;
-- 
1.0.7-g0263
