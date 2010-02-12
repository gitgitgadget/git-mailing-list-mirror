From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 14:16:40 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002121158430.14365@iabervon.org>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>  <20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>  <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>  <20100212091635.GA22942@glandium.org>
 <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>  <fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com>  <alpine.LNX.2.00.1002120923060.14365@iabervon.org> <fabb9a1e1002120841o71651f82h782eab46206df402@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:16:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng10W-0001JC-Ie
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 20:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110Ab0BLTQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 14:16:42 -0500
Received: from iabervon.org ([66.92.72.58]:58081 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab0BLTQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 14:16:41 -0500
Received: (qmail 21719 invoked by uid 1000); 12 Feb 2010 19:16:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Feb 2010 19:16:40 -0000
In-Reply-To: <fabb9a1e1002120841o71651f82h782eab46206df402@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139739>

On Fri, 12 Feb 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Feb 12, 2010 at 17:10, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Also note that the current helper protocol is definitely insufficient to
> > replace git-svn ('export' isn't actually specified, although I think
> > everyone who guesses how it works guesses the same thing),
> 
> I've finally started implementing this yesterday.

Great.

> > and the
> > transport code needs to be extended to handle the "dcommit" situation
> > (when you push a commit, the state that you see on the remote changes
> > based on the semantics of what you sent, but it does not change to have
> > the same hash as what you pushed).
> 
> So basically what you want to do is after you push, automagically do a
> 'git reset --hard @{u}'? That could be handled by a specific response
> from the helper to the 'export'/'push' command, perhaps it could list
> which refs need to be updated?

I think that 'export' will always have this effect, because the 
export/reimport roundtrip is practically never going to be exact with a 
remote system that isn't actually git (and the state that you see the 
remote as having after a successful push should match what you see if you 
were to clone again). People have wanted to have the remote server getting 
a push able to make changes like this as well, and so far we've resisted 
doing it, because it starts causing problems.

I'm not sure what it should do, and I'm not terribly happy about any of 
the obvious choices, but it does have to do something to be able to 
replace "git svn dcommit".

	-Daniel
*This .sig left intentionally blank*
