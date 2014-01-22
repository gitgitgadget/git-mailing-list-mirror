From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 09/11] git p4: fix an error message when "p4 where" fails
Date: Wed, 22 Jan 2014 17:47:27 -0500
Message-ID: <1390430849-11436-9-git-send-email-pw@padd.com>
References: <20140122224421.GB4047@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:50:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66cl-0006Ov-PG
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbaAVWuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:50:13 -0500
Received: from honk.padd.com ([74.3.171.149]:41865 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbaAVWuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:50:13 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 4FE17712D;
	Wed, 22 Jan 2014 14:50:12 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B2C25200AB; Wed, 22 Jan 2014 17:50:09 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <20140122224421.GB4047@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240880>

When "p4 where" fails, for whatever reason, the error message tries to
show an undefined variable.  This minor bug applies only when using a
client spec, and was introduced recently in 9d57c4a (git p4: implement
view spec wildcards with "p4 where", 2013-08-30).

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 39a0fa0..db43629 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1871,7 +1871,7 @@ class View(object):
                 # assume error is "... file(s) not in client view"
                 continue
             if "clientFile" not in res:
-                die("No clientFile from 'p4 where %s'" % depot_path)
+                die("No clientFile in 'p4 where' output")
             if "unmap" in res:
                 # it will list all of them, but only one not unmap-ped
                 continue
-- 
1.8.5.2.364.g6ac45cd
