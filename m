From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mysterious error message
Date: Fri, 26 Sep 2008 07:37:26 -0700
Message-ID: <20080926143726.GZ3669@spearce.org>
References: <20593.1222378418@as220.org> <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de> <30988.1222439568@as220.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: tom sgouros <tomfool@as220.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:39:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjESr-0006fv-Rq
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYIZOh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYIZOh2
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:37:28 -0400
Received: from george.spearce.org ([209.20.77.23]:34280 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYIZOh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:37:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F029B3835F; Fri, 26 Sep 2008 14:37:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <30988.1222439568@as220.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96858>

tom sgouros <tomfool@as220.org> wrote:
> > On Thu, 25 Sep 2008, Tom Sgouros wrote:
> > > I receive the following error message when I try to do a 'git push':
> > > 
> > >   tomfool@toms-box:hpl$ git push
> > >   updating 'refs/heads/master'
> > >     from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
> > >     to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
> > >    Also local refs/remotes/origin/master
> > >   Generating pack...
> > >   Done counting 10 objects.
> > >   Deltifying 10 objects...
> > >   error: pack-objects died with strange error
> > >   unpack eof before pack header was fully read
> > >   ng refs/heads/master n/a (unpacker error)
> > >   error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
> > >   tomfool@toms-box:hpl$
> > 
> > I got this message when I tried to push a project with submodules to a 
> > server which had submodule-ignorant git installed.  Maybe it's that?
> 
> I'm not sure which versions are submodule-ignorant, but it's version
> 1.5.3.6 on the pusher and version 1.5.4.5 on the server.  I installed
> git via the fink package manager.  Could there be some other
> incompatibility? 

This change came after 1.5.3.6 and I think its what you are
tripping over:

  commit 481f0ee60eef2c34b891e5d04b7e6e5a955eedf4
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Sun Nov 11 23:35:23 2007 +0000

    Fix rev-list when showing objects involving submodules

rev-list aborting because it cannot mark a submodule commit
as uninteresting should cause pack-objects to abort too since
the list of objects wasn't completely produced.

That fix is in 1.5.3.7 or later.

-- 
Shawn.
