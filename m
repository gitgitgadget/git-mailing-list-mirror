From: Jeff King <peff@peff.net>
Subject: Re: Simple commit mechanism for non-technical users
Date: Wed, 19 Aug 2009 06:20:36 -0400
Message-ID: <20090819102036.GC28920@sigill.intra.peff.net>
References: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
 <alpine.DEB.1.00.0908190940430.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: D Sundstrom <sunds@peapod.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 12:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdiHd-0007Hy-Cl
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 12:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZHSKUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 06:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZHSKUg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 06:20:36 -0400
Received: from peff.net ([208.65.91.99]:41984 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbZHSKUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 06:20:36 -0400
Received: (qmail 18690 invoked by uid 107); 19 Aug 2009 10:20:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 19 Aug 2009 06:20:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Aug 2009 06:20:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908190940430.5594@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126532>

On Wed, Aug 19, 2009 at 09:49:50AM +0200, Johannes Schindelin wrote:

> Then you have a bunch of people who do not want to care about learning 
> proper version control.
> 
> This is what I would do: write a very simple .cgi (I'd use Perl for that), 
> which has a file upload button, takes the name as commit message (or maybe 
> adds a field where you can type in a commit message, but that might be 
> asking your bunch of Aunt Tillies too much), strips the "v3"-like suffixes 
> ($name =~ s/[-_ ]*v\d+(\.[A-Za-z0-9]{1,5})$/$1/;), set author and 
> committer information according to IP (and refuse if the IP is not in the 
> internal mapping) and commit.
> 
> The whole script would probably not be larger than 50 lines, and require 
> Git to be installed on the server.
> 
> The bigger problem is that your Aunt Tillies most likely would not love 
> gitweb, so you need a fancier interface.

Actually, I think there is a technical problem here. You get Aunt
Tillie's v3, but you don't necessarily know what it is based on. So if
some other Aunt Tillie has submitted a v3 in the meantime, what do you
do with her file? Commit on top? Try to guess where her v2 was, branch
from there, and merge?

If you commit on top, then you are potentially erasing the other
person's work. If you do a merge, you are likely to get conflicts
(especially because Aunt Tillie likes to use horrible binary formats)
that _somebody_ will have to resolve.

I guess you can throw each Tillie on their own branch and then let
somebody clueful do the merging, but then you do not really have people
working together.

I think this is a fundamental issue. Most version control systems (and
especially distributed ones) are about doing concurrent work and
merging, and merging requires a bit of a clue. The Aunt Tillies of the
world really need a locking system to manage concurrency.

-Peff
