From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git push bug?
Date: Fri, 19 Oct 2007 20:50:29 +0200
Message-ID: <000001c81280$ebc5c5e0$5267a8c0@Jocke>
References: <Pine.LNX.4.64.0710191920210.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Steffen Prohaska'" <prohaska@zib.de>,
	"'git'" <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 20:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiww8-0008Qq-Ct
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 20:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935468AbXJSSuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 14:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935895AbXJSSuh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 14:50:37 -0400
Received: from mail.transmode.se ([83.241.175.147]:55612 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934532AbXJSSug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 14:50:36 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 19 Oct 2007 20:50:32 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <Pine.LNX.4.64.0710191920210.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Thread-Index: AcgSdO9Hwt2ehTuiT1a323gas/ILxgABmRow
X-OriginalArrivalTime: 19 Oct 2007 18:50:33.0034 (UTC) FILETIME=[ED88D2A0:01C81280]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61739>

> -----Original Message-----
> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> Sent: den 19 oktober 2007 19:25
> To: Joakim Tjernlund
> Cc: Steffen Prohaska; git
> Subject: Re: git push bug?
> 
> Hi,
> 
> On Fri, 19 Oct 2007, Joakim Tjernlund wrote:
> 
> > On Thu, 2007-10-18 at 23:00 +0100, Johannes Schindelin wrote:
> > > 
> > > On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> > > 
> > > > First, I didn't know that I could do that. Secondly, I was also 
> > > > looking do v2.6.23:linus refspecs
> > > 
> > > 
> > > First, then our documentation could be better.  How?
> > 
> > Well, it isn't clear to me how all this is supposed to work 
> and what is 
> > bugs. Clearifying that would help.
> > 
> > For instances I did a push with v2.6.23:refs/heads/linus 
> and now I got a 
> > branch with the SHA1 of v2.6.23 
> > tag(0b8bc8b91cf6befea20fe78b90367ca7b61cfa0d) in it. Makes 
> gitk display 
> > that branch as "linus^{}".
> 
> It strikes me as really odd that you would _want_ to create a branch 
> remotely, that has _never_ existed locally.

It strikes me as really odd that a core developers like yourself
hasn't tried to justify/explain why push works as it does.

As I am trying to convince our dev. group here to move to git instead of subversion, I
need to learn how git works. Now I have gotten to the push function and I need
to know what can be done with push and how, pitfalls too. As I go along I find behavior
that I find odd and report these to the list.

 git push <repo> v2.6.23:refs/heads/linus
will make a tag look like a branch

 git push <repo> linus:linus
won't let me create the remote branch linus but
 git push <repo> linus
will

 git push <repo> :linus
OOPS, now I just deleted remote branch linus, no warning
 
 git push <repo> linus:refs/head/linus
creates a branch that is invisible(wont show in git branch -a)

 git push <repo> linus:refs/heads/newbranch
creates remote branch newbranch, but you have to know the magic words
refs/heads/ to do it.

Se what I mean? 

> 
> > > Second, why not "git checkout -b linus v2.6.23 && git push origin 
> > > linus"?
> > 
> > An extra checkout that takes time but works.
> 
> Not only that: before trying to publish something, I would 
> have expected 
> you to have that branch locally, and that you actually worked on it.
> 
> > Doesn't make the above "weiredness" go away though.
> 
> Yes it does.

No it doesn't. If someone else in my group wants to create a branch they
might do the same mistakes as I did.

> 
> git checkout -b <branchname> resolves to the commit that the 
> tag pointed 
> to.  So it would not push a tag, which you did.
> 
> Of course you could do what you planned to do, if you knew 
> git better.  
> But you are not familiar enough with git's inner workings yet, so I 
> suggest to stay with things for now that work _always_, and 
> exactly as 
> expected.
> 
> Such as creating a branch locally, with exactly the name that 
> you plan it 
> to have remotely, and then pushing it with "git push origin 
> <branchname>".  
> Easy as apple pie.
> 
> Ciao,
> Dscho
> 
> 
> 
