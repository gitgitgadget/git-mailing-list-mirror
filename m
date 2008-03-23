From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording cherry-picked commits
Date: Sun, 23 Mar 2008 13:11:59 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231309370.4353@racer.site>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>  <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>  <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
 <ae63f8b50803230407u7062586dy26fab7d98090efb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>, git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 13:12:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdP48-0001da-OG
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 13:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267AbYCWMMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 08:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759241AbYCWMMB
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 08:12:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:51254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759177AbYCWMMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 08:12:00 -0400
Received: (qmail invoked by alias); 23 Mar 2008 12:11:58 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp021) with SMTP; 23 Mar 2008 13:11:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SejBixRZSRieg+xhbYG/6ffs2qfYa97YqpXr4Zk
	QyOK1tUqIMAqxm
X-X-Sender: gene099@racer.site
In-Reply-To: <ae63f8b50803230407u7062586dy26fab7d98090efb9@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77883>

Hi,

On Sun, 23 Mar 2008, Jean-Baptiste Quenot wrote:

> 2008/3/22, Rafael Garcia-Suarez <rgarciasuarez@gmail.com>:
> > On 22/03/2008, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> >  > What about using a hidden ".gitcherry" file in the current branch 
> >  > to store the commits that have been applied?  With the simple shell 
> >  > scripts below I'm able to achieve the same effect as svnmerge:
> >
> > (.gitcherry should really be at the root of the git repository, not in 
> > the current directory)
> 
> Yes that's what I meant.  Usually I'm always at the root when I'm 
> cherry-picking changes but you're right the script could be improved in 
> this regard.  Is there a trick to find the root repository directory?

Actually, you should not store it in the root of the working tree, but in 
the git dir (because it should never be tracked!), and then you can make 
it non-hidden:

	file="$(git rev-parse --git-dir)"/cherry

> > What happens to .gitcherry across merges ?  I think your solution 
> > isn't robust enough.
> 
> The .gitcherry is merged like any other file.  I'm just trying to
> mimic svnmerge here, not to reinvent anything.  As Git does not have
> file metadata, I'm using a plain text file to achieve this.

Ah, I see, so you _want_ to track it.  I do not like this idea personally, 
but then, I will not use .gitcherry anyway.

	file="$(git rev-parse --show-cdup)"/.gitcherry

Hth,
Dscho
