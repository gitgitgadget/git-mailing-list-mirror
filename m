From: Jeff King <peff@peff.net>
Subject: Re: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 13:13:07 -0400
Message-ID: <20110620171307.GA5859@sigill.intra.peff.net>
References: <4DFF19C4.5070003@drmicha.warpmail.net>
 <20110620110440.GA29270@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 19:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYi2G-0001gi-C7
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 19:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab1FTRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 13:13:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44978
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab1FTRNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 13:13:11 -0400
Received: (qmail 22483 invoked by uid 107); 20 Jun 2011 17:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 13:13:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 13:13:07 -0400
Content-Disposition: inline
In-Reply-To: <20110620110440.GA29270@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176080>

On Mon, Jun 20, 2011 at 06:04:41AM -0500, Jonathan Nieder wrote:

> Michael J Gruber wrote:
> 
> > echo "a\"b\n\"c"
> > a"b
> > "c
> >
> > t7810.87 breaks with dash because of this. Escaping the \n does not make
> > the test work with both either.
> 
> This seems to have slipped by because testing it requires USE_LIBPCRE
> to be set.  Thanks for catching it.

Yeah, I test with dash, too, and missed it because I hadn't enabled
pcre.

> > So I'd like to know which one's right
> > and (independently) how to make it work for both...
> 
> Both are right.  The simplest fix is to use printf, as in
> 
> 	printf "%s\n" "a\"b\n\"c"
> 
> See [1] and [2].

Yep. We've dealt with this before and used printf as the solution. E.g.:

  938791c (git-rebase--interactive.sh: use printf instead of echo to print commit message, 2010-07-22)
  4d2e283 (git-am: re-fix the diag message printing, 2009-01-18)
  a23bfae (More echo "$user_message" fixes., 2007-05-26)
  4b7cc26 (git-am: use printf instead of echo on user-supplied strings, 2007-05-25)

-Peff
