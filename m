From: Jeff King <peff@peff.net>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Fri, 11 Feb 2011 14:03:26 -0500
Message-ID: <20110211190326.GB29203@sigill.intra.peff.net>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
 <AANLkTikrVPCr92XHirn1u=73eM--T190V-7nbE6fo8ng@mail.gmail.com>
 <201102111240.29746.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: skillzero@gmail.com, git@vger.kernel.org,
	John Wiegley <johnw@boostpro.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 11 20:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnyHH-0006ac-89
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 20:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060Ab1BKTDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 14:03:30 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50860 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013Ab1BKTD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 14:03:29 -0500
Received: (qmail 27262 invoked by uid 111); 11 Feb 2011 19:03:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 11 Feb 2011 19:03:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Feb 2011 14:03:26 -0500
Content-Disposition: inline
In-Reply-To: <201102111240.29746.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166569>

On Fri, Feb 11, 2011 at 12:40:29PM +0100, Johan Herland wrote:

> > I don't know very much about how git really works so what I'm saying
> > may be dumb, but rather than record where a commit came from, would it
> > be reasonable for rebase to look at the patch-id for each change on
> > the topic branch after the merge base and automatically remove topic
> > branch commits that match that patch-id? So in your example, rebase
> > would check each topic branch commit against 3', d, e*, and f and see
> > that the 3' patch-id is the same as the topic branch 3 and remove
> > topic branch 3 before it gets to e*?
> 
> I believe "git rebase" already does exactly what you describe [1].

Yep. It uses format-patch's "--ignore-if-in-upstream", which computes
patch-ids (you can get the same list with "git cherry").

> However, comparing patch-ids stops working when the cherry-pick (3 -> 3') 
> has conflicts. IINM, it is the conflicting cases that John is interested in 
> solving...

Exactly. One other possible solution to this problem would be to somehow
make patch-ids handle fuzzy situations better. I doubt it is possible to
do that without introducing a lot of false positives, though.

-Peff
