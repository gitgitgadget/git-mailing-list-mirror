From: Jeff King <peff@peff.net>
Subject: Re: referencing a revision at a certain date
Date: Mon, 11 Feb 2008 13:29:34 -0500
Message-ID: <20080211182934.GA23351@sigill.intra.peff.net>
References: <20080211180424.GA4905@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT mailing-list <git@vger.kernel.org>
To: David Madore <david.madore@ens.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdQz-0005NF-48
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760267AbYBKS3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759196AbYBKS3j
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:29:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4518 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760247AbYBKS3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:29:38 -0500
Received: (qmail 13388 invoked by uid 111); 11 Feb 2008 18:29:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 11 Feb 2008 13:29:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 13:29:34 -0500
Content-Disposition: inline
In-Reply-To: <20080211180424.GA4905@clipper.ens.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73560>

On Mon, Feb 11, 2008 at 07:04:24PM +0100, David Madore wrote:

> I understand that if "rev" denotes a certain revision, then "rev~42"
> references the commit which is 42 generations back from rev.  What I'd
> like to do is write something like "rev~@{2008-01-18}" (say) to get
> the same thing but with the 42 being computed automatically so that
> the commit in question is the latest possible (in commit date) before
> 2008-01-18.  Is this possible?  If so, how?  If not, might I suggest
> this as an addition for consideration?

How about --before=2008-01-18? As in,

  git log --before=2008-01-18

to start your log there (and "git log -1 --before=2008-01-18" if you
just want that one commit).

> I thought "rev@{2008-01-18}" did this, but apparently it doesn't: it
> requires a ref log of some kind, and I don't know how to make a ref
> log (git-clone doesn't seem to copy them).

Ref logs are a log of where your particular, local ref was pointing to.
In other words, it is a history not of the project commits, but of an
individual branch in your local repository. So you don't ask the reflog
things like "which commit has a date at X" but rather "where was my
master branch pointing at 3pm yesterday?"

And because they are purely a local matter, they don't get copied by
clone.

> So, is there some way I can either generate a ref log by
> systematically taking the first parent in each commit as per git-log
> --first-parent, OR (better) specify a revision directly that way?

So this question doesn't really make sense. You generate a ref log by
doing operations on a branch.

-Peff
