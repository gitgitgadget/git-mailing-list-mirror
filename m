From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 22:13:16 +0100
Message-ID: <20120227211316.GA29081@ecki>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
 <20120227191846.GB1600@sigill.intra.peff.net>
 <7vr4xg6pn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S280z-00074Y-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab2B0VVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:21:43 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31277 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754565Ab2B0VVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:21:41 -0500
Received: from localhost (p5B22E80B.dip.t-dialin.net [91.34.232.11])
	by bsmtp.bon.at (Postfix) with ESMTP id 6C610A7EB9;
	Mon, 27 Feb 2012 22:22:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr4xg6pn2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191673>

On Mon, Feb 27, 2012 at 11:29:53AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> Given that, isn't it not just sufficient but actually better to instead
> >> add a new --no-dangling option and keep the default unchanged?
> >
> > ... Of course, it is fsck, so I wonder how often clueless people are
> > really running it in the first place (i.e., it is not and should not be
> > part of most users' typical workflows). If it is simply the case that
> > they are being told to run "git fsck" by more expert users without
> > understanding what it does, then I could buy the argument that those
> > expert users could just as easily say "git fsck --no-dangling".
> 
> Yes, that was certainly part of my pros-and-cons analysis.  If you run
> "git fsck" without "--no-dangling" without reading the manual, you may
> get confused, but that is *not* the primary audience.

It is not my only concern that users might be confused. I believe the
command prints a lot of useless messages, which is by itself a UI
deficiency. But even worse, those numerous messages tend to hide an
actual problem in a long scrollback buffer. Sometimes my scrollback
buffer is not even large enough and I have to re-run fsck (which is not
exactly a fast command), just so I can grep out the dangling blobs.

> People who are curious can read the manual and figure it out, and the
> need for "fsck" is much rarer these days, compared to 2005 ;-)

In my opinion, the need for fsck is much more common these days. With
the alternates feature, it happens all the time that a repository breaks
if one is not extremely careful.

> In that context, only large downsides of potentially breaking and having
> to adjust existing scripts remains without much upsides, if we were to
> switch the default.

There is something wrong with weighting a UI improvement against
convenient use in scripts. If that were the issue, then we should add a
plumbing version for all commands, like we do for git status
--porcelain. Otherwise we can never change anything any more.
