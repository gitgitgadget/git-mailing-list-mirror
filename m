From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Better control of the tests run by a test suite
Date: Mon, 24 Mar 2014 19:03:05 -0400
Message-ID: <20140324230304.GC17080@sigill.intra.peff.net>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:03:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSDth-0001y7-UH
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 00:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbaCXXDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 19:03:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:46237 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbaCXXDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 19:03:07 -0400
Received: (qmail 13842 invoked by uid 102); 24 Mar 2014 23:03:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 18:03:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 19:03:05 -0400
Content-Disposition: inline
In-Reply-To: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244897>

On Mon, Mar 24, 2014 at 01:49:44AM -0700, Ilya Bobyr wrote:

> Here are some examples of how functionality added by the patch
> could be used.  In order to run setup tests and then only a
> specific test (use case 1) one can do:
> 
>     $ ./t0000-init.sh --run='1 2 25'
> 
> or:
> 
>     $ ./t0000-init.sh --run='<3 25'
> 
> ('<=' is also supported, as well as '>' and '>=').

I don't have anything against this in principle, but I suspect it will
end up being a big pain to figure out which of the early tests are
required to set up the state, and which are not. Having "<" makes
specifying it easier, but you still have to read the test script to
figure out which tests need to be run.

I wonder if it would make sense to "auto-select" tests that match a
regex like "set.?up|create"? A while ago, Jonathan made a claim that
this would cover most tests that are dependencies of other tests. I did
not believe him, but looking into it, I recall that we did seem to have
quite a few matching that pattern. If there were a good feature like
this that gave us a reason to follow that pattern, I think people might
fix the remainder

-Peff
