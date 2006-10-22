From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
Date: Sun, 22 Oct 2006 15:55:59 -0700
Message-ID: <7v64ec2c5c.fsf@assigned-by-dhcp.cox.net>
References: <200610211750.49188.jnareb@gmail.com>
	<200610211752.19891.jnareb@gmail.com>
	<7v3b9g5cde.fsf@assigned-by-dhcp.cox.net>
	<200610222236.45414.jnareb@gmail.com>
	<Pine.LNX.4.64.0610221359090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 00:56:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbmEm-00006J-9K
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 00:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJVW4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 18:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWJVW4E
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 18:56:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:53454 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750784AbWJVW4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 18:56:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022225600.WZEE6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 18:56:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id daw41V0031kojtg0000000
	Sun, 22 Oct 2006 18:56:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610221359090.3962@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 22 Oct 2006 14:03:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29801>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 22 Oct 2006, Jakub Narebski wrote:
>> 
>> To be true I do those "whitespace cleanup" patches when I notice
>> that something is mis-aligned for _my_ tab width (2 spaces).
>
> Oh, wow.
>
> You have clearly been damaged by some nasty GNU coding style or similar.
>
> Please immediately turn tabs into 8 character hard-tabs, and read the 
> kernel Documentation/CodingStyle document.

Offtopic comments.

I am from old school, so a TAB to me is always equivalent to a
run of spaces that pads up to the next column that is dividible
by 8, but there is one valid reason to occasionally take a look
at your code with unusual TAB settings to catch coding style
violations, if you _were_ following an indentation policy that
is different from what the kernel and git uses.

Aside from the textual comparison order habit (aka "never use >
or >= comparison operators") that everybody hates (and I've been
trying not to inroduce new ones, albeit slowly), I have picked
up two other "unusual" coding style habits, which I deliberately
have stayed away from applying to the code I write for git.

They both relate to the way the code is indented; unlike the
textual order comparison one, they do not affect readability to
me that much and it is easier for me to shake them when I want
to be.

They are:

 - There is no "aligning" between two lines, other than the case
   in which they start with _identical_ substring.  Not just
   that a TAB does not necessarily look the same as spaces to
   the next display column that is divisible by 8 by everybody;
   think about proportinal fonts.

   When you take this position, there is only one thing you can
   do when your logical line extends over more than one physical
   lines because it is too long.  Since there is no aligning,
   the only sensible thing to do is to indent it one level
   deeper than the first physical line of the logical line.
   Your indentation becomes like this:

   <BOL><TAB>if (very long expression that extends over<EOL>
   <BOL><TAB><TAB>more than one line) {<EOL>
   <BOL><TAB><TAB>do this and do that...<EOL>
   <BOL><TAB>}<EOL>

   When you are following this principle (and git sources do not
   and should not), viewing your code with an unusual tab width
   is a good way to check the coding style violation.

 - If you have to split a long expression over multiple lines,
   split the line _before_ a binary operator, not after, so when
   you turn your head sideways 90 degrees, you would see the
   parse tree of the expression:

        foo = a-term
                * (a-very-very-long-expression-term
                        + yet-another-term);

   If there _were_ alignment, this would perhaps look like this:

        foo =     a-term
                * (       a-very-very-long-expression-term
                        + yet-another-term);
