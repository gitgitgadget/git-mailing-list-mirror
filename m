From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git submodule update to use distributed
 repositories
Date: Thu, 17 Jul 2008 13:58:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807171351380.8986@racer>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>  <alpine.DEB.1.00.0807171311010.8986@racer>  <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com> <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:59:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJT4e-00032Y-FO
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbYGQM6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbYGQM6J
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:58:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:52083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755424AbYGQM6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:58:08 -0400
Received: (qmail invoked by alias); 17 Jul 2008 12:58:05 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp017) with SMTP; 17 Jul 2008 14:58:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FHuYiIAVFBvJS+lakM68ksMVPOinPXPsYhJMqsi
	L3/IYNqDonfr7M
X-X-Sender: gene099@racer
In-Reply-To: <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88845>

Hi,

On Thu, 17 Jul 2008, Nigel Magnay wrote:

> On Thu, Jul 17, 2008 at 1:13 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 17 Jul 2008, Nigel Magnay wrote:
> >
> >> When doing a git submodule update, it fetches any missing submodule 
> >> commits from the repository specified in .gitmodules.
> >
> > Huh?  It takes what is in .git/config!  Not what is in .gitmodules.
> 
> Huh? And where does .git/config get it from? Oh, that's right, 
> .gitmodules.

Oh, that's right, after "git submodule init".  Right before you are 
supposed to change them if your setup commands that.

> > So if you have another remote (or URL, e.g. if you have ssh:// access, 
> > but the .gitmodules file lists git://), just edit .git/config.
> 
> So for my usecase, you'd have me go in and change *evey single one* of 
> my submodule refs from the centralised repository, *every time* I want 
> to do a peer review?

No.

> Doesn't the current system strike you as being somewhat centralised in 
> nature?

No.

> > I meant, that is the whole _point_ of having a two-step init/update 
> > procedure.
> 
> Are you just determined that submodules should remain useless for "the 
> rest of us"?

No.

If you really need to change the "origin" back and forth between reviews, 
while the committed state of the superproject stays the same, then 
something is seriously awkward and needs to be streamlined in your setup.

Because when the superproject's revision stays the same, "git submodule 
update" may fetch additional objects if you specify another remote, but it 
will check out just the same revisions of the submodules.  Because they 
were committed as such.

But if you want to get objects from another server (as opposed to update 
the submodules' working directories to the latest committed revisions), 
which happens to have the identical layout of the principal server (which 
I would deem another setup peculiarity to be fixed), you might want to 
look into the recurse patch that was flying about on this list a few 
months back.

Hth,
Dscho
