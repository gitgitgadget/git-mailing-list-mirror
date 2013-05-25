From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/25] string_list_add_refs_by_glob(): add a comment about memory management
Date: Sat, 25 May 2013 11:08:21 +0200
Message-ID: <1369472904-12875-23-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAUm-0005t7-Sv
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab3EYJKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:10:31 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:64455 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754464Ab3EYJJa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:30 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-4f-51a07fcaaadb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.4F.02295.ACF70A15; Sat, 25 May 2013 05:09:30 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guw000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:28 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHuqfkGgweS1zBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzji1cSJTwTK2ihtzVzE1MPazdjFyckgImEhMudDLAmGLSVy4t54N
	xBYSuMwoMfswcxcjF5B9gUni49b5YEVsAroSi3qamUBsEQFHiRMPrrOCFDEL9DJKPHz0HSwh
	LBAv8WPGe7AGFgFViblbpoNN5RVwlbjy+QMjxDYFicuz1gBt4ODgBIq/PcEJsdhF4vmnc6wT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAgJM54djN/WyRxiFOBg
	VOLhFSyfHyjEmlhWXJl7iFGSg0lJlJe/dkGgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFehhSg
	HG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgpcJGE9CgkWp6akVaZk5
	JQhpJg5OEMEFsoEHaAMXSCFvcUFibnFmOkTRKUZFKXHem3VACQGQREZpHtwAWEJ4xSgO9I8w
	712QKh5gMoHrfgU0mAlo8M3c+SCDSxIRUlINjO4rjT64N0VHGx19vfvrks+LuM/EqrBEzX2+
	m4f9ycIoc6M3fVoq3oea/0v3+ZSx5f1565/EErpOyI9doaZOVoqrbNtNlV1p3m5H5UqvrvW/
	6lEWv/wfa0pt8f+aeZESE3c9WlbjW5H/iO//4eSvVx6uWB/ONtUxfueE1rcfmSd/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225508>

Since string_list_add_one_ref() adds refname to the string list, but
the lifetime of refname is limited, it is important that the
string_list passed to string_list_add_one_ref() has strdup_strings
set.  Document this fact.

All current callers do the right thing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/notes.c b/notes.c
index fa7cdf7..602d956 100644
--- a/notes.c
+++ b/notes.c
@@ -927,6 +927,9 @@ static int string_list_add_one_ref(const char *refname, const unsigned char *sha
 	return 0;
 }
 
+/*
+ * The list argument must have strdup_strings set on it.
+ */
 void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 {
 	if (has_glob_specials(glob)) {
-- 
1.8.2.3
