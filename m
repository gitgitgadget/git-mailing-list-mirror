From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 11:45:03 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802191127080.19024@iabervon.org>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:45:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVbC-000069-G5
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYBSQpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYBSQpG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:45:06 -0500
Received: from iabervon.org ([66.92.72.58]:53854 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbYBSQpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:45:05 -0500
Received: (qmail 9932 invoked by uid 1000); 19 Feb 2008 16:45:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 16:45:03 -0000
In-Reply-To: <47BAF18F.5040709@freescale.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74433>

On Tue, 19 Feb 2008, Jon Loeliger wrote:

> Daniel Barkalow wrote:
> > This allows users with different preferences for access methods to the
> > same remote repositories to rewrite each other's URLs by pattern
> > matching across a large set of similiarly set up repositories to each
> > get the desired access.
> > 
> > For example, if you don't have a kernel.org account, you might want
> > settings like:
> > 
> > [host "kernel.org"]
> >       base = git://git.kernel.org/pub/
> >       rewritebase = master.kernel.org:/pub
> > 
> > Then, if you give git a URL like:
> > 
> >   master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> > 
> > it will act like you gave it:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> > 
> > and you can cut-and-paste pull requests in email without fixing them
> > by hand, for example.
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> 
> So, I may be dense, but I'm having a hard time distinguishing
> the names "base" and "rewritebase" just from a User Interface
> perspective.  It's not clear to me which of those is the A and
> which is the B part in s/A/B/.  "Rewritebase" might be the "from"
> basis, or it might be the "to" basis.  Can we come up with more
> descriptive property names here?

rewritebase is the base you rewrite, which follows apache usage (which is 
where somebody got the term to suggest in an earlier round). It seems like 
it should be clear; am I obfuscating it by showing the options in the more 
backwards order in the examples? If you've got an idea that people find 
more clear, I'd be happy to change it (again).

> Is the rewrite always just prefix substitution/replacement?
> What if there was some generic path rewrite needed? (KISS? :-))

It's just prefix substitution. I suppose a future version could do 
something more clever (but it would probably also use variables named 
"pattern" instead of "base", so there shouldn't be any issues).

> Also, is "host" really the right config key?  Maybe "rewritehost"?
> Or is this thought to be the basis of other (perhaps not rewrite
> related) properties of the same host as well?

I think it's likely that other properties of the host could show up. I 
suspect that uploadpack and receivepack would be useful host-wide if you 
were using a lot of ad-hoc repository names on a big site. Rewriting the 
URLs is just the itch I had with this scope.

	-Daniel
*This .sig left intentionally blank*
