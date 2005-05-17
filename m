From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 12:32:37 -0700
Message-ID: <7vbr79fy22.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505171325150.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 17 21:37:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7r2-0001QG-Dr
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVEQTe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEQTed
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:34:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:18408 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261448AbVEQTcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 15:32:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517193238.KSPF7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 15:32:38 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> It wouldn't make any types special; the caller can just control each type
DB> individually, so that code that only cares about commits could get commits
DB> unpacked, but not get trees unpacked even if it has them parsed.

That is exactly the behaviour I am questioning about.  You are
giving the caller the ability to discriminate objects based on
their _type_ (which is fine and better than not having that
control at all).  Why can't the caller discriminate objects
based on their, say, size for example [*1*]?  That's what I
meant to say by "types are special" but I phrased it so badly.
 
And the callback would solve that naturally.  Or you can
additionally give the callback the result of the parse_xxx(),
which would be even more useful.  The callback can then throw
commit raw-data away based on the date, for example.

[Footnote]

*1* So this hypothethical program uses fast cached raw data for
small things but is willing to pay penalty for big things if it
later finds those big things turn out to be needed.

