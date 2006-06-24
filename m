From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff --color: use reset sequence when we mean reset.
Date: Sat, 24 Jun 2006 04:23:11 -0700
Message-ID: <7vveqqx0f4.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 13:23:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu6EO-0002Vu-ER
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbWFXLXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbWFXLXN
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:23:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64163 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752214AbWFXLXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:23:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624112312.VRYE12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 07:23:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 22 Jun 2006 13:53:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22504>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Linus Torvalds <torvalds@osdl.org> writes:

 >  - always reset the color _before_ printing out the newline.
 >
 >    This is actually important. You (and Johannes) didn't see it, because 
 >    it only matters if you set the background, but if you don't do this, 
 >    you get some random and funky behaviour if you pick a color with a 
 >    non-default background (which still potentially has problems with tabs 
 >    etc, but less so).

 Doh.

 I think you did not see it until you tried "git diff" with
 a stat-dirty but otherwise unmodified file.

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 33c8c57..549f4e0 100644
--- a/diff.c
+++ b/diff.c
@@ -681,7 +681,7 @@ static void builtin_diff(const char *nam
 	const char *lbl[2];
 	char *a_one, *b_two;
 	const char *set = get_color(o->color_diff, DIFF_METAINFO);
-	const char *reset = get_color(o->color_diff, DIFF_PLAIN);
+	const char *reset = get_color(o->color_diff, DIFF_RESET);
 
 	a_one = quote_two("a/", name_a);
 	b_two = quote_two("b/", name_b);
-- 
1.4.1.rc1.ga77b7
