From: Jeff King <peff@peff.net>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 3 Aug 2011 19:41:43 -0600
Message-ID: <20110804014143.GA32579@sigill.intra.peff.net>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 03:42:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qomwj-0004YR-AV
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 03:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab1HDBlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 21:41:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab1HDBlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 21:41:46 -0400
Received: (qmail 12683 invoked by uid 107); 4 Aug 2011 01:42:19 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 21:42:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 19:41:43 -0600
Content-Disposition: inline
In-Reply-To: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178649>

On Wed, Aug 03, 2011 at 11:17:59PM +0100, Hin-Tak Leung wrote:

> The summary of the problem is that, git-archive's "--format=tar"
> option really write the pax format most of the time, and some
> cross-platform archive extraction library (rather than the
> all-powerful GNU tar) really does not think that's the tar format and
> bail out.

Out of curiosity, what is the library? Putting pax headers into ustar
format has been standardized in POSIX since 2001.

> Is it possible to (1) add a warning in the man-page, or (2) actually
> fix the problem in git-archive ( archive-tar.c ) to generate more
> conformant archive packages?

That header contains useful information (the commit id from which the
archive was generated). And there is a way to turn it off: give a tree
id instead of a commit id. There is an example in the git-archive
manpage that does exactly this already. Look for the example mentioning
"pax header" here:

  http://www.kernel.org/pub/software/scm/git/docs/git-archive.html

It might be a bit more obvious to find if we actually had a
--no-pax-header option, though.

-Peff
