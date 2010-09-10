From: Jeff King <peff@peff.net>
Subject: Re: git revert ignore whitespace
Date: Fri, 10 Sep 2010 10:21:14 -0400
Message-ID: <20100910142114.GB6936@sigill.intra.peff.net>
References: <14756.91.183.48.98.1284105472.squirrel@stevenleeuw.kwik.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven <redalert.commander@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 16:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou4Te-0006t5-VA
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 16:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab0IJOVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 10:21:00 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab0IJOVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 10:21:00 -0400
Received: (qmail 24706 invoked by uid 111); 10 Sep 2010 14:20:59 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 10 Sep 2010 14:20:59 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Sep 2010 10:21:14 -0400
Content-Disposition: inline
In-Reply-To: <14756.91.183.48.98.1284105472.squirrel@stevenleeuw.kwik.to>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155931>

On Fri, Sep 10, 2010 at 09:57:52AM +0200, Steven wrote:

> I want to revert a specific commit using 'git revert',
> however in the meantime there were some whitespace changes.
> Is it still possible to do this? The manual doesn't mention a -w or
> --ignore-whitespace option for git revert.

In theory there is no reason we couldn't support "-w", but I don't think
there is a way to do it currently.

You could just manually do the revert. Something like:

  git diff-tree -p $commit | git apply --ignore-whitespace
  git commit -m "revert '`git log -1 --format=%s $commit`'"

which is more or less what revert will do (actually, I think it will do
more with 3-way merges during the application, but the point is that a
revert in git is nothing more than achieving a tree state that pulls out
the reverted content, and then making a commit. It has no special status
in the history graph).

-Peff
