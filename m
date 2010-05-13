From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/7] grep: add test script for binary file handling
Date: Thu, 13 May 2010 22:34:59 +0200
Message-ID: <4BEC6273.7070603@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:35:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCf88-0005ck-HG
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126Ab0EMUfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:35:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:53158 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758505Ab0EMUfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:35:04 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 63BA92F806A;
	Thu, 13 May 2010 22:35:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147022>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t7008-grep-binary.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100755 t/t7008-grep-binary.sh

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
new file mode 100755
index 0000000..f9fd5e6
--- /dev/null
+++ b/t/t7008-grep-binary.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='git grep in binary files'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	printf 'binary\000file\n' >a &&
+	git add a &&
+	git commit -m.
+"
+
+test_expect_success 'git grep ina a' '
+	echo Binary file a matches >expect &&
+	git grep ina a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git grep -ah ina a' '
+	git grep -ah ina a >actual &&
+	test_cmp a actual
+'
+
+test_expect_success 'git grep -I ina a' '
+	: >expect &&
+	test_must_fail git grep -I ina a >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.1
