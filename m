From: Jeff King <peff@peff.net>
Subject: Re: tracking binary files
Date: Wed, 18 Feb 2009 22:52:19 -0500
Message-ID: <20090219035219.GB19862@coredump.intra.peff.net>
References: <20090219031602.GD20416@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzz2-0004se-N3
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBSDwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbZBSDwV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:52:21 -0500
Received: from peff.net ([208.65.91.99]:54115 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbZBSDwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:52:21 -0500
Received: (qmail 19177 invoked by uid 107); 19 Feb 2009 03:52:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:52:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:52:19 -0500
Content-Disposition: inline
In-Reply-To: <20090219031602.GD20416@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110617>

On Thu, Feb 19, 2009 at 11:16:02AM +0800, bill lam wrote:

> I would like to use git to track some database files of sizes from 1MB
> to 50MB.  I want to know does git compress them for storage or not.

Yes, git will compress them via zlib.

> If so, what will be the expected compression ratio.  Those files
> normally compressed to 25% of original size using zip.

Then I would expect the same ratio, since I believe zip and zlib both
use the "deflate" algorithm.

Note, however, that git will also do delta compression between versions.
So storing N versions of a file should be no _worse_ than zipping and
keeping those N versions. But if the database files have small enough
changes from version to version (which depends on the database format,
and how much the on-disk structure changes for each update) then it will
compress even more.

-Peff
