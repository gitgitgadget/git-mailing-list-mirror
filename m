From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb - option to disable rename detection
Date: Mon, 15 Aug 2005 18:21:29 -0700
Message-ID: <7voe7yr812.fsf@assigned-by-dhcp.cox.net>
References: <87d5ofoxvt.wl@mail2.atmark-techno.com>
	<Pine.LNX.4.58.0508151140050.3553@g5.osdl.org>
	<87br3zorjk.wl@mail2.atmark-techno.com>
	<Pine.LNX.4.58.0508151542290.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 03:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4q92-0008Fl-WA
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 03:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVHPBVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 21:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVHPBVc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 21:21:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30939 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965059AbVHPBVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 21:21:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816012129.HIYZ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 21:21:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508151542290.3553@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 15 Aug 2005 15:43:26 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> This makes it somewhat more expensive - I was thinking about disabling it 
> in git-diff-tree, since the rename logic already knows how many 
> new/deleted files there are.

That's doable.  I'll rig something up on my next GIT day, along
with the clean-up for diff option handling which we have
postponed for some time.  Clearly this would introduce another
option to diffcore.

OTOH, you could take totally the opposite avenue and take
advantage of the fact that git commit ancestry is immultable.
Once commitdiff is made, you do not have to regenerate it but
cache it and reuse for the next request.  I may be mistaken, but
I vaguely recall kernel.org webservers already does something
like that.

If you have infinite amount of disk space, you could choose to
cache everything, and also prime the cache before any real users
ask for a page.  Once you go that route, you could even give -C
flag for copy detection, with --find-copies-harder which is an
ultra expensive option, and nobody would notice.
