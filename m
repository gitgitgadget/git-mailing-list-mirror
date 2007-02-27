From: Junio C Hamano <junkio@cox.net>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 13:50:29 -0800
Message-ID: <7v649nclsq.fsf@assigned-by-dhcp.cox.net>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<200702271257.37437.andyparkins@gmail.com>
	<200702272227.05244.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAE2-0005JI-VB
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXB0Vue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbXB0Vue
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:50:34 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43325 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXB0Vud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:50:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227215030.RACI2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 16:50:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UlqV1W00F1kojtg0000000; Tue, 27 Feb 2007 16:50:29 -0500
In-Reply-To: <200702272227.05244.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Tue, 27 Feb 2007 22:27:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40816>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> tisdag 27 februari 2007 13:57 skrev Andy Parkins:
>> On Tuesday 2007 February 27 11:41, Simon Josefsson wrote:
>> 
>> > * How do I discard all locally modified or added files?  'cvs upd -C'
>> >   does some of that, but I've been using a tool 'cvsco' which quickly
>> >   restore a CVS checkout into a pristine state.
>> 
>> Not that I know of, but git has some lovely log generation tools, so I'm sure 
>> it could be easily done with a snippet of perl - or perhaps a change to git's 
>> own log generator to support
>> 
>>  git-rev-list --pretty=gnucl
>> 
> gir-rev-list ??
>
> Extend git-shortlog with --gnucl instead. What seems missing is the grouping
> of changes by date. git-shortlog only groups by author.

If GNU changelog _were_ to have one entry per day, mixing
changes from different commits together, that might be a good
approach. I do not think GNU changelog guideline can be _THAT_
broken.

Listing of filenames of changed files in the log, followed by
short description of the nature of the change (e.g. "Updated to
do blah", "New File"), shows the CVS mentality "File matters",
and that was what Simon's original example showed.  It's been a
while I looked at the coding guideline the last time, but I
think GNU convention wants you to say "filename (function)" when
applicable.  Which I happen to think makes much more sense than
the filename alone.

The information that would appear in "log -p --pretty" output
needs to be condensed to obtain such a log entry.  You _could_
still do that as a built-in if you really wanted to, but I tend
to think that it is much better to implement such a specialized
processing (for one thing, what a function is depends on the
programming language you are reading from) as an external
postprocessing filter that people can more easily tweak for
their specific needs.

That's why I keep stressing that one good thing about git is it
is easily scriptable.
