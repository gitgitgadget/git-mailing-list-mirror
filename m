From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Thu, 28 Apr 2016 14:05:31 -0400
Message-ID: <20160428180531.GA578@sigill.intra.peff.net>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
 <20160428115748.37177-2-gitter.spiros@gmail.com>
 <CAGZ79kYe-WsAJj3xkr9YkHZbHqQ9rhKV80+K0Bx3SZsB85+tHA@mail.gmail.com>
 <20160428174423.GA32486@sigill.intra.peff.net>
 <CAGZ79kaqDa5Bo2EQ-1VO6H5UpLun7emWPTmgoBAEeNaWJBaEnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 20:05:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avqJm-0005rj-S8
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 20:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbcD1SFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 14:05:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:58641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750847AbcD1SFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 14:05:34 -0400
Received: (qmail 6832 invoked by uid 102); 28 Apr 2016 18:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 14:05:33 -0400
Received: (qmail 12951 invoked by uid 107); 28 Apr 2016 18:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 14:05:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 14:05:31 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kaqDa5Bo2EQ-1VO6H5UpLun7emWPTmgoBAEeNaWJBaEnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292932>

On Thu, Apr 28, 2016 at 10:48:38AM -0700, Stefan Beller wrote:

> >> How does it overwrite the GIT_CURL_VERBOSE variable?
> >
> > You can't use both, as they are both triggered using the CURLOPT_VERBOSE
> > option of curl. The main difference is that with GIT_CURL_VERBOSE, we
> > rely on curl to print the information to stderr. With GIT_CURL_TRACE, we
> > do the printing ourselves (so we can tweak the output format, send it to
> > places other than stderr, etc).
> 
> Well that's the information I'd rather find in the documentation
> than in a mailing list archive ;)

Sure, but I'm not sure what of part of that you want to put in the
documentation.  I was just explaining why the implementation constrains
us to overriding, and there really aren't any other sane options.

I don't think we want to get into defining the exact set of information,
which is not up to us anyway. We're just relaying whatever curl gives
us.

IMHO, we do not even need to mention GIT_CURL_VERBOSE here at all. That
is an undocumented interface that can hopefully just be forgotten over
time.

> > So I think we should consider GIT_CURL_VERBOSE deprecated (though I do
> > not mind keeping it for old-timers since it is literally one line of
> > code).
> 
> I see, so by this patch there is no need to document
> GIT_CURL_VERBOSE any more?

Exactly.

-Peff
