From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 17:59:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811141758230.30769@pacific.mpi-cbg.de>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com> <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
 <20081114050822.GA23963@foursquare.net> <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Frey <cdfrey@foursquare.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 17:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L11v9-0001hw-M9
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 17:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYKNQvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 11:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYKNQvj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 11:51:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:33872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750845AbYKNQvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 11:51:38 -0500
Received: (qmail invoked by alias); 14 Nov 2008 16:51:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 14 Nov 2008 17:51:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2LYwcV8/2aU/L/gQ2y7kC9wD/kfzk9li0Dd9im6
	qGOTrKyBNoojK9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100986>

Hi,

On Fri, 14 Nov 2008, Linus Torvalds wrote:

> So we _could_ do something like
> 
> 	git log {a..b} {c..d ^e}
> 
> and just declare that { $args } is a self-contained "subset", and 
> effectively becomes the same thing as "$(git rev-list $args)" but with 
> magic no-walking semantics (ie all walking is done only _within_ the { 
> }, not between different groups.
> 
> You literally _can_ do it right now that way:
> 
> 	git log --no-walk $(git rev-list HEAD~5..HEAD~3) $(git rev-list 
> 	HEAD~1..)
> 
> actually works, but that will hit argument size limits on many platforms 
> really quickly.
> 
> So we could make a '{ }' in the argument space basically do a SHA1 
> expansion of the range inside, and imply --no-walk. It's _not_ entirely 
> trivial, because we'd need to handle the fact that object flags are 
> sticky, and clear them in between invocations of multiple ranges, but 
> it's not _fundmanetally_ difficult. It's just that somebody would need 
> to do it.

Well, do not forget the case

	git log ^HEAD^ {HEAD^..HEAD} $BLUB

Ciao,
Dscho
