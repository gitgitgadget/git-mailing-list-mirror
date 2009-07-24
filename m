From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Fri, 24 Jul 2009 13:06:22 -0400
Message-ID: <20090724170622.GA20247@sigill.intra.peff.net>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 19:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUOEG-0007I3-QG
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 19:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZGXRGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 13:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZGXRGd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 13:06:33 -0400
Received: from peff.net ([208.65.91.99]:45811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbZGXRGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 13:06:24 -0400
Received: (qmail 16785 invoked by uid 107); 24 Jul 2009 17:08:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 24 Jul 2009 13:08:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2009 13:06:22 -0400
Content-Disposition: inline
In-Reply-To: <7v8wienk07.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123931>

On Fri, Jul 24, 2009 at 09:06:16AM -0700, Junio C Hamano wrote:

> In your arsenal, you have "git add -p" to help you sift good pieces from
> other parts in finer grained manner, instead of having to make an all or
> nothing decision per file basis (i.e. "git add file").  But "git add -p"
> (and "git add -i") is still about the "git add" step in the above high
> level view.  You have a mixture of good and not so good changes in your
> work tree, and you pick only good pieces to add to the index, _knowing_
> that you can go back and redo this step safely exactly because your work
> tree will stay the same even if you did make mistakes.
> 
> The proposed change breaks this expectation you would have naturally
> gained during the course of becoming more and more proficient in using
> git.
> 
> In other words, I do not think you can say that the change will not harm
> the experts due to both the points 2 (experts can easily make typo) and 3
> above (the change breaks the mental model of the world experts would have
> formed).
> 
> Having said all that, it indeed would be useful to selectively revert
> changes from the work tree files.

Perhaps it makes sense to have an interactive stash rather than an
interactive revert? Then the reverts that you make are still being saved
somewhere, and you can recover from an error by applying the stash. Not
to mention that interactive stash is useful in its own right.

The downside is that if you are the sort of person who keeps a clean
stash list (and I am not such a person), then you have this
"to-be-deleted" cruft on the top of your stash (whereas with a true
revert, it just goes away).

-Peff
