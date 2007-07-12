From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] --decorate now decorates ancestors, too
Date: Thu, 12 Jul 2007 11:45:41 -0700
Message-ID: <7vmyy1tq96.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
	<Pine.LNX.4.64.0707110229320.4047@racer.site>
	<20070711022714.GI27033@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93ft-0004dJ-1E
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbXGLSpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbXGLSpp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:45:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33462 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXGLSpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:45:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712184542.YISK1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 14:45:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nilh1X00h1kojtg0000000; Thu, 12 Jul 2007 14:45:42 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52318>

Theodore Tso <tytso@mit.edu> writes:

> On Wed, Jul 11, 2007 at 02:29:49AM +0100, Johannes Schindelin wrote:
>> 
>> The option --decorate changed default behavior: Earlier, it decorated
>> commits pointed to by any ref.  The new behavior is this: decorate the
>> with the given refs and its ancestors, i.e.
>> 
>> 	git log --decorate next master
>> 
>> will show "next", "next^", "next~2", ..., "master", "master^", ...
>> in parenthesis after the commit name.
>
> I'm wondering how useful the default is.  The arguments get used for
> two things; both for git-log to decide what revisions to display, and
> which refs to decorate, right?  I'm not sure that overloading is such
> a great idea.
>
> Also, I note that "git log --decorate" does nothing at all.  Maybe it
> would be better to keep the default to be "any-ref" instead of "given"?

I think defaulting to "given" is a regression.  It could be
argued that "tag-ref" or "tag" might be a better default
(judging from my experience with "name-rev"), but keeping
"any-ref" would probably be the safest.

But in general I do not see ("I haven't realized" might turn out
to be a better expression) much value in this series yet except
for the initial clean-up patches, while I think this option
would be quite expensive in terms of memory footprints on
projects with nontrivial size of history.  I dunno.
