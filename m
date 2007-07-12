From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 09:46:40 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707120933120.20061@woody.linux-foundation.org>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91oo-0005E4-Tu
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765367AbXGLQrC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbXGLQrA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:47:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53092 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759228AbXGLQrA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 12:47:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CGkk1D009046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 09:46:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CGkfuF019913;
	Thu, 12 Jul 2007 09:46:41 -0700
In-Reply-To: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
X-Spam-Status: No, hits=-2.609 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52305>



On Thu, 12 Jul 2007, Fredrik Tolf wrote:
> 
> I was wondering -- whenever I see Git patches committed to projects
> like the Linux kernel or Git itself, the commits always seems to be
> committing rather large changes and be rather well-defined in terms of
> what they change.

Well, people already talked about how to do it using git, but I'd like to 
point out that one of the reasons you see this kind of pattern is that 
when you push patches around by email for commentary (which is what both 
git and the kernel do a _lot_), that very much inherently encourages a 
setup where each patch makes sense on its own, and I think it causes 
*much* better code cleanliness behaviour.

When people make changes that they know will be shown as patches, they 
just tend to make more sure that the changes make logical sense. Part of 
it is cleanups after-the-fact, but part of it is that when you get used to 
doing it, after a while you start _thinking_ in those terms when you make 
the changes, and that's also a good thing!

When I do any bigger changes, I usually tend to commit at points where it 
starts working, but then before I actually would send it to Junio, I'd go 
back and clean up the series (by creating a new branch, and 
cherry-picking, and doing diffs between the branch and applying the parts 
I want to).

But I do that only for stuff where I can't see the end result as a clean 
series of steps from the beginning. If I know exactly what I'm doing, I'll 
just do it the clean way from the get-go, and I don't need to clean up the 
series after-the-fact.

(Most of the time I actually try to get it right the first time. It's 
actually become a challenge to me to notice when some change needs a 
cleanup first in order to make the later changes much easier, so I really 
*like* trying to actually do the actual development in a logical order: 
first re-organize the code, and verify that the re-organized code works 
identically to the old one, then commit that, then start actually working 
on the new feature with the now cleaner code-base).

And no, I didn't start out programming that way. But when you get used to 
looking at changes as a nice series of independent commits in emails, you 
really start _working_ that way yourself. And I'm 100% convinced that it 
actually makes you a better programmer too.

> When I develop for myself, I usually commit incrementally quite a
> bit, if for no other reason because Git won't let me switch between
> branches if I don't commit first. I usually try to keep my commits
> well-defined, but I don't manage to get anywhere close to what I see
> when I look at the history of Linux or Git.

The stuff you see in git or the kernel has mostly been discussed as 
emails, or at least been sent out that way (and if it didn't cause any 
discussion, it was probably "obviously clean and correct"). And that whole 
flow really *does* end up causing people to write cleaner patches.

It's absolutely worth emulating it, but in some respect, if it's just your 
own project, I suspect you'll just never have the incentive to have your 
history be quite as clean as the kernel/git development itself has.

		Linus
