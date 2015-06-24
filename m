From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Wed, 24 Jun 2015 03:55:14 -0400
Message-ID: <20150624075514.GB827@peff.net>
References: <20150623105042.GA10888@peff.net>
 <20150623105411.GB12518@peff.net>
 <1435095074.28466.74.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 09:55:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7fWl-0006bv-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 09:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbbFXHzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 03:55:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:50851 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751214AbbFXHzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 03:55:17 -0400
Received: (qmail 2589 invoked by uid 102); 24 Jun 2015 07:55:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 02:55:17 -0500
Received: (qmail 25541 invoked by uid 107); 24 Jun 2015 07:55:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 03:55:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jun 2015 03:55:14 -0400
Content-Disposition: inline
In-Reply-To: <1435095074.28466.74.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272538>

On Tue, Jun 23, 2015 at 05:31:14PM -0400, David Turner wrote:

> On Tue, 2015-06-23 at 06:54 -0400, Jeff King wrote:
> > +	mkconfig 1 preciousObjects >.git/config &&
> 
> nit: I think it's better to use git config rather than manually writing
> config files.  git config is more future-proof if we up switching config
> backends; it's also more composable with other configs (making this test
> easier to copy and manipulate), and more explicit.

I would have preferred that, but it makes the tests very fragile. You
are depending on "git config" running even when the current directory is
not a valid git repo (and we walk up to the surround git.git directory
and change the config there!).

I guess we could use "git config -f .git/config", though that is
partially defeating the purpose of your suggestion.

I dunno. I kind of figured we would cross that bridge if and when we
come to it. I imagine you are pretty sensitive to it, though, having
just waded through all the tests that assume various things about
.git/refs. :)

-Peff
