From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sat, 06 May 2006 00:10:00 -0700
Message-ID: <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<87mzdx7mh9.wl%cworth@cworth.org>
	<7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	<e3fqb9$hed$1@sea.gmane.org>
	<Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
	<46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 09:10:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcGvn-0003Jy-MU
	for gcvg-git@gmane.org; Sat, 06 May 2006 09:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWEFHKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 03:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWEFHKE
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 03:10:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16282 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932436AbWEFHKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 03:10:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506071001.RVZF9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 03:10:01 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
	(Martin Langhoff's message of "Sat, 6 May 2006 18:23:03 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19650>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 5/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> Of course, that would require another slight difference to "rev-list.c",
>> where we'd only recurse into trees of selected commit objects (ie we'd
>> have to mark the HAVE/WANT commits specially, but it's not exactly
>> complex either).
>
> Would it make sense to make all the shallow clone clone machinery walk
> everything and trim only blob objects? In that case, all the machinery
> that walks commits/trees would remain intact -- we only have to deal
> with the case of not having blob objects, which affects less
> codepaths.
>
> It means that for a merge or checkout involving stuff we "don't have",
> it's trivial to know we are missing, and so we can  attempt a fetch of
> the missing objects or tell the user how to request them them before
> retrying.
>
> And in any case commits and trees are lightweight and compress well...

Commit maybe, but is this based on a hard fact?  

Earlier Linus said something about "git log" working on
commit-only copy, but obviously you would want at least trees
for the path limiting part to work, so having commits and trees
would be handy, but my impression was that at least for deep
project like the kernel trees tend to be nonnegligible (a commit
consists of 18K paths and 1200 trees or something like that).
