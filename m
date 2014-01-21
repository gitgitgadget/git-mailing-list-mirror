From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 09/11] git p4: fix an error message when "p4 where" fails
Date: Tue, 21 Jan 2014 18:16:46 -0500
Message-ID: <1390346208-9207-10-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kbr-0002NS-QG
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbaAUXTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:19:52 -0500
Received: from honk.padd.com ([74.3.171.149]:36962 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbaAUXTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:19:51 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 4E3787112;
	Tue, 21 Jan 2014 15:19:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C173D200F7; Tue, 21 Jan 2014 18:19:48 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240799>

When "p4 where" fails, for whatever reason, the error message tries to
show an undefined variable.  This minor bug applies only when using a
client spec, and was introduced recently in 9d57c4a (git p4: implement
view spec wildcards with "p4 where", 2013-08-30).

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 26b874f..cdfa2df 100755
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
1.8.5.2.320.g99957e5
