From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 4 Feb 2013 15:59:11 -0500
Message-ID: <20130204205911.GA13186@sigill.intra.peff.net>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <xa1tmwvk9gy1.fsf@mina86.com>
 <878v74vwst.fsf@lifelogs.com>
 <20130204201040.GA13272@sigill.intra.peff.net>
 <87a9rju8l7.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2T8c-00029g-0k
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 21:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab3BDU7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 15:59:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60637 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab3BDU7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 15:59:14 -0500
Received: (qmail 22249 invoked by uid 107); 4 Feb 2013 21:00:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 16:00:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 15:59:11 -0500
Content-Disposition: inline
In-Reply-To: <87a9rju8l7.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215419>

On Mon, Feb 04, 2013 at 03:28:52PM -0500, Ted Zlatanov wrote:

> JK> You might want to map this to "port" in .autoinfo separately if it's
> JK> available.
> 
> That would create the following possibilities:
> 
> * host example.com:31337, protocol https
> * host example.com:31337, protocol unspecified
> * host example.com, protocol https
> * host example.com, protocol unspecified

Possibilities for .netrc, or for git? Git will always specify the
protocol.

> How would you like each one to be handled?  My preference would be to
> make the user say "host example.com:31337" in the netrc file (the
> current situation); that's what we do in Emacs and it lets applications
> request credentials for a logical service no matter what the port is.
> 
> It means that example.com credentials won't be used for
> example.com:31337.  In practice, that has not been a problem for us.

Yeah, I think that is a good thing. The credentials used for
example.com:31337 are not necessarily the same as for the main site.
It's less convenient, but a more secure default.

What I was more wondering (and I know very little about .netrc, so this
might not be a possibility at all) is a line like:

  host example.com port 5001 protocol https username foo password bar

To match git's representation on a token-by-token basis, you would have
to either split out git's "host:port" pair, or combine the .netrc's
representation to "example.com:5001".

-Peff
