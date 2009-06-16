From: Jeff King <peff@peff.net>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 08:07:37 -0400
Message-ID: <20090616120737.GA5227@coredump.intra.peff.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 14:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGXS9-0002tn-Q9
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 14:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbZFPMHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 08:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbZFPMHh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 08:07:37 -0400
Received: from peff.net ([208.65.91.99]:55174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470AbZFPMHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 08:07:37 -0400
Received: (qmail 4082 invoked by uid 107); 16 Jun 2009 12:09:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 08:09:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 08:07:37 -0400
Content-Disposition: inline
In-Reply-To: <20090616114726.GA4343@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121675>

On Tue, Jun 16, 2009 at 07:47:26AM -0400, Jeff King wrote:

>   $ git clone git://repo.or.cz/egit.git
>   $ git diff v0.4.0 -- \
>     org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
> 
> which isn't even all that big a file, but it is either causing some
> horrible algorithmic behavior in the regex library, or is outright
> sending it into an infinite loop.
> 
> I tried building against the code in compat/regex; it completes in a
> reasonable amount of time, though it is still noticeably slow. With
> system regex, the diff given above doesn't complete in less than 90
> seconds (at which I get bored and kill it). With compat/regex, it
> completes in about 2.2 seconds. Disabling the xfuncname, it completes in
> 0.14 seconds.

And here is a patch series to use compat/regex on Solaris. I think the
first one should be non-controversial, as it just makes the knob more
convenient to turn. The second one is up for debate.

  1/2: Makefile: refactor regex compat support
  2/2: Makefile: use compat regex on Solaris

-Peff
