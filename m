From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 4/5] svn-fe: use svn-fe --no-progress in remote-svn-alpha
Date: Tue,  5 Jul 2011 22:45:49 +0600
Message-ID: <1309884350-13415-5-git-send-email-divanorama@gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:44:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe8jw-0002em-Ry
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 18:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330Ab1GEQom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 12:44:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49913 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab1GEQok (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 12:44:40 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4899798bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qkmTRz5dtpJ7vmnS8SZOZJqq3tEXHf8SfWsxFR7ZKy8=;
        b=u80pOm0IH745bMkJb6HyCxpCjIEVWXj39hXMknF32fAGMl8ZmaaHI5GJXJMUEdvqu5
         9D5q/kLorTuT/5s5u9RrbW8bVpovEfBFwUAc+L6HeAt113/xdSuNBlEhqDFjtxOWHzHS
         vxmU13ixj62Zn/HKqY3ncO/BXhV2+LrfQT/fk=
Received: by 10.204.16.145 with SMTP id o17mr6869550bka.154.1309884280097;
        Tue, 05 Jul 2011 09:44:40 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id l24sm6696272bkw.15.2011.07.05.09.44.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 09:44:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176614>

svn-fe by default  produces a progress line for each imported revision.
For large repos it stresses the terminal and a user, possibly scrolls
away error messages.

Just disable progress lines for now.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index 84d841e..d75bc2a 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -37,7 +37,7 @@ SVNDUMP=${SVNDUMP:-`try_svnadmin`}
 
 do_import () {
 	revs=$1 url=$2
-	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe) 3<&0 || die "FAILURE"
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
-- 
1.7.3.4
