From: Jeff King <peff@peff.net>
Subject: Re: Rebase and incrementing version numbers
Date: Tue, 24 Jan 2012 21:09:03 -0500
Message-ID: <20120125020903.GA21535@sigill.intra.peff.net>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
 <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
 <CAH3Anro8T4SJqBvw1E_7u__4kYyB6hMCYPbtHSVxkgSUYSb2+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Wed Jan 25 03:09:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpsIU-00070j-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 03:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab2AYCJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 21:09:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43632
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab2AYCJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 21:09:07 -0500
Received: (qmail 14618 invoked by uid 107); 25 Jan 2012 02:16:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jan 2012 21:16:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2012 21:09:03 -0500
Content-Disposition: inline
In-Reply-To: <CAH3Anro8T4SJqBvw1E_7u__4kYyB6hMCYPbtHSVxkgSUYSb2+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189093>

On Fri, Jan 20, 2012 at 08:33:57AM +1100, Jon Seymour wrote:

> I wonder if you can defer your changes to the config files until after
> you have synced with the current SVN head, so that you typically only
> modify the latest configuration file. Then use git to work out what
> numbers you have to update (by working out which files you changed
> that the SVN upstream has not seen yet). Not perfect, because of race
> conditions, and may not work with your integration testing processes,
> but perhaps worth considering.

That was my thought, too (assuming this workflow, which seems slightly
insane, is outside your power to change).

In this list here:

> Something like:
> 
> 1. pull latest SVN
> 2. work on file
> 3. test. skip back to 2 until done.
> 4. ready to push to upstream
> 5. pull latest SVN
> 6. calculate configuration changes required
> 7. apply configuration changes
> 8. push work + configuration changes upstream

Steps 5 and 8 are basically "git svn dcommit". I suspect you could use
some combination of "git svn rebase" and "git filter-branch" to rewrite
your commits with the right counters, and then dcommit the result
(hopefully fast enough to avoid races).

-Peff
