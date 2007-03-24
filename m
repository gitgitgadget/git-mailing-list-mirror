From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Fri, 23 Mar 2007 18:09:56 -0700
Message-ID: <7v648ro3a3.fsf@assigned-by-dhcp.cox.net>
References: <200703231022.00189.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 02:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUuld-0008MZ-Gn
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 02:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992657AbXCXBJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 21:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992659AbXCXBJ6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 21:09:58 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38264 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992657AbXCXBJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 21:09:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324010956.UEIY28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Mar 2007 21:09:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id eR9w1W0171kojtg0000000; Fri, 23 Mar 2007 21:09:57 -0400
In-Reply-To: <200703231022.00189.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 23 Mar 2007 10:21:59 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42972>

Andy Parkins <andyparkins@gmail.com> writes:

> Now that we have a post-receive hook; the update hook's only job is to
> decide is a particular update is allowed or not.
>
> This example hook removes all of the functionality that should now
> rightly be done by the post-receive hook.  In particular: the generation
> of notification emails.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

I was quite impressed by seeing what Shawn did with his
'continuous' stuff, not the way it is implemented, but the way
it was presented as "you can do this to use it from your hook
script".

You know what?  I am very tempted to take this patch, while
dropping the other one.  Well, dropping is probably not quite
accurate, because being a nice person (and I am good looking,
too ;-), I would probably end up creating "contrib/mailhook/"
hierarchy and stash the contents of your second patch there
myself.

I think I'd better let fancier hooks live in contrib/examples
hierarchy for people to pick and choose, and keep the default
templates/ directory lean and clean.

There is a small detail of how users who use prepackaged git
would get rich library of example hooks from, but that is
something better left to distro people; that way I do not have
to worry about them too much, and it would also make it crystal
clear that these are just examples.

The thing is, not many people are interested in sending e-mail
out from post- any hooks (I don't do so, Linus doesn't either),
and there is no strong justifiation to give e-mail sending users
any preferential treatment and penalize others by copying rather
huge hook scripts from templates/ that they are not going to
ever use.
