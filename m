From: Jeff King <peff@peff.net>
Subject: Re: git mergetool vs stash apply
Date: Tue, 20 May 2008 08:45:58 -0400
Message-ID: <20080520124557.GA5873@sigill.intra.peff.net>
References: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com> <20080520090258.GB31703@sigill.intra.peff.net> <c6c947f60805200416s61b0cc1eqd6d6c804abd15b4@mail.gmail.com> <m3prrh42hl.fsf@localhost.localdomain> <c6c947f60805200532h53e7ec64jb846f1d8c1b7066c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 14:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyRFO-00050M-Ql
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 14:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbYETMqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 08:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766004AbYETMqB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 08:46:01 -0400
Received: from peff.net ([208.65.91.99]:4291 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766009AbYETMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 08:46:00 -0400
Received: (qmail 9904 invoked by uid 111); 20 May 2008 12:45:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 May 2008 08:45:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2008 08:45:58 -0400
Content-Disposition: inline
In-Reply-To: <c6c947f60805200532h53e7ec64jb846f1d8c1b7066c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82481>

On Tue, May 20, 2008 at 04:32:49PM +0400, Alexander Gladysh wrote:

> 1. My repo is 650+ MB, my working copy is 350+ KLOC. That size is hard
> to share. Would that tool reduce it enough? Is it possible to filter
> out irrelevant content somehow?

It doesn't really shrink it very much. You can always filter out some
content with filter-branch, but the trick is trying to produce a repo
that still exhibits the problem. In your case, it might be enough to
simply provide the stashed state and the state upon which you are trying
to apply.

> 2. Would that tool obfuscate binaries as well?

It looks at lines, so wherever your binary happened to have a newline,
it would get split into chunks. So the answer is yes, it would obfuscate
them, but the diffs won't necessarily be meaningful.

All that being said...

> Furthermore, I have tried to reproduce that bug once again (by
> checking out that problematic revision and trying to apply that git
> stash on it) and was unable to (but my repo has changed since that).
> Perhaps it was some "moonphase-related" fluctuation...

Obfuscating your repository to let us reproduce is pointless if you
can't reproduce on the repository itself. So I would keep an eye on it,
and if it happens again, try to save the broken state.

-Peff
