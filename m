From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: Monotone workflow compared to Git workflow ( was RE: Git vs Monotone)
Date: Thu, 31 Jul 2008 14:48:21 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	<sverre@rabbelier.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOeAT-0007Sb-Tv
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbYGaTtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYGaTtc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:49:32 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:56305 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbYGaTtc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:49:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Monotone workflow compared to Git workflow ( was RE: Git vs Monotone)
Thread-Index: AcjzQpKt1InvJeuJRmaYho7KUAh5pgAApRdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90975>

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Linus Torvalds
> Sent: Thursday, July 31, 2008 2:18 PM

> single database for git, but wants to force a full clone for 
> each. Not to mention that in git, you'd normally not do 11 
> clones to begin with, you'd just do 11 branches in one repo.
> 

I have a question about this.  I asked this awhile back and didn't
really get any satisfactory answers except to use git-new-workdir, which
makes git behave a lot like monotone.  In our workflow, we do create
branches for nearly everything, but we do find that we have a need to
keep the build artifacts of those branches isolated from each other
because rebuilding is expensive.  IOW, we have this sort of workflow:

git checkout A
[work on A, build, test, do some commits]
git checkout B
[work on B, build, test, do some commits]
git checkout A
[work on A, re-build, test, do some commits]

We find ourselves constantly having to shift gears and work on other
things in the middle of whatever it is we're currently working on.  For
instance, in the scenario above, A might be branch that contains a
feature going into our next release.  B might be a bugfix and takes
priority over A, so you have to leave A as-is and start work on B.  When
I come back to work on A, I have to rebuild A to continue working, and
that's just too expensive for us.  So we use the monotone-like
new-workdir which allows us to save those build artifacts.

So, that said, I ask again, am I missing something?  Is there a better
way to do this?  How do the kernel developers do this, surely they're
switching branches back and forth having to build in-between?

> 			Linus
> --
> To unsubscribe from this list: send the line "unsubscribe 
> git" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Cheers,
Craig
