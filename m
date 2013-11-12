From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 6/9] test-hg.sh: avoid obsolete 'test' syntax
Date: Tue, 12 Nov 2013 00:54:45 -0500
Message-ID: <1384235688-9655-7-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:55:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6wz-0000SH-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab3KLFzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:55:32 -0500
Received: from smtp.bbn.com ([128.33.1.81]:46278 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab3KLFzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:55:21 -0500
Received: from socket.bbn.com ([192.1.120.102]:44825)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6wa-0002PN-6h; Tue, 12 Nov 2013 00:55:20 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 8F00C40064
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237693>

The POSIX spec says that the '-a', '-o', and parentheses operands to
the 'test' utility are obsolete extensions due to the potential for
ambiguity.  Replace '-o' with '|| test' to avoid unspecified behavior.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-hg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index ceef6b1..5535e8c 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -83,7 +83,7 @@ check_push () {
 		test $ref_ret -ne 0 && echo "match for '$branch' failed" && break
 	done
 
-	if test $expected_ret -ne $ret -o $ref_ret -ne 0
+	if test $expected_ret -ne $ret || test $ref_ret -ne 0
 	then
 		return 1
 	fi
-- 
1.8.5.rc1.208.g8ff7964
