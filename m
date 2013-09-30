From: Jeff King <peff@peff.net>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 19:18:03 -0400
Message-ID: <20130930231803.GA23218@sigill.intra.peff.net>
References: <alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
 <5246C975.1050504@alum.mit.edu>
 <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
 <5247ACB9.40208@alum.mit.edu>
 <52499797.9030100@xiplink.com>
 <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg>
 <5249CDF7.4050904@xiplink.com>
 <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg>
 <5249E9C8.1070700@xiplink.com>
 <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 01 01:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQmjD-0004BA-RT
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 01:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3I3XSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 19:18:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451Ab3I3XSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 19:18:07 -0400
Received: (qmail 12369 invoked by uid 102); 30 Sep 2013 23:18:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Sep 2013 18:18:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Sep 2013 19:18:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235635>

On Mon, Sep 30, 2013 at 06:44:09PM -0400, Nicolas Pitre wrote:

> > Again, I don't think that's the common case.  I think it's just as likely for
> > there to be multiple remotes with duplicate tag names that refer to different
> > objects.
> 
> Why do you say so?  I'm curious to know what kind of work flow would do 
> that in practice.
> 
> At least for typical Linux kernel workflows what I said above is true.

I could image if you are fetching from a bunch of coworkers that several
people might reuse a common name like "start" or "tmp" for different
purposes.

But I think the behavior you've described handles that quite naturally.
If there is one "start", or if they all match, it is unambiguous. If
there are multiple matches, git says "which one did you mean?" and you
can say "bob/start" or "alice/start" to disambiguate. Anything else
would be a guess.

If _you_ have a refs/tags/start, then I think that should unambiguously
take precedence over that of your coworkers. That way your coworkers
cannot pollute the lookup of items in your own namespace.

-Peff
