From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 5/5] stash: change built-in ref to 'stash' instead
 of 'refs/stash'
Date: Wed, 14 Oct 2009 01:06:45 -0400
Message-ID: <20091014050645.GD31810@coredump.intra.peff.net>
References: <cover.1255380039.git.trast@student.ethz.ch>
 <548bc3a41c03a049e782d5d04a34c3b26c0897d2.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw8w-00038c-1O
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZJNFHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZJNFHW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:07:22 -0400
Received: from peff.net ([208.65.91.99]:60203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbZJNFHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:07:21 -0400
Received: (qmail 24577 invoked by uid 107); 14 Oct 2009 05:10:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:10:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 01:06:45 -0400
Content-Disposition: inline
In-Reply-To: <548bc3a41c03a049e782d5d04a34c3b26c0897d2.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130250>

On Mon, Oct 12, 2009 at 11:06:07PM +0200, Thomas Rast wrote:

> 'git stash list' now always shows 'refs/stash@{...}' instead of
> 'stash@{...}', because that's what we specify for the ref.
> 
> Since git checks .git/$ref, .git/refs/$ref and only then
> .git/refs/{branches,tags,remotes}, we can drop the prefix.  This only
> affects people who have .git/stash, who were never able to refer to
> their stashes by stash@{...}.  (Sadly, now they won't be able to use
> git-stash anymore at all.)

Maybe a better solution would be a "short name" variant for pretty
format specifiers. We already have %(refname) and %(refname:short) in
for-each-ref, where the latter cuts off "refs/heads/", "refs/tags", or
"refs/remotes/" from the beginning. I'm not sure if it does just
"refs/", but probably it should. It may even check for ambiguity, but
I'd have to double-check the code.

The tricky part would be deciding on a syntax. This seems to come up a
fair bit. I think there is room for somebody to suggest a more expansive
--format syntax that can handle arbitrary arguments being given to
expansions (I think there was some discussion recently in a related
thread about body indentation, but I haven't been following it too
closely).

-Peff
