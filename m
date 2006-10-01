From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Sat, 30 Sep 2006 17:24:22 -0700
Message-ID: <7v64f47uix.fsf@assigned-by-dhcp.cox.net>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
	<Pine.LNX.4.64.0609272232040.9349@xanadu.home>
	<7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281029300.9349@xanadu.home>
	<7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
	<20060930045037.GB18479@spearce.org>
	<7v4pupizix.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609301033460.3952@g5.osdl.org>
	<7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609301712340.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 02:24:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTp8K-0000qC-3D
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 02:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWJAAYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 20:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWJAAYh
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 20:24:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34263 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751830AbWJAAYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 20:24:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001002434.RYMF13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 20:24:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UoQb1V00S1kojtg0000000
	Sat, 30 Sep 2006 20:24:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301712340.3952@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 30 Sep 2006 17:13:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28166>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 30 Sep 2006, Junio C Hamano wrote:
>> 
>> However, I think the traditional "find the closest ancestor"
>> behaviour and ref-log behaviour are mutually incompatible, while
>> they both return information to help address similar issues to
>> the end user when viewed at a very high level.
>> 
>> Especially, "find the closest ancestor" behaviour means when you
>> get "tag-gXXXX" as an answer, the tag proper does _not_ contain
>> the given commit (e.g. commit v1.4.2-g4839bd8 is not part of
>> v1.4.2).
>
> Correct.
>
> But that just means that we should take the _next_ one in the time-ordered 
> list, no?

I do not think so.

Extending the example (sorry for doing the same topic on two
separate threads) I just gave Jeff on "fix based on v0.99",
after finding that the fix is based on v0.99, finding another
commit that immediately followed the v0.99 commit on my master
branch does not help finding out that I very recently merged the
fix in at all.  I think we cannot get away without honestly
doing the first descendant, which is unfortunately a lot more
expensive.
