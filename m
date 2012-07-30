From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 30 Jul 2012 20:38:44 +0000
Message-ID: <20120730203844.GA23892@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:38:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svwjq-0006Fb-2s
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab2G3Uip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:38:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56618 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab2G3Uio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:38:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AD21F449;
	Mon, 30 Jul 2012 20:38:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202612>

"Michael G. Schwern" <schwern@pobox.com> wrote:
> There is one exception.  t9100-git-svn-basic.sh fails 11-13.  This appears
> to be due to a bug in SVN to do with symlinks.  Leave that for somebody
> else, this is the final submission in the series.

That's fine, a few failing tests is better than completely failing.

> The work was difficult because the code relies on simple string equalty
> when comparing URLs and paths.  Turning on canonicalization in one part
> of the code would cause another part to fail if it also did not
> canonicalize.  There's likely still issues.
> 
> A better solution would be to have path and URL objects which overload
> the eq operator and automatically stringify canonicalized and escaped.

Perhaps we can depend on the URI.pm module?  It seems to be
widely-available and not be a significant barrier to installation.  On
the other hand, I don't know its history, either (especially since we're
now dealing with SVN changes...).

Anyways, I don't like relying on operator overloading, it makes code
harder to read and review.
