From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 2 Nov 2015 16:53:24 -0500
Message-ID: <20151102215324.GA13765@sigill.intra.peff.net>
References: <1446500398-12257-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 22:53:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtN2h-0000Se-8O
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 22:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbbKBVx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 16:53:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:51686 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750750AbbKBVx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 16:53:27 -0500
Received: (qmail 17841 invoked by uid 102); 2 Nov 2015 21:53:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 15:53:26 -0600
Received: (qmail 17595 invoked by uid 107); 2 Nov 2015 21:53:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 16:53:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Nov 2015 16:53:24 -0500
Content-Disposition: inline
In-Reply-To: <1446500398-12257-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280726>

On Mon, Nov 02, 2015 at 04:39:58PM -0500, David Turner wrote:

> A HTTP server is permitted to return a non-range response to a HTTP
> range request (and Apache httpd in fact does this in some cases).
> While libcurl knows how to correctly handle this (by skipping bytes
> before and after the requested range), it only turns on this handling
> if it is aware that a range request is being made.  By manually
> setting the range header instead of using CURLOPT_RANGE, we were
> hiding the fact that this was a range request from libcurl.  This
> could cause corruption.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> 
> This one incorporates Jeff's suggestions about off_t.  It also
> simplifies by removing the possiblity of a missing low-end of a range;
> the entire point of this function is to add a range HEADER and a
> range of - is nugatory.

Thanks, looks good to me. And I learned a new vocabulary word. :)

-Peff
