From: Petr Baudis <pasky@suse.cz>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path
	to do sparse clone
Date: Thu, 24 Jul 2008 20:53:32 +0200
Message-ID: <20080724185332.GQ32184@machine.or.cz>
References: <20080723145718.GA29134@laptop> <20080724171952.GB21043@sigill.intra.peff.net> <alpine.DEB.1.00.0807241837441.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nguy?n =?iso-8859-2?Q?Th=E1i?= Ng?c Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5xU-0007Be-Eq
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYGXSxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYGXSxg
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:53:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54580 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbYGXSxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:53:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 04FAD393A2E4; Thu, 24 Jul 2008 20:53:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807241837441.8986@racer>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89939>

  Hi,

On Thu, Jul 24, 2008 at 06:41:03PM +0100, Johannes Schindelin wrote:
> On Thu, 24 Jul 2008, Jeff King wrote:
> 
> > As a user, I would expect "sparse clone" to also be sparse on the 
> > fetching. That is, to not even bother fetching tree objects that we are 
> > not going to check out. But that is a whole other can of worms from 
> > local sparseness, so I think it is worth saving for a different series.
> 
> I think this is not even worth of a series.  Sure, it would have benefits 
> for those who want sparse checkouts.  But it comes for a high price on 
> everyone else:
> 
> - security issues (you'd need to open the git protocol to give you 
>   something else than a ref, _including_ refs that were deleted)
> 
> - performance issues (the server would have to do a lot more, faking 
>   commits, or in the alternative serving a gazillion more sessions if the 
>   client does the reconstruction)

  I don't follow how these two issues arise, if the server will do the
pruning for you. It will just skip entering some tree objects when doing
object traversal; why opening the git protocol or faking commits? This
would be a simple extra capability in the protocol.

  One question is what to do with delta chains including unwanted
objects, but I think that given the objects' associativity for delta
chains, this shouldn't be huge practical issues and it could be
affordable in principle to include even unwanted objects.

> ... and I am sure there are tons more issues.

  I do agree on this. :-)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
