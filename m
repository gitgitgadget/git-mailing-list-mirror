From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] Makefile: Use the same source directory for "ln -s" as
 for "ln" / "cp"
Date: Thu, 5 Feb 2015 16:51:39 +0100
Message-ID: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:51:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJOiW-0002aw-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 16:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005AbbBEPvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 10:51:41 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:62217 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbbBEPvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 10:51:40 -0500
Received: by mail-yk0-f171.google.com with SMTP id 10so3527600ykt.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=23BSVEjqjXUIls2S3Rz/6HbBT6ySvn7aZrsPJ1LjmG0=;
        b=G6ZRuRz/34yG/zD4tUXl+IZN3/0Errcz5TqybzE7NGM0hwesiUutE0T2GowO00m6hF
         aTlWR0AbF4/gdQ167/HYKdg2LwH0Z5SG3Hi251O7tuc8uDVw0JDrZny2D/P4b3ToB3WW
         4bj73GRzWJ8eKtScqTcSkyJCmlAGMP4wu8cCUNnYOC0+917urnXs3vLlGinqwM943qFb
         IQFgqZqCFcHsZRhF6Nfw0axc+p+fNsgprigD+APMNFCAG0wKzPc6X1Duz5vPIkfJNjr4
         26fV+UWOesXqzP2GEvZKyrEYjP9ocWUa8fVNuJiDJ0zYVtppvaM/JgoYsckcjnGlxOuD
         t7hg==
X-Received: by 10.236.189.199 with SMTP id c47mr1794365yhn.68.1423151499617;
 Thu, 05 Feb 2015 07:51:39 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 07:51:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263374>

For consistency, we should use the same source for symbolic links as for
hard links and copies.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index c44eb3a..21f23cb 100644
--- a/Makefile
+++ b/Makefile
@@ -2265,14 +2265,14 @@ endif
         $(RM) "$$bindir/$$p" && \
         test -z "$(NO_INSTALL_HARDLINKS)" && \
         ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-        ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
+        ln -s "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
         cp "$$bindir/git$X" "$$bindir/$$p" || exit; \
     done && \
     for p in $(BUILT_INS); do \
         $(RM) "$$execdir/$$p" && \
         test -z "$(NO_INSTALL_HARDLINKS)" && \
         ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-        ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+        ln -s "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
         cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
     done && \
     remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
@@ -2280,7 +2280,7 @@ endif
         $(RM) "$$execdir/$$p" && \
         test -z "$(NO_INSTALL_HARDLINKS)" && \
         ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-        ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+        ln -s "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
         cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
     done && \
     ./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
-- 
2.1.2-mingw-1
