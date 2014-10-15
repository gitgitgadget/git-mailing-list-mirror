From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/11] handle_missing_loose_ref(): return an int
Date: Wed, 15 Oct 2014 17:06:14 +0200
Message-ID: <1413385583-4872-3-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQA8-0002Oj-JE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbaJOPGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:06:39 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53580 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbaJOPGi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:38 -0400
X-AuditID: 1207440f-f79ea6d000004f72-3d-543e8d7a2a34
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EA.CB.20338.A7D8E345; Wed, 15 Oct 2014 11:06:34 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNU020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:33 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqFvVaxdicHWqiEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujMa9H5kLDvFXzJ63mLmB8SZ3FyMnh4SAicT+1insELaYxIV769lAbCGB
	y4wSE3pCuxi5gOzjTBKXd3QwgyTYBHQlFvU0M4EkRAQaGCUOvVrIBuIwCyxilGhfdQWsSljA
	WeLEmS4wm0VAVeLz7BVgK3iB4leXTGSDWCcnsXfyahYQm1PAReLXy22MEKudJRYsncwCUS8o
	cXLmEyCbA2iBusT6eUIgYWYBeYnmrbOZJzAKzEJSNQuhahaSqgWMzKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdE30cjNL9FJTSjcxQgKefwdj13qZQ4wCHIxKPLycB2xDhFgTy4orcw8xSnIw
	KYnyLuixCxHiS8pPqcxILM6ILyrNSS0+xCjBwawkwjs/ASjHm5JYWZValA+TkuZgURLnVV+i
	7ickkJ5YkpqdmlqQWgSTleHgUJLg3QcyVLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQk
	Ix4UqfHFwFgFSfEA7QVr5y0uSMwFikK0nmJUlBLnzQJJCIAkMkrz4MbC0tgrRnGgL4V5e0Cq
	eIApEK77FdBgJqDBE0NtQQaXJCKkpBoY49ivpt9+uuC2kqn3k9QJWuG3d7PIdGbbe/lK3ao9
	+l9X7I+Uy6tri6Liq8UbvrPNmaL8Venct3WLrjnfv7Ey5ZuIqjnLod+lnBpzVt6w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The return value of handle_missing_loose_ref() was either NULL to
signify an error or the input parameter refname on success. So instead
of returning a string, just return a 0 on success or -1 on error, so
the reader doesn't have to wonder what string the return value points
at.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index ffd45e9..ceba23c 100644
--- a/refs.c
+++ b/refs.c
@@ -1370,10 +1370,10 @@ static struct ref_entry *get_packed_ref(const c=
har *refname)
  * A loose ref file doesn't exist; check for a packed ref.  The
  * options are forwarded from resolve_safe_unsafe().
  */
-static const char *handle_missing_loose_ref(const char *refname,
-					    unsigned char *sha1,
-					    int reading,
-					    int *flag)
+static int handle_missing_loose_ref(const char *refname,
+				    unsigned char *sha1,
+				    int reading,
+				    int *flag)
 {
 	struct ref_entry *entry;
=20
@@ -1386,14 +1386,14 @@ static const char *handle_missing_loose_ref(con=
st char *refname,
 		hashcpy(sha1, entry->u.value.sha1);
 		if (flag)
 			*flag |=3D REF_ISPACKED;
-		return refname;
+		return 0;
 	}
 	/* The reference is not a packed reference, either. */
 	if (reading) {
-		return NULL;
+		return -1;
 	} else {
 		hashclr(sha1);
-		return refname;
+		return 0;
 	}
 }
=20
@@ -1437,10 +1437,12 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 		 */
 	stat_ref:
 		if (lstat(path, &st) < 0) {
-			if (errno =3D=3D ENOENT)
-				return handle_missing_loose_ref(refname, sha1,
-								reading, flag);
-			else
+			if (errno =3D=3D ENOENT) {
+				if (handle_missing_loose_ref(refname, sha1,
+							     reading, flag))
+					return NULL;
+				return refname;
+			} else
 				return NULL;
 		}
=20
--=20
2.1.1
