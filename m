From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Sun, 1 Nov 2015 20:51:58 -0500
Message-ID: <20151102015157.GA25597@sigill.intra.peff.net>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
 <20151031000837.GA25849@sigill.intra.peff.net>
 <alpine.DEB.2.11.1511012359150.24283@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Nov 02 02:52:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt4I2-00081F-UY
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 02:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbbKBBwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 20:52:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:51344 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751076AbbKBBwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 20:52:00 -0500
Received: (qmail 12180 invoked by uid 102); 2 Nov 2015 01:52:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Nov 2015 19:52:00 -0600
Received: (qmail 10598 invoked by uid 107); 2 Nov 2015 01:52:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Nov 2015 20:52:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Nov 2015 20:51:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1511012359150.24283@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280677>

On Mon, Nov 02, 2015 at 12:00:42AM +0100, Daniel Stenberg wrote:

> On Fri, 30 Oct 2015, Jeff King wrote:
> 
> >The goal makes sense. Why weren't we using CURLOPT_RANGE before? Did it
> >not exist (or otherwise have limitations) in 2005, and if so, when did it
> >become usable? Do we need to protect this with an #ifdef for the curl
> >version?
> 
> CURLOPT_RANGE existed already in the first libcurl release: version 7.1,
> relased in August 2000.

Ah, thanks. I guess we don't have to worry about that, then.

While I have your attention, Daniel, am I correct in assuming that
performing a second unrelated request with the same CURL object will
need an explicit:

  curl_easy_setopt(curl, CURLOPT_RANGE, NULL);

to avoid using the range twice?

-Peff
