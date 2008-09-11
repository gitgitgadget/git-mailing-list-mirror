From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use compatibility regex library also on AIX
Date: Thu, 11 Sep 2008 08:12:16 -0400
Message-ID: <20080911121216.GB17303@coredump.intra.peff.net>
References: <20080907184537.GA4148@regex.yaph.org> <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com> <20080910100301.GA27748@regex.yaph.org> <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com> <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com> <48C8D374.9050007@viscovery.net> <20080911082554.GB27748@regex.yaph.org> <e2b179460809110131h781f0c91i9d478e20b55dec24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 14:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdl3D-0003nP-2N
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 14:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYIKMMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 08:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbYIKMMT
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 08:12:19 -0400
Received: from peff.net ([208.65.91.99]:4216 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbYIKMMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 08:12:18 -0400
Received: (qmail 10844 invoked by uid 111); 11 Sep 2008 12:12:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Sep 2008 08:12:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2008 08:12:16 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460809110131h781f0c91i9d478e20b55dec24@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95602>

On Thu, Sep 11, 2008 at 09:31:25AM +0100, Mike Ralphson wrote:

> I think the reason it's in pu is that it's in maint, master and next too...
> 
> All my test runs went bang this morning. 8-)

Mine too. :)

This is needed for FreeBSD, as well. No idea about OpenBSD or others.
Should probably be squashed with the AIX patch if it's not too late.

-- >8 --
Use compatibility regex library also on FreeBSD

Commit 3632cfc24 makes the same change for Darwin; however, the problem
also exists on FreeBSD.

Signed-off-by: Jeff King <peff@peff.net>
---

diff --git a/Makefile b/Makefile
index 247cd2d..9b1bd7b 100644
--- a/Makefile
+++ b/Makefile
@@ -688,6 +688,8 @@ ifeq ($(uname_S),FreeBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
+	COMPAT_CFLAGS += -Icompat/regex
+	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
