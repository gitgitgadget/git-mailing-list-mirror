From: Jeff King <peff@peff.net>
Subject: Re: git apply: git diff header lacks filename information for git
	diff --no-index patch
Date: Sun, 5 Oct 2008 15:24:39 -0400
Message-ID: <20081005192439.GD6173@coredump.intra.peff.net>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net> <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org> <20081005191728.GA6173@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:26:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZEl-0006tb-Gy
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbYJETYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755944AbYJETYm
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:24:42 -0400
Received: from peff.net ([208.65.91.99]:3311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755819AbYJETYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:24:41 -0400
Received: (qmail 17145 invoked by uid 111); 5 Oct 2008 19:24:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 15:24:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 15:24:39 -0400
Content-Disposition: inline
In-Reply-To: <20081005191728.GA6173@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97526>

On Sun, Oct 05, 2008 at 03:17:28PM -0400, Jeff King wrote:

> Yes, I noticed that, as well. And obviously it looks bogus, but I
> thought I managed to get "git diff" to produce "a/dev/null" on some
> otherwise valid input, and so assumed that was something we were able to
> work around in applying the patch. But testing again today, I can't seem
> to get anything except this broken diff to say "a/dev/null". So probably
> I was just mistaken yesterday.

Ah, I found it. It was the fact that _text_ diffs using --no-index also
generate that bogosity. But of course they work fine, since we just
reject the "default" name from the "diff --git" line, but end up getting
the names from the "---" and "+++" lines.

-Peff
