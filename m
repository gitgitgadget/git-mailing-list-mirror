From: Junio C Hamano <junkio@cox.net>
Subject: Re: FFmpeg considering GIT
Date: Mon, 07 May 2007 12:10:57 -0700
Message-ID: <7vfy6878la.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070502T111026-882@post.gmane.org>
	<20070503180016.GB21333@informatik.uni-freiburg.de>
	<20070503200013.GG4489@pasky.or.cz>
	<loom.20070504T143538-533@post.gmane.org>
	<87y7k4lahq.wl%cworth@cworth.org>
	<20070505133543.GC3379@diana.vm.bytemark.co.uk>
	<alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	<17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 07 21:11:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl8bx-00058f-BV
	for gcvg-git@gmane.org; Mon, 07 May 2007 21:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966143AbXEGTK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966169AbXEGTK7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 15:10:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43125 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966143AbXEGTK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 15:10:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070507191058.RJU22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 7 May 2007 15:10:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wKAx1W00n1kojtg0000000; Mon, 07 May 2007 15:10:58 -0400
In-Reply-To: <17983.6136.147062.346626@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Mon, 7 May 2007 22:13:44 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46477>

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> Finally, it realy _should_ check that the first 7 characters of the commit 
>> log (the ones it ignores by just asking for substring 7..) are actually 
>> the exact characters "commit ", but I'll blame my lack of comfort with the 
>> language again.
>
> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals.  I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and
> MacOS AFAIK.  Python/Tk would be a possibility, but I have never
> learnt python and I'm actually not all that comfortable with having to
> do things the object-oriented way.
>
> Any suggestions?

I've looked at Perl and Python Tk integration in the past; they
take slightly different approaches.  The Perl integration tries
to first libify Tk part to make it less dependent to the host
language, tcl, and then retargets it to a new host language,
Perl.  Compared to that, Python integration was shallower;
calling from Python to Tk and callback from Tk to Python were
done using Tcl as intermediary.  Which looked somewhat hacky but
at the same time cleaner.  From scriptability point of view,
both were much more pleasant to use than tcl.  You would have
object-orientation in the nature of data anyway (e.g. your
commitdata, commitlisted, commitidx and friends will not be
look-up tables keyed with commit object name, rather they will
become attributes to commit objects), so I would expect doing it
in Python+Tk would feel natural.
