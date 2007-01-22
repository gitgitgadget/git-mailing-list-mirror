From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 23:12:05 -0800
Message-ID: <7vd557v8l6.fsf@assigned-by-dhcp.cox.net>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
	<7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
	<20070121103724.GA23256@moooo.ath.cx>
	<7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
	<20070121220114.GA24729@coredump.intra.peff.net>
	<45B415B1.30407@midwinter.com>
	<20070122015252.GA26934@coredump.intra.peff.net>
	<7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701211813410.14248@woody.osdl.org>
	<7virezwzpz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701211851310.14248@woody.osdl.org>
	<7v3b63wsh3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701212137370.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 08:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8tMG-0000va-Mg
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 08:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbXAVHMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 02:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbXAVHMp
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 02:12:45 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35735 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbXAVHMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 02:12:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122071205.BHZO3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 02:12:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E7CP1W00P1kojtg0000000; Mon, 22 Jan 2007 02:12:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701212137370.14248@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 21 Jan 2007 22:26:41 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37401>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 21 Jan 2007, Junio C Hamano wrote:
>> 
>> I've been annoyed by those scary messages fsck-objects enough
>> and was wondering if we could make it less scary.  Especially
>> annoying is that the message about missing blobs and trees that
>> are only referred to by dangling commits.
> ...
> Add my sign-off on the patch as appropriate. I do think it's mergeable, 
> but I'd _really_ like somebody else to double-check me here.

I think this is very sensible.  Even without all the added
comments, the refactoring makes the code much more readable.

-- >8 --
From: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 21 Jan 2007 22:26:41 -0800 (PST)
Subject: [PATCH] fsck-objects: refactor checking for connectivity

This separates the connectivity check into separate codepaths,
one for reachable objects and the other for unreachable ones,
while adding a lot of comments to explain what is going on.

When checking an unreachable object, unlike a reachable one, we
do not have to complain if it does not exist (we used to
complain about a missing blob even when the only thing that
references it is a tree that is dangling).  Also we do not have
to check and complain about objects that are referenced by an
unreachable object.

This makes the messages from fsck-objects a lot less noisy and
more useful.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 <<your patch here>>
