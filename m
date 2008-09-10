From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 18:55:18 -0400
Message-ID: <20080910225518.GA24534@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net> <20080910223427.GB22739@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 00:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYbt-0002Hj-Rv
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 00:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYIJWzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYIJWzV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 18:55:21 -0400
Received: from peff.net ([208.65.91.99]:1066 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbYIJWzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 18:55:21 -0400
Received: (qmail 3024 invoked by uid 111); 10 Sep 2008 22:55:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Sep 2008 18:55:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2008 18:55:18 -0400
Content-Disposition: inline
In-Reply-To: <20080910223427.GB22739@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95566>

On Thu, Sep 11, 2008 at 12:34:27AM +0200, Stephen R. van den Berg wrote:

> I see.  Indeed.  That's a lot better.
> Did the binary search inside tree objects ever get implemented?

I believe it's still linear (and skimming tree-walk.c:find_tree_entry
seems to confirm). However, one advantage of such an approach is that it
will improve as tree lookup improves (e.g., I believe the pack v4 work
included improvements in this area).

> The downsides when doing that are:
> - The lookup cost is small, but still noticable, since it is sometimes
>   done on every commit; using the in-commit origin headerfield solves
>   this at negligible cost.
> - The origin information is no longer cryptographically protected (under
>   certain circumstances this could be considered an advantage and a
>   disadvantage at the same time).

Yes, those are inherent in the scheme, as is the upside that one can
make and distribute such annotations separately from commit creation.

I haven't thought enough about it to decide whether there is a scenario
where making such a "cherry-picked from" annotation might make use of
that property.

-Peff
