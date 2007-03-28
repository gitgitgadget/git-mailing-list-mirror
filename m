From: Junio C Hamano <junkio@cox.net>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 19:04:18 -0700
Message-ID: <7vd52um8d9.fsf@assigned-by-dhcp.cox.net>
References: <17929.37382.984339.742025@lisa.zopyra.com>
	<20070327233552.GA7186@coredump.intra.peff.net>
	<Pine.LNX.4.64.0703271759510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 04:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWNWS-0005BY-04
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 04:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbXC1CEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 22:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbXC1CEV
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 22:04:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39595 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759AbXC1CEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 22:04:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328020419.LGEM27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 27 Mar 2007 22:04:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id g24J1W00f1kojtg0000000; Tue, 27 Mar 2007 22:04:19 -0400
In-Reply-To: <Pine.LNX.4.64.0703271759510.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 27 Mar 2007 18:06:11 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43343>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 27 Mar 2007, Jeff King wrote:
>>
>> You have to look at the latest merge-base, but that tells you the last 
>> time you merged with master, not necessarily the first time.
>
> Well, if you know which branch it is a branch off of, don't use 
> merge-base, just do
>
> 	git log --reverse -1 origin..branch
>
> which should pick up the first commit that is on that branch but haven't 
> been merged back to the original branch.

I suspect you fell into the common trap of confused interaction
between --max-count and --reverse here.  This will show the
latest one commit on the branch that is still not in origin.

Similarly, "git log --reverse -1 master" is _not_ the way to
find the root commit of the project.

> (Personally, if I didn't want the graphical version, I'd likely just do
>
> 	git log origin..branch
>
> and then do '>' in the pager to get to the bottom. That way I can then 
> scroll up and down if I decide I want to get a bigger picture)

What I use myself is git-topic.perl script from the 'todo'
branch.  It essentially is:

	for topic
        do
        	git [short]log --no-merges master..$topic
	done

with frills.
