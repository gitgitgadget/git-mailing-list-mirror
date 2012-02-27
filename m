From: Jeff King <peff@peff.net>
Subject: Re: git-cherries
Date: Mon, 27 Feb 2012 14:27:46 -0500
Message-ID: <20120227192746.GC1600@sigill.intra.peff.net>
References: <874nucee98.fsf@gnuvola.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thien-Thi Nguyen <ttn@gnuvola.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 20:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26Ej-0008MW-EL
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab2B0T1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:27:49 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58941
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab2B0T1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:27:48 -0500
Received: (qmail 29667 invoked by uid 107); 27 Feb 2012 19:27:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 14:27:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:27:46 -0500
Content-Disposition: inline
In-Reply-To: <874nucee98.fsf@gnuvola.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191655>

On Mon, Feb 27, 2012 at 11:56:19AM +0100, Thien-Thi Nguyen wrote:

> For my personal use, i wrote git-cherries, attached.
> It commits each hunk of every modified file separately
> (creating cherries to cherry-pick later, you see).
> 
> I am writing to ask if this is already in Git somewhere,
> and if not, for tips on how to make it faster / more elegant.

So if I understand correctly, this just creates a series of commits, one
per hunk, of what's in your working tree. And the commit messages won't
be useful, so this is really about recording the work somewhere so that
you can pick it out later using "git cherry-pick --no-commit", make a
real commit from some subset of the cherries, and then throw away the
cherries?

I think you could do this more simply by putting everything in a single
throw-away commit, then using "git checkout -p $throwaway" to pick the
individual cherries from the single commit. You don't grab the commit
message from $throwaway as you might with cherry-pick, but by definition
it's not a very good commit message anyway.

-Peff
