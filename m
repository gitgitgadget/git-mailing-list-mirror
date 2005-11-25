From: Junio C Hamano <junkio@cox.net>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 13:28:00 -0800
Message-ID: <7virugmn8f.fsf@assigned-by-dhcp.cox.net>
References: <20051123142303.GJ22568@schottelius.org>
	<Pine.LNX.4.64.0511230917130.13959@g5.osdl.org>
	<20051124084633.GA3361@schottelius.org>
	<43866EDA.9050203@michonline.com>
	<20051125103048.GB30691@schottelius.org>
	<Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
	<20051125195121.GG16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 22:30:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efl7D-0005gp-Jw
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 22:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVKYV2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 16:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKYV2F
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 16:28:05 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37522 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751478AbVKYV2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 16:28:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051125212638.ZMBD17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 16:26:38 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051125195121.GG16995@mythryan2.michonline.com> (Ryan
	Anderson's message of "Fri, 25 Nov 2005 14:51:22 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12751>

Ryan Anderson <ryan@michonline.com> writes:

> Can something like this sequence do it?
>
> ...
>
> The key point being that the merge is done in a tree that has its index
> out of sync with its HEAD (git push ../tree2/ .... git pull ../tree3/ )
>
> I think that's the situation where I've personally managed to lose
> and/or revert some changes.

The moral of the story is not to push into the checked-out
branch of a non-naked repository, or you need to do what you are
doing if you choose to do so.  It might have made sense if index
file recorded which tree object its contents came from, but I am
not sure what tools is responsible for recording that if we
choose to extend index file to store that information.  Probably
read-tree is, but it should not do that unconditionally.

In any case, the workflow presented by Nick is that individual
developers use cg-* commands in CVS like workflow where the only
place you push into is the central repository and everybody
pulls from there, so I do not think the above example applies.
