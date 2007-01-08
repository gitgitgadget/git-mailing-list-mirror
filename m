From: Theodore Tso <tytso@mit.edu>
Subject: Re: I just pulled and built 'next'...
Date: Mon, 8 Jan 2007 16:00:02 -0500
Message-ID: <20070108210002.GA15121@thunk.org>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 22:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H41bH-0007eM-RX
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 22:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXAHVAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 16:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbXAHVAH
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 16:00:07 -0500
Received: from thunk.org ([69.25.196.29]:54468 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932673AbXAHVAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 16:00:05 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H41fd-0005bH-ST; Mon, 08 Jan 2007 16:04:42 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H41b8-0001Cf-9X; Mon, 08 Jan 2007 16:00:02 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36280>

On Mon, Jan 08, 2007 at 12:11:35PM -0800, Junio C Hamano wrote:
> One question is how you would sort the result.  If you sort them
> by taggerdate, you would get v1.4.4.4 anyway ;-).

I was assuming either lexigraphically, or via some really complicated
rpm/dpkg version number comparison scheme.  :-)

> If we go with topology, we do not necessarily have to find all
> the tags.  When we hit a commit that is tagged, we can stop the
> traversal (so after finding v1.5.0-rc0, we do not have to go
> back along the 'master' lineage to find v1.4.4 tag).  Traversing
> from the tip of 'master' (or 'next') this way we will notice
> that v1.5.0-rc0 and v1.4.4.4 are the candidates without going
> any further in the past.
> 
> But the question still remains which one between the two to
> pick.

Yeah, that is the question.  If we're willing to look at the tag name,
it's pretty clear that if both v1.5.0-rc0 and v1.4.4.4 is reachable
from the head, it should be based on the "newer" version, i.e.,
v1.5.0-rc0.  A human can figure this out easily, but algorithimically
we end up having to use something like the rpm or dpkg version
comparison algorithm, both of which are hueristics that will sometimes
get thigns wrong.

						- Ted
