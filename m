From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][PATCH] Fix assumption that git is installed in a standard
 place on the remote end ssh
Date: Fri, 22 Jun 2007 11:47:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706221140140.4059@racer.site>
References: <20070615150351.GH14677@menevado.ms.com>
 <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk>
 <20070615154000.GK14677@menevado.ms.com> <Pine.LNX.4.64.0706190114110.4059@racer.site>
 <20070622013026.GY14298@menevado.ms.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 12:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1gfZ-0005WR-Oc
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 12:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXFVKrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 06:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbXFVKrK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 06:47:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:36734 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752136AbXFVKrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 06:47:06 -0400
Received: (qmail invoked by alias); 22 Jun 2007 10:47:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 22 Jun 2007 12:47:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/T7gM8XIPTJoNxPc/HRv0w/pk3gEahW8Vfnw3Zq1
	4Bc+7ahT+XnQWe
X-X-Sender: gene099@racer.site
In-Reply-To: <20070622013026.GY14298@menevado.ms.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50688>

Hi,

On Thu, 21 Jun 2007, Kevin Green wrote:

> On 06/18/07 20:16:47, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Fri, 15 Jun 2007, Kevin Green wrote:
> > 
> > > I'm thinking I like the env var idea much more though.  I can just 
> > > export it in my shell and it works in both cases.
> > 
> > And it completely breaks down when you have more than one remotes. Or when 
> > you cd to another project with another remote. Or etc. IOW it is fragile.
> > 
> > Clearly, the config approach is the only one which makes sense. This 
> > information is so closely coupled to a specific remote that you should 
> > store it right where you store all the other remote information, too.
> > 
> 
> You're absolutely right.  I agree, except that in _my_ environment git 
> will be in a non-standard path but *always* consistently in the same 
> place.  I'm being greedy here. :)

Note that this "solution" will _only_ work for you.

> The config approach is clearly the most versatile.  The question I have 
> is, is there a good reason not to provide the third option of setting 
> env var?  I suppose that in the more likely case this could cause more 
> harm than good, i.e. maybe this is too specific for my use case.

Since it will _only_ work for you, I think there is more harm done than 
good, by including that in mainline git. Just think of somebody seeing 
this mentioned in the docs, not reading further properly, and just getting 
confused, blaming it on Git.

Instead, we have that wonderful config solution, which is the proper one 
anyway, and which does not confuse people, once they found it.

However, Git is all about the freedom to fork and merge. So do the same as 
me: keep those changes in your local repo, and do not use mainline Git.

For example, I have this option "-t" to Git, which automatically tries to 
give human-readable names to all the 40-character object names, and does 
not change colouring. Thus, I can say

	git -t log -p whatever.c

to find exactly which commit introduced a certain feature (which I find by 
searching the diffs). Then, I only have to copy&paste the nice commit name 
into the mail/IRC where I am responding to, and be done.

This feature was not liked on the list, so it remains in my local fork 
forever (though it is also stored in the mail archives).

Ciao,
Dscho
