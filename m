From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-commit: prefix the relative path to the message file
Date: Fri, 25 Aug 2006 02:06:14 +0200
Message-ID: <20060825000614.GF2817@diku.dk>
References: <87d5aru4px.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 02:06:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGPDi-0007Qa-58
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 02:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWHYAGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 20:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWHYAGm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 20:06:42 -0400
Received: from [130.225.96.91] ([130.225.96.91]:15497 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751581AbWHYAGm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 20:06:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1463E770066;
	Fri, 25 Aug 2006 02:06:16 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25028-16; Fri, 25 Aug 2006 02:06:14 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A5EDF77000E;
	Fri, 25 Aug 2006 02:06:14 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 91B426DF835; Fri, 25 Aug 2006 02:04:56 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8A281629FB; Fri, 25 Aug 2006 02:06:14 +0200 (CEST)
To: Jim Meyering <jim@meyering.net>
Content-Disposition: inline
In-Reply-To: <87d5aru4px.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25980>

Makes the -M switch work from a subdirectory.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

Jim Meyering <jim@meyering.net> wrote Wed, Aug 23, 2006:
> Hello,

Hi,

> I discovered that "cg-commit -M MSG-FILE ..." fails when run from
> a subdirectory, and when MSG-FILE is a relative file name.
> This is using cogito-0.17.3-2 from Debian/unstable, but the problem
> remains when using the latest cogito sources, pulled minutes ago.

The attached patch should fix this problem.

---

 cg-commit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-commit b/cg-commit
index 0cec58f..5cebd81 100755
--- a/cg-commit
+++ b/cg-commit
@@ -398,7 +398,7 @@ fi
 
 if [ "$msgfile" ]; then
 	[ "$written" ] && echo >>"$LOGMSG"
-	cat "$msgfile" >>"$LOGMSG" || exit 1
+	cat "$_git_relpath$msgfile" >>"$LOGMSG" || exit 1
 	written=1
 fi
 

-- 
Jonas Fonseca
