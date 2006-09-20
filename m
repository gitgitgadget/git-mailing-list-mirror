From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 09:34:33 -0700
Message-ID: <7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net>
References: <20060919232851.GA12195@spearce.org>
	<7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
	<20060920161407.GQ8259@pasky.or.cz>
	<20060920162145.GA23260@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 20 18:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ51y-0007a2-9n
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWITQef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWITQef
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:34:35 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49044 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751814AbWITQef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:34:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920163434.ZMAO6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 12:34:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QgaK1V00e1kojtg0000000
	Wed, 20 Sep 2006 12:34:20 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920162145.GA23260@spearce.org> (Shawn Pearce's message of
	"Wed, 20 Sep 2006 12:21:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27369>

Shawn Pearce <spearce@spearce.org> writes:

> Petr Baudis <pasky@suse.cz> wrote:
>> Dear diary, on Wed, Sep 20, 2006 at 06:06:11PM CEST, I got a letter
>> where Junio C Hamano <junkio@cox.net> said that...
> [snip]
>> >  (2) Although there is no inherent reason not allowing a working
>> >      tree associated with the repository that is kept updated
>> >      this way, the user will be utterly confused in a working
>> >      tree whose current branch head is updated like this, until
>> >      the working tree and the index is matched to the updated
>> >      HEAD.
>> 
>> git-fetch --mirror-all can still be very useful even with a working copy
>> if you are keeping all the remote heads in .git/refs/remotes/. I'd
>> venture to say that in that case, this is frequently what you actually
>> want when fetching from the repository (given that you have already let
>> git clone do that once).
>
> I think that's more `git fetch --all`.  You are pulling every remote
> head available at a given remote into a subdirectory of your own ref
> space.  That's rather different than replacing your entire ref space
> with the one available on the remote, which is what --mirror-all
> is doing and what you wanted for the hosting you are offering.

I realize I am going around in circles, but Pasky's "remotes/"
argument made me realize that this mirroring is not much more
than "fetch --force --all".  I initially had an impression that
this was for only strict mirroring where you do not even want
your own "origin", but if you arrange the .git/remotes/origin
file the right way, "fetch --force --all" (if you remembered to
put '+' in front of the refspecs, even without --force) would
what --mirror-all would do wouldn't it?

Having said that, I am not sure if "fetch --all" should delete
branches that do not exist on the remote end.  For mirroring, I
definitely would want the tool to delete them, and that is one
of the reason I feel this is much more similar to git-clone than
git-fetch, unless it is a separate command (perhaps git-mirror).
