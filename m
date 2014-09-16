From: Jeff King <peff@peff.net>
Subject: Re: Apparent bug in git-gc
Date: Mon, 15 Sep 2014 20:30:47 -0400
Message-ID: <20140916003046.GE5019@peff.net>
References: <201409152334.s8FNY33M032615@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTgfV-0006or-Li
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 02:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898AbaIPAau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 20:30:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:48657 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754659AbaIPAat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 20:30:49 -0400
Received: (qmail 13607 invoked by uid 102); 16 Sep 2014 00:30:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 19:30:49 -0500
Received: (qmail 26403 invoked by uid 107); 16 Sep 2014 00:31:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 20:31:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Sep 2014 20:30:47 -0400
Content-Disposition: inline
In-Reply-To: <201409152334.s8FNY33M032615@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257121>

On Mon, Sep 15, 2014 at 07:34:03PM -0400, Dale R. Worley wrote:

> I have an 11 GB repository.  It passes git-fsck (though with a number
> of dangling objects).  But when I run git-gc on it, the file
> refs/heads/master disappears.

That's the expected behavior. Gc runs "git pack-refs", which puts an
entry into packed-refs and prunes the loose ref.

> Since HEAD points to refs/heads/master, this makes the repository
> unusable.

Unusable how?  Does `git rev-parse refs/heads/master` still produce a
sha1? Does `git rev-parse HEAD`? If not, then that is definitely a bug.

-Peff
