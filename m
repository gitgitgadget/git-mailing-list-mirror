From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl: fall back to Basic auth if Negotiate fails.
Date: Sat, 27 Dec 2014 16:29:49 -0500
Message-ID: <20141227212948.GA30098@peff.net>
References: <FBFEB910-4CB8-4049-901C-AADBFAB3AE9E@cisco.com>
 <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <20141227175604.GA23732@peff.net>
 <20141227210935.GA10649@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 22:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4yw5-0005aM-FA
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 22:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbaL0V3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 16:29:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:57380 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751702AbaL0V3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 16:29:51 -0500
Received: (qmail 18939 invoked by uid 102); 27 Dec 2014 21:29:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Dec 2014 15:29:51 -0600
Received: (qmail 21997 invoked by uid 107); 27 Dec 2014 21:30:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Dec 2014 16:30:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Dec 2014 16:29:49 -0500
Content-Disposition: inline
In-Reply-To: <20141227210935.GA10649@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261841>

On Sat, Dec 27, 2014 at 09:09:36PM +0000, brian m. carlson wrote:

> > I'm not familiar enough with Negotiate auth to do give a thorough review
> > on the logic above. But FWIW, it makes sense to me, and the code looks
> > correct.
> 
> libcurl will try very hard to use something other than Basic auth, even
> over HTTPS.  If Basic and something else are offered, libcurl will never
> use Basic.  I should probably make a note of that in the commit message.

Thanks, that does help explain things (to me, anyway).

The thing I am not sure of in your explanation is:

>>> since if they failed the first time, they will never succeed

Are there other GSSAPI methods where this is not the case? I don't know
of any, and AFAICT git's support is used only for Kerberos, so this is
probably safe for now. If somebody can produce a concrete case that
behaves differently, we can untangle it then.

-Peff
