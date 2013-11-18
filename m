From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 6/9] test-hg.sh: avoid obsolete 'test' syntax
Date: Sun, 17 Nov 2013 23:12:47 -0500
Message-ID: <1384747970-25481-7-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDb-000452-OH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab3KRENi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:38 -0500
Received: from smtp.bbn.com ([128.33.0.80]:51518 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab3KRENW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:22 -0500
Received: from socket.bbn.com ([192.1.120.102]:57938)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGDC-0009cr-5M; Sun, 17 Nov 2013 23:13:22 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 6869440222
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237971>

The POSIX spec says that the '-a', '-o', and parentheses operands to
the 'test' utility are obsolete extensions due to the potential for
ambiguity.  Replace '-o' with '|| test' to avoid unspecified behavior.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
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
