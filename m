From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Wed, 13 Mar 2013 00:08:45 -0400
Message-ID: <20130313040845.GA5057@sigill.intra.peff.net>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <1362786889-28688-2-git-send-email-gitster@pobox.com>
 <vpqmwubgsqy.fsf@grenoble-inp.fr>
 <20130312112840.GA13186@sigill.intra.peff.net>
 <vpqhakgiusr.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 13 05:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFd0G-0004Wa-AG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 05:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab3CMEIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 00:08:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50493 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab3CMEIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 00:08:49 -0400
Received: (qmail 1393 invoked by uid 107); 13 Mar 2013 04:10:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Mar 2013 00:10:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2013 00:08:45 -0400
Content-Disposition: inline
In-Reply-To: <vpqhakgiusr.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218029>

On Tue, Mar 12, 2013 at 02:58:44PM +0100, Matthieu Moy wrote:

> > I guess we already rejected the idea of being able to shut off the
> > warning and just get the new behavior, in favor of having people
> > specify it manually each time?
> 
> Somehow, but we may find a way to do so, as long as it temporary (i.e.
> something that will have no effect after the transition period), and
> that is is crystal clear that it's temporary.

Yeah, I think this is easy as long as it is "enable the new behavior
now" and not "toggle between new and old behavior". That is, a boolean
rather than a selector, with a note that it will go away at the behavior
switch.

The only downside I see is that a user may switch it on now, saying
"Yes, I understand and prefer the new behavior", but some script they
run might not expect it. We can warn against that in the documentation,
but that may or may not be enough.

Here's a series which does that; if it's the direction we want to go, I
think we'd want to rebase Junio's "now add -u is full-tree" patch on
top.

  [1/2]: t2200: check that "add -u" limits itself to subdirectory
  [2/2]: add: respect add.updateroot config option

-Peff
