From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 17:20:43 -0400
Message-ID: <20120913212043.GB16968@sigill.intra.peff.net>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net>
 <7v627h7hny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGqF-0008WL-LE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab2IMVUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:20:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43794 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2IMVUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:20:46 -0400
Received: (qmail 8254 invoked by uid 107); 13 Sep 2012 21:21:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 17:21:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 17:20:43 -0400
Content-Disposition: inline
In-Reply-To: <7v627h7hny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205428>

On Thu, Sep 13, 2012 at 02:10:41PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect we will end up with people not setting i18n.projectlang, and
> > getting Klingon diffstats on the list.
> 
> Yes, but when our starting point is that the diffstat summary is not
> meant for machine consumption, which I tend to agree, that is a
> logical consequence no matter how you cut it, no?  After all, they
> want to be careless when running format-patch meant for _this_
> project whose project language is C locale, but still want to be
> able to see output that is not meant for machine consumption in
> their native language, and these are incompatible goals.

I do not think they are incompatible if you separate it into three
categories: machine readable (must never be translated), for the current
user right now (current i18n), and for sharing with other humans
(i18n.projectlang).

Whether the maintenance of that three-way split is worthwhile, I don't
know (and that is why I said "in an ideal world..." in my original
mail, and left the implementation for people who care more). In the
meantime, before we have a working i18n.projectlang solution, which slot
should we put those messages in?

I'd argue for putting them in the machine-readable category, because it
is less likely to cause interoperability annoyances (and since git is
not fully translated anyway, we kind of assume at this point that people
know some basic phrases in the C locale).

And of course it is not fool-proof. The "for the current user right now"
messages may bleed into conversation with other people. But that cannot
be helped if we are to do any localization at all, and it does not seem
to be a big problem in practice. The only practical problem so far is
with certain meant-to-be-shared messages.

-Peff
