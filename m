From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 5/8] svn-fe: allow svnrdump_sim.py to run with Python 3
Date: Thu, 17 Jan 2013 18:53:58 +0000
Message-ID: <649f0d65308358637d923483df6b780ebcce5d82.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvudu-0005Dz-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab3AQS4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:56:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56515 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab3AQS43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:56:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 02C4ECDA56C;
	Thu, 17 Jan 2013 18:56:29 +0000 (GMT)
X-Quarantine-ID: <FFMITrL8nAX3>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFMITrL8nAX3; Thu, 17 Jan 2013 18:56:23 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 38B59CDA5AE;
	Thu, 17 Jan 2013 18:56:22 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 1D522276DFE;
	Thu, 17 Jan 2013 18:56:22 +0000 (GMT)
X-Quarantine-ID: <BJeXSv5oYcbj>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJeXSv5oYcbj; Thu, 17 Jan 2013 18:56:21 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 9F5C8276DFB;
	Thu, 17 Jan 2013 18:56:10 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213867>

The changes to allow this script to run with Python 3 are minimal and do
not affect its functionality on the versions of Python 2 that are
already supported (2.4 onwards).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/svn-fe/svnrdump_sim.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 17cf6f9..4e78a1c 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -14,7 +14,7 @@ if sys.hexversion < 0x02040000:
 
 def getrevlimit():
         var = 'SVNRMAX'
-        if os.environ.has_key(var):
+        if var in os.environ:
                 return os.environ[var]
         return None
 
@@ -44,7 +44,7 @@ def writedump(url, lower, upper):
 
 if __name__ == "__main__":
         if not (len(sys.argv) in (3, 4, 5)):
-                print "usage: %s dump URL -rLOWER:UPPER"
+                print("usage: %s dump URL -rLOWER:UPPER")
                 sys.exit(1)
         if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
         url = sys.argv[2]
-- 
1.8.1.1.260.g99b33f4.dirty
