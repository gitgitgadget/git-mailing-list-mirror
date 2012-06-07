From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1304: improve setfacl prerequisite setup
Date: Thu, 7 Jun 2012 05:02:00 -0400
Message-ID: <20120607090200.GA6087@sigill.intra.peff.net>
References: <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
 <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
 <20120606132824.GA2597@sigill.intra.peff.net>
 <7vvcj4ml6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 11:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScYbd-00026m-VR
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 11:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759228Ab2FGJCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 05:02:09 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:46316
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273Ab2FGJCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 05:02:07 -0400
Received: (qmail 12793 invoked by uid 107); 7 Jun 2012 09:02:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jun 2012 05:02:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jun 2012 05:02:00 -0400
Content-Disposition: inline
In-Reply-To: <7vvcj4ml6a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199383>

On Wed, Jun 06, 2012 at 09:58:53AM -0700, Junio C Hamano wrote:

> > +test_expect_success 'checking for a working acl setup' '
> > +	if setfacl -m d:m:rwx -m u:root:rwx . &&
> > +	   getfacl . | grep user:root:rwx &&
> > +	   touch should-have-readable-acl &&
> > +	   getfacl should-have-readable-acl | egrep "mask::?rw-"
> 
> At this point of the test, I do not think there is anything that can
> cause this check to be fooled by a user whose name is 'mask', but
> please make it a habit to anchor the pattern at the left.  The tests
> done in check_perms_and_acl do risk getting fooled by a user whose
> name is 'mask', and need to be updated, I think, but that is a
> separate issue.

I intentionally did not anchor it because the tests themselves did not,
and I worried that that there was some subtle portability issue there
(especially because of the magic "let there be two colons" part of the
pattern).

If it was just sloppiness in the original test, then yes, they should
all be fixed.

-Peff
