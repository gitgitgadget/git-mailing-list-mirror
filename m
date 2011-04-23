From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 09/23] Introduce --tag-exists
Date: Sat, 23 Apr 2011 17:22:38 +1000
Message-ID: <1303543372-77843-10-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCe-0004tb-Ja
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab1DWHYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:16 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1DWHYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:14 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gcW/zsUkWTRII9O4po+MhbC2Gao6Xvs6yzv+1G5Y2BE=;
        b=cHQMwrUzx3pVVJ1HTNLJBVzwhm3rNhaz1YpBhU3D9vr5BEBa82gReTavTIFnhh3YvG
         nrLpybE33FhSQHEnxwoVrRKUZE79yNkbMgfRvNfrHiJi5x3Y2/fSNU/YshoUFN2QQCG5
         rG8eFEWmuVHuSq5Zie8hXhZy8wWssvY/zCELg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JF7vSmFcpToXuW2TtnrJItfM4jgTrEBkjUaxbE8SqOoXWkqIH9IywY6yzKFXWmrSfx
         NdH/VYN7e689PAkZyYAirTDemRPw021V+IXASA64qwx5bCJRdgL7XJJLXPXiT/kqduHS
         8KwVuMt9ouZqXFcQZQnYGTPTqxB8IhQMw3OMQ=
Received: by 10.68.65.229 with SMTP id a5mr2814028pbt.474.1303543454061;
        Sat, 23 Apr 2011 00:24:14 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171964>

tweak tag

tweak tag
---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index ea54d20..69c8710 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -78,6 +78,8 @@ CONDITIONS
 	Tests if the head is (not) detached.
 '--branch-exists'|'--not-branch-exists branch'::
         Tests if the specified branch does (not) exist.				    
+'--tag-exists'|'--not-tag-exists tag'::
+        Tests if the specified tag does (not) exist.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 5d7a7f8..93a916a 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -87,5 +87,17 @@ check_branch_exists_1()
 	fi
 }
 
+check_tag_exists_1()
+{
+	symbolic=$(git rev-parse --quiet --symbolic-full-name --verify "$1")
+ 	if test "${symbolic#refs/tags/}" != "${symbolic}"
+	then
+		echo "Tag '$1' exists."
+	else
+		echo "Tag '$1' does not exist."
+		false
+	fi
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622
