From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 FIXUP 22/25] fixup! string_list_add_refs_by_glob(): add a comment about memory management
Date: Fri, 31 May 2013 00:05:51 +0200
Message-ID: <1369951551-25662-1-git-send-email-mhagger@alum.mit.edu>
References: <87ppwaurfy.fsf@linux-k42r.v.cablecom.net>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 31 00:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiAzM-0007X4-3N
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 00:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab3E3WGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 18:06:25 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58109 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758178Ab3E3WGX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 18:06:23 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-0a-51a7cd5e8805
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BF.F4.02380.E5DC7A15; Thu, 30 May 2013 18:06:22 -0400 (EDT)
Received: from michael.fritz.box (p57A24A59.dip0.t-ipconnect.de [87.162.74.89])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4UM5vX8031018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 May 2013 18:06:20 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <87ppwaurfy.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBt3dnmgwdz95hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzlh0Or/gNUvFgnWXmBoY/zF3MXJySAiYSCy8e4IRwhaTuHBvPVsX
	IxeHkMBlRolLhx+xQzjnmSSW3r0D1sEmoCuxqKeZCcQWEXCUOPHgOitIEbNAL6PEw0ffwRLC
	AjkSB1r+gzWwCKhKTL23ECzOK+Ai8eXpQhaIdXIS7+/sArM5Bcwldk7qBqsREjCTmPD8FeME
	Rt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUICjW8HY/t6mUOMAhyM
	Sjy8B1OWBwqxJpYVV+YeYpTkYFIS5f15CijEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFfyKFCO
	NyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBW30GqFGwKDU9tSItM6cE
	Ic3EwQkiuEA28ABtSAUp5C0uSMwtzkyHKDrFqCglzhsKkhAASWSU5sENgKWEV4ziQP8I81aC
	VPEA0wlc9yugwUxAg59Ygw0uSURISTUwzhAolCpPX/BvdjnLHd4um4CCkptffu34wuvy7l33
	I5dNpqGn9kxSZow7eiqWI964eW4X57XDW6J3+zRMv9ozdbF/apXeDfUmxzuFlYXL7zftznq6
	5TTnxcv6Wao7xQVWtxz81H1i4sLLHyKL05kP69sYbxNyb77SxKtxIcTrbseNug83 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226039>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Junio, would you mind squashing this patch onto mh/reflife 22/25?

 notes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/notes.c b/notes.c
index 602d956..b69c0b8 100644
--- a/notes.c
+++ b/notes.c
@@ -932,6 +932,7 @@ static int string_list_add_one_ref(const char *refname, const unsigned char *sha
  */
 void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 {
+	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
 		for_each_glob_ref(string_list_add_one_ref, glob, list);
 	} else {
-- 
1.8.3
