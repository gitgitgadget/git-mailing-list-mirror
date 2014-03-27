From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 09/10] t4213: test --function-name option
Date: Thu, 27 Mar 2014 14:50:55 -0400
Message-ID: <4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOy-0004xo-MG
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbaC0Svh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:37 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47681 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757222AbaC0Svg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:36 -0400
X-AuditID: 1207440f-f79326d000003c9f-fb-53347336d839
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 92.D4.15519.63374335; Thu, 27 Mar 2014 14:51:34 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TR013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:33 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsUixO6iqGtWbBJscH+mnsXclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4Mroe3SHseCBcMW2KT4NjNMEuhg5OSQETCTuPHzGDGGLSVy4t56ti5GLQ0jgMqPE684r
	rBDOSiaJhxdPsINUsQk4S2z6tZ8JxBYREJd4e3wmO0gRs8BCRom3eyaDjRIWsJR4du4jI4jN
	IqAqcbFrFVgDr0CUxP2jr1kh1hlIfHp2BqyeU8BBYvL8jUA2B9A2e4mPS20hwtESr7cuZgOx
	hYBaX289yTKBkX8BI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJAQ5N/B
	2LVe5hCjAAejEg+vg4VJsBBrYllxZe4hRgkOZiUR3rkFQCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK86kvU/YQE0hNLUrNTUwtSi2CyTBycUg2MHP8nvTsYc0lzwYRrd/uS9HSL/W9tz526Sel+
	/cK4lxX8VraSU9+cveV7bbbL/ueNjzNtzwj6HL1zVj7WaN4voxWsk02Py72PfRvlGKBeFN9U
	6bPo1KvybXFXvl2NPjfzbMbHXL9DUjkiNmoz6jS2LGPnFtSxn5FyqJBn8+VwAVELmRSp8t3e
	SizFGYmGWsxFxYkAWQT9Ej0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245314>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

This test builds a sample C file, adding and removing functions, and
checks that the right commits are filtered by --function-name matching.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 t/t4213-log-function-name.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100755 t/t4213-log-function-name.sh

diff --git a/t/t4213-log-function-name.sh b/t/t4213-log-function-name.sh
new file mode 100755
index 0000000..1243ce5
--- /dev/null
+++ b/t/t4213-log-function-name.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='log --function-name'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* diff=cpp" > .gitattributes
+
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+
+	printf "int main(){\n\treturn 0;\n}\n" >> file &&
+	test_tick &&
+	git commit -am second
+
+	printf "void newfunc(){\n\treturn;\n}\n" >> file &&
+	test_tick &&
+	git commit -am third
+
+	printf "void newfunc2(){\n\treturn;\n}\n" | cat - file > temp &&
+	mv temp file &&
+	test_tick &&
+	git commit -am fourth
+
+	printf "void newfunc3(){\n\treturn;\n}\n" | cat - file > temp &&
+	mv temp file &&
+	test_tick &&
+	git commit -am fifth
+
+	sed -i -e "s/void newfunc2/void newfunc4/" file &&
+	test_tick &&
+	git commit -am sixth
+'
+
+test_expect_success 'log --function-name=main' '
+	git log --function-name=main >actual &&
+	git log --grep=second >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --function-name "newfunc\W"' '
+	git log --function-name "newfunc\W" >actual &&
+	git log --grep=third >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --function-name "newfunc2"' '
+	git log --function-name newfunc2 >actual &&
+	git log -E --grep "sixth|fourth" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --function-name "newfunc3"' '
+	git log --function-name newfunc3 >actual &&
+	git log --grep=fifth >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --function-name "newfunc4"' '
+	git log --function-name newfunc4 >actual &&
+	git log --grep=sixth >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --function-name "newfunc"' '
+	git log --function-name newfunc >actual &&
+	git log -E --grep "third|fourth|fifth|sixth" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.12.4 (Apple Git-37)
