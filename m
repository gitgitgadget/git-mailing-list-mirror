From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/12] ref_transaction_delete(): check that old_sha1 is not null_sha1
Date: Thu, 12 Feb 2015 12:12:20 +0100
Message-ID: <1423739543-1025-10-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:20:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLroU-0007X8-D2
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbbBLLT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:19:57 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57873 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755012AbbBLLT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:19:56 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2015 06:19:56 EST
X-AuditID: 1207440e-f79bc6d000000c43-45-54dc8aadb06f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 26.F6.03139.DAA8CD45; Thu, 12 Feb 2015 06:12:45 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7c003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:43 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLu2606IwZMpwhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzeteGFpxnrfg/6wJTA+Nmli5GTg4JAROJ9609zBC2mMSFe+vZuhi5
	OIQELjNKLDj+gxXCOcEkcfvVSyaQKjYBXYlFPc1gtoiAmsTEtkNgk5gFVjNJbL3LBmILC0RI
	tJ87zA5iswioSpzonc8KYvMKuEhM2D+DDWKbnMT54z/BNnMCxd9damAEsYUEnCV2tW1hncDI
	u4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSJDx7WBsXy9ziFGAg1GJ
	h3eF6Z0QIdbEsuLK3EOMkhxMSqK8XK1AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8vk1AOd6U
	xMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO+6TqBGwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO0l6MLZG9xQWIuUBSi9RSjLseC9v0zmYRY
	8vLzUqXEee+D7BAAKcoozYNbAUsprxjFgT4W5r0DUsUDTEdwk14BLWECWjJxxm2QJSWJCCmp
	BsatWR9rN+vVOPcl7OM40isZoSbBnKU/MeD15ruvnry3iroRw68509AmrbvMnulCSpLjytLT
	BZVC6dW3GlQ4y5YcCY90aw1IfHFt2ZP9fR3++9wZV+yTPuPWcrRVqn/ficlF6zzM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263727>

It makes no sense to delete a reference that is already known not to
exist.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index 3f78fac..9dd7932 100644
--- a/refs.c
+++ b/refs.c
@@ -3702,6 +3702,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
+	if (old_sha1 && is_null_sha1(old_sha1))
+		die("BUG: delete called with old_sha1 set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_sha1, old_sha1,
 				      flags, msg, err);
-- 
2.1.4
