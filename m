From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/21] t1430: test the output and error of some commands more carefully
Date: Wed, 23 Mar 2016 11:04:18 +0100
Message-ID: <b7e3b3bfbd8b4db7c3a76ecf7dcf8466a302c063.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifme-0001Ah-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbcCWKMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:40 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49379 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037AbcCWKMg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:36 -0400
X-AuditID: 1207440c-98bff700000008b4-94-56f26a404a09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 07.D9.02228.04A62F65; Wed, 23 Mar 2016 06:04:48 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g16018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:47 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOuY9SnM4NRMZouuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZjx/vYi3YLlLx4uNkpgbG6YJdjJwcEgImEoe/X2TsYuTiEBLYyijx
	+ON8ZgjnJJPEvCkr2ECq2AR0JRb1NDOB2CICahIT2w6xgBQxCyxglNi4eDEzSEJYIFxiS/Ns
	RhCbRUBV4ubtF2A2r0CUxJzuJjaIdUoSGx5cABvEKWAhcfLkUrAaIQFzie0P1jJNYORZwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkoHh2MH5bJ3OIUYCDUYmHV+LM
	xzAh1sSy4srcQ4ySHExKorzngz6FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLhbc4EyvGmJFZW
	pRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHjbQRoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQVEQXwyMA5AUD9DeVrC9xQWJuUBRiNZTjIpS4rzeIAkBkERGaR7c
	WFiaeMUoDvSlMO9KkCoeYIqB634FNJgJaPBCH7DBJYkIKakGRvGONeLzg3fz/M1j3PY0554L
	y9WV1tfFigT/hlvdTbbJO/NW6q7D34J9nVE6j3TjSluYF7KqHI4y+8m3+4zz0j1T3x02XOSw
	+tULhZiH84o4r17qY3zW5/di15tv+oyT03b7v9vO73531j3+V7s+K/Y3RRf9O/VD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289619>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c465abe..005e2b1 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -42,7 +42,7 @@ test_expect_success 'git branch shows badly named ref as warning' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch >output 2>error &&
-	grep -e "broken\.\.\.ref" error &&
+	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -152,21 +152,25 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
-	test_i18ngrep "ignoring.*refs/tags/shadow" err
+	test_i18ngrep "ignoring dangling symref refs/tags/shadow" err
 '
 
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
 	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	test_path_is_file .git/refs/heads/badname &&
-	git update-ref --no-deref -d refs/heads/badname &&
-	test_path_is_missing .git/refs/heads/badname
+	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_must_be_empty output &&
+	test_must_be_empty error
 '
 
 test_expect_success 'update-ref -d can delete broken name' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git update-ref -d refs/heads/broken...ref &&
+	git update-ref -d refs/heads/broken...ref >output 2>error &&
+	test_must_be_empty output &&
+	test_must_be_empty error &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
@@ -175,7 +179,9 @@ test_expect_success 'update-ref -d can delete broken name' '
 test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
 	echo precious >.git/my-private-file &&
 	echo precious >expect &&
-	test_must_fail git update-ref -d my-private-file &&
+	test_must_fail git update-ref -d my-private-file >output 2>error &&
+	test_must_be_empty output &&
+	test_i18ngrep -e "cannot lock .*: unable to resolve reference" error &&
 	test_cmp expect .git/my-private-file
 '
 
-- 
2.8.0.rc3
