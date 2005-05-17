From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Tue, 17 May 2005 15:25:08 -0700
Message-ID: <7vsm0lqym3.fsf@assigned-by-dhcp.cox.net>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
	<20050516220559.GC8609@pasky.ji.cz>
	<7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
	<20050517070158.GA10031@pasky.ji.cz>
	<Pine.LNX.4.58.0505170812060.18337@ppc970.osdl.org>
	<7vu0l1fz6p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505171227260.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 00:37:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYAfz-0002nG-Lq
	for gcvg-git@gmane.org; Wed, 18 May 2005 00:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVEQW1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEQW0w
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 18:26:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12475 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262034AbVEQWZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 18:25:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517222509.ZQCF1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 18:25:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505171227260.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 17 May 2005 12:32:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> So I'd really suggest having just a flag that says "pure old diff format"  
LT> or "new diff format with renames", and if the latter is selected, then do
LT> _just_ the changes, ie the rename+change case would really boil down to
LT> getting just

That is sensible.  So the with --detect-rename flag, we do
rename detection and show only the changes, otherwise we do not
do rename detection and give pure old diff (two diffs against
/dev/null, that is).  I do not personally think --detect-rename
with --output-old-style-diff is useful.

Now, in the new diff format, if the rename is really a pure
rename, then we would have:

     diff -git a/nitfol b/nitfol
     rename old frotz
     rename new nitfol
     diff -git a/rezrov b/rezrov
     --- a/rezrov
     +++ b/rezrov
     @@ ...

that is, nothing until the patch for the next file or EOF.  Is
this acceptable?

