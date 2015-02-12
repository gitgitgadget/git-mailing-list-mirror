From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/12] refs: move REF_DELETING to refs.c
Date: Thu, 12 Feb 2015 12:12:12 +0100
Message-ID: <1423739543-1025-2-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhR-00045M-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbbBLLMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:38 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50383 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755589AbbBLLMf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:35 -0500
X-AuditID: 1207440f-f792a6d000001284-44-54dc8aa19dd3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.A0.04740.1AA8CD45; Thu, 12 Feb 2015 06:12:33 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7U003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:31 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLuw606Iwb2LPBZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzvix5xVzwlqvix8/tTA2Mpzm6GDk5JARMJNrX3GSDsMUkLtxbD2YL
	CVxmlPjXYNbFyAVkn2CS+HjlEDNIgk1AV2JRTzMTiC0ioCYxse0QC4jNLLCaSWLrXbBmYQFr
	iZeHZ4LVsAioSlyZ1QRm8wo4S/xcsIYFYpmcxPnjP8Fmcgq4SLy71MAIsdhZYlfbFtYJjLwL
	GBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoQEGf8Oxq71MocYBTgYlXh4
	V5jeCRFiTSwrrsw9xCjJwaQkysvVChTiS8pPqcxILM6ILyrNSS0+xCjBwawkwuvbBJTjTUms
	rEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwlncCNQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1iIO28xQWJuUBRiNZTjIpS4ryZIAkBkERG
	aR7cWFjqeMUoDvSlMK8EMJEI8QDTDlz3K6DBTECDJ864DTK4JBEhJdXAOHcyR9nTJL/QDYHM
	3CtznjYfSL1zVMHqhVugQ4BTm8kFE/4JOcVhn2wE7khGp5z72n7vvHDi1643ZkuDLwSmJiTz
	CnhFGe6cstxfK/Seet+iX7KeGo7WE4NP7ts3b35TYEKh3W3Ps7tfhy9buXiTl0Op 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263716>

It is only used internally now. Document it a little bit better, too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 6 ++++++
 refs.h | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index ab2f2a9..5e6355c 100644
--- a/refs.c
+++ b/refs.c
@@ -35,6 +35,12 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING	0x02
+
+/*
  * Used as a flag to ref_transaction_delete when a loose ref is being
  * pruned.
  */
diff --git a/refs.h b/refs.h
index afa3c4d..9bf2148 100644
--- a/refs.h
+++ b/refs.h
@@ -183,12 +183,10 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
- * REF_DELETING: tolerate broken refs
  *
- * Flags >= 0x100 are reserved for internal use.
+ * Other flags are reserved for internal use.
  */
 #define REF_NODEREF	0x01
-#define REF_DELETING	0x02
 
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
-- 
2.1.4
