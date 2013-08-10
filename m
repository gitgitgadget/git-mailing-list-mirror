From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/2] git p4 test: sanitize P4CHARSET
Date: Sat, 10 Aug 2013 16:15:12 -0400
Message-ID: <1376165713-26170-1-git-send-email-pw@padd.com>
References: <20130810201123.GA31706@padd.com>
Cc: git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 22:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8FZK-0004nc-0w
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 22:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754Ab3HJUPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 16:15:17 -0400
Received: from honk.padd.com ([74.3.171.149]:49971 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758703Ab3HJUPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 16:15:17 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 6AF662B8F;
	Sat, 10 Aug 2013 13:15:16 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D164322855; Sat, 10 Aug 2013 16:15:13 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc2.88.ga5463da
In-Reply-To: <20130810201123.GA31706@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232110>

From: kazuki saitoh <ksaitoh560@gmail.com>

In the tests, p4d is started without using "internationalized
mode".  Make sure this environment variable is unset, otherwise
a mis-matched user setting would break the tests.  The error
message would be "Unicode clients require a unicode enabled server."

[pw: use unset, add commit text]

Signed-off-by: Kazuki Saitoh <ksaitoh560@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2098b9b..ccd918e 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -48,7 +48,8 @@ P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 P4PORT=localhost:$P4DPORT
 P4CLIENT=client
 P4EDITOR=:
-export P4PORT P4CLIENT P4EDITOR
+unset P4CHARSET
+export P4PORT P4CLIENT P4EDITOR P4CHARSET
 
 db="$TRASH_DIRECTORY/db"
 cli="$TRASH_DIRECTORY/cli"
-- 
1.8.4.rc2.88.ga5463da
