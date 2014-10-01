From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 13/38] prepare_index(): declare return value to be (const char *)
Date: Wed,  1 Oct 2014 12:28:17 +0200
Message-ID: <1412159322-2622-14-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9t-0002YE-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbaJAK3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:16 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42555 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489AbaJAK3M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:12 -0400
X-AuditID: 12074414-f79446d000001f1d-73-542bd778e9b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B4.61.07965.877DB245; Wed,  1 Oct 2014 06:29:12 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6C026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:10 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1K24rh1icGUrm0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Blbli9mKZjMUfG2vZ2xgfEqWxcj
	J4eEgInEtvsN7BC2mMSFe+uB4lwcQgKXGSW2ftnKCOEcZ5JY/mciK0gVm4CuxKKeZiYQW0RA
	TWJi2yEWkCJmgcVMEhMObQIbKywQIrHs/nxmEJtFQFXiwLbDYM28Ai4S/Yc/s0Csk5PYsPs/
	I4jNCRRffrkZLC4k4Cyx485XpgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW
	6KWmlG5ihISjyA7GIyflDjEKcDAq8fAqJGiHCLEmlhVX5h5ilORgUhLlXXQJKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmEN/sAUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxW
	hoNDSYKX4RpQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoOuKLgfEBkuIB2usM
	0s5bXJCYCxSFaD3FqMuxrvNbP5MQS15+XqqUOG8mSJEASFFGaR7cCljyecUoDvSxMG84SBUP
	MHHBTXoFtIQJaEnyGrAlJYkIKakGxuZ9Xq3h+b8OCN8N0s4r2/zs5eZz92+d1bftZp7AoKbt
	2pDXGqOeeNPhWPKDtdKLVmvu3Zvcv6n+lqeD4N+Vy1Sbt2qYWGl+UZqf8XtBq+T+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257704>

Declare the return value to be const to make it clear that we aren't
giving callers permission to write over the string that it points at.
(The return value is the filename field of a struct lock_file, which
can be used by a signal handler at any time and therefore shouldn't be
tampered with.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b0fe784..70f5935 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -315,8 +315,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix,
-			   const struct commit *current_head, int is_status)
+static const char *prepare_index(int argc, const char **argv, const char *prefix,
+				 const struct commit *current_head, int is_status)
 {
 	struct string_list partial;
 	struct pathspec pathspec;
-- 
2.1.0
