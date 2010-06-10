From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Thu, 10 Jun 2010 04:59:52 -0400
Message-ID: <20100610085952.GA8269@coredump.intra.peff.net>
References: <4C0E5103.7030501@viscovery.net>
 <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
 <4C0E6810.3070301@viscovery.net>
 <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
 <4C0E932B.3010702@viscovery.net>
 <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
 <4C0EB741.9020905@op5.se>
 <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
 <20100610082916.GA5559@coredump.intra.peff.net>
 <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:00:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMdcO-0006jH-Vo
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab0FJI76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 04:59:58 -0400
Received: from peff.net ([208.65.91.99]:60934 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab0FJI75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 04:59:57 -0400
Received: (qmail 2234 invoked by uid 107); 10 Jun 2010 09:00:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Jun 2010 05:00:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jun 2010 04:59:52 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148843>

On Thu, Jun 10, 2010 at 10:48:31AM +0200, Tor Arntsen wrote:

> That looks good to me.

OK, here it is with a commit message. Other systems might want the same,
I guess (Solaris, IRIX?). I'm cc'ing Brandon, who might have some input.

Note that this is completely untested by me, as all of my AIX boxen have
gone away in the past few months (yay!).

-- >8 --
Subject: [PATCH] Makefile: default pager on AIX to "more"

AIX doesn't ship with "less" by default, and their "more" is
more featureful than average, so the latter is a more
sensible choice.  People who really want less can set the
compile-time option themselves, or users can set $PAGER.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 34b7dd5..6ad0aca 100644
--- a/Makefile
+++ b/Makefile
@@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),AIX)
+	DEFAULT_PAGER = more
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
-- 
1.7.1.514.g71ed8
