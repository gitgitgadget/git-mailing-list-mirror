From: Jeff King <peff@peff.net>
Subject: Re: Honoring a checked out gitattributes file
Date: Wed, 28 Jan 2009 12:55:45 -0500
Message-ID: <20090128175545.GE8863@coredump.intra.peff.net>
References: <498078F1.20807@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 18:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEfR-0005Dv-Cp
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 18:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZA1Rzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbZA1Rzs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 12:55:48 -0500
Received: from peff.net ([208.65.91.99]:52089 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZA1Rzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 12:55:47 -0500
Received: (qmail 24290 invoked by uid 107); 28 Jan 2009 17:55:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 12:55:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 12:55:45 -0500
Content-Disposition: inline
In-Reply-To: <498078F1.20807@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107554>

On Wed, Jan 28, 2009 at 04:25:37PM +0100, Kristian Amlie wrote:

> However, if the .gitattributes file is also checked in to the branch, it
> will not always be honored. I browsed the code a bit, and it seems to
> happen whenever there is an existing .gitattributes file, but the
> checkout adds new files to it. These new files will not get the correct
> line endings (although I'm not sure if it happens *every* time, it could
> depend on the order they are checked out).

This is a known limitation of gitattributes. There has been some
discussion in the past on how it should work, but I don't recall the
specifics; try searching the list archive. I think it is really just
waiting for somebody to step up and write some patches.

As a workaround, you might be able to do something like:

  branch=master
  git show $branch:.gitattributes >.git/info/attributes
  git checkout $branch

which is very hacky, but might work depending on your setup. Notably it
will overwrite any actual use you were making of .git/info/attributes,
and it will not respect any .gitattributes files in subdirectories.

-Peff
