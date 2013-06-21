From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/16] t/t5505-remote: use test_path_is_missing
Date: Fri, 21 Jun 2013 16:42:27 +0530
Message-ID: <1371813160-4200-4-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzK5-00036l-KM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965508Ab3FULQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:05 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:45644 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab3FULQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:04 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so7701182pab.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=deiTX5dsHYVY7rG0nwGt3O3KYtxGQ+xGr6HUehNLokw=;
        b=zmaPYVIrR87jogz7EvAXBcGZWFRiSmGNPEQIbqYc7V2K7KitpxLr7wo2CVR3n8ComU
         GDEvtczXUtQP0JeLk7vn8qnhYFZY/Mkob/zIqHSobIGRszajXEwDs1Iohbag6YzCD8uj
         zU/T5KcvyPZ7e5uVoreggvlWA16mwgvtmb3HpG6wY4vTu3UDlCMI8S1HjcXaxju5Z6B9
         gxWGhOWfijpO2H0NcfpxYAXIceCACbRSOZCon9REe6e0rR6lXFkLRJSg9qRLeU4uJwnJ
         TcMslFNpxR1XI80+ZZfLpfaGuwlplsF2xihAYnaAz/L6elGcWlC7LHJaDm6hVXR4+uhk
         +ucw==
X-Received: by 10.67.5.70 with SMTP id ck6mr11028120pad.110.1371813363930;
        Fri, 21 Jun 2013 04:16:03 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228596>

Replace instances of ! test -f with test_path_is_missing.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 38c62ec..dcb6c2f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -682,7 +682,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	 mkdir -p .git/remotes &&
 	 cat ../remotes_origin > .git/remotes/origin &&
 	 git remote rename origin origin &&
-	 ! test -f .git/remotes/origin &&
+	 test_path_is_missing .git/remotes/origin &&
 	 test "$(git config remote.origin.url)" = "$origin_url" &&
 	 test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
 	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
@@ -696,7 +696,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 		git remote rm origin &&
 		echo "$origin_url" > .git/branches/origin &&
 		git remote rename origin origin &&
-		! test -f .git/branches/origin &&
+		test_path_is_missing .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
 		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
 		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
-- 
1.8.3.1.499.g7ad3486.dirty
