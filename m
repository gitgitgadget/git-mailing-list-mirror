From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 15:00:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811141452550.30769@pacific.mpi-cbg.de>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com> <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
 <20081114050822.GA23963@foursquare.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:54:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0z8L-0002Qn-BR
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYKNNxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 08:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbYKNNxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:53:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:47813 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751190AbYKNNxI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 08:53:08 -0500
Received: (qmail invoked by alias); 14 Nov 2008 13:53:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 14 Nov 2008 14:53:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ijTE3CROi3Z5BFn/ESGZu64CXNZjvDbXS73zuJx
	v0P5GFKSPFwdL+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081114050822.GA23963@foursquare.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100974>

Hi,

On Fri, 14 Nov 2008, Chris Frey wrote:

> On Mon, Nov 10, 2008 at 10:31:32PM +0100, Johannes Schindelin wrote:
> > On Mon, 10 Nov 2008, Alex Riesen wrote:
> > > for cs in HEAD^..HEAD HEAD~10; do
> > >   case "$cs"; in
> > >   *..*)
> > >      git format-patch --stdout "$cs"
> > >      ;;
> > >   *)
> > >      git show --pretty=email "$cs"
> > >      ;;
> > >   esac
> > > done
> > > 
> > > At least, this is what I have in mind and how I expect it to work.
> > 
> > That is not the way git-show is implemented (it uses setup_revisions() to 
> > check for validity and to parse the arguments), and I cannot think of any 
> > way to make this work without ugly workarounds.
> 
> Would it be possible to add "range" support to a subset of commands by
> using a git-range wrapper?
> 
> Hypothetical, pie-in-the-sky idea:
> 
> 	git range HEAD^..HEAD HEAD~10 -- show --pretty=email
> 	git range HEAD^..HEAD HEAD~10 -- log
> 	git range HEAD^..HEAD HEAD~10 -- cherry-pick

This is not really well defined is it?  What about

	git range HEAD -- log makefile

Where should it insert the "HEAD" argument?

Besides, I do not like how this muddies the semantics: if git range as you 
proposed it became part of Git, people _would_ get confused why "git range 
HEAD^..HEAD HEAD~10" interprets the range _differently_ from "git log 
HEAD^..HEAD HEAD~10".

Ciao,
Dscho
