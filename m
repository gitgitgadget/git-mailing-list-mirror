From: Jeff King <peff@peff.net>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 00:12:48 -0400
Message-ID: <20100410041247.GB11977@coredump.intra.peff.net>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0S4L-0007yf-04
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab0DJENM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:13:12 -0400
Received: from peff.net ([208.65.91.99]:46239 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab0DJENL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:13:11 -0400
Received: (qmail 13306 invoked by uid 107); 10 Apr 2010 04:13:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 00:13:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 00:12:48 -0400
Content-Disposition: inline
In-Reply-To: <20100409190601.47B37475FEF@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144499>

On Fri, Apr 09, 2010 at 03:06:01PM -0400, Eric Raymond wrote:

> A format properly designed for script parseability should use even use
> whitespace as a field separator.
> 
> Why?
> 
> Because if you do that, front ends *will* do field analysis using a
> naive split-on-whitespace operation.  And then...someday...someone
> will try to run one of these of these on a volume from a system where
> filenames contain embedded whitespace.  Like Mac OS X or Windows.

Yes, that is why almost every scriptable git interface supports a "-z"
variant with NUL termination.

> Conclusion: As it is presently, git status --porcelain format is
> irretrievably botched.  You need a field separator that's musch less
> likely to land in a filename, like '|' - and to warn in the documentation
> that careful front ends must check for and ignore '\|'.

We already quote correctly, so it is only sloppy parsers that will be in
trouble. Yes, space is more common than "|", but sloppy is sloppy. Parse
it right, or use "-z".

-Peff
