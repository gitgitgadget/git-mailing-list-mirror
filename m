From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sat, 21 May 2005 23:33:32 -0700
Message-ID: <7voeb3db2b.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505212253350.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 08:32:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZk0d-0007sS-Ub
	for gcvg-git@gmane.org; Sun, 22 May 2005 08:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEVGdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 02:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVEVGdg
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 02:33:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36093 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261213AbVEVGde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 02:33:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522063332.WSRY8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 02:33:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505212253350.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 May 2005 23:01:27 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sat, 21 May 2005, Junio C Hamano wrote:
>> 
>> Update the diff-raw format as Linus and I discussed, except that
>> it does not use sequence of underscore '_' letters to express
>> nonexistence.  All '0' mode is used for that purpose instead.

LT> Ok, it all looks very nice, but it looks like -C is still broken ;)

Well it is not _still_ broken, but rather was introduced by the
code reorganization to expose diff_rename_detect().  Sorry about
the lack of testing.

------------
Add the code to set default minimum score back in.

When the minimum score is specified as 0 (meaning "use default
value"), set it to the default as we are told.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
$ jit-diff
# - linus: [PATCH] The diff-raw format updates.
# + (working tree)
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -235,6 +235,8 @@ void diff_detect_rename(int detect_renam
 	int h, i, j;
 	int num_create, num_src, dst_cnt, src_cnt;
 
+	if (!minimum_score)
+		minimum_score = DEFAULT_MINIMUM_SCORE;
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 


