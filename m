From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/21] t1430: don't rely on symbolic-ref for creating broken symrefs
Date: Wed, 23 Mar 2016 11:04:20 +0100
Message-ID: <766a2dc4a13b4e2f98a256455d35f1aade548be9.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifli-0000Ak-R3
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbcCWKL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:11:58 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49316 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbcCWKL5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:11:57 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:11:56 EDT
X-AuditID: 12074411-fe7ff700000071cf-c3-56f26a43e40d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4B.17.29135.34A62F65; Wed, 23 Mar 2016 06:04:51 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g18018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:50 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqOuS9SnM4O5WBYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZiz/uYSn4yFXxt3MqWwPjYs4uRk4OCQETiR8TvrJ2MXJxCAlsZZRo
	edfODuGcZJLo+7abFaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwAJGiY2LFzN3MXJwCAuESDz8
	YAFisgioSnyZFAJi8gpESbw7rQixS0liw4MLYFM4BSwkTp5cyghiCwmYS2x/sJZpAiPPAkaG
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghoSS4g3HGSblDjAIcjEo8vIXn
	PoYJsSaWFVfmHmKU5GBSEuU9H/QpTIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb0gGUI43JbGy
	KrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMF7LR2oUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4U/vHFwAgASfEA7Y0E21tckJgLFIVoPcWoKCXOqwGSEABJZJTm
	wY2FJYhXjOJAXwrz1oNU8QCTC1z3K6DBTECDF/qADS5JREhJNTByeC476sB3bHf1vJQArq6U
	iwkNz5eZGc46n+Z+U6aiYe6O7c9n3fsUtmz1ktV2dotztI/tPiGW9K9s+5LpeyvKxZYnfXiX
	mZ1QdUhR65lZ+19HgVNSN1nmC7AfP3Ok59K3/kn/ZFa2/7Pi5G672TNBd0fHkaC8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289627>

It's questionable whether it should even work.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index cb815ab..a963951 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -147,7 +147,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch shadow one &&
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	git symbolic-ref refs/tags/shadow refs/heads/broken...ref &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
 	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
@@ -156,7 +156,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
-	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	test_path_is_file .git/refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-- 
2.8.0.rc3
