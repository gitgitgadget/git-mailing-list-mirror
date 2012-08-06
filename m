From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Makefile: use overridable $(FIND) instead of hard-coded 'find'
Date: Mon, 06 Aug 2012 23:06:14 +0200
Message-ID: <502031C6.7040908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyUVO-0004Oi-4P
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 23:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770Ab2HFVGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 17:06:20 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23490 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754121Ab2HFVGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 17:06:19 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 97E31A7EB0;
	Mon,  6 Aug 2012 23:06:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1D77019F6E5;
	Mon,  6 Aug 2012 23:06:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202988>

The Makefile already offers the variable $(FIND) and uses it except in one
place. Fix it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 For my Windows builds, I need "FIND=/usr/bin/find" in config.mak because
 I have /usr/bin is too late in PATH to override MS's incompatible 'find'.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fe9bcea..bc88d13 100644
--- a/Makefile
+++ b/Makefile
@@ -2094,7 +2094,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 perl/perl.mak: perl/PM.stamp
 
 perl/PM.stamp: FORCE
-	$(QUIET_GEN)find perl -type f -name '*.pm' | sort >$@+ && \
+	$(QUIET_GEN)$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
 	$(RM) $@+
 
-- 
1.7.11.1.127.gdcfb9a9
