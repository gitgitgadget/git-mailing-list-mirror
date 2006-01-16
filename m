From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] new tutorial
Date: Sun, 15 Jan 2006 22:57:31 -0500
Message-ID: <20060116035731.GA14849@fieldses.org>
References: <7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <20060112005531.GB14599@fieldses.org> <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net> <20060113030837.GD27214@fieldses.org> <7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net> <20060113151005.GA29804@fieldses.org> <7v4q477vqj.fsf@assigned-by-dhcp.cox.net> <20060113200152.GI4369@fieldses.org> <20060115185458.GA3985@fieldses.org> <7v64olysw2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 04:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyLV2-0007ND-0D
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 04:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWAPD5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 22:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAPD5d
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 22:57:33 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46505 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750976AbWAPD5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 22:57:33 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1EyLUp-0006Fq-Sp; Sun, 15 Jan 2006 22:57:31 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64olysw2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14720>

On Sun, Jan 15, 2006 at 03:26:53PM -0800, Junio C Hamano wrote:
> We may want to mention that the canonical commit log message
> format is a single line "summary phrase", an empty line, and the
> body of the message.

Sounds reasonable.  After the second mention of "commit -a" I've added:

	A note on commit messages: though not required, it's a good idea
	to begin the commit message with a single short (less than 50
	character) line summarizing the change, followed by a blank line
	and then a more thorough description.  Tools that turn commits
	into email, for example, use the first line on the Subject line
	and the rest of the commit in the body.

(Alternatively, if we had more of this sort of thing we could collect
them into a "best practices" document to reference at the end.)

> A bit narrower fill-column settings, please.

Does 70 characters work for you?

And thanks for the rest of the comments; I'll work through them and then
send an update.  (May be a few days.)  I'll assume you want a
replacement unless you tell me you'd prefer an incremental diff.

This caught my eye:

> Empirically the first 7 hexdigits are enough (even 5 for small
> projects such as git itself).  In fact, in the linux-2.6
> repository itself, it appears 5 hexdigits are enough to identify
> all 171902 objects (not just commits) uniquely currently

Five hex digits is only 20 bits, and 171902/2^20 > 1/10, so each
additional object has a better than 1-in-10 chance of colliding with an
existing object.  The chances there hasn't been a collision in the first
5 digits by now must be practically zero.  Maybe you're thinking bytes,
not hex digits?  Unless my math is wrong.

But for these purposes we're just worried about the chance of a
particular string having a collision, which should be more like
(number of objects) / 2^(4*number of digits), so yeah, 16 digits is
overkill, good point.

> BTW, I do not see the CC'ed copy on list archives and am wondering why
> even though I see CC: header in the copy I received...

Maybe the list software didn't like the big patch?

> BTW^2, it might be interesting to do
> 
> 	$ git format-patch -C origin..master
> 
> the next time around.

Oh, I see, it catches the rename then.  Neat.

--b.
