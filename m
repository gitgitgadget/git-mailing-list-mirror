From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [RFC] git rev-contains [Was: merge -s ffonly]
Date: Wed, 8 Oct 2008 17:41:06 +0200
Message-ID: <20081008154106.GA18549@strlen.de>
References: <20081006235611.GA17662@spearce.org> <20081007185815.GA10744@strlen.de> <20081008143050.GG3052@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 17:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnbB9-0004oe-KK
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 17:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbYJHPlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 11:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbYJHPlL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 11:41:11 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:52551 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167AbYJHPlL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2008 11:41:11 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1Knb9u-0004qf-Va; Wed, 08 Oct 2008 17:41:07 +0200
Content-Disposition: inline
In-Reply-To: <20081008143050.GG3052@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97803>

Hello Deskin,

On Wed, Oct 08, 2008 at 10:30:50AM -0400, Deskin Miller wrote:
> On Tue, Oct 07, 2008 at 08:58:15PM +0200, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig_ wrote:
> > > +	if test -n "$(git rev-list $1..HEAD)"
> > I already wrote similar tests and I wonder if this couldn't be done in a
> > new builtin command more effectively.  Something like
> > 
> > 	git rev-contains HEAD "$1"
> > 
> > .  I expect it to be faster and maybe it prevents a command line
> > overflow?! [...]
>  
> I'm not sure this warrants a builtin; seems like test is perfectly capable of
> doing what you want:
> 
> if test '(' -n "$(git rev-list --max-count=1 $1..HEAD)" ')' -a \
> 	'(' -z "$(git rev-list --max-count=1 HEAD..$1)" ')'
> 
> The second check is needed to ensure that the commits actually have an
> ancestor-descendant relationship.
This is needed for the original patch, too, isn't it.

>                                    And --max-count means your command line
> won't overflow.
ah, --max-count is a nice idea.  Topgit could benefit from it.
 
> Or what about this:
> 
> if test "$(git merge-base $1 HEAD)" = "$(git rev-parse $1)"

It's not entirely clear to me, this works in general, because a
merge-base isn't unique.  It should work in this case, though.

Best regards
Uwe
