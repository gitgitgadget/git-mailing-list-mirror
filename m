From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 18:47:33 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806291821520.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5h9-0005K1-4o
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbYF2Wrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYF2Wre
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:47:34 -0400
Received: from iabervon.org ([66.92.72.58]:38047 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbYF2Wre (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:47:34 -0400
Received: (qmail 20938 invoked by uid 1000); 29 Jun 2008 22:47:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jun 2008 22:47:33 -0000
In-Reply-To: <alpine.DEB.1.00.0806292248160.9925@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86845>

On Sun, 29 Jun 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 29 Jun 2008, Daniel Barkalow wrote:
> 
> > Did we even make a commitment on whether:
> > 
> > GIT_CONFIG=foo git clone bar
> > 
> > must ignore the environment variable, or simply doesn't necessarily obey 
> > it?
> 
> I'd rather strongly argue that no matter what is the answer to this 
> question, we _HAVE TO_ unsetenv() GIT_CONFIG at some stage, otherwise no 
> .git/config will be written.

Why should .git/config get written? The user is explicitly using a 
different file instead, so .git/config really shouldn't get written, 
unless the user isn't allowed to use the environment variable or the 
environment variable shouldn't apply.

Actually, perhaps the right thing is to remove the code to look at the 
environment variable from config.c and have it in builtin-config.c, since 
only "git config" is actually documented to be affected by GIT_CONFIG at 
all. But I don't really know what the variable is supposed to do, beyond 
what's in the documentation. In any case, I don't think "git clone" is at 
all special with respect to GIT_CONFIG.

	-Daniel
*This .sig left intentionally blank*
