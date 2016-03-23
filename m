From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/21] checkout_paths(): remove unneeded flag variable
Date: Wed, 23 Mar 2016 11:04:36 +0100
Message-ID: <1b77b4a4bba21cb4f38092b6b36663b38de58a23.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:05:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiffL-0002rw-OG
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbcCWKFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:05:19 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56304 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754610AbcCWKFS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:05:18 -0400
X-AuditID: 1207440d-6a3ff7000000068f-6e-56f26a5cf4bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7F.5F.01679.C5A62F65; Wed, 23 Mar 2016 06:05:16 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1O018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:15 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqBub9SnM4HWaRdeVbiaLht4rzBa3
	V8xntuie8pbR4kdLD7PFzKvWDmwef99/YPLYOesuu8ez3j2MHhcvKXvsX7qNzePzJrkAtihu
	m6TEkrLgzPQ8fbsE7ozVR44xFlxjr3hw4jtzA+NKti5GTg4JAROJ3S/eA9lcHEICWxklfs47
	DZYQEjjJJLHlmASIzSagK7Gop5kJxBYRUJOY2HaIBaSBWWABo8TGxYuZQRLCAm4SO96cB2tm
	EVCV2HNqKZDNwcErECVx4rUhxDIliQ0PLoDN4RSwkDh5cikjxC5zie0P1jJNYORZwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMklHh3MP5fJ3OIUYCDUYmHt+jcxzAh
	1sSy4srcQ4ySHExKorzngz6FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLhnZEBlONNSaysSi3K
	h0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBuA2kULEpNT61Iy8wpQUgzcXCCDOeS
	EilOzUtJLUosLcmIB0VAfDEwBkBSPEB7p4HtLS5IzAWKQrSeYtTlWPDj9lomIZa8/LxUKXFe
	DZAiAZCijNI8uBWwxPGKURzoY2FezkygKh5g0oGb9ApoCRPQkoU+YEtKEhFSUg2M3V67XhwI
	XbFiyvNlXBu1/+75pnHuq4TJ9X0Cl/acNtzdPDdn4zWX+W59e14bfj8+N+3kQ97O+W6VzzPP
	K0ln+ik0SO3omyzuOEPa/2fYmbi/htWF380yMm8x+lacbN/D0G0dcS7KZ9vid0v+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289611>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cfa66e2..ef42237 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -242,7 +242,6 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct checkout state;
 	static char *ps_matched;
 	unsigned char rev[20];
-	int flag;
 	struct commit *head;
 	int errs = 0;
 	struct lock_file *lock_file;
@@ -375,7 +374,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", 0, rev, &flag);
+	read_ref_full("HEAD", 0, rev, NULL);
 	head = lookup_commit_reference_gently(rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
-- 
2.8.0.rc3
