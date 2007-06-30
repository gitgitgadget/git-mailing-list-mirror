From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 11:13:17 -0700
Message-ID: <7vk5tlcnuq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
	<200706300539.l5U5dHLh003989@mi1.bluebottle.com>
	<Pine.LNX.4.64.0706301644190.4438@racer.site>
	<7vps3dcp76.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0706301853400.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hRh-0005eZ-RB
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbXF3SNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbXF3SNT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:13:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49896 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbXF3SNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:13:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630181318.YKCR22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 14:13:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HuDH1X00J1kojtg0000000; Sat, 30 Jun 2007 14:13:18 -0400
In-Reply-To: <Pine.LNX.4.64.0706301853400.4438@racer.site> (Johannes
	Schindelin's message of "Sat, 30 Jun 2007 18:56:02 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51237>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +apply [<stashname>]::
>> > +	Try to apply the stashed changes to the current HEAD. You need
>> > +	a clean working directory for that, i.e. you must not have changes
>> > +	relative to HEAD in your working directory or index.
>> 
>> The implementation appears to apply on a clean index without
>> restriction to where the HEAD is.  I hinted that that behaviour
>> is fine in my previous message, but on the other hand haven't
>> convinced myself enough to say that it would not confuse end
>> users.  Maybe insisting on not just clean index but no changes
>> from the HEAD would reduce confusion?  I dunno.
>
> I am sure confused why the index state is stashed away when it is not 
> used...

Yeah, I think Nanako kept this from her previous round because I
mentioned that "git show stash" (not "git stash show") is
interesting in that it gives stashed (HEAD, index, working tree)
in --cc fashion.  I also mentioned that it might make sense to
stash untracked files in the working tree portion of the commit,
and if we do that then we would need to record what was known to
git by the index tree so that we can discard them from the index
upon applying, but (1) I no longer think it is useful to try
carrying forward the untracked file states, and (2) it would
make "git show stash" uninteresting (too much cruft).

So perhaps we would want to drop the index tree portion from the
stash.

>> > +Author
>> > +------
>> > +Written by Johannes E. Schindelin <johannes.schindelin@gmx.de>
>> 
>> You wrote that ;-)?
>
> No. ;-)
>
> Hey, be nice. It's a new role for me, usually others document what _I_ 
> wrote, not vice versa :-)

Actually I have been wondering if it is a good idea to start
dropping the Author section.  Perhaps replace it by list of
stakeholders or people who have been active in the area recently
and who are likely to be able to help when an end-user has
troubles with the command.
