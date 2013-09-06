From: Andreas Krey <a.krey@gmx.de>
Subject: [PATCH 3/3] clone: test the new HEAD detection logic
Date: Fri, 6 Sep 2013 17:57:53 +0200
Message-ID: <20130906155753.GH12966@inner.h.apk.li>
References: <20130906155204.GE12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 17:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHyR7-0001eU-6y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 17:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab3IFP67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 11:58:59 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51633 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab3IFP66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 11:58:58 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86FvrB01188;
	Fri, 6 Sep 2013 17:57:53 +0200
Content-Disposition: inline
In-Reply-To: <20130906155204.GE12966@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234056>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Andreas Krey <a.krey@gmx.de>
---
 t/t5601-clone.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..ccda6df 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -285,4 +285,15 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
 	git clone "./foo:bar" foobar
 '
 
+test_expect_success 'clone from a repository with two identical branches' '
+
+	(
+		cd src &&
+		git checkout -b another master
+	) &&
+	git clone src target-11 &&
+	test "z$( cd target-11 && git symbolic-ref HEAD )" = zrefs/heads/another
+
+'
+
 test_done
-- 
1.8.3.1.485.g9704416.dirty
