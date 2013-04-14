From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/33] refs: define constant PEELED_LINE_LENGTH
Date: Sun, 14 Apr 2013 14:54:20 +0200
Message-ID: <1365944088-10588-6-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMUH-0005c4-Pg
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab3DNMzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:32 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:60506 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865Ab3DNMzY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:24 -0400
X-AuditID: 12074414-b7fb86d000000905-ff-516aa73b091c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 84.A8.02309.B37AA615; Sun, 14 Apr 2013 08:55:23 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk2007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:22 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqGu9PCvQYNpEQ4uuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5Y07CdqeAJe8XeST+YGxgb2boYOTkkBEwkDl/azwRhi0lcuLceKM7FISRwmVHi1cQW
	VgjnLJPEiYdzmUGq2AR0JRb1NAN1cHCICGRL7F4rDxJmFnCQ2Py5kRHEFhawl2g7+okFxGYR
	UJVY8fQ4WJxXwEXieedBFohlChLHt28Di3MKuEpMf36MHcQWAqqZtXk26wRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQkJKZAfjkZNyhxgFOBiVeHgdWLIChVgT
	y4orcw8xSnIwKYnyKi4DCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhdWwFyvGmJFZWpRblw6Sk
	OViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfBqgAwVLEpNT61Iy8wpQUgzcXCCCC6QDTxA
	G94uBdlQXJCYW5yZDlF0ilFRSpz3I0hCACSRUZoHNwAW/a8YxYH+EeZ9ClLFA0wccN2vgAYz
	AQ322ZsOMrgkESEl1cC4YLVccO3yiQufm9TZpp3YmyuXOS/bzToiufn+ril6k5mlWt/2n1xy
	7a/i9QPi75ctvmBZarDka+rK/VoWvfs3CW8SbK6tWnr0Tpmsn3ed7+nkl55PNPuElqy4+Pvz
	ohgPiSIz3okbZWxa3Dk6SpcseFvzptrc7XbxxfiT63b7y/NyRT6afWCSEktxRqKh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221126>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 88ff153..7cbf228 100644
--- a/refs.c
+++ b/refs.c
@@ -805,6 +805,9 @@ void invalidate_ref_cache(const char *submodule)
 	clear_loose_ref_cache(refs);
 }
 
+/* The length of a peeled reference line in packed-refs, including EOL: */
+#define PEELED_LINE_LENGTH 42
+
 /*
  * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
  * Return a pointer to the refname within the line (null-terminated),
@@ -897,8 +900,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		}
 		if (last &&
 		    refline[0] == '^' &&
-		    strlen(refline) == 42 &&
-		    refline[41] == '\n' &&
+		    strlen(refline) == PEELED_LINE_LENGTH &&
+		    refline[PEELED_LINE_LENGTH - 1] == '\n' &&
 		    !get_sha1_hex(refline + 1, sha1)) {
 			hashcpy(last->u.value.peeled, sha1);
 			/*
-- 
1.8.2.1
