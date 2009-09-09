From: Jeff King <peff@peff.net>
Subject: Re: `Git Status`-like output for two local branches
Date: Wed, 9 Sep 2009 08:26:02 -0400
Message-ID: <20090909122602.GA31208@coredump.intra.peff.net>
References: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com>
 <20090902075713.GA1832@coredump.intra.peff.net>
 <fabb9a1e0909020118m2fe2e6e1g79cc83ce941ac000@mail.gmail.com>
 <20090905081726.GA7109@coredump.intra.peff.net>
 <9b18b3110909050758k597f917fn3baefa5fdb4741a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 14:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlMFe-0008S7-Me
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 14:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZIIM0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 08:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZIIM0H
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 08:26:07 -0400
Received: from peff.net ([208.65.91.99]:34516 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbZIIM0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 08:26:06 -0400
Received: (qmail 28157 invoked by uid 107); 9 Sep 2009 12:26:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 08:26:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 08:26:02 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110909050758k597f917fn3baefa5fdb4741a0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128064>

On Sat, Sep 05, 2009 at 04:58:36PM +0200, demerphq wrote:

> It would be useful in for instance prompt status line. At $work we
> have a number of people using a prompt that includes the result of
> parsing git-status, but something --left-right-count would be much
> nicer, and if i understand it, more efficient (although maybe im
> wrong). In the prompt they use a number of different unicode arrows to
> show what has happened, with a Y type thing for diverged.

Well, if they are using the other bits of "git status" then it may not
be that inefficient compared to a "--left-right-count".

However, it sounds like they are not actually interested in the count,
but just the two bits of information: is A ahead of B, and is B ahead of
A (and then displaying one of four symbols as a result).

And getting that information is even more efficient than just a count,
because you don't have to traverse all of the commits. Though you do
still have to find the merge base, so I'm not sure how much you would be
saving in practice.

A "--left-right-count" does feel like an odd option to "git log" or "git
rev-list", as you are no longer logging or listing anything. In a way,
it makes more sense to me as a special output format of "git
merge-base".

Anyway, I think your example sounds like a reasonable application.
Personally, I do not use a git-enhanced prompt, so it is not my itch to
scratch (and I think a plumbing patch would only make sense if it was a
stepping stone to an actual application, which means somebody needs to
write the actual application).

-Peff
