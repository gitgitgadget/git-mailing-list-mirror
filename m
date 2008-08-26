From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix a warning (on cygwin) to allow -Werror
Date: Tue, 26 Aug 2008 18:50:37 +0100
Message-ID: <48B4426D.3090801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2w2-0007Jv-9S
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbYHZSF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYHZSF0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:05:26 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:4118 "EHLO
	anchor-post-30.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758237AbYHZSFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 14:05:25 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.67)
	id 1KY2ki-0005SP-1m; Tue, 26 Aug 2008 17:54:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93790>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Noticed while building 1.6.0 from the release tar-ball.

Also, I noticed that git_ntohl() is still defined in compat/mingw.h; is this
still required?  It's not a problem, just curious! (I don't have mingw
installed, so I can't test myself)

ATB,

Ramsay Jones

 builtin-fast-export.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 0709716..7c93eb8 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -417,7 +417,8 @@ static void export_marks(char *file)
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
 			mark = ptr_to_mark(deco->decoration);
-			fprintf(f, ":%u %s\n", mark, sha1_to_hex(deco->base->sha1));
+			fprintf(f, ":%"PRIu32" %s\n", mark,
+				sha1_to_hex(deco->base->sha1));
 		}
 		deco++;
 	}
-- 
1.6.0
