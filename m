From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 11:33:21 -0800
Message-ID: <7vbqxsyyym.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
	<20060131181248.GE11955@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F41Fn-0006B2-0x
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWAaTdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWAaTdY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:33:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:25234 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751409AbWAaTdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 14:33:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131193027.QGTU17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 14:30:27 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15336>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Tue, Jan 31, 2006 at 09:30:48AM -0800, Linus Torvalds wrote:
>>
>> The "ignore the index" approach is the simple one to explain. It's 
>> strictly less powerful, but hey, what else is new? 
>
> Yeah, I do wonder what's likely to be the best approach for most users.
> My goal with the new tutorial was to get a reader doing something fun
> and useful as quickly as possible.  So it just refers elsewhere for any
> discussion of the index file or SHA1 names.  But probably everyone needs
> to pick up that stuff eventually anyway, and maybe it's better to get to
> it a little sooner, I dunno.

I think many good stuff git offers would not be helpful to the
users until index is understood as the third entity, in addition
to the usual "committed state" and "working tree state".  It
might be better to talk about it sooner rather than later.  And
the tool is geared towards taking advantage of it, so until the
user understands that, behaviour of some tools would feel
unintuitive.

You can have local throw-away modifications while applying
patches and merging (I once broke merges by ignoring that it is
perfectly valid to have index and working tree files be
different and keep working that way.  That was a hard lesson).
The index file knows what working tree changes are meant to be
committed.  Another thing I find useful, which cannot be done
without index, is to sanity check while developing.  When "git
diff" gives too many diffs, running update-index on paths that I
think are more-or-less OK helps to reduce clutter, and I can
view only further changes to those paths.

In a sense, update-index can be thought of to check in the
changes without committing.  You can check in number of times,
and the cumulative effect is committed later.  "reset --mixed"
is undoing these uncommitted check-ins.  "reset --hard" undoes
the last commit.
