From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-refs: fix git_path() usage.
Date: Fri, 22 Sep 2006 21:34:48 -0700
Message-ID: <7vmz8rw68n.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org>
	<20060919205554.GA8259@pasky.or.cz>
	<20060922230845.GB8259@pasky.or.cz>
	<7vzmcrxvgw.fsf@assigned-by-dhcp.cox.net>
	<20060923011634.GL13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 23 06:34:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQzE5-0005Fh-AW
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 06:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWIWEeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 00:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIWEeu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 00:34:50 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36248 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750818AbWIWEet (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 00:34:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923043449.WKPI13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 00:34:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rgao1V00B1kojtg0000000
	Sat, 23 Sep 2006 00:34:48 -0400
To: git@vger.kernel.org
In-Reply-To: <20060923011634.GL13132@pasky.or.cz> (Petr Baudis's message of
	"Sat, 23 Sep 2006 03:16:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27562>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * A valid ref name can contain %.

 builtin-pack-refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 246dd63..db57fee 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -56,7 +56,7 @@ static void prune_ref(struct ref_to_prun
 	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1, 1);
 
 	if (lock) {
-		unlink(git_path(r->name));
+		unlink(git_path("%s", r->name));
 		unlock_ref(lock);
 	}
 }
-- 
1.4.2.1.gf2bba
