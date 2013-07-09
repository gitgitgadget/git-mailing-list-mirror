From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the
 incoming object to commit first
Date: Tue, 9 Jul 2013 01:35:33 -0400
Message-ID: <20130709053533.GA4395@sigill.intra.peff.net>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
 <1373236424-25617-5-git-send-email-gitster@pobox.com>
 <20130709050615.GF27903@sigill.intra.peff.net>
 <7va9lwxpp5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 07:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQaS-00072y-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab3GIFfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:35:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:35741 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab3GIFfg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:35:36 -0400
Received: (qmail 4850 invoked by uid 102); 9 Jul 2013 05:36:52 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 00:36:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 01:35:33 -0400
Content-Disposition: inline
In-Reply-To: <7va9lwxpp5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229913>

On Mon, Jul 08, 2013 at 10:33:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   1. Behave more or less the same between "git name-rev $sha1" and "echo
> >      $sha1 | git name-rev --stdin". Your patch improves that. Though I
> >      note that --peel-to-commit does not affect --stdin at all. Should
> >      it? And of course the two differ in that the command line will take
> >      any rev-parse expression, and --stdin only looks for full sha1s.
> 
> To "Should it?", I do not deeply care.  "--peel-to-commit" is an
> exception that only is needed to support "describe".
> 
> I could instead have tucked "^0" at the end of each argument when
> "describe" calls out to "name-rev" without adding this new option,
> which is much much closer to what is really going on.

Yeah, I tend to think that is a more sane interface, even though it is a
little more work in git-describe.

Although I am still not clear on why it would not be up to the caller of
git-describe in the first place to decide which they wanted.

-Peff
