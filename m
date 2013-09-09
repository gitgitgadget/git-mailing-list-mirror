From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] config: set errno in numeric git_parse_* functions
Date: Mon, 9 Sep 2013 15:53:04 -0400
Message-ID: <20130909195304.GB14021@sigill.intra.peff.net>
References: <20130908082724.GA27184@sigill.intra.peff.net>
 <20130908083642.GC29554@sigill.intra.peff.net>
 <CAPig+cSPf0Cvk4Em71NX-ad46Ub7GysdhKUuqtjRU7fFTKOvSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 21:53:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7WK-0006DX-IH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab3IITxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:53:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:57484 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab3IITxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:53:07 -0400
Received: (qmail 22124 invoked by uid 102); 9 Sep 2013 19:53:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 14:53:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 15:53:04 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSPf0Cvk4Em71NX-ad46Ub7GysdhKUuqtjRU7fFTKOvSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234366>

On Sun, Sep 08, 2013 at 08:36:35PM -0400, Eric Sunshine wrote:

> On Sun, Sep 8, 2013 at 4:36 AM, Jeff King <peff@peff.net> wrote:
> > When we are parsing an integer or unsigned long, we use
> > the strto*max functions, which properly set errno to ERANGE
> > if we get a large value. However, we also do further range
> > checks after applying our multiplication factor, but do not
> > set ERANGE. This means that a caller cannot tell if an error
> > was caused by ERANGE or if the input was simply not a valid
> > number.
> >
> > This patch teaches git_parse_signed and git_parse_unsigned
> > reliably set ERANGE for range errors, and EINVAL for other
> 
> Missing "to": s/reliably/to reliably/
> 
> Or, if you don't like splitting the infinitive:
> 
> s/reliably set ERANGE/to set ERANGE reliably/

Thanks. That is what I get for last-minute tweaking of the commit
message (and I am OK with splitting the infinitive :) ).

-Peff
