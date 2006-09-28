From: Jeff King <peff@peff.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 20:21:24 -0400
Message-ID: <20060928002124.GA16634@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0609271606050.3952@g5.osdl.org> <20060928001241.62887.qmail@web51013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 02:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjed-0003hb-5z
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031278AbWI1AV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWI1AV2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:21:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:61824 "HELO
	peff.net") by vger.kernel.org with SMTP id S965171AbWI1AV1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 20:21:27 -0400
Received: (qmail 11284 invoked from network); 27 Sep 2006 20:21:24 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Sep 2006 20:21:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2006 20:21:24 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27952>

On Wed, Sep 27, 2006 at 05:12:41PM -0700, Matthew L Foster wrote:

> Ignoring the separate issue of replication for a momment, can someone
> respond to my time integrity question about whether a future version
> of git could trust/prefer its local time rather than a
> remote/sub/parent (non replicated) git server's timestamp?

Yes, it could. But it would not involve rewriting the commit object or
adding a new commit object (for reasons I hope have been adequately
explained by Linus). Instead, an external mapping would be made between
a commit SHA1 and a timestamp (or a (branch,sha1) pair and a timestamp).

In fact, this is how reflogs work (but they make a map only when the
head changes, not marking each commit that enters the repo).

> How do we fix gitweb.cgi, ref-log?

To "fix" gitweb, keep a database in each local repository as described
above (either based on reflog, or one that is more comprehensive). Have
gitweb report that date rather than the timestamp contained in the
commit.

Nobody has created such a patch; you can always try and see what the
response is.

> How useful is gitweb.cgi if timestamps are all over the place? It does

Quite useful, according to many git users.

-Peff
