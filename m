From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/13] remote-hg: trivial test cleanups
Date: Tue,  2 Apr 2013 13:02:55 -0600
Message-ID: <1364929382-1399-7-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Vl-0006yp-H5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762106Ab3DBTEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:20 -0400
Received: from mail-gg0-f172.google.com ([209.85.161.172]:54581 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762098Ab3DBTES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:18 -0400
Received: by mail-gg0-f172.google.com with SMTP id f4so114199ggn.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sp5sVp5Gs2XPFDNAFbQO9ebMZjZR+/4huVcSZJY/cRc=;
        b=ML7Zc+nOfuWGjQuV1tWqKsnKjqf6phV8GAZCTsZeaPKMNQMoAkYFf7296I+x1eYHy2
         UjvwBTAwPqxrCtx5fxCfY8JVPpdabyCXFaYp4UtHVv3JAgRPXDQTerUn83b6hWMYB/s/
         t+jfuW6K10p24BPsfOxx8WCqHSxKWo2ia/bNWnpRMLRhvMO1QLVTd2WMkY4QuNuMJOMY
         DPhhJ74a+MSDk1z+Kqv0fomClwd6HoRSWcZGKyCP3Deiy5yNoadLGrA7fDIoIZzY8OmI
         DGprsmr9cOkUwI26mgoCMWkBgdkweXD0Lsq+fP7OuFX2xxMuPDsZMy0UYGx/3fdbbLf2
         49dg==
X-Received: by 10.236.163.199 with SMTP id a47mr16239760yhl.176.1364929457879;
        Tue, 02 Apr 2013 12:04:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s16sm4853050yhj.13.2013.04.02.12.04.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219836>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-bidi.sh   | 5 ++---
 contrib/remote-helpers/test-hg-hg-git.sh | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index fe38e49..a3c88f6 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -22,7 +22,6 @@ fi
 
 # clone to a git repo
 git_clone () {
-	hg -R $1 bookmark -f -r tip master &&
 	git clone -q "hg::$PWD/$1" $2
 }
 
@@ -201,8 +200,8 @@ test_expect_success 'hg branch' '
 	hg_push hgrepo gitrepo &&
 	hg_clone gitrepo hgrepo2 &&
 
-	: TODO, avoid "master" bookmark &&
-	(cd hgrepo2 && hg checkout gamma) &&
+	: Back to the common revision &&
+	(cd hgrepo && hg checkout default) &&
 
 	hg_log hgrepo > expected &&
 	hg_log hgrepo2 > actual &&
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index e116cb0..73ae18d 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -27,7 +27,6 @@ fi
 
 # clone to a git repo with git
 git_clone_git () {
-	hg -R $1 bookmark -f -r tip master &&
 	git clone -q "hg::$PWD/$1" $2
 }
 
@@ -48,7 +47,7 @@ git_clone_hg () {
 	(
 	git init -q $2 &&
 	cd $1 &&
-	hg bookmark -f -r tip master &&
+	hg bookmark -i -f -r tip master &&
 	hg -q push -r master ../$2 || true
 	)
 }
-- 
1.8.2
