From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] git-init-db should error out with a message
Date: Wed, 26 Oct 2005 16:18:32 -0700
Message-ID: <7vhdb3c1fb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510260139000.30576@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051026194520.GC8030@steel.home>
	<7v3bmoc9d7.fsf@assigned-by-dhcp.cox.net>
	<20051026204727.GA19846@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 01:19:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUuXX-0005QN-On
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 01:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbVJZXSe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 19:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVJZXSe
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 19:18:34 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:55737 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751509AbVJZXSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 19:18:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026231757.UYTL776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 19:17:57 -0400
To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20051026204727.GA19846@steel.home> (Alex Riesen's message of
	"Wed, 26 Oct 2005 22:47:27 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10695>

Alex Riesen <fork0@users.sourceforge.net> writes:

> I think the file ref version uses rename of HEAD.lock into HEAD, doesn't it?
> Rename(2) should just remove the symlink, right?

If everybody used symlink or if everybody used regular file
symref, we would catch this race and the second one will be
stopped.  My point was that by falling back we are introducing
this unnecessary race, which might be unimportant but still it
is a new race.

To avoid that, I think symlink version needs to honor the
HEAD.lock convention, which would slow down normal cases.
