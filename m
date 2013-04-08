From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 8 Apr 2013 17:11:54 -0400
Message-ID: <20130408211154.GA10310@sigill.intra.peff.net>
References: <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
 <7vtxngyl30.fsf@alter.siamese.dyndns.org>
 <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
 <7vwqscx3l5.fsf@alter.siamese.dyndns.org>
 <CAMP44s0DjJL44uavM44sxgSyrgbTLpUarEPB6=-imvw1rewOOA@mail.gmail.com>
 <7vy5csvih8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:12:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJMD-0000n0-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936035Ab3DHVMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:12:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34285 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935958Ab3DHVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:11:59 -0400
Received: (qmail 15509 invoked by uid 107); 8 Apr 2013 21:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:13:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:11:54 -0400
Content-Disposition: inline
In-Reply-To: <7vy5csvih8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220518>

On Mon, Apr 08, 2013 at 02:08:03PM -0700, Junio C Hamano wrote:

> OK, so you are envisioning that transport-helper would read from the
> helper after importer is done?  If so, perhaps it is a prudent
> solution to disconnect in this version (to fix), and then in a
> separate patch that adds such an extension (I imagine it would
> involve that the helper advertising a capability or being invoked
> with an option to let transport-helper somehow know that it should
> continue the conversation once fast-import is done) to disable the
> disconnect here when that extension is in use?

At this point, I am of the opinion that it's OK to just do nothing;
modern helpers should be using the "done" flag, and if they aren't, then
that is the right place for the fix. Then we don't have to worry about
any side effects of disconnecting, or adding a new capability flag.

-Peff
