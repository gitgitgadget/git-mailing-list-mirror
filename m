From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 4 Sep 2009 15:05:03 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909041429540.28290@iabervon.org>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com> <alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 21:05:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mje5x-0006s6-Jf
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbZIDTFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 15:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757168AbZIDTFD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 15:05:03 -0400
Received: from iabervon.org ([66.92.72.58]:35845 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbZIDTFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 15:05:01 -0400
Received: (qmail 14236 invoked by uid 1000); 4 Sep 2009 19:05:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 19:05:03 -0000
In-Reply-To: <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127761>

On Fri, 4 Sep 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 4 Sep 2009, Junio C Hamano wrote:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > > It turns out that the method used to form URLs that use a helper 
> > > doesn't generalize well to other cases, because it interferes with the 
> > > ssh-style locations. Instead, some different mechanism needs to be 
> > > made up to handle arbitrary handlers that git doesn't know about. 
> > > Since we want to keep supporting "http://something", that'll have to 
> > > be a special case anyway, and so we might as well handle it by having 
> > > git know what helpers to use for things that we've always supported, 
> > > and use a single descriptive name for the helper that handles that 
> > > collection of URLs.
> > >
> > > As of this version, the idea is that there will be three ways helpers 
> > > get selected:
> > >
> > >  - git selects a helper based on the URL being something traditionally 
> > >    supported internally; that is, git recognizes the URL and knows 
> > >    what to run, if possible, to handle it
> > >
> > >  - git uses the "vcs" option if it is set
> > >
> > >  - something with the URL that we don't understand well enough yet to 
> > >    design, but which doesn't seem to be possible to fit in as a single 
> > >    rule with the first item.
> > 
> > Thanks for a clear description.
> > 
> > I do not see that there is much difference between the above description
> > and what Dscho is advocating, and I do not see anything to get excited
> > about as Dscho seems to do.
> 
> I mainly take exception at complicating things with a "vcs" config 
> variable.
> 
> The way you describe it, I like it, as I do not see any mention of said 
> config variable there.
> 
> If you allow "git clone <URL>" for foreign vcs URLs, you do not need the 
> "vcs" variable.  If you require that variable, you cannot allow an easy 
> clone, and you will earn my opposition.

Some foreign vcses, including the only one I ever personally use, do not 
have URLs, and require a bunch of options and paths to specify a 
repository. I don't want to have to use:

	url = p4://rsh:ssh+-q+-a+-x+-l+p4ssh+-q+-x+perforce+%2Fbin%2Ftrue//projects/foo/bar-1.0/...,//projects/foo/bar-1.1/...

(actually, I don't even know what the normal thing is for a URL for 
something that's split between multiple locations, or how URLs handle 
"servers" that are arbitrary commands including options which make a 
connection to the server)

For cases where the foreign vcs has something to put in the "url" spot, 
you don't need to set "vcs". In fact, you are only allowed to set one or 
the other of "vcs" and "url" with my current version. What you're 
interested in is explicitly left for later, when we have a prototype 
helper for such a foreign vcs and can try it out with potential users.

	-Daniel
*This .sig left intentionally blank*
