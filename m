From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH (take 2)] diff-cache.c compilation warning fix.
Date: Wed, 27 Apr 2005 21:59:55 -0700
Message-ID: <7vzmvja438.fsf@assigned-by-dhcp.cox.net>
References: <7vekcvbkq8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:55:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR13g-0006ik-8g
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 06:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVD1FA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVD1FAZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:00:25 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29130 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261969AbVD1FAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 01:00:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428045954.RSQW19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 00:59:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcvbkq8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 27 Apr 2005 21:15:11 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nobody uses return value from show_new_file() function but it is
defined as returning int and falls off at the end without
returning.  Make it void.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

This is take 2.  Earlier one was a botched patch that left
"return -1" in the function.

diff-cache.c |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

# - [PATCH] diff-tree -p implies diff-tree -p -r
# + 04/27 21:50 diff.c clean up temporary file.
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -38,14 +38,14 @@ static int get_stat_data(struct cache_en
 	return 0;
 }
 
-static int show_new_file(struct cache_entry *new)
+static void show_new_file(struct cache_entry *new)
 {
 	unsigned char *sha1;
 	unsigned int mode;
 
 	/* New file in the index: it might actually be different in the working copy */
 	if (get_stat_data(new, &sha1, &mode) < 0)
-		return -1;
+		return;
 
 	show_file("+", new, sha1, mode);
 }

