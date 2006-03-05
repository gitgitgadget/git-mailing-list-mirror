From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-blame: Kill warning "print_map defined but not used"
Date: Sun, 05 Mar 2006 14:45:23 -0800
Message-ID: <7vmzg4ecjg.fsf@assigned-by-dhcp.cox.net>
References: <20060305111650.GC23448@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0603051054330.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Mar 05 23:45:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG1yk-0004D2-NK
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 23:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWCEWpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 17:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCEWpZ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 17:45:25 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64131 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932170AbWCEWpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 17:45:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305224144.RGOX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 17:41:44 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603051054330.13139@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 5 Mar 2006 10:58:19 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17246>

Linus Torvalds <torvalds@osdl.org> writes:

>  - you should use "-u -U 0" instead of "-u0" to avoid warnings from some 
>    versions of GNU diff

One liner here.

>  - Please default to HEAD so that you don't need to say it.

Fredrik's latest patch already does.

-- >8 --
Subject: [PATCH] blame: avoid "diff -u0".

As Linus suggests, use "diff -u -U 0" instead.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 blame.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1f7d9585190c22a4c019487444d9e461e08baa0e
diff --git a/blame.c b/blame.c
index a3a8ddc..141e4c6 100644
--- a/blame.c
+++ b/blame.c
@@ -92,7 +92,7 @@ static struct patch *get_patch(struct co
 		die("write failed: %s", strerror(errno));
 	close(fd);
 
-	sprintf(diff_cmd, "diff -u0 %s %s", tmp_path1, tmp_path2);
+	sprintf(diff_cmd, "diff -u -U 0 %s %s", tmp_path1, tmp_path2);
 	fin = popen(diff_cmd, "r");
 	if (!fin)
 		die("popen failed: %s", strerror(errno));
-- 
1.2.4.gee5c7
