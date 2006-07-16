From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge performance problem..
Date: Sat, 15 Jul 2006 20:18:45 -0700
Message-ID: <7v7j2eme3u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 16 05:19:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1x9m-0002rD-9i
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 05:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWGPDSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 23:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWGPDSr
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 23:18:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:41967 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964820AbWGPDSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jul 2006 23:18:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060716031846.EIKD12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Jul 2006 23:18:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 15 Jul 2006 14:48:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23941>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, I think there is something wrong with git-merge. It sometimes takes 
> up to ten seconds, and it's stuck at the
>
> 	git-show-branch --independent "$head" "$@"
>
> call.
>
> I don't know quite what that thing is even meant to do (we do already know 
> the parents, why do we do something special here?) but even apart from 
> that, the whole thing must be doing something seriously wrong, since it 
> takes so long. Does it check the whole commit history?

The code is to cull redundant parents primarily in octopus and
is not strictly necessary.  Can I have the $head and $@ (the
other merge parents, but in your case you never do an octopus so
that would be the other branch head) to see what is going on
please?  It should not descend down the history all the way but
with the recent changes to the object marking/unmarking code it
is possible we might have broken something.
