From: Junio C Hamano <junkio@cox.net>
Subject: Do not barf on too long action description
Date: Sat, 28 Apr 2007 00:15:48 -0700
Message-ID: <7v3b2lklzv.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070427203043.GD18276@pasky.or.cz>
	<7vfy6lmp0y.fsf@assigned-by-dhcp.cox.net>
	<20070427235952.GE18276@pasky.or.cz>
	<7vy7kdl5jm.fsf@assigned-by-dhcp.cox.net>
	<20070428002638.GF18276@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 09:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhh9v-0006Hm-CK
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 09:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbXD1HPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 03:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbXD1HPv
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 03:15:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63693 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161408AbXD1HPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 03:15:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428071550.DKOA1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 03:15:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sXFo1W00J1kojtg0000000; Sat, 28 Apr 2007 03:15:49 -0400
In-Reply-To: <20070428002638.GF18276@pasky.or.cz> (Petr Baudis's message of
	"Sat, 28 Apr 2007 02:26:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45771>

Reflog message is primarily about easier identification, and
leaving truncated entry is much better than dying.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-fetch--tool.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 3145c01..1b04881 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -42,9 +42,7 @@ static int update_ref(const char *action,
 
 	if (!rla)
 		rla = "(reflog update)";
-	len = snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	if (sizeof(msg) <= len)
-		die("insanely long action");
+	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 	lock = lock_any_ref_for_update(refname, oldval);
 	if (!lock)
 		return 1;
