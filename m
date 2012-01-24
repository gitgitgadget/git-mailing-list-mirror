From: Jeff King <peff@peff.net>
Subject: Re: {Spam?} push pull not working
Date: Tue, 24 Jan 2012 15:18:07 -0500
Message-ID: <20120124201807.GA20145@sigill.intra.peff.net>
References: <1327431631.21582.209.camel@thor>
 <20120124194153.GB19534@sigill.intra.peff.net>
 <7vty3k3lmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rick Bragg <lists@gmnet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:18:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpmop-0005wy-Uz
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab2AXUSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 15:18:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43519
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756471Ab2AXUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:18:09 -0500
Received: (qmail 12516 invoked by uid 107); 24 Jan 2012 20:25:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jan 2012 15:25:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2012 15:18:07 -0500
Content-Disposition: inline
In-Reply-To: <7vty3k3lmh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189066>

On Tue, Jan 24, 2012 at 12:12:54PM -0800, Junio C Hamano wrote:

> > For example, imagine repo1 has two branches, "master" and "foo", and the
> > "master" branch is checked out. When you clone it, the resulting repo2
> > will have remote-tracking branches for both "master" and "foo", but will
> > only checkout the "master" branch. Now imagine you make commits on
> > "foo" in repo1, and then try to push. Git's default behavior is to push
> > only branches which match (by name) a branch on the destination. So we
> > would attempt to push "master" (which is up to date), but not "foo".
> 
> Technically you are not saying anything incorrect, but the above is not an
> appropriate paragraph to give to a total newbie, I would have to say.
> [...]

Yeah, I agree with all of this. I was trying not to go into too much
detail because we knew so little about the situation (e.g., we don't
even know if repo2 in the example is bare or not!), but perhaps my
terseness made things even more confusing.

This might have been a better example (it exhibits the problem, but is
not an example of a terrible thing to be doing):

  1. repo1 has a "master" branch

  2. clone repo1 with "git clone --bare repo1 repo2". Repo2 now has a
     master branch.

  3. create a new "foo" branch in repo and commit on it

  4. "git push ../repo2" from repo1. This is a sane thing to be doing,
     but will not push the newly-created "foo" branch, as some users
     might expect.

-Peff
