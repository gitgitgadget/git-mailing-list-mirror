From: Jeff King <peff@peff.net>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Fri, 30 Oct 2015 13:01:03 -0400
Message-ID: <20151030170102.GA32384@sigill.intra.peff.net>
References: <56337DF8.5050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: The development of GRUB 2 <grub-devel@gnu.org>,
	git@vger.kernel.org, savannah-users@gnu.org
To: Andrei Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsD39-0006b9-GD
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbbJ3RBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:01:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:50435 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751314AbbJ3RBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:01:05 -0400
Received: (qmail 29177 invoked by uid 102); 30 Oct 2015 17:01:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 12:01:05 -0500
Received: (qmail 23457 invoked by uid 107); 30 Oct 2015 17:01:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 13:01:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 13:01:03 -0400
Content-Disposition: inline
In-Reply-To: <56337DF8.5050802@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280495>

On Fri, Oct 30, 2015 at 05:26:00PM +0300, Andrei Borzenkov wrote:

> See http://git.savannah.gnu.org/cgit/grub.git/commit/?id=206676601eb853fc319df14cd3398fbdfde665ac
> 
> I was not even aware that this is possible. Is there anything on server side
> that can prevent it?

I would have thought that receive.fsckObjects would reject it, but seems
that git-fsck does not complain about it at all, as it is otherwise
syntactically valid (a space separating the zero-length name from the
email, and <> surrounding the empty email).

We do complain during "git commit" about an empty name. We don't seem to
do so for blank emails, though. The only discussion I could find
mentions that should probably disallow both[1].

I wonder how this commit was created in the first place (through
git-commit, and we have an empty-name case that is not covered, or using
a lower-level tool that bypasses the checks).

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/261237
