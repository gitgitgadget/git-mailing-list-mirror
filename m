From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Thu, 15 Mar 2012 09:26:43 -0400
Message-ID: <20120315132642.GA8945@sigill.intra.peff.net>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
 <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
 <20120315035405.GA4149@sigill.intra.peff.net>
 <7vk42ml5er.fsf@alter.siamese.dyndns.org>
 <20120315132428.GB8467@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 14:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Ahd-0004lp-U1
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 14:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab2CON0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 09:26:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49871
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab2CON0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 09:26:45 -0400
Received: (qmail 21756 invoked by uid 107); 15 Mar 2012 13:26:57 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Mar 2012 09:26:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2012 09:26:43 -0400
Content-Disposition: inline
In-Reply-To: <20120315132428.GB8467@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193215>

On Thu, Mar 15, 2012 at 09:24:28AM -0400, Jeff King wrote:

> > >> 	make GIT_TEST_CREDENTIAL_HELPER=cache T=t0303-*.sh prove
> > >> 
> > >> seems to get stuck forever.
> > >
> > > It's because t0303 is the generic "test any helper" script, and does not
> > > know how to clean up the credential-cache daemon. So the daemon sticks
> > > around, holding onto a file descriptor that causes prove to hang.
> > 
> > And the reason why "sh t0303-*.sh" version does not have this problem is...?
> [long-winded explanation from me]

Oops. I read this as "why does t0301 not have the problem?". So ignore
everything I said.

The reason why running it via sh works is that we leave the daemon
running in both cases, but only prove actually cares about the leaked
file descriptor and blocks.

-Peff
