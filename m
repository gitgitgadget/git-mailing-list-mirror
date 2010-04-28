From: Jeff King <peff@peff.net>
Subject: Re: [patch 04/16] Without this patch at least IBM VisualAge C 5.0
 (I have 5.0.2) on AIX 5.1 fails to compile git.
Date: Wed, 28 Apr 2010 12:23:24 -0400
Message-ID: <20100428162324.GB7527@coredump.intra.peff.net>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135823.017417000@mlists.thewrittenword.com>
 <4BD70C1A.80709@spacetec.no>
 <20100428084027.GC36271@thor.il.thewrittenword.com>
 <4BD7F81A.4030906@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Apr 28 18:23:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7A2x-0005Rd-Ta
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab0D1QX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 12:23:28 -0400
Received: from peff.net ([208.65.91.99]:43616 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab0D1QX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 12:23:27 -0400
Received: (qmail 17730 invoked by uid 107); 28 Apr 2010 16:23:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Apr 2010 12:23:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Apr 2010 12:23:24 -0400
Content-Disposition: inline
In-Reply-To: <4BD7F81A.4030906@spacetec.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145998>

On Wed, Apr 28, 2010 at 10:55:54AM +0200, Tor Arntsen wrote:

> >> The patch is against master. Are we supposed to make patches against
> >> master or maint? (I thought I saw the latter somewhere. I'm pretty
> >> new in here though..)
> [...]
> Ok. That would correspond to master from git anyway. I make my patches
> against a git checkout, and I was just throwing out the question to
> the general audience, for my own knowledge.

The answer is that you should base your patch on whatever is the best
place for Junio to apply it. :)

For new feature work that will go into the next 3-number release (e.g.,
1.7.1), that should generally just go on 'master'.

For bugfixes that will be part of stable release (e.g., 1.7.0.7), they
should generally go right on top of the commit introducing the bug, and
can then be merged into whichever versions exhibit the bug. If it's not
a bugfix but rather a documentation or portability fix that should go to
maint, and doesn't necessarily have a specific commit to based on,
building on 'maint' is probably OK, which would be appropriate for the
next stable release. There is some benefit to going farther back if the
fix should be merged to multiple maint tracks (e.g., both 1.6.6.x and
1.7.0.x). I'm not sure how Junio decides which maint releases are "too
old" to care about.

It's almost never a good idea to base work on "next" as a whole.  It is
appropriate to base work on commits on a topic that is _in_ next, but
only if you are building on to that topic. Otherwise, we try to keep
topics independent (by building them on "master") so that they can be
merged independently as they mature.

For this particular patch set, "master" is probably a good starting
point. Portability fixes can often go to maint as described above, but
this particular patchset is more like feature work. It's big and
invasive, and it is not about fixing minor portability issues introduced
by recent commits, but rather is about porting to many brand new
platforms.

-Peff
