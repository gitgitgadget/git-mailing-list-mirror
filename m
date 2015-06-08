From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/13] remove_branches(): remove temporary
Date: Mon,  8 Jun 2015 13:45:36 +0200
Message-ID: <77713838b598b95c5973a1fe73569635f5f31ee9.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVE-00054K-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbbFHLp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:45:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49628 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366AbbFHLp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:45:56 -0400
X-AuditID: 1207440d-f79026d000000bad-21-557580733ad3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 48.5E.02989.37085755; Mon,  8 Jun 2015 07:45:55 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjoox017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:54 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqFvcUBpq8KdT0qLrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGT+WvmMqWM1acaPrDnsD4zqWLkZODgkBE4nfx36wQdhiEhfurQezhQQuM0o0f4jsYuQC
	sk8wSRx99A2sgU1AV2JRTzMTiC0ioCYxse0QC0gRs0AHo8SF5dvYQRLCAlYSq77PACtiEVCV
	ePq4D2wqr0CUxMKJv9ghtslJnD/+kxnE5hSwkLj7/wLUZnOJj9vaGScw8i5gZFjFKJeYU5qr
	m5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJSvDsY/6+TOcQowMGoxMN7YFFJqBBrYllx
	Ze4hRkkOJiVR3q6y0lAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxMFkA53pTEyqrUonyYlDQH
	i5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE78c6oEbBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UGzEFwOjAyTFA7RXpR5kb3FBYi5QFKL1FKMux50p/xcxCbHk5eelSonzPgbZ
	IQBSlFGaB7cClkBeMYoDfSzMmw0yigeYfOAmvQJawgS05PvXYpAlJYkIKakGRp8v98t2CmzW
	+5/0Nu3UmRnGc14/MTn+5929hoySEJWZ3iurYj9ZvS76Vl1YN+2dvLkR33Frxvpdh669FP+a
	NXPT1ncvW0+mC5edKzTSt3cKilD1nfoqfFr+1m9Tfn9m/1hV1tWZcFPmYq3bjKP9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271014>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f4a6ec9..53b8e13 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -756,8 +756,7 @@ static int remove_branches(struct string_list *branches)
 	strbuf_release(&err);
 
 	for (i = 0; i < branches->nr; i++) {
-		struct string_list_item *item = branches->items + i;
-		const char *refname = item->string;
+		const char *refname = branches->items[i].string;
 
 		if (delete_ref(refname, NULL, 0))
 			result |= error(_("Could not remove branch %s"), refname);
-- 
2.1.4
