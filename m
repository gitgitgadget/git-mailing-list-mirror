From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
 foreign vcs
Date: Wed, 5 Aug 2009 18:09:08 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051750270.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>  <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org>  <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com> <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYofd-0007uz-Ix
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbZHEWJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbZHEWJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:09:09 -0400
Received: from iabervon.org ([66.92.72.58]:54730 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbZHEWJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:09:08 -0400
Received: (qmail 25161 invoked by uid 1000); 5 Aug 2009 22:09:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 22:09:08 -0000
In-Reply-To: <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125008>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 5 Aug 2009, Sverre Rabbelier wrote:
> 
> > On Wed, Aug 5, 2009 at 14:20, Johannes 
> > Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > > I actually would rather have "svn-http://something" because it tells 
> > > me right away and in red letters what is happening.
> > 
> > I don't know if this is only for ssh, but wouldn't
> > "http+svn://something" be very recognisable?
> 
> Problem: on Windows, we cannot name the helper git-remote-http+svn: "+" is 
> not an allowed character in a filename.

Also, the ssh thing is "svn+ssh", so it should be "svn+http".

The transport code could know that, if there's a + before the colon, the 
relevant part is before the +; I think the svn helper should have to take 
care of whatever access to svn is requested (perhaps itself using a 
transport-layer protocol helper, and if you say "svn+uucp://something", it 
should be up to the svn helper to tell you you're nuts, not git failing to 
find a svn+uucp helper. In particular, if the svn helper uses a library to 
do its network access, the URLs it can handle may vary arbitrarily, even 
when you're not changing the package with git-remote-svn in it, so it 
shouldn't be a matter of what names the svn helper is available under in 
the filesystem.

In any case, we do want to support SVN repos at "svn+ssh://something" 
somehow, and I think users will go crazy if it isn't either sticking that 
in the URL or also setting another option to "svn" (the latter probably 
being unfortunate to require).

	-Daniel
*This .sig left intentionally blank*
