From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] gitk: disable checkout of remote branch
Date: Tue, 3 Nov 2009 21:30:12 +0530
Message-ID: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 17:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5LoM-0006vd-3O
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 17:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbZKCQAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 11:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbZKCQAL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 11:00:11 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:54569 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbZKCQAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 11:00:08 -0500
Received: by iwn10 with SMTP id 10so4192188iwn.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=82FLvd55MZU6SulSa6vR97BzyQcWTy7J7c/Vn6KSyDo=;
        b=jCcOm2fVY9/RWB/PM7hRmK1qEoB0KwEeMv2Of5il3pAcH7tKiUI8TAJCQQSopiFph8
         NKTIqdEhL0IbW5zhJGprJzWGRvzCL3iNyDhYoS/Z0EcMwi4o9gss6Gk+oOnOGfUHzyLL
         97BVeuhfM3NqS1TUDT1sOISBxtYrnUHtGfUqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=gfbbaVLrco+B9vA/b232wx09k/WR0Nic2Z63Bz3rKH6eDRc0GvNvrgDNNyZxAbWilB
         9re4CN6K0eDXzf5gUIHb9V2+vPREtW91TwIb1TvKAUrdF/1kF2wcfkiuS5NtkkfKLcz5
         W3tqjgJ7mKjzAN91PapY1/Gxd1u8Czay6l/w0=
Received: by 10.231.9.218 with SMTP id m26mr499697ibm.29.1257264012800; Tue, 
	03 Nov 2009 08:00:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131975>

At the command line, this gives you a detailed warning message, but the
GUI currently allows it without any fuss.

Since the GUI is often used by people much less familiar with git, it
seems reasonable to make the GUI more restrictive than the command line,
not less.

This prevents a lot of detached HEAD commits by new users.

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---
 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index db5ec54..95e27d4 100755
--- a/gitk
+++ b/gitk
@@ -8897,6 +8897,9 @@ proc headmenu {x y id head} {
     set headmenuid $id
     set headmenuhead $head
     set state normal
+    if {[string match "remotes/*" $head]} {
+	set state disabled
+    }
     if {$head eq $mainhead} {
 	set state disabled
     }
-- 
1.6.5
