From: Jeff King <peff@peff.net>
Subject: Re: rsync busy non-bare git repo 'source' to quiet
Date: Tue, 8 Mar 2011 17:38:41 -0500
Message-ID: <20110308223841.GA6648@sigill.intra.peff.net>
References: <il66rd$46u$1@dough.gmane.org>
 <20110308213959.GB5786@sigill.intra.peff.net>
 <4D76ABB1.9080001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5YF-0007qB-CZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab1CHWim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:38:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55561
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab1CHWil (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:38:41 -0500
Received: (qmail 5620 invoked by uid 107); 8 Mar 2011 22:39:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 17:39:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 17:38:41 -0500
Content-Disposition: inline
In-Reply-To: <4D76ABB1.9080001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168713>

On Tue, Mar 08, 2011 at 04:20:33PM -0600, Neal Kreitzinger wrote:

> Rsync seems like a simpler solution and more accurate solution for
> creating a copy of an ecosystem of interrelated git repos colocated on
> the same box.

Sure. It is simpler, but not atomic unless you do a multi-stage rsync.

> A previous post in the newsgroup states:
> > If you want your rsync backup to be fine, you need to follow some
> >ordering.  You need to copy the refs first (.git/packed-refs and
> >.git/refs/), then the loose objects (.git/objects/??/*), and then all
> >the rest.  If files are copied in a different order while some write
> >operations are performed on the source repository then you may end up
> >with an incoherent repository."
> 
> Would that work?

If you do it in that order, the end result will be a consistent repo.
But during the copy, the refs at the destination will point to objects
you don't have. I don't know if that matters for your case.

-Peff
