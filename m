From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] test-lib.sh: show git init output when in verbose mode
Date: Thu, 26 Jun 2008 20:35:19 +0200
Message-ID: <1214505319-24946-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 20:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwKW-0005ib-Nb
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYFZSfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYFZSfZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:35:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:46419 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbYFZSfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:35:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so72038fgg.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=d8tnZcgwZx2nRSWXh5hYk05HelLRT7aLaJgv0z0nQak=;
        b=WInz0UFOLDXIvZuhHt1AyxHEVZtiLkGaKLxBjrGt+UqcqZ7RE7gmWjKe5q3bLqsona
         MYAUdPVDrhJiuriDpfOd+sji8uWMHde21EcCyxcOly93annKqb4uhRq8lgr/dkBWz/MU
         tgpA0uT2Z50LDWCyuiyVnpQ5cA6o7ZQsjpKc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=S2xZW4f357WOOQJkEb/x3f+jup7dF9w+rBh/R8Bj+ZV02a1Q+97kIa+4gAtzfYNwGD
         Gw6H/zQBwg3h5OeiQx+Oqr/KNLG5H6Pabn+wmma453EFBWraMU/XxUq1A7kfLHC1NOrz
         Q1zfmpxxNikpVi0jpfKGHdrRwzu36xDvxrcxw=
Received: by 10.86.30.9 with SMTP id d9mr572975fgd.8.1214505322438;
        Thu, 26 Jun 2008 11:35:22 -0700 (PDT)
Received: from fly ( [91.33.220.151])
        by mx.google.com with ESMTPS id e20sm821215fga.1.2008.06.26.11.35.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 11:35:21 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KBwJT-0006Uk-4C; Thu, 26 Jun 2008 20:35:19 +0200
X-Mailer: git-send-email 1.5.6.1.184.g27776.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86470>

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---

I've had a hard-to-spot problem where git would crash due to a missing
library, and this solved it. :)  IMHO there's no reason not to show the
git init output when --verbose is given.

(FD 3 and 4 are the streams where verbose output is redirected; in
non-verbose mode they're redirected to /dev/null.)

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a9fc621..8e2849b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -408,7 +408,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >/dev/null 2>&1 ||
+	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.5.6.1.184.g27776.dirty
