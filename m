From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 3/7] revert: add --ff option to allow fast forward when cherry-picking
Date: Sun, 7 Mar 2010 21:39:45 +0100
Message-ID: <201003072139.45942.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org> <4B936500.9020005@gnu.org> <7vy6i4zem7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 21:40:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoNGf-0005Lq-3i
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 21:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab0CGUj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 15:39:58 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:34752 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab0CGUj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 15:39:58 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 10FA38181BE;
	Sun,  7 Mar 2010 21:39:48 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 28E15818045;
	Sun,  7 Mar 2010 21:39:46 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vy6i4zem7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141729>

On Sunday 07 March 2010 10:05:04 Junio C Hamano wrote:
> Paolo Bonzini <bonzini@gnu.org> writes:
> > On 03/07/2010 04:55 AM, Junio C Hamano wrote:
> >> What was the real motive/use case of "cherry-pick --ff"?
> >
> > Avoiding pointless separation of histories.  It's true that nowadays
> > git-patch-id will make a good job of reconciling them, but they do
> > look ugly in gitk.
> 
> Sorry, but that is a not-very-useful XY answer.
> 
> Why were _you_ using "cherry-pick" on a commit that is an immediate child
> of the current commit?  What were you trying to achieve by blindly using
> cherry-pick even in such a case?
> 
> I am sort-of guessing that "blindly" is coming from a script that doesn't
> bother to check if the commit you are cherry-picking is a direct child,
> and I do not think it is such a bad thing to allow scripts to blindly call
> cherry-pick that way and at the same time avoid making cherry-picked
> commits that are unnecessary.  So in that sense I am not opposed to having
> an option to allow "--ff".
> 
> But if that is the real motivation, then making --ff default is a wrong
> thing to do, as existing scripts knew and trusted cherry-pick will _not_
> fast-forward, and the ones that do want fast-forward have already checked
> just like "rebase -i" does.  Changing the default like Chriscool suggested
> would not help anybody.

The wording is: "Maybe this option could be made the default in the long run, 
..."

I didn't wrote something like: "This option should be made the default in the 
long run, ..."

I really didn't know if it should or should not be made the default now or in 
the long run, but I thought I had to talk about it.

Why? Because Paolo said that he would like it to become the default, and also 
because if we implement "git cherry-pick A..B" and people start to use it a 
lot, they may find it boring to have to always add --ff to avoid creating lots 
of spurious commit (instead of reusing existing ones).

Now if you want me to remove this part of the commit message, I will do it.
But my opinion is that it is interesting to document that we thought about 
making it the default now or in the future.

Do you prefer something like:

"Making this option the default was discussed on the mailing list but we 
decided that it is best left as non default for now. Though we recognized that 
it is best to have a --no-ff option too to future proof scripts in case the 
decision to make fast forwarding the default is made in the future."

?

Best regards,
Christian.
