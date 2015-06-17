From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 15:12:35 -0400
Message-ID: <20150617191235.GB25304@peff.net>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
 <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
 <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5IlP-00011a-DD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbbFQTMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:12:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:47580 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751074AbbFQTMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:12:38 -0400
Received: (qmail 30012 invoked by uid 102); 17 Jun 2015 19:12:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:12:37 -0500
Received: (qmail 28255 invoked by uid 107); 17 Jun 2015 19:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 15:12:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 15:12:35 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271882>

On Wed, Jun 17, 2015 at 10:58:10AM -0700, Stefan Beller wrote:

> > Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
> > happy, we'll have cleaner defect list
> 
> It's down 31 defects, roughly 10% of all things coverity detected as
> problematic.
> YAY!

That's a good thing.  I do find the solution a little gross, though. I
wonder if there is a way we can tell coverity more about how strbuf
works. I've noticed similar problems with string_list, where it
complains that we are touching list->items, which was assigned to NULL
(of course it was, but then after that we did string_list_append!).

I know literally nothing about coverity's annotations and what's
possible with them. So I may be barking up a wrong tree completely.

-Peff
