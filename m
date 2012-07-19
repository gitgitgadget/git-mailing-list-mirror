From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Thu, 19 Jul 2012 13:25:50 -0400
Message-ID: <20120719172550.GA12883@sigill.intra.peff.net>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <20120717034640.GB20945@sigill.intra.peff.net>
 <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
 <20120718072104.GB12942@sigill.intra.peff.net>
 <7vhat4wv6h.fsf@alter.siamese.dyndns.org>
 <20120719113535.GA29774@sigill.intra.peff.net>
 <7vr4s7vfal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:32:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sruad-0006fq-4p
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab2GSRce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:32:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55499 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab2GSRcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:32:33 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2012 13:32:32 EDT
Received: (qmail 1396 invoked by uid 107); 19 Jul 2012 17:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 13:25:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 13:25:50 -0400
Content-Disposition: inline
In-Reply-To: <7vr4s7vfal.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201746>

On Thu, Jul 19, 2012 at 10:20:18AM -0700, Junio C Hamano wrote:

> > So for plumbing, I think this is the wrong direction, anyway. The real
> > value of this patch is that the pretty-printed code path would work more
> > like git-log (especially the "%N" format, which lets callers make their
> > own micro-format for specifying all the bits they are interested in).
> 
> Yeah, but at that point the obvious question becomes "why you aren't
> using 'git log' in the first place".

I dunno. I guess there are other plumbing-like behaviors of rev-list
that you would want, but the only ones I can think of are diff options,
which rev-list does not handle at all.

> > Maybe the best thing is to simply disallow --notes when not using a
> > pretty-printed format.
> 
> Yeah, or simply ignore it.

I'd rather generate an error to make it more obvious what is happening
(and it is not that we are somehow failing to find any notes). And it
might help prevent the later question of: why does "git rev-list
--oneline --notes" show notes, but "git rev-list --notes" silently
ignores it? 

-Peff
