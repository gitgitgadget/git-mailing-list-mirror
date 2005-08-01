From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 17:11:20 -0700
Message-ID: <7vhdeabjo7.fsf@assigned-by-dhcp.cox.net>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0507311305170.29650@g5.osdl.org>
	<7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507311549300.14342@g5.osdl.org>
	<7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507311627280.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 02:12:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNuv-0007j2-Nw
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 02:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVHAALx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 20:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVHAALx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 20:11:53 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:25266 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262173AbVHAALW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 20:11:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050801001120.BOXC550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 20:11:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507311627280.14342@g5.osdl.org> (Linus Torvalds's message of "Sun, 31 Jul 2005 16:33:53 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In the "central repo model" you have another issue - you have potentially
> parallell pushes to different branches with no locking what-so-ever (and
> that's definitely _supposed_ to work), and I have this suspicion that the 
> "update for dumb servers" code isn't really safe in that setting anyway. I 
> haven't checked.

You are absolutely right.  It should grab some sort of lock
while it does its thing (would fcntl(F_GETLK) be acceptable to
networked filesystem folks?).

I have one question regarding the hooks.  We seem to prefer
avoiding system and roll our own.  Is there a particular reason,
other than bypassing the need to quote parameters for shell?
