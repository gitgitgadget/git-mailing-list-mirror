From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] diff_scoreopt_parse(): use skip_prefix_if_present()
Date: Wed,  5 Feb 2014 07:25:16 +0100
Message-ID: <1391581517-8586-3-git-send-email-mhagger@alum.mit.edu>
References: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
Cc: "Kent R. Spillner" <kspillner@acm.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 07:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAvwO-0004mm-3y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 07:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbaBEG0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 01:26:23 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49373 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563AbaBEGZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 01:25:59 -0500
X-AuditID: 12074413-b7fc76d000002aba-70-52f1d976093d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B3.8C.10938.679D1F25; Wed,  5 Feb 2014 01:25:58 -0500 (EST)
Received: from michael.fritz.box (p57A24DEA.dip0.t-ipconnect.de [87.162.77.234])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s156POxw019775
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Feb 2014 01:25:57 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqFt282OQweQzhhZdV7qZLBp6rzBb
	PNjxk8ni9or5zBbdU94yOrB6XL7i7fH3/Qcmj52z7rJ7XLyk7PF5k1wAaxS3TVJiSVlwZnqe
	vl0Cd8a8Pd1sBSs5K6b9Oc7SwLiWvYuRk0NCwETi0+6ZzBC2mMSFe+vZuhi5OIQELjNKTPmy
	ngXCOc4kcaFlEVgVm4CuxKKeZiYQW0RATWJi2yGwImaB04wSHyf+Yu1i5OAQFvCQOHgjD6SG
	RUBVYs8ciA28As4SX2f+ZYTYpiDRsmwX2BWcAi4Sf3/fBLOFgGpmzz/EPoGRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkJAS3sG466TcIUYBDkYlHl4D4Y9BQqyJ
	ZcWVuYcYJTmYlER5628AhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwJnYD5XhTEiurUovyYVLS
	HCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErypIEMFi1LTUyvSMnNKENJMHJwgggtkAw/Q
	huUghbzFBYm5xZnpEEWnGBWlxHmTQBICIImM0jy4AbDof8UoDvSPMO9SkCoeYOKA634FNJgJ
	aPA61/cgg0sSEVJSDYzq37gUHj1Jao5ztik44Bx0Zy33yi1Ly9y9or80B9mnWV5e3vvz0JWA
	ixNm/jssdnD7co3GsFvTGWPmJd5Ov3I//sqUgu7onnsW6foS3r2cP7boHfZq/LOIu3N6X6cW
	u+yhOf93d8aZHdBtkBdu9P6u9W0n4yK1NyF8xS8ENCyYebKO/7XQmKvEUpyRaKjF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241596>

Whenever skip_prefix_defval() was called, opt was still equal to
*opt_p.  So we can use skip_prefix_if_present() instead.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d629cc5..a07fe9d 100644
--- a/diff.c
+++ b/diff.c
@@ -3890,13 +3890,13 @@ static int diff_scoreopt_parse(const char **opt_p)
 	*opt_p = opt;
 	if (cmd == '-') {
 		/* convert the long-form arguments into short-form versions */
-		if ((opt = skip_prefix_defval(opt, "break-rewrites", *opt_p)) != *opt_p) {
+		if ((opt = skip_prefix_if_present(opt, "break-rewrites")) != *opt_p) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'B';
-		} else if ((opt = skip_prefix_defval(opt, "find-copies", *opt_p)) != *opt_p) {
+		} else if ((opt = skip_prefix_if_present(opt, "find-copies")) != *opt_p) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if ((opt = skip_prefix_defval(opt, "find-renames", *opt_p)) != *opt_p) {
+		} else if ((opt = skip_prefix_if_present(opt, "find-renames")) != *opt_p) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'M';
 		}
-- 
1.8.5.3
