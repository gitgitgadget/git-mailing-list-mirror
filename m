From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Sat, 3 Jan 2015 15:14:44 -0500
Message-ID: <20150103201444.GA8285@peff.net>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <20150103111922.GB27793@peff.net>
 <20150103174509.GA1025060@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 21:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7V64-0002Gp-Pv
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 21:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbbACUOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 15:14:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:58598 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751326AbbACUOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 15:14:47 -0500
Received: (qmail 17966 invoked by uid 102); 3 Jan 2015 20:14:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Jan 2015 14:14:47 -0600
Received: (qmail 22659 invoked by uid 107); 3 Jan 2015 20:15:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Jan 2015 15:15:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Jan 2015 15:14:44 -0500
Content-Disposition: inline
In-Reply-To: <20150103174509.GA1025060@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261999>

On Sat, Jan 03, 2015 at 05:45:09PM +0000, brian m. carlson wrote:

> >+	{
> >+		int flags = CURLAUTH_ANY;
> 
> I think this needs to be unsigned long or it can cause undefined behavior,
> since libcurl uses unsigned long in the flags.  I'll fix that up when I
> reroll.  I'll need your sign-off since it will essentially be your work.

I think curl typically uses signed "long" for flags, but certainly
check the docs to be sure.

I was thinking it would be integer-promoted in this case, but I'm not
sure that works always (certainly it does not if CURLAUTH_ANY needs high
bits, but depending on how curl_easy_setopt is implemented, it may also
be implicitly cast as a pointer or something).

And certainly you can have my signoff:

  Signed-off-by: Jeff King <peff@peff.net>

-Peff
