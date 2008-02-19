From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 11:52:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802191146000.19024@iabervon.org>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com> <alpine.LSU.1.00.0802191547580.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVir-0003C6-Nx
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbYBSQw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbYBSQwz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:52:55 -0500
Received: from iabervon.org ([66.92.72.58]:40452 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316AbYBSQwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:52:55 -0500
Received: (qmail 10217 invoked by uid 1000); 19 Feb 2008 16:52:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 16:52:51 -0000
In-Reply-To: <alpine.LSU.1.00.0802191547580.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74436>

On Tue, 19 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 19 Feb 2008, Jon Loeliger wrote:
> 
> > Daniel Barkalow wrote:
> >
> > > For example, if you don't have a kernel.org account, you might want 
> > > settings like:
> > > 
> > > [host "kernel.org"]
> > >       base = git://git.kernel.org/pub/
> > >       rewritebase = master.kernel.org:/pub
> > > 
> > > Then, if you give git a URL like:
> > > 
> > >   master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> > > 
> > > it will act like you gave it:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> > > 
> > > and you can cut-and-paste pull requests in email without fixing them 
> > > by hand, for example.
> > > 
> > > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > > ---
> > 
> > So, I may be dense, but I'm having a hard time distinguishing the names 
> > "base" and "rewritebase" just from a User Interface perspective.  It's 
> > not clear to me which of those is the A and which is the B part in 
> > s/A/B/.  "Rewritebase" might be the "from" basis, or it might be the 
> > "to" basis.  Can we come up with more descriptive property names here?
> > 
> > Is the rewrite always just prefix substitution/replacement?
> > What if there was some generic path rewrite needed? (KISS? :-))
> 
> I just tried this:
> 
> $ git config rewrite."master.kernel.org:/pub".url \
> 	git://git.kernel.org/pub/
> 
> and it worked.  IOW, the config will look like this:
> 
> [rewrite "master.kernel.org:/pub"]
>         url = git://git.kernel.org/pub/
> 
> So maybe this is easier to grasp?

If you've also got people using http:// URLs, this would require giving 
the preferred URL twice. And it doesn't help with possible future 
host-based configuration, or a non-prefix pattern, if that came up some 
day.

I suppose perhaps:

[host "git://git.kernel.org/pub/"]
	aka = "master.kernel.org:/pub/"
	aka = "http://www.kernel.org/pub/"

I'm a little worried about putting URLs in keys, but I don't know if 
that's a reasonable worry.

	-Daniel
*This .sig left intentionally blank*
