From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 11:44:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com>
 <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
 <435264B1.2010204@de.bosch.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 16 17:40:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERAcI-0004IH-0i
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 17:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVJPPjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 11:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVJPPjo
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 11:39:44 -0400
Received: from iabervon.org ([66.92.72.58]:54794 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751289AbVJPPjo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2005 11:39:44 -0400
Received: (qmail 11485 invoked by uid 1000); 16 Oct 2005 11:44:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2005 11:44:46 -0400
To: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <435264B1.2010204@de.bosch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10159>

On Sun, 16 Oct 2005, Dirk Behme wrote:

> > On Thu, 13 Oct 2005, Jeff Garzik wrote:
> >
> > >I have real users of my git repos who can't just download a 100MB pack file
> > >in
> > >an hour, it takes them many hours.
> 
> Seems that I'm one of these users (but using an other repo).
> 
> Pack files are very nice saving bandwith and disk space. But what I dislike is
> that I often have to download same information twice: Remote .git/objects/*
> repo grows and I update my local repo daily against this. Then once a
> month/release/whatever .git/objects/* are packed into one file. This new pack
> file then is downloaded as well, but most/all of the information in this file
> is already in my local repo and downloaded again. Something like
> 
> - detect that there is new pack file in remote repo
> - check what is in this remote pack file
> - if in local repo no or only few .git/objects/* are missing, download the
> missing ones and create an identical copy of remote pack file using local
> .git/objects/*. Don't download remote pack file.

This is the problem: it's impossible to download only a few objects from a 
pack file from an HTTP server, because those don't exist on the server as 
separate files.

The current HTTP code actually never downloads a pack file unless a needed 
object is not anywhere else, at which point it has no choice but to 
download the pack.

	-Daniel
*This .sig left intentionally blank*
