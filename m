From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Thu, 12 Jul 2007 13:48:11 -0700
Message-ID: <7vejjdtkl0.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
	<7vir8ptksi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 22:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95aC-0007ks-Id
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 22:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333AbXGLUsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 16:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbXGLUsN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 16:48:13 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63038 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbXGLUsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 16:48:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712204812.XQDZ1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 16:48:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NkoB1X0091kojtg0000000; Thu, 12 Jul 2007 16:48:11 -0400
In-Reply-To: <7vir8ptksi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Jul 2007 13:43:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52332>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I like how gitk shows the local changes as an unnamed commit at the top, 
>> but what I *don't* like is how it just ignored the difference between 
>> stuff that has been added to the index, and stuff that hasn't..
>>
>> It would be very nice to have *two* such commits (either or both of which 
>> just disappear), where the top-most is the diff to the index, and the 
>> second is the diff from the index to HEAD.
>>
>> That would not only be useful in general, it would be a wonderful way to 
>> visually introduce people to the notion of what the staging area is all 
>> about.
>
> Interesting, as I was thinking about something similar when I
> typed "git show stash" by mistake. I meant to say "git stash
> show", but "git show stash" output actually was even closer to
> what I wanted to see.
>
> "git stash" internally creates two commits, based on your HEAD:
> ...

Clarification.  I do not mean gitk should create such a view
using git-stash (for one thing that would nuke your local
modifications after saving it away).  I just meant that I agree
with you that --cc between HEAD, index and the working tree is a
wonderful way to view the current state.

It might make sense to teach "git diff" itself to show this
3-way diff with a new option ("git diff --h-i-w").  The
necessary machinery is already there to handle "git diff maint
master next pu" (four trees!), and "git diff maint:Makefile
master:Makefile next:Makefile" (three blobs).
