From: mhagger@alum.mit.edu
Subject: [PATCH 1/7] t0000: verify that absolute_path() fails if passed the empty string
Date: Tue,  4 Sep 2012 10:14:24 +0200
Message-ID: <1346746470-23127-2-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oIN-0007eK-9d
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab2IDIPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:15:20 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:62095 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894Ab2IDIPI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:15:08 -0400
X-AuditID: 1207440d-b7f236d000000943-a3-5045b88a0524
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 36.5E.02371.A88B5405; Tue,  4 Sep 2012 04:15:06 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSV025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:05 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqNu1wzXAYPVrU4uuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGZeOT2Qq
	2MNaMXHBUtYGxj0sXYycHBICJhL/fi9lhbDFJC7cW8/WxcjFISRwmVHi5aUF7BDOaSaJt01v
	GEGq2ASkJF429rCD2CICahIT2w6BTWIWSJc4saAdzBYWiJDY+OwMM4jNIqAq8avnBNgGXgEX
	iZ7jE6C2KUr8+L4GrIZTwFXi1YfXQJs5gJa5SHx84DyBkXcBI8MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl0jvdzMEr3UlNJNjJDw4d3B+H+dzCFGAQ5GJR7eyk8uAUKsiWXFlbmHGCU5mJRE
	ee02uwYI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG9vRoox5uSWFmVWpQPk5LmYFES51Vbou4n
	JJCeWJKanZpakFoEk5Xh4FCS4N23HahRsCg1PbUiLTOnBCHNxMEJIrhANvAAbXgEUshbXJCY
	W5yZDlF0ilFRSpx3BUhCACSRUZoHNwAW6a8YxYH+EeZdD1LFA0wScN2vgAYzAQ12fe8CMrgk
	ESEl1cDY2j+bta5Iee/hfZevr7q8JvD8lDNPZZRv6pzeefXv18jmr2vZDTIezYitCW3eMHcP
	Y+ATvZebVxhvv8IVlX1WqOXou7/G+/mXvuZguv6gtjnvw5yT1/22s5UkbWervv+vNuaRP8dP
	vQ6nsslTVzS95T7ROZ3v4kK3CdsyXVNdbjP5Xdh2fLpsphJLcUaioRZzUXEiABmG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204723>

From: Michael Haggerty <mhagger@alum.mit.edu>

It doesn't, so mark the test as failing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0000-basic.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ccb5435..7347fb8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -450,6 +450,10 @@ test_expect_success 'update-index D/F conflict' '
 	test $numpath0 = 1
 '
 
+test_expect_failure 'absolute path rejects the empty string' '
+	test_must_fail test-path-utils absolute_path ""
+'
+
 test_expect_success SYMLINKS 'real path works as expected' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
-- 
1.7.11.3
