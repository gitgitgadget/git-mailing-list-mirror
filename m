From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Tue, 26 Feb 2008 17:49:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261742260.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net> <alpine.LNX.1.00.0802261709180.19665@iabervon.org> <alpine.LSU.1.00.0802262239200.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8cq-0002Iv-II
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 23:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763655AbYBZWtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 17:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756128AbYBZWtj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 17:49:39 -0500
Received: from iabervon.org ([66.92.72.58]:40660 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763428AbYBZWti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 17:49:38 -0500
Received: (qmail 32144 invoked by uid 1000); 26 Feb 2008 22:49:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 22:49:29 -0000
In-Reply-To: <alpine.LSU.1.00.0802262239200.22527@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75185>

On Tue, 26 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 26 Feb 2008, Daniel Barkalow wrote:
> 
> > Actually, I think I'll be leaving CONFIG_ENVIRONMENT alone entirely; I 
> > was only using it to override the setting that t5505 uses, but t5505 is 
> > just wrong to set it. So this is the right placement of git_config(), 
> > and the setenv and unsetenv aren't needed.
> 
> Well, existing git-clone.sh sets GIT_CONFIG.  So we have to unset any 
> existing GIT_CONFIG at least.

As far as I can tell, that's a flaw in git-clone.sh; if the user has set 
GIT_CONFIG, it shouldn't be the case that every program other than 
git-clone obeys it while git-clone ignores it. (On the other hand, 
possibly every program other than git-config should ignore it, since it's 
only documented as affecting git-config.) git-clone.sh only sets it, I 
think, because it runs programs from the wrong context for them to do the 
right thing by default, not because it's specifically trying to override a 
user-provided setting.

	-Daniel
*This .sig left intentionally blank*.
