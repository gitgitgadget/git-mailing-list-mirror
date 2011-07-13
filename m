From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 5/9] svn-fe: use svn-fe --no-progress in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:49 +0600
Message-ID: <1310570813-16648-6-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1LB-0002iX-7E
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab1GMP0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:38 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1GMP0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:37 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2112126eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ij7Px9W+J/JIWb+7x73U+lw7GFg44c3qCTk2F0HVC6g=;
        b=U+iZbxA+HwnZZwNS51yiRD904uFvJKmb8U9rSRK4tNI/us18E0Qm9nhCaiDLL97mQJ
         4P87dQPT+Y6dN3wNHFobKrz97HxZIewqkH7Jr3DrdHyelPpPetISkOd2iIVOfXWKyLAj
         Nq8Yl84lNm5sqMCCpOUdcqB+4H+hWFtocO3aA=
Received: by 10.213.8.66 with SMTP id g2mr197435ebg.149.1310570796245;
        Wed, 13 Jul 2011 08:26:36 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177048>

svn-fe by default  produces a progress line for each imported revision.
For large repos it stresses the terminal and a user, possibly scrolls
away error messages.

Just disable progress lines for now.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index ca9d431..ed8da7b 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -59,7 +59,7 @@ test -n "$SVNDUMP" || die "neither svnrdump nor svnadmin & svnlook was found"
 
 do_import () {
 	revs=$1 url=$2
-	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe) 3<&0 || die "FAILURE"
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
-- 
1.7.3.4
