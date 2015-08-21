From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 15:51:35 -0400
Message-ID: <20150821195135.GA26720@sigill.intra.peff.net>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
 <1440121237-24576-2-git-send-email-sbeller@google.com>
 <xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
 <20150821194454.GB26466@sigill.intra.peff.net>
 <CAGZ79kYM6m-Me=okbxMAY_NKDm40JwfgRutwTzYfT5=ez42=jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsLn-0001mX-IA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbbHUTvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:51:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:48343 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752700AbbHUTvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:51:38 -0400
Received: (qmail 17562 invoked by uid 102); 21 Aug 2015 19:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 14:51:38 -0500
Received: (qmail 4306 invoked by uid 107); 21 Aug 2015 19:51:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 15:51:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 15:51:35 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYM6m-Me=okbxMAY_NKDm40JwfgRutwTzYfT5=ez42=jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276326>

On Fri, Aug 21, 2015 at 12:48:23PM -0700, Stefan Beller wrote:

> > Before even looking at the implementation, my first question would be
> > whether this pattern is applicable in several places in git (i.e., is it
> > worth the extra complexity of abstracting out in the first place). I
> > think there are a few task-queue patterns already in git; for example
> > the delta search in pack-objects. Is the interface given here sufficient
> > to convert pack-objects? Is the result nicer to read? Is it as
> > efficient?
> >
> > We do not need to convert all possible call-sites to the new abstracted
> > code at once. But I find that converting at least _one_ is a good litmus
> > test to confirm that a new interface is generally useful.
> 
> Ok, I'll head off to convert one place.

Thanks. By the way, reading over what I wrote, it sounds a little
harsher than I meant. It is not "if you do not convert an existing site,
we cannot accept a new interface, period". But I would like at least
some explanation as an alternative, like "I'm pretty sure we can convert
site X to this, but it is not a good time to do so now because of Y".
Where "Y" might be "we need to do this other refactoring work first", or
"it would be disruptive to other work in the area".

-Peff
