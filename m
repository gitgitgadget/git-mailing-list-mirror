From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Broken dependencies..
Date: Wed, 28 Feb 2007 00:55:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280053140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702271543080.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCAq-0003Yn-EA
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXB0Xzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXB0Xzv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:55:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:46610 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752658AbXB0Xzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:55:50 -0500
Received: (qmail invoked by alias); 27 Feb 2007 23:55:48 -0000
X-Provags-ID: V01U2FsdGVkX19m9XY4s2NmRTd58jhgzQxS2ycNw6Co52ihDLo3H/
	VsHQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271543080.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40854>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> 	/home/torvalds/git/fetch.c:137: undefined reference to `type_names'
> 	fetch.o: In function `typename':

I realized that too, and forgot to send out the patch:

-- snip --
[PATCH] fetch.o depends on the headers, too.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 20acc78..ce284fa 100644
--- a/Makefile
+++ b/Makefile
@@ -788,7 +788,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
+$(LIB_OBJS) $(BUILTIN_OBJS) fetch.o: $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
-- snap --

Ciao,
Dscho
