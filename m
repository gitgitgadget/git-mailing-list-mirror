From: Jeff King <peff@peff.net>
Subject: Re: fatal: ambiguous argument 'HEAD^': unknown revision or path not
 in the working tree.
Date: Wed, 9 Sep 2015 05:20:42 -0400
Message-ID: <20150909092042.GC21892@sigill.intra.peff.net>
References: <loom.20101028T150254-457@post.gmane.org>
 <1441787643787-7639207.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: davilda_ <vattolou@jam-difus.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 11:21:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZbYp-0004T8-Po
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 11:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbbIIJUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 05:20:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:56652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754953AbbIIJUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 05:20:45 -0400
Received: (qmail 8505 invoked by uid 102); 9 Sep 2015 09:20:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Sep 2015 04:20:45 -0500
Received: (qmail 29748 invoked by uid 107); 9 Sep 2015 09:20:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Sep 2015 05:20:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2015 05:20:42 -0400
Content-Disposition: inline
In-Reply-To: <1441787643787-7639207.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277541>

On Wed, Sep 09, 2015 at 01:34:03AM -0700, davilda_ wrote:

> i'm new with git and i just want to cancel a commit. I just do git add and
> git commit.
> How can i canceled a commit in my case.

Usually with "git reset HEAD^". But I'm guessing from your subject line
that you tried that, and it did not work because this commit is the
_only_ commit in your repository (and "HEAD^", which means "the parent
commit of HEAD", does not make any sense, as there is no parent).

Annoyingly, I don't think there is an easy way with the current tools to
handle this corner case (you want to not reset to a commit, but back to
the "unborn branch" state).

The "simplest" way to do that is:

  rm .git/refs/heads/master

but that is not guaranteed to work in future versions of git, and I
wouldn't recommend it in general.

Probably a better workflow is to create the commit state you _do_ want
(change files, "git add" them, etc), and then run "git commit --amend"
to replace the bad commit.

-Peff
