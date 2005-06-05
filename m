From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix diff.c to match rename extended header to the document.
Date: Sun, 05 Jun 2005 15:25:42 -0700
Message-ID: <7vekbg1lw9.fsf_-_@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 00:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df3Vq-0001l1-E1
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVFEWZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVFEWZx
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 18:25:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55965 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261554AbVFEWZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 18:25:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605222544.JPFN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 18:25:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 15:11:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sun, 5 Jun 2005, Junio C Hamano wrote:
>> 
>> The documentation failed to describe "diff --git" extended diff
>> headers, so add some.

LT> You document the "rename" header as being "rename from/to", which is 
LT> sensible, but doesn't match reality. diff.c has "rename old/new". I found 
LT> that out the hard way when doing git-apply ;)

LT> I'd almost prefer fixing diff.c (and now apply.c). Comments?

Yes, sir ;-).

------------
This matches the git extended header to what is documented.
There is no need to touch git-external-diff-script since it gets
the string generated here and simply spits it out.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - linus: git-apply: fix rename header parsing
# + (working tree)
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -786,8 +786,8 @@ static void diff_flush_patch(struct diff
 	case 'R':
 		sprintf(msg_,
 			"similarity index %d%%\n"
-			"rename old %s\n"
-			"rename new %s",
+			"rename from %s\n"
+			"rename to %s",
 			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;

Compilation finished at Sun Jun  5 15:23:44

