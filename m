From: Jeff King <peff@peff.net>
Subject: Re: Support for EBCDIC
Date: Thu, 3 Jul 2014 13:34:13 -0400
Message-ID: <20140703173413.GC20571@sigill.intra.peff.net>
References: <1404355152.86116.YahooMailNeo@web184805.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org   " <git@vger.kernel.org>
To: Scott McKellar <mck9@swbell.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 19:34:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2ktn-0007BS-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 19:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417AbaGCReP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 13:34:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:55599 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbaGCReP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 13:34:15 -0400
Received: (qmail 32262 invoked by uid 102); 3 Jul 2014 17:34:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jul 2014 12:34:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2014 13:34:13 -0400
Content-Disposition: inline
In-Reply-To: <1404355152.86116.YahooMailNeo@web184805.mail.gq1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252871>

On Wed, Jul 02, 2014 at 07:39:12PM -0700, Scott McKellar wrote:

> Is Git supposed to be usable in an environment where the execution character set is EBCDIC?

Not really.

In addition to the cases you found (and I would be surprised if there
are not more, such as our reimplementation of ctype.h), we assume:

  - we can intermingle ASCII from string literals with user data to form
    diffs, commit objects, network protocols, etc. This is actually a
    problem not just for EBCDIC, but for any encoding which is not an
    ASCII-superset (like UTF-16).

  - many outputs from git should be ASCII in order to interoperate with
    the outside world (object headers, network protocols, etc).

So I'd be surprised if things worked well in an EBCDIC environment (but
I have never worked with one, so maybe I do not understand all of the
implications).

-Peff
