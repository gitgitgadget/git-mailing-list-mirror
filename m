From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 17:16:59 -0400
Message-ID: <20130919211659.GB16556@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <20130911191620.GB24251@sigill.intra.peff.net>
 <CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
 <CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
 <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 23:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMlb8-00060M-3c
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3ISVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 17:17:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:38488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3ISVRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 17:17:09 -0400
Received: (qmail 5232 invoked by uid 102); 19 Sep 2013 21:17:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 16:17:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 17:16:59 -0400
Content-Disposition: inline
In-Reply-To: <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235031>

On Thu, Sep 19, 2013 at 11:47:51AM +0200, Piotr Krukowiecki wrote:

> >> > it still ends up as a single function call). The downside is that it has
> >> > to be remembered at each site that uses strcasecmp, but we do not use
> >> > pointers to standard library functions very often.
> >>
> >> Is it possible to add a test which fails if wrapper is not used?
> >
> > No test needed for this, as compilation or linkage will fail, I think.
> 
> But only when someone compiles on MinGW, no?

Yeah. I think a more clear way to phrase the question would be: is there
some trick we can use to booby-trap strcasecmp as a function pointer so
that it fails to compile even on systems where it would otherwise work?

I can't think off-hand of a way to do so using preprocessor tricks, and
even if we could, I suspect the result would end up quite ugly. It's
probably enough to just catch such problems in review, or let people on
affected systems report and fix the error if it slips through.

-Peff
