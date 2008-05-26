From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Tue, 27 May 2008 00:15:06 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805270012240.30431@racer>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer> <483AF570.9000609@gmail.com> <alpine.DEB.1.00.0805262226400.30431@racer> <483B3E86.5020100@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0lv0-0008Qn-2c
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbYEZXPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbYEZXPA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:15:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:50471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755553AbYEZXPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:15:00 -0400
Received: (qmail invoked by alias); 26 May 2008 23:14:58 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp035) with SMTP; 27 May 2008 01:14:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z7j0keUTZqhMDqCmHJP1xi0oc9eYwn0KswPfwIf
	98jTlK+i6ZJu6o
X-X-Sender: gene099@racer
In-Reply-To: <483B3E86.5020100@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82974>

Hi,

On Mon, 26 May 2008, Mark Levedahl wrote:

> >git checkout -f origin/master
> error: git-checkout-index: unable to create file t/t5100/nul (File exists)
> >git mv t/t5100/nul t/t5100/nul-file
> fatal: not under version control, source=t/t5100/nul,
> destination=t/t5100/nul-file

I should not do this, because you cost me already too much time with your 
outrageous proposal to rewrite history just for that stupid platform 
called Windows, whose users seem to complain more than actually 
contribute, but here it goes:

http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/nul-fix

The corresponding patch:

-- snipsnap --
[PATCH] Fix t5100 for Windows

On Windows, "nul" is not allowed as a file name.  So bend over for that
platform even more than we do already.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5100-mailinfo.sh        |    4 ++--
 t/t5100/{nul => nul-plain} |  Bin 91 -> 91 bytes
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename t/t5100/{nul => nul-plain} (100%)

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index a8b78eb..577ecc2 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -27,8 +27,8 @@ done
 
 test_expect_success 'respect NULs' '
 
-	git mailsplit -d3 -o. ../t5100/nul &&
-	cmp ../t5100/nul 001 &&
+	git mailsplit -d3 -o. ../t5100/nul-plain &&
+	cmp ../t5100/nul-plain 001 &&
 	(cat 001 | git mailinfo msg patch) &&
 	test 4 = $(wc -l < patch)
 
diff --git a/t/t5100/nul b/t/t5100/nul-plain
similarity index 100%
rename from t/t5100/nul
rename to t/t5100/nul-plain
-- 
1.5.6.rc0.175.gdd78
