From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] remote-curl: verify smart-http metadata lines
Date: Mon, 18 Feb 2013 03:59:36 -0500
Message-ID: <20130218085936.GA17003@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064707.GB22626@sigill.intra.peff.net>
 <20130217104939.GE6759@elie.Belkin>
 <20130217191422.GA25096@sigill.intra.peff.net>
 <20130218005443.GB3221@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:00:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7MZv-0000Js-QU
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab3BRI7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 03:59:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51637 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3BRI7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 03:59:39 -0500
Received: (qmail 17435 invoked by uid 107); 18 Feb 2013 09:01:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:01:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 03:59:36 -0500
Content-Disposition: inline
In-Reply-To: <20130218005443.GB3221@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216444>

On Sun, Feb 17, 2013 at 04:54:43PM -0800, Jonathan Nieder wrote:

> > My intent was that it followed the error convention of "negative is
> > error, 0 is success, and positive is not used, but reserved for
> > future use".
> 
> From a maintainability perspective, that kind of contract would be
> dangerous, since some *other* caller could arrive and use the function
> without a "< 0" without knowing it is doing anything wrong.  When new
> return values appear, the function should be renamed to help the patch
> author and reviewers remember to check all callers.

True. That's why I always write "< 0". :)

> That is, from the point of view of maintainability, there is no
> distinction between "if (read_packets_until_... < 0)" and
> "if (read_packets_until_...)" and either form is fine.
> 
> My comment was just to say the "< 0" forced me to pause a moment and
> check out the implementation.  This is basically a stylistic thing and
> if you prefer to keep the "< 0", that's fine with me.

Interesting. To me, "foo() < 0" just reads idiomatically as "error-check
the foo call".

Anyway, I've redone the patch series to just re-use get_remote_heads,
which is more robust. So this function has gone away in the new version.

-Peff
