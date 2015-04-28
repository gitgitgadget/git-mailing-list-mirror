From: Jeff King <peff@peff.net>
Subject: Re: curl
Date: Tue, 28 Apr 2015 00:57:32 -0400
Message-ID: <20150428045732.GD24580@peff.net>
References: <CACnwZYc8VvQ4mh3pbVcd06uc6YZOXnrGOEpTu19qacBy8v_Y8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 06:57:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmxaX-0007WS-8X
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 06:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbD1E5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 00:57:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:50949 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750964AbbD1E5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 00:57:35 -0400
Received: (qmail 16850 invoked by uid 102); 28 Apr 2015 04:57:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 23:57:35 -0500
Received: (qmail 11383 invoked by uid 107); 28 Apr 2015 04:58:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:58:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 00:57:32 -0400
Content-Disposition: inline
In-Reply-To: <CACnwZYc8VvQ4mh3pbVcd06uc6YZOXnrGOEpTu19qacBy8v_Y8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267893>

On Mon, Apr 27, 2015 at 11:49:51PM -0300, Thiago Farina wrote:

> Is it right that git uses libcurl to download while libgit2 does without it?

I'm not sure if you mean "right" as in "this statement is true" or as in
"is this a good thing that it is the case".

For the former, yes, libgit2 does not use curl.  On Windows, it can use
the native http calls (which do nice things like using the system proxy
and auth systems). On Unix, I think it is a combination of hand-rolled
code, openssl, and an imported http parser (from nginx).

Whether that is a good idea or not, I can't comment too much. From what
I have seen discussed in libgit2 issues, the stock http transport is
meant to be bare-bones (but with minimal dependencies). But it could
co-exist with a curl transport (just as it does with the WinHTTP
transport).  Maybe Carlos (cc'd) can say more.

-Peff
