From: Jeff King <peff@peff.net>
Subject: Re: bug (?) in send email
Date: Mon, 30 Jul 2012 12:34:40 -0400
Message-ID: <20120730163440.GC16701@sigill.intra.peff.net>
References: <50145A90.1090904@web.de>
 <50166408.8000008@web.de>
 <873949mnx0.fsf@thomas.inf.ethz.ch>
 <7vpq7ds1hu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Christoph Miebach <christoph.miebach@web.de>,
	git@vger.kernel.org,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svsvg-0003qC-9j
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab2G3Qen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:34:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41478 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631Ab2G3Qen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:34:43 -0400
Received: (qmail 17198 invoked by uid 107); 30 Jul 2012 16:34:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jul 2012 12:34:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2012 12:34:40 -0400
Content-Disposition: inline
In-Reply-To: <7vpq7ds1hu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202574>

On Mon, Jul 30, 2012 at 08:38:21AM -0700, Junio C Hamano wrote:

> > I think this patch would be a better match for what RFC2047 specifies.
> > On the one hand it avoids substituting _ outside of encodings, but OTOH
> > it also handles more than one encoded-word.
> 
> Yeah, I think it is an improvement.
> 
> I however wonder if the captured pattern for $2 should be minimized
> with ? at the end, i.e. "..\?q\?(.*?)\?="?

Yeah, definitely. "?=" cannot appear inside (it would need to be
quoted).

> > It still does not handle
> > the case where there are several encoded-words of *different* encodings,
> > but who would do such a crazy thing?
> 
> Even if somebody did so, it wouldn't have worked, and to make it
> work, the sub and its caller (there is only one caller that actually
> cares what the original encoding was) needs to be rethought anyway,
> so I do not think it matters.
> 
> It may deserve an in-code NEEDSWORK comment, though.

I rambled about this in much more detail in another reply, but the gist
of it is that yes, that is the right step for now.

-Peff
