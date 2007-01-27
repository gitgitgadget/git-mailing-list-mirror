From: Junio C Hamano <junkio@cox.net>
Subject: Re: finding earliest tags descended from a given commit
Date: Fri, 26 Jan 2007 21:23:12 -0800
Message-ID: <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
References: <20070127040618.GA14205@fieldses.org>
	<Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
	<20070127044246.GC14205@fieldses.org>
	<20070127045552.GB9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 06:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAg26-0005Nn-6w
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 06:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbXA0FXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 00:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXA0FXP
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 00:23:15 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49547 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbXA0FXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 00:23:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127052313.XLTS9717.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 00:23:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G5NF1W00K1kojtg0000000; Sat, 27 Jan 2007 00:22:16 -0500
In-Reply-To: <20070127045552.GB9966@spearce.org> (Shawn O. Pearce's message of
	"Fri, 26 Jan 2007 23:55:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37920>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> "J. Bruce Fields" <bfields@fieldses.org> wrote:
>> That's interesting, I hadn't noticed name-rev before you and Shawn
>> mentioned it.
>> 
>> It only finds one name, though. When I tried it just now on my
>> repository what it found was a tag I'd created for an experimental
>> version, which probably wouldn't be what I wanted.  (Though it might be,
>> in some situations.)
>
> Yea. Hmm.  Maybe name-rev needs to learn a few more tricks, like
> favoring annotated tags over non-annotated ones/heads, and being
> able to print the top n nearest matches (e.g. 10), by displaying
> only one line of output per tag (or ref).

Yeah, I found name-rev to be mostly useless since it almost
always names relative to my unannotated "anchor" tag that I use
to keep track of 'master' I sent the last "What's in" message
for.

I think doing parallel merge-base computation that is in
show-branch and the updated describe would be a sensible
approach.  When somebody says such and such does not work yet in
his version, after identifying the commit that introduced that
feature, I would run "show-branch $that_rev 'tags/v1.*'" to see
which tag(s) contain that revision.
