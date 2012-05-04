From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 4 May 2012 12:05:43 -0400
Message-ID: <20120504160543.GB1331@sigill.intra.peff.net>
References: <4FA2B4D3.90809@seap.minhap.es>
 <20120504070802.GA21895@sigill.intra.peff.net>
 <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr>
 <20120504073913.GA22388@sigill.intra.peff.net>
 <7v4nrwc61e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 18:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQL0w-000547-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942Ab2EDQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 12:05:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57987
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2EDQFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 12:05:45 -0400
Received: (qmail 22794 invoked by uid 107); 4 May 2012 16:06:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 12:06:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 12:05:43 -0400
Content-Disposition: inline
In-Reply-To: <7v4nrwc61e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197033>

On Fri, May 04, 2012 at 08:36:13AM -0700, Junio C Hamano wrote:

> Thanks for a nice summary, and I agree with your list of what we wish we
> had from the cURL library.  With such a change, it becomes irrelevant how
> the user fed cURL provisional (partial) authentication information, either
> in http.proxy (which we turn into CURLOPT_PROXY), or from the environment
> (without Git having to know anything about it), and a lot of complexity
> that led to bugs in this series will become unnecessary.
> 
> I am tempted to suggest that the current series should be rerolled without
> all the guessing and preauth tricks until such an update to the cURL
> library materializes.

I am very tempted by that, too. In the meantime (and even once that curl
version comes out and we write the new code, people will still be on the
older version of curl), we have a fallback: they can use http.proxy if
they want auth support. It's not as nice as supporting auth on the
environment variables, but I think it will end up being a lot cleaner.

-Peff
